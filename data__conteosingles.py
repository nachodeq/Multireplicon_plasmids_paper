import pandas as pd
import re

df = pd.read_csv("plasmid_replicons.tsv", sep="\t")

# válidos: no vacío, no "-", no NaN
valid = df["replicon_types"].fillna("").astype(str).str.strip()
valid = valid[(valid != "") & (valid != "-") & (valid != " ")]

# subset con solo válidos
dfv = df.loc[valid.index].copy()

# cuenta de tipos por fila (separadores: | , ; espacios)
dfv["n_types"] = dfv["replicon_types"].str.split(r",").apply(lambda xs: len([x for x in xs if x]))

# single-replicon si hay exactamente 1 tipo
single_ids = set(dfv.loc[dfv["n_types"] == 1, "plasmid_id"])

print("plasmid_id single-replicon únicos:", len(single_ids))
# opcional: verlos
# print(sorted(single_ids))

