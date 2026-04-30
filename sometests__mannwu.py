#!/usr/bin/env python3

import pandas as pd
import numpy as np
from scipy.stats import mannwhitneyu

INPUT = "qcv_real_vs_null(1).tsv"

def cliffs_delta(x, y):
    x = np.asarray(x)
    y = np.asarray(y)

    n_greater = 0
    n_less = 0

    for xi in x:
        n_greater += np.sum(xi > y)
        n_less += np.sum(xi < y)

    return (n_greater - n_less) / (len(x) * len(y))

def iqr(x):
    return np.percentile(x, 25), np.percentile(x, 75)

def main():
    df = pd.read_csv(INPUT, sep="\t")

    df = df.dropna(subset=["QCV_rel", "group"]).copy()

    real = df.loc[df["group"].str.lower() == "real", "QCV_rel"].values
    null = df.loc[df["group"].str.lower().isin(["null", "simulated", "random", "nulo"]), "QCV_rel"].values

    if len(real) == 0 or len(null) == 0:
        print("Groups found:")
        print(df["group"].value_counts())
        raise ValueError("No encuentro valores Real o Null/Simulated en la columna 'group'.")

    result = mannwhitneyu(real, null, alternative="less")
    delta = cliffs_delta(real, null)

    real_q1, real_q3 = iqr(real)
    null_q1, null_q3 = iqr(null)

    print("Mann–Whitney U test")
    print("-------------------")
    print("Alternative hypothesis: Real QCV < Null QCV")
    print(f"N real: {len(real)}")
    print(f"N null: {len(null)}")
    print(f"Median real QCV: {np.median(real):.4f}")
    print(f"IQR real QCV: {real_q1:.4f}–{real_q3:.4f}")
    print(f"Median null QCV: {np.median(null):.4f}")
    print(f"IQR null QCV: {null_q1:.4f}–{null_q3:.4f}")
    print(f"U statistic: {result.statistic:.4f}")
    print(f"p-value: {result.pvalue:.4e}")
    print(f"Cliff's delta: {delta:.4f}")

    if result.pvalue < 0.05:
        print("\nResult: Real QCV is significantly lower than null QCV.")
    else:
        print("\nResult: No significant evidence that Real QCV is lower than null QCV.")

if __name__ == "__main__":
    main()
