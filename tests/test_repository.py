#!/usr/bin/env python3
"""Fast integrity tests for the public analysis repository."""

import ast
import csv
import gzip
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import unittest

import pandas as pd


ROOT = Path(__file__).resolve().parents[1]


class RepositoryIntegrityTests(unittest.TestCase):
    def test_python_scripts_parse(self):
        for path in ROOT.joinpath("scripts").rglob("*.py"):
            with self.subTest(path=path.relative_to(ROOT)):
                ast.parse(path.read_text(), filename=str(path))

    def test_no_personal_absolute_paths(self):
        pattern = re.compile(r"/(home|Users|media)/|[A-Za-z]:\\\\")
        for suffix in ("*.py", "*.R", "*.sh"):
            for path in ROOT.joinpath("scripts").rglob(suffix):
                with self.subTest(path=path.relative_to(ROOT)):
                    self.assertIsNone(pattern.search(path.read_text()))

    def test_supplementary_dataset_1_schema_and_counts(self):
        path = ROOT / "Supplementary_Datasets/Supplementary_Dataset_1.xlsx"
        table = pd.read_excel(path, sheet_name="selected_representatives")
        required = {"plasmid_id", "n_replicons", "length_bp"}
        self.assertTrue(required.issubset(table.columns))
        self.assertEqual(len(table), 23925)
        self.assertEqual(int((table["n_replicons"] >= 2).sum()), 7549)
        self.assertFalse(table["plasmid_id"].duplicated().any())

    def test_atb_master_table_interface(self):
        script = (
            ROOT
            / "scripts/02_mobility_host_range/02f_validate_host_range_jumps_atb.py"
        )
        with tempfile.TemporaryDirectory() as tmp:
            tmpdir = Path(tmp)
            raw_events = tmpdir / "raw_events.tsv"
            species_calls = tmpdir / "species_calls.tsv.gz"
            mobtyper_master = tmpdir / "mobtyper_master.tsv"
            outdir = tmpdir / "outputs"

            self._write_tsv(
                raw_events,
                [
                    {
                        "plasmid": "PLSDB_1",
                        "replicon": "IncFII",
                        "new_genus": "Escherichia",
                        "new_family": "Enterobacteriaceae",
                        "taxonomic_jump": "family",
                        "baseline_genera": "Klebsiella",
                        "baseline_families": "Enterobacteriaceae",
                        "cointegrated_replicons": "IncFIB",
                    }
                ],
            )
            self._write_tsv(
                species_calls,
                [
                    {
                        "sample_accession": "SAMPLE_1",
                        "sylph_species": "Escherichia coli",
                        "HQ": "TRUE",
                    }
                ],
            )
            self._write_tsv(
                mobtyper_master,
                [{"sample_id": "SAMPLE_1", "rep_type(s)": "IncFII,IncFIB"}],
            )

            subprocess.run(
                [
                    sys.executable,
                    str(script),
                    "--raw-events",
                    str(raw_events),
                    "--species-calls",
                    str(species_calls),
                    "--mobtyper-master",
                    str(mobtyper_master),
                    "--outdir",
                    str(outdir),
                ],
                check=True,
                capture_output=True,
                text=True,
            )
            result = pd.read_csv(
                outdir / "atb_plsdb_observed_subcombinations_by_combo.tsv",
                sep="\t",
            )
            self.assertEqual(len(result), 1)
            self.assertEqual(
                result.loc[0, "atb_status"], "exact_combination_found_in_atb"
            )
            self.assertEqual(result.loc[0, "atb_samples_exact_combination"], 1)

    @staticmethod
    def _write_tsv(path, rows):
        if path.suffix == ".gz":
            stream = gzip.open(path, "wt", newline="", encoding="utf-8")
        else:
            stream = path.open("w", newline="", encoding="utf-8")
        with stream as handle:
            writer = csv.DictWriter(handle, fieldnames=rows[0], delimiter="\t")
            writer.writeheader()
            writer.writerows(rows)


if __name__ == "__main__":
    unittest.main()
