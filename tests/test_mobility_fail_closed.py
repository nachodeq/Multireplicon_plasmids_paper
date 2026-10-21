"""CLI regressions for native schema validation and isolated output runs."""
import csv
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / 'scripts/02_mobility_host_range/02g_independent_mobility.py'

class NativeFailureTests(unittest.TestCase):
    def fixture(self, root, columns=None):
        native = root / 'native'
        models = root / 'models'
        native.mkdir(); models.mkdir()
        fasta = root / 'P.fasta'
        fasta.write_text('>P\n' + 'ACGT' * 100 + '\n')
        (native / 'input_fastas.txt').write_text(str(fasta) + '\n')
        profiles = ['T4SS_MOB_x', 'T4SS_t4cp_x', 'T4SS_struct_x']
        (models / 'T4SS_typeX.xml').write_text('<model>' + ''.join('<gene name="' + name + '"/>' for name in profiles) + '</model>')
        hits = native / 'conjscan_per_plasmid/P/hmmer_results'
        hits.mkdir(parents=True)
        for profile in profiles:
            (hits / (profile + '.res_hmm_extract')).write_text('')
        counts = root / 'counts.tsv'
        fields = columns or ['plasmid_id', 'replicon_status', 'n_T4SS_typeX']
        with counts.open('w') as handle:
            writer = csv.DictWriter(handle, fieldnames=fields, delimiter='\t')
            writer.writeheader()
            writer.writerow({field: 'P' if field == 'plasmid_id' else 'Single-replicon' if field == 'replicon_status' else '0' for field in fields})
        reference = root / 'oriT.fasta'
        reference.write_text('>experimental\n' + 'ACGT' * 25 + '\n')
        binary = root / 'bin'; binary.mkdir()
        for executable in ['makeblastdb', 'blastn']:
            path = binary / executable
            path.write_text('#!/bin/sh\necho controlled-native-tool-failure >&2\nexit 7\n')
            path.chmod(0o755)
        return ['--native-dir', str(native), '--model-definitions', str(models), '--model-counts', str(counts), '--orit-reference', str(reference), '--blast-bin', str(binary)]

    def run_cli(self, out, arguments):
        return subprocess.run([sys.executable, str(SCRIPT), '--outdir', str(out), *arguments], capture_output=True, text=True)

    def test_missing_or_misspelled_complete_columns_fail_before_output(self):
        for fields in [['plasmid_id', 'replicon_status'], ['plasmid_id', 'replicon_status', 'n_T4SS_typoX']]:
            with self.subTest(fields=fields), tempfile.TemporaryDirectory() as directory:
                root = Path(directory); arguments = self.fixture(root, fields); out = root / 'result'
                result = self.run_cli(out, arguments)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn('n_T4SS_typeX', result.stderr)
                self.assertFalse(out.exists())

    def test_invalid_counts_and_duplicate_ids_fail_before_output(self):
        for value in ['-1', 'NA', '0.5', '']:
            with self.subTest(value=value), tempfile.TemporaryDirectory() as directory:
                root = Path(directory); arguments = self.fixture(root); out = root / 'result'
                (root / 'counts.tsv').write_text('plasmid_id\treplicon_status\tn_T4SS_typeX\nP\tSingle-replicon\t' + value + '\n')
                result = self.run_cli(out, arguments)
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse(out.exists())
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory); arguments = self.fixture(root); out = root / 'result'
            with (root / 'counts.tsv').open('a') as handle:
                handle.write('NZ_P\tSingle-replicon\t0\n')
            self.assertNotEqual(self.run_cli(out, arguments).returncode, 0)
            self.assertFalse(out.exists())

    def test_positive_native_and_cached_classification(self):
        # Instrumented successful tools exercise orchestration, not real sequence searches.
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory); arguments = self.fixture(root)
            for executable in ['makeblastdb', 'blastn']:
                (root / 'bin' / executable).write_text('#!/bin/sh\nwhile [ "$#" -gt 0 ]; do if [ "$1" = "-out" ]; then shift; : > "$1"; fi; shift; done\nexit 0\n')
            native_out = root / 'native_result'
            native_result = self.run_cli(native_out, arguments)
            self.assertEqual(native_result.returncode, 0, native_result.stderr)
            self.assertTrue((native_out / 'outputs/run_manifest.json').exists())
            with (native_out / 'outputs/plasmid_summary.tsv').open() as handle:
                rows = list(csv.DictReader(handle, delimiter='\t'))
            self.assertEqual(rows[0]['functional_category'], 'pNT')
            cached_out = root / 'cached_result'; cached_out.mkdir()
            cached = self.run_cli(cached_out, ['--protein-summary', str(native_out / 'outputs/protein_summary.tsv'), '--orit-blast', str(native_out / 'outputs/blast_standard.tsv'), '--reference-aliases', str(native_out / 'inputs/reference_aliases.tsv')])
            self.assertEqual(cached.returncode, 0, cached.stderr)
            self.assertEqual((cached_out / 'outputs/plasmid_summary.tsv').read_text(), (native_out / 'outputs/plasmid_summary.tsv').read_text())

    def test_nonempty_output_is_rejected_without_modification(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory); arguments = self.fixture(root); out = root / 'result'; out.mkdir()
            (out / 'outputs').mkdir()
            sentinel = out / 'outputs/run_manifest.json'; sentinel.write_text('previous-success-sentinel')
            summary = out / 'outputs/plasmid_summary.tsv'; summary.write_text('previous-classification-sentinel')
            before = {str(path.relative_to(out)): path.read_bytes() for path in out.rglob('*') if path.is_file()}
            result = self.run_cli(out, arguments)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('empty', result.stderr.lower())
            self.assertEqual(sentinel.read_text(), 'previous-success-sentinel')
            self.assertEqual({str(path.relative_to(out)): path.read_bytes() for path in out.rglob('*') if path.is_file()}, before)
            self.assertEqual([path.name for path in out.iterdir()], ['outputs'])

    def test_native_failure_has_no_completed_classification(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory); arguments = self.fixture(root); out = root / 'result'; out.mkdir()
            (root / 'bin/makeblastdb').write_text('#!/bin/sh\nexit 0\n')
            result = self.run_cli(out, arguments)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('controlled-native-tool-failure', result.stderr)
            self.assertFalse((out / 'outputs/plasmid_summary.tsv').exists())
            self.assertFalse((out / 'outputs/run_manifest.json').exists())
            cohort = root / 'cohort.tsv'
            cohort.write_text('plasmid_id\tmultireplicon_status\tlog10_length\thost_genus_model\tsource_model\nP\t0\t3\tExample\tOther\n')
            glm_out = root / 'glm_result'
            downstream = subprocess.run([sys.executable, str(ROOT / 'scripts/02_mobility_host_range/02h_independent_mobility_glm.py'), '--model-data', str(cohort), '--mobility-table', str(out / 'outputs/plasmid_summary.tsv'), '--outdir', str(glm_out)], capture_output=True, text=True)
            self.assertNotEqual(downstream.returncode, 0)
            self.assertFalse((glm_out / 'primary_M3_results.tsv').exists())
            retry = self.run_cli(out, arguments)
            self.assertNotEqual(retry.returncode, 0)
            self.assertIn('empty', retry.stderr.lower())

if __name__ == '__main__':
    unittest.main()
