#!/usr/bin/env python3
import pandas as pd
import re

FILES = {
    "breakpoints": "output_mefinder_breakpoints.csv",
    "background": "output_mefinder_background.csv",
    "chromocontrol": "output_mefinder_cromosomacontrol.csv"
}

def load_mefinder_table(path, label):
    # First read raw
    df = pd.read_csv(path, comment="#", header=0)

    # Detect whether it's all in ONE column (common MEfinder issue)
    if df.shape[1] == 1:
        # Re-parse as comma-separated
        df = pd.read_csv(path, comment="#", sep=",", header=0)

    df["dataset"] = label
    return df


def clean_contig_field(c):
    """
    Extract clean contig name:
      - background/breakpoints: things like 'NZ_CP022072.1__bg__34292_35291'
      - chromocontrol: strings containing 'contig=...'
    """

    c = str(c)

    # Case 1: contig already simple (NZ_CPxxxx)
    m = re.match(r"^([A-Za-z0-9_.]+)__", c)
    if m:
        return m.group(1)

    # Case 2: format: 'NZ_CPxxxx:start-end'
    m = re.match(r"^([A-Za-z0-9_.]+):\d+-\d+", c)
    if m:
        return m.group(1)

    # Case 3: chromosomal: 'window_63 contig=contig_1 start=...'
    m = re.search(r"contig=([A-Za-z0-9_.]+)", c)
    if m:
        return m.group(1)

    # Fallback: return whole field
    return c


# ---------------- Load all datasets ----------------

dfs = []
for label, file in FILES.items():
    df = load_mefinder_table(file, label)
    df["clean_contig"] = df["contig"].apply(clean_contig_field)
    dfs.append(df)

full = pd.concat(dfs, ignore_index=True)

# ---------------- Summary: counts by TYPE ----------------

summary_type = (
    full.groupby(["dataset", "type"])
        .size()
        .reset_index(name="count")
        .sort_values(["dataset", "count"], ascending=[True, False])
)

summary_type.to_csv("summary_mefinder_by_type.tsv", sep="\t", index=False)

# ---------------- Summary: counts by CONTIG + TYPE (no chromocontrol) ----------------

subset = full[full["dataset"] != "chromocontrol"]

summary_contig = (
    subset.groupby(["dataset", "clean_contig", "type"])
        .size()
        .reset_index(name="count")
        .sort_values(["dataset", "clean_contig", "count"], ascending=[True, True, False])
)

summary_contig.to_csv("summary_mefinder_by_type_and_contig.tsv", sep="\t", index=False)

print("Generated:\n  summary_mefinder_by_type.tsv\n  summary_mefinder_by_type_and_contig.tsv")

# ---------------- Optional plot ----------------

try:
    import matplotlib.pyplot as plt

    pivot = summary_type.pivot(index="type", columns="dataset", values="count").fillna(0)
    pivot.plot(kind="bar", figsize=(10,6))
    plt.ylabel("Count")
    plt.title("Counts of MGEs by dataset")
    plt.tight_layout()
    plt.savefig("barplot_mefinder_types.png")
    print("Generated: barplot_mefinder_types.png")

except Exception as e:
    print("Plot failed:", e)

