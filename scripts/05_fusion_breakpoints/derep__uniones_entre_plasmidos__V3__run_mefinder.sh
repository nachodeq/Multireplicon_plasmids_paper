#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# CONFIG
# ============================================================

BASE="/home/nacho/HDD16/Nacho/RepliCOOC/derep/uniones_entre_plasmidos/V3"
HWS=(500 1000 1500 2000 2500 3000)

NPROC=20
MODE="full"    # cambia a full cuando veas que funciona
N_TEST=5

# ============================================================
# CHECK
# ============================================================

if ! command -v mefinder >/dev/null 2>&1; then
    echo "ERROR: mefinder no está en PATH."
    echo "Activa primero el entorno conda correcto."
    exit 1
fi

echo "Usando mefinder en:"
which mefinder
echo "MODE  = $MODE"
echo "NPROC = $NPROC"
echo

# limpiar caché previa global de mefinder
rm -rf /tmp/mge_finder || true

# ============================================================
# WORKER
# ============================================================

WORKER=$(mktemp)
cat > "$WORKER" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

fa="$1"
outdir="$2"
hw="$3"

base=$(basename "$fa" .fa)

# prefijo único por longitud
prefix="$outdir/hw${hw}_${base}"

# si ya existe csv no vacío, saltar
if [[ -s "${prefix}.csv" ]]; then
    echo "[SKIP] hw${hw}_${base}"
    exit 0
fi

# tmp único por job
tmpdir=$(mktemp -d /tmp/mefinder_job_XXXXXX)
export TMPDIR="$tmpdir"

echo "[RUN] hw${hw}_${base}"

{
    echo "CMD: mefinder find --contig $fa $prefix"
    echo "TMPDIR: $TMPDIR"
    mefinder find --contig "$fa" "$prefix"
} > "${prefix}.stdout.log" 2> "${prefix}.stderr.log" || {
    echo "[ERROR] hw${hw}_${base}"
    rm -rf "$tmpdir"
    exit 0
}

csv_size=0
txt_size=0
mge_size=0

[[ -f "${prefix}.csv" ]] && csv_size=$(stat -c%s "${prefix}.csv")
[[ -f "${prefix}_result.txt" ]] && txt_size=$(stat -c%s "${prefix}_result.txt")
[[ -f "${prefix}_mge_sequences.fna" ]] && mge_size=$(stat -c%s "${prefix}_mge_sequences.fna")

echo "[DONE] hw${hw}_${base} csv=${csv_size} txt=${txt_size} mge=${mge_size}"

rm -rf "$tmpdir"
EOF

chmod +x "$WORKER"

# ============================================================
# MAIN
# ============================================================

for HW in "${HWS[@]}"; do
    TRACE_DIR="$BASE/TRACEABLE_hardcut_95pid_${HW}_onebest_per_pair"
    WINDOWS_DIR="$TRACE_DIR/windows"
    OUTDIR="$TRACE_DIR/mefinder_windows_v2"

    echo "============================================================"
    echo "HW = $HW"
    echo "TRACE_DIR   = $TRACE_DIR"
    echo "WINDOWS_DIR = $WINDOWS_DIR"
    echo "OUTDIR      = $OUTDIR"
    echo "============================================================"

    if [[ ! -d "$WINDOWS_DIR" ]]; then
        echo "[WARN] no existe $WINDOWS_DIR, salto"
        echo
        continue
    fi

    mkdir -p "$OUTDIR"

    mapfile -t FASTAS < <(find "$WINDOWS_DIR" -maxdepth 1 -type f -name 'bp_*.fa' | sort -V)

    if [[ "${#FASTAS[@]}" -eq 0 ]]; then
        echo "[WARN] no encuentro bp_*.fa en $WINDOWS_DIR"
        echo
        continue
    fi

    if [[ "$MODE" == "test" ]]; then
        FASTAS=( "${FASTAS[@]:0:$N_TEST}" )
    fi

    echo "Ventanas a procesar: ${#FASTAS[@]}"
    echo

    for fa in "${FASTAS[@]}"; do
        echo "$fa"
    done | xargs -I{} -P "$NPROC" "$WORKER" "{}" "$OUTDIR" "$HW"

    echo
    echo "--- RESUMEN HW=$HW ---"

    n_csv=$(find "$OUTDIR" -maxdepth 1 -type f -name "hw${HW}_bp_*.csv" | wc -l)
    n_csv_nonempty=$(find "$OUTDIR" -maxdepth 1 -type f -name "hw${HW}_bp_*.csv" -size +1c | wc -l)
    n_txt=$(find "$OUTDIR" -maxdepth 1 -type f -name "hw${HW}_bp_*_result.txt" | wc -l)

    echo "CSV files        : $n_csv"
    echo "Non-empty CSV    : $n_csv_nonempty"
    echo "Result TXT files : $n_txt"

    echo
    echo "Ejemplo de stderr (si existe):"
    err_example=$(find "$OUTDIR" -maxdepth 1 -type f -name "hw${HW}_bp_*.stderr.log" | head -n 1 || true)
    if [[ -n "${err_example:-}" ]]; then
        echo "FILE: $err_example"
        head -n 40 "$err_example" || true
    else
        echo "[none]"
    fi

    echo
done

rm -f "$WORKER"

echo "DONE."
