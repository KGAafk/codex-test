import unittest

from delay_queue_patch import BEGIN, END, OLD, NEW, patch


class DelayPatchTest(unittest.TestCase):
    def test_exact_change_and_idempotence_with_crlf_and_non_ascii(self):
        original = b'\x81\x40\r\n' + BEGIN + b'\r\n\t\t' + OLD + b'\r\n' + END
        fixed = patch(original)
        self.assertEqual(fixed, original.replace(OLD, NEW))
        self.assertEqual(patch(fixed), fixed)

    def test_missing_or_ambiguous_anchor_fails_closed(self):
        for original in (b'bad', BEGIN + OLD + OLD + END,
                         BEGIN + OLD + NEW + END, END + OLD + BEGIN,
                         BEGIN + NEW + NEW + END):
            with self.subTest(original=original):
                with self.assertRaises(ValueError):
                    patch(original)


if __name__ == '__main__':
    unittest.main()
