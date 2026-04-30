#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Filtra líneas cuyo último campo (shared/total) tenga shared==0 en un TSV enorme (p.ej., mash_dist.tsv),
con procesamiento paralelo por rangos de bytes y barras de progreso.

Uso:
  python3 filter_nonzero_kmers_progress.py -i mash_dist.tsv -o mash_dist.nozero.tsv -p 0 -b 1024M
"""
import argparse, os, re, sys, tempfile
from concurrent.futures import ProcessPoolExecutor, as_completed
from tqdm.auto import tqdm

PAT = re.compile(r'^\s*([0-9]+)\/[0-9]+\s*$', re.ASCII)

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument("-i", "--input", required=True, help="TSV de entrada")
    p.add_argument("-o", "--output", required=True, help="TSV de salida")
    p.add_argument("-p", "--processes", type=int, default=0, help="Nº de procesos (0=todos los cores)")
    p.add_argument("-b", "--block", default="1024M", help="Tamaño de bloque por shard (e.g., 512M, 1G)")
    p.add_argument("--tmpdir", default=None, help="Directorio temporal (opcional)")
    return p.parse_args()

def parse_size(s: str) -> int:
    s = s.strip().upper()
    mult = 1
    if s.endswith("K"):
        mult, s = 1024, s[:-1]
    elif s.endswith("M"):
        mult, s = 1024**2, s[:-1]
    elif s.endswith("G"):
        mult, s = 1024**3, s[:-1]
    return int(float(s) * mult)

def shard_ranges(fsize: int, block: int):
    ranges, off = [], 0
    while off < fsize:
        end = min(off + block, fsize)
        ranges.append((off, end))
        off = end
    return ranges

def adjust_to_linebound(fp, start, end, fsize):
    # Ajusta inicio a siguiente '\n' si no es 0
    if start > 0:
        fp.seek(start)
        _ = fp.readline()
        start = fp.tell()
        if start >= end:
            return (end, end)
    # Ajusta fin al anterior '\n' si no es EOF
    if end < fsize:
        step = 1024
        pos = end
        while pos > start:
            back = max(start, pos - step)
            fp.seek(back)
            data = fp.read(pos - back)
            idx = data.rfind(b'\n')
            if idx != -1:
                end = back + idx + 1  # incluir salto
                break
            pos = back
    return (start, end)

def worker(input_path, start, end, tmp_path):
    kept = total = 0
    with open(input_path, "rb") as f_in, open(tmp_path, "wb") as f_out:
        f_in.seek(start)
        to_read = end - start
        bufsize = 2 * 1024 * 1024  # 2MB
        leftover = b""
        while to_read > 0:
            chunk = f_in.read(min(bufsize, to_read))
            if not chunk:
                break
            to_read -= len(chunk)
            data = leftover + chunk
            lines = data.split(b'\n')
            leftover = lines.pop()
            for line in lines:
                total += 1
                if not line:
                    f_out.write(b'\n'); kept += 1; continue
                try:
                    last_field = line.rsplit(b'\t', 1)[-1]
                except Exception:
                    f_out.write(line + b'\n'); kept += 1; continue
                m = PAT.match(last_field.decode('ascii', errors='ignore'))
                if m:
                    if int(m.group(1)) > 0:
                        f_out.write(line + b'\n'); kept += 1
                else:
                    f_out.write(line + b'\n'); kept += 1
        if leftover:
            line = leftover
            total += 1
            try:
                last_field = line.rsplit(b'\t', 1)[-1]
            except Exception:
                f_out.write(line + b'\n'); kept += 1
            else:
                m = PAT.match(last_field.decode('ascii', errors='ignore'))
                if m:
                    if int(m.group(1)) > 0:
                        f_out.write(line + b'\n'); kept += 1
                else:
                    f_out.write(line + b'\n'); kept += 1
    return kept, total

def main():
    args = parse_args()
    in_path, out_path = args.input, args.output
    procs = args.processes or (os.cpu_count() or 1)
    block_size = parse_size(args.block)

    fsize = os.path.getsize(in_path)
    ranges = shard_ranges(fsize, block_size)

    adjusted = []
    with open(in_path, "rb") as f:
        for s, e in ranges:
            s2, e2 = adjust_to_linebound(f, s, e, fsize)
            if s2 < e2:
                adjusted.append((s2, e2))

    if not adjusted:
        open(out_path, "wb").close()
        print("[OK] No hay rangos válidos.", file=sys.stderr)
        return

    tmpdir = args.tmpdir or tempfile.mkdtemp(prefix="nonzero_shards_")
    tmp_files = [os.path.join(tmpdir, f"shard_{i:06d}.tsv") for i in range(len(adjusted))]

    kept_sum = total_sum = 0

    # Progreso: procesamiento por shards
    with ProcessPoolExecutor(max_workers=procs) as ex, \
         tqdm(total=len(adjusted), desc="Procesando shards", unit="shard") as pbar:
        futures = {ex.submit(worker, in_path, s, e, tmp_files[i]): i
                   for i, (s, e) in enumerate(adjusted)}
        for fut in as_completed(futures):
            k, t = fut.result()
            kept_sum += k
            total_sum += t
            pbar.update(1)

    # Progreso: concatenación por bytes
    total_concat_bytes = sum(os.path.getsize(p) for p in tmp_files)
    with open(out_path, "wb") as fout, \
         tqdm(total=total_concat_bytes, desc="Concatenando", unit="B", unit_scale=True) as pbar2:
        for tmpf in tmp_files:
            with open(tmpf, "rb") as fin:
                for chunk in iter(lambda: fin.read(1024 * 1024), b""):
                    fout.write(chunk)
                    pbar2.update(len(chunk))

    # Limpieza
    for tmpf in tmp_files:
        try: os.remove(tmpf)
        except Exception: pass
    try: os.rmdir(tmpdir)
    except Exception: pass

    print(f"[OK] Líneas procesadas: {total_sum:,} | Líneas conservadas: {kept_sum:,}", file=sys.stderr)

if __name__ == "__main__":
    main()

