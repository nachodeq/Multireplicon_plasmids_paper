#!/usr/bin/env python3
# ===============================================================
# Create MMseqs2 databases for all plasmid .faa files (skip on fail)
# Requires: mmseqs2 installed and active in PATH
# ===============================================================

import shutil, subprocess, sys
from pathlib import Path
import pandas as pd

# -------- Paths --------
BASE = Path("/home/nacho/HDD16/Nacho/RepliCOOC")
DATA = BASE / "data"
RES  = BASE / "results" / "wgrr_pairs"
DB   = RES / "mmseqs_db"
LOG  = RES / "logs"
DB.mkdir(parents=True, exist_ok=True)
LOG.mkdir(parents=True, exist_ok=True)

# -------- Load metadata --------
meta_path = DATA / "plasmid_replicons.tsv"
assert meta_path.exists(), f"❌ No existe {meta_path}"
meta = pd.read_csv(meta_path, sep="\t", dtype=str).fillna("")
faa_df = meta.query("faa != ''").copy()
print(f"Encontrados {len(faa_df)} plásmidos con archivos FAA no vacíos")

# -------- Check mmseqs --------
mmseqs = shutil.which("mmseqs")
assert mmseqs, "❌ No encuentro 'mmseqs' en PATH (activa tu entorno con conda/mamba activate mmseqs2)"
print(f"Usando MMseqs2 en: {mmseqs}")

def faa_has_sequences(faa_path: str) -> bool:
    try:
        with open(faa_path, "r") as fh:
            for line in fh:
                if line.startswith(">"):
                    return True
        return False
    except Exception:
        return False

created = 0
skipped_existing = 0
failed = []

for r in faa_df.itertuples(index=False):
    pid = r.plasmid_id
    faa = Path(r.faa)

    dbtype = DB / f"{pid}.dbtype"
    if dbtype.exists():
        skipped_existing += 1
        continue

    # prechecks
    if not faa.exists():
        failed.append((pid, str(faa), "faa_missing"))
        continue
    if not faa_has_sequences(str(faa)):
        failed.append((pid, str(faa), "no_sequences_in_faa"))
        # escribe log corto
        (LOG / f"{pid}.createdb.log").write_text("No FASTA sequences found (no lines starting with '>').\n")
        continue

    # run mmseqs createdb
    cmd = [mmseqs, "createdb", str(faa), str(DB / pid)]
    log_path = LOG / f"{pid}.createdb.log"
    try:
        with open(log_path, "w") as lf:
            subprocess.run(cmd, check=True, stdout=lf, stderr=lf)
        created += 1
        print(f"[{created}] Creado DB para {pid}")
    except subprocess.CalledProcessError as e:
        failed.append((pid, str(faa), f"createdb_error_exit_{e.returncode}"))
        # anota el comando que falló
        with open(log_path, "a") as lf:
            lf.write(f"\n[ERROR] mmseqs createdb failed with exit code {e.returncode}\n")
        continue
    except Exception as e:
        failed.append((pid, str(faa), f"unexpected_error:{type(e).__name__}"))
        with open(log_path, "a") as lf:
            lf.write(f"\n[ERROR] Unexpected: {e}\n")
        continue

# resumen
print(f"✅ creados ahora: {created}")
print(f"⏩ ya existían: {skipped_existing}")
print(f"⚠️ fallidos: {len(failed)}")

if failed:
    fail_df = pd.DataFrame(failed, columns=["plasmid_id","faa","reason"])
    out_fail = RES / "failed_createdb.tsv"
    fail_df.to_csv(out_fail, sep="\t", index=False)
    print(f"Listado de fallos → {out_fail}")

