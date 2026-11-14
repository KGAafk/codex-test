import importlib.util
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('explicit_player_patch', HERE / 'explicit-player-patch.py')
patch = importlib.util.module_from_spec(spec)
spec.loader.exec_module(patch)
UPSTREAM = HERE / 'ai' / 'th123_ai'
if not UPSTREAM.exists():
    UPSTREAM = HERE.parent / 'th123_ai' / 'th123_ai'


class ExplicitPlayerPatchTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.src = Path(self.temp.name)
        for filename in ('main.cpp', 'key_manager.cpp'):
            (self.src / filename).write_bytes((UPSTREAM / filename).read_bytes())

    def tearDown(self):
        self.temp.cleanup()

    def test_override_and_mutex_are_placed_before_mutations(self):
        patch.apply(self.src)
        main = (self.src / 'main.cpp').read_bytes()
        keys = (self.src / 'key_manager.cpp').read_bytes()
        init = main[main.index(b'void init(void)'):main.index(b'void title_message(void)')]
        self.assertLess(init.index(b'load_inis();'), init.index(b'soku_forced_player()'))
        self.assertLess(init.index(b'soku_forced_player()'), init.index(b'change_player();'))
        mutex = main[main.index(b'void change_player(void)'):main.index(b'void init(void)')]
        self.assertLess(mutex.index(b'if (soku_forced_player() > 0)'), mutex.index(b'ini_add(L"Option"'))
        self.assertIn(b'exit(2);', mutex[:mutex.index(b'ini_add(L"Option"')])
        search = keys[keys.index(b'void search_key('):keys.index(b'void on_check(')]
        self.assertLess(search.index(b'p = soku_prefer_forced_player(p);'),
                        search.index(b'i = ini_int2(L"Player", 1);'))
        self.assertIn(b'key[i] = map[p-1][i];', search)
        self.assertEqual(search.count(b'p = soku_prefer_forced_player(p);'), 1)

    def test_invalid_or_double_patch_fails_before_modification(self):
        patch.apply(self.src)
        before = {p.name: p.read_bytes() for p in self.src.iterdir()}
        with self.assertRaises(ValueError):
            patch.apply(self.src)
        self.assertEqual(before, {p.name: p.read_bytes() for p in self.src.iterdir()})

    def test_missing_anchor_does_not_write_partial_result(self):
        key = self.src / 'key_manager.cpp'
        key.write_bytes(key.read_bytes().replace(b'i = ini_int2(L"Player", 1);', b'i = 7;'))
        before = {p.name: p.read_bytes() for p in self.src.iterdir()}
        with self.assertRaises(ValueError):
            patch.apply(self.src)
        self.assertEqual(before, {p.name: p.read_bytes() for p in self.src.iterdir()})


if __name__ == '__main__':
    unittest.main()
