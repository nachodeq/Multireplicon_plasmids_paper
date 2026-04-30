import pandas as pd
from Bio import SeqIO

# ============================================================
# INPUT FILES
# ============================================================

cluster_file = "hspq_clusters_cluster.tsv"
rep_fasta = "hspq_clusters_rep_seq.fasta"

# ============================================================
# 1. LOAD CLUSTERS
# ============================================================

cl = pd.read_csv(
    cluster_file,
    sep="\t",
    header=None,
    names=["rep", "member"]
)

# ============================================================
# 2. GET TOP 3 CLUSTERS
# ============================================================

sizes = (
    cl.groupby("rep")
      .size()
      .sort_values(ascending=False)
      .reset_index(name="n")
)

top3 = sizes.head(3)

print("\nTop 3 clusters:")
print(top3)

top_ids = set(top3["rep"])

# ============================================================
# 3. EXTRACT REPRESENTATIVE SEQUENCES
# ============================================================

records = []
for rec in SeqIO.parse(rep_fasta, "fasta"):
    if rec.id in top_ids:
        records.append(rec)

# ============================================================
# 4. WRITE OUTPUT
# ============================================================

out_fasta = "top3_cluster_representatives.fa"

SeqIO.write(records, out_fasta, "fasta")

print("\nWritten:", out_fasta)
print("Sequences extracted:", len(records))
