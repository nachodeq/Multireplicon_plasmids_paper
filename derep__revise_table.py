import pandas as pd
from pathlib import Path

# Rutas
RAW = Path("/home/nacho/HDD16/Nacho/RepliCOOC/data/raw")
DEREP = Path("/home/nacho/HDD16/Nacho/RepliCOOC/derep")
PLSDB_MOB_PATH = RAW / "plsdb_mob.csv"
OUTPUT_PATH = DEREP / "plasmid_replicons_revised.tsv"

# Helpers
def _normalize_id(pid):
    if pd.isna(pid) or pid == "":
        return ""
    pid_str = str(pid)
    pid_str = pid_str.split("/")[-1]
    for ext in [".fasta", ".fa", ".fna", ".gbk", ".gb", ".csv"]:
        if pid_str.endswith(ext):
            pid_str = pid_str[:-len(ext)]
    return pid_str

# 1) Cargar plsdb_mob.csv completo
mob = pd.read_csv(PLSDB_MOB_PATH, dtype=str).fillna("")

# 2) Normalizar IDs para replicon agrupación
mob["plasmid_id"] = mob["NUCCORE_ACC"].map(_normalize_id)

# 3) Agrupar replicones por plasmid_id SIN eliminar duplicados (concatenar cadenas replicon, manteniendo repeticiones)
# replicon es columna 'rep_type' (puede tener múltiples replicones separados por comas dentro de una celda)
# Primero separamos los replicones en listas y expandimos para evitar pérdidas
mob_expanded = mob.assign(rep_type=mob["rep_type"].str.split(",")).explode("rep_type")

# Limpiar espacios
mob_expanded["rep_type"] = mob_expanded["rep_type"].str.strip()

# Filtrar entradas con replicón vacío o nulo
mob_expanded_valid = mob_expanded[mob_expanded["rep_type"] != ""]

# 4) Ahora contamos total de replicones por plasmid_id con repeticiones
replicon_list = (
    mob_expanded_valid
    .groupby("plasmid_id")["rep_type"]
    .apply(lambda x: ",".join(x))
    .reset_index()
    .rename(columns={"rep_type": "replicon_types"})
)

replicon_count = (
    mob_expanded_valid
    .groupby("plasmid_id")["rep_type"]
    .count()
    .reset_index()
    .rename(columns={"rep_type": "n_replicons"})
)

# 5) Obtener rutas faa y size_bp desde el dataset previo si necesario (o dejar vacío)
# Supongamos que "faa" y "size_bp" están en el antiguo plasmid_replicons.tsv para unión
old_rep = pd.read_csv(DEREP / "plasmid_replicons.tsv", sep="\t", dtype=str)

# Normalizar old IDs y quedarnos solo columnas de interés
old_rep["plasmid_id"] = old_rep["plasmid_id"].map(_normalize_id)
old_rep_sel = old_rep[["plasmid_id", "faa", "size_bp"]].drop_duplicates(subset=["plasmid_id"])

# 6) Unir todo en versión final
plasmid_replicons_new = (
    replicon_list
    .merge(replicon_count, on="plasmid_id", how="left")
    .merge(old_rep_sel, on="plasmid_id", how="left")
)

# 7) Guardar archivo reiniciado
plasmid_replicons_new.to_csv(OUTPUT_PATH, sep="\t", index=False)

print(f"Archivo generado con {len(plasmid_replicons_new)} filas en: {OUTPUT_PATH}")
plasmid_replicons_new.head(10)

