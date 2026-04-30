#!/usr/bin/env python3
# ===============================================================
# MMseqs2 RBH en streaming usando DBs ya creados (NO easy-rbh)
#   - mmseqs rbh queryDB targetDB resultDB tmp
#   - mmseqs createtsv queryDB targetDB resultDB result.tsv
#   - Lee pares línea a línea (no carga todo en RAM)
#   - Resumible: si result.tsv existe y tiene tamaño >0 -> skip
#   - Progreso cada REPORT_EVERY trabajos
# Env:
#   N_WORKERS (por defecto: os.cpu_count())
#   THREADS_PER_JOB (por defecto: 1)
#   REPORT_EVERY (por defecto: 1000)
# Uso:
#   conda activate mmseqs2
#   export N_WORKERS=$(nproc) THREADS_PER_JOB=1 REPORT_EVERY=200
#   python -u run_rbh_fromdb_streaming_pairs.py /ruta/a/pares.tsv
# ===============================================================

import os, sys, shutil, subprocess, time
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
from collections import deque
from datetime import timedelta

if len(sys.argv) < 2:
    print("Uso: python run_rbh_fromdb_streaming_pairs.py /ruta/a/pares.tsv")
    sys.exit(1)

pairs_path = Path(sys.argv[1]); assert pairs_path.exists(), f"No existe: {pairs_path}"

BASE = Path("/home/nacho/HDD16/Nacho/RepliCOOC")
RES  = BASE / "results" / "wgrr_pairs"
DB   = RES / "mmseqs_db"
OUT  = RES / "mmseqs_out"
TMP  = RES / "tmp"
LOG  = RES / "logs"
for d in [OUT, TMP, LOG]: d.mkdir(parents=True, exist_ok=True)

mmseqs = shutil.which("mmseqs")
assert mmseqs, "mmseqs no está en PATH (activa conda/mamba activate mmseqs2)"

E_VALUE="1e-4"; COV_MODE,COV_CUT="2","0.5"; SENS="7.5"
N_WORKERS=int(os.environ.get("N_WORKERS", os.cpu_count() or 1))
THREADS_PER_JOB=int(os.environ.get("THREADS_PER_JOB", 1))
REPORT_EVERY=int(os.environ.get("REPORT_EVERY", 1000))

def have_db(pid: str) -> bool:
    return (DB / f"{pid}.dbtype").exists()

def run_one(a: str, b: str) -> str:
    """RBH + createtsv usando DBs ya creados."""
    outdir = OUT / f"{a}_VS_{b}"
    tmpdir = TMP / f"{a}_VS_{b}"
    resfile = outdir / "result.tsv"
    if resfile.exists() and resfile.stat().st_size > 0:
        return "skip"

    if not (have_db(a) and have_db(b)):
        return "missing_db"

    outdir.mkdir(parents=True, exist_ok=True)
    tmpdir.mkdir(parents=True, exist_ok=True)

    rbhdb = outdir / "rbhDB"
    logf  = LOG / f"{a}_VS_{b}.rbh.log"

    cmd_rbh = [
        mmseqs, "rbh",
        str(DB / a), str(DB / b),
        str(rbhdb), str(tmpdir),
        "--threads", str(THREADS_PER_JOB),
        "-e", E_VALUE, "--cov-mode", COV_MODE, "-c", COV_CUT, "-s", SENS
    ]
    cmd_tsv = [
        mmseqs, "createtsv",
        str(DB / a), str(DB / b),
        str(rbhdb), str(resfile)
    ]
    try:
        with open(logf, "w") as lf:
            subprocess.run(cmd_rbh, check=True, stdout=lf, stderr=lf)
            subprocess.run(cmd_tsv, check=True, stdout=lf, stderr=lf)
        return "done"
    except subprocess.CalledProcessError as e:
        with open(logf, "a") as lf:
            lf.write(f"\n[ERROR] rbh/createtsv exit={e.returncode}\n")
        return "fail"
    except Exception as e:
        with open(logf, "a") as lf:
            lf.write(f"\n[ERROR] unexpected {type(e).__name__}: {e}\n")
        return "fail"

def total_lines_fast(path: Path) -> int:
    try:
        out = subprocess.check_output(["wc","-l",str(path)], text=True).split()[0]
        return max(0, int(out)-1)
    except Exception:
        with open(path) as fh: return sum(1 for _ in fh) - 1

TOTAL = total_lines_fast(pairs_path)
print(f"Pairs: {TOTAL:,} | workers={N_WORKERS} | threads/job={THREADS_PER_JOB}")
print(f"MMseqs2: {mmseqs}\n")

t0=time.time(); done=skipped=failed=finished=missing=0
from collections import deque
with ThreadPoolExecutor(max_workers=N_WORKERS) as ex, open(pairs_path) as fh:
    header = fh.readline()
    inflight = deque()

    def submit_line(line: str):
        parts = line.rstrip("\n").split("\t")
        if len(parts) < 2: return None
        a, b = parts[0], parts[1]
        resfile = OUT / f"{a}_VS_{b}" / "result.tsv"
        if resfile.exists() and resfile.stat().st_size > 0:
            return "skip"
        if not (have_db(a) and have_db(b)):
            return "missing_db"
        return ex.submit(run_one, a, b)

    # prellenar
    for _ in range(N_WORKERS):
        line = fh.readline()
        if not line: break
        tag = submit_line(line)
        if tag == "skip": skipped += 1; finished += 1
        elif tag == "missing_db": missing += 1; finished += 1
        elif tag: inflight.append(tag)

    # ciclo
    while inflight:
        fut = inflight.popleft()
        status = fut.result()
        finished += 1
        if status == "done": done += 1
        elif status == "skip": skipped += 1
        elif status == "missing_db": missing += 1
        else: failed += 1

        if finished % REPORT_EVERY == 0 or finished == TOTAL:
            elapsed = time.time() - t0
            rate = finished/elapsed if elapsed else 0.0
            eta = (TOTAL - finished)/rate if rate else 0.0
            print(f"[{finished:>12}/{TOTAL}] done={done} skip={skipped} fail={failed} missing_db={missing} "
                  f"| {rate:5.2f} jobs/s | ETA {timedelta(seconds=int(eta))}", flush=True)

        next_line = fh.readline()
        if next_line:
            tag = submit_line(next_line)
            if tag == "skip": skipped += 1; finished += 1
            elif tag == "missing_db": missing += 1; finished += 1
            elif tag: inflight.append(tag)

elapsed = time.time() - t0
print("\n✅ RBH streaming (DB) completado")
print(f"Tiempo: {timedelta(seconds=int(elapsed))}")
print(f"done={done} skip={skipped} fail={failed} missing_db={missing}")
print(f"OUT={OUT}\nLOG={LOG}")

