from Bio import SeqIO
import pandas as pd

lengths = []

for record in SeqIO.parse("IS.fna", "fasta"):
    lengths.append(len(record.seq))

df = pd.DataFrame({"length": lengths})
df.to_csv("IS_lengths.csv", index=False)

