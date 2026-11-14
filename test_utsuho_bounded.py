import hashlib
import importlib.util
import re
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('bounded', HERE / 'make_utsuho_bounded.py')
bounded = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bounded)


class UtsuhoCandidateTest(unittest.TestCase):
    def test_candidate_preserves_other_files_and_every_original_gate(self):
        source = HERE / 'utsuho-fixture'
        with tempfile.TemporaryDirectory() as temp:
            dest = Path(temp) / 'candidate'
            bounded.build(source, dest)
            for f in source.rglob('*'):
                if f.is_file() and f.name != bounded.FILENAME:
                    other = dest / f.relative_to(source)
                    self.assertEqual(hashlib.sha256(f.read_bytes()).digest(),
                                     hashlib.sha256(other.read_bytes()).digest(), str(f))
            original = (source / bounded.FILENAME).read_bytes()
            result = (dest / bounded.FILENAME).read_bytes()
            nl = b'\r\n' if b'\r\n' in original else b'\n'
            self.assertEqual(result.count(bounded.GATE), original.count(bounded.GATE))
            self.assertEqual(result.count(bounded.HELPER.replace(b'\n', nl)), 1)
            result = result.replace(bounded.HELPER.replace(b'\n', nl), b'', 1)
            for card in bounded.CARDS:
                number = str(card).encode('ascii')
                pattern = (rb'(?m)^([ \t]*)for i=1,10 do\s*\r?\n[ \t]*card_use\('
                           + number + rb'\);\s*\r?\n[ \t]*yield\(\)\s*\r?\n[ \t]*end')
                matches = list(re.finditer(pattern, original))
                self.assertEqual(len(matches), 1)
                original_loop = matches[0].group(0)
                replacement = matches[0].group(1) + b'utsuho_bounded_card_use(' + number + b');'
                self.assertEqual(result.count(replacement), 1)
                result = result.replace(replacement, original_loop, 1)
            self.assertEqual(result, original, 'only the specified helper and loops may differ')

    def test_refuses_existing_or_in_source_destination(self):
        with tempfile.TemporaryDirectory() as temp:
            dest = Path(temp) / 'existing'
            dest.mkdir()
            marker = dest / 'do-not-touch'
            marker.write_text('preserve')
            with self.assertRaises(FileExistsError):
                bounded.build(HERE / 'utsuho-fixture', dest)
            self.assertEqual(marker.read_text(), 'preserve')
        with self.assertRaises(ValueError):
            bounded.build(HERE / 'utsuho-fixture', HERE / 'utsuho-fixture' / 'not-created')


if __name__ == '__main__':
    unittest.main()
