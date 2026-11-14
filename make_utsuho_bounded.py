#!/usr/bin/env python3
"""Create an isolated Utsuho candidate; never overwrite an existing target."""
from pathlib import Path
import argparse
import hashlib
import re
import shutil

DEFAULT_SOURCE = Path(r'C:\Users\29287\Documents\Codex\2026-11-14\ni-h\work\ai-run\ai2026-compare')
DEFAULT_DESTINATION = Path(r'D:\soku-ai-research\ai2026-utsuho-bounded')
FILENAME = '18_utsuho_main.lua'
CARDS = (211, 212, 213, 203)
GATE = b'enemy_obj_range_in(150,60)==false'
HELPER = b'''-- Experimental bounded card use; original eligibility gate stays in main.\nfunction utsuho_bounded_card_use(card_id)\n    for i=1,8 do\n        if my_hp<=0 or enemy_hp<=0 or (my_act>=50 and my_act<180) or my_act>=600\n            or not card_check(card_id) or enemy_obj_range_in(150,20) then\n            key_reset()\n            return false\n        end\n        key_reset()\n        if my_card==card_id then\n            if is_card_use then\n                key_event(ACT_BC)\n                return true\n            end\n            return false\n        end\n        card_1st(card_id)\n        yield()\n    end\n    key_reset()\n    return false\nend\n\n'''


def build(source, destination):
    source, destination = Path(source).resolve(), Path(destination).resolve()
    if not source.is_dir():
        raise ValueError('source directory does not exist')
    if destination.exists():
        raise FileExistsError('destination already exists; refusing overwrite')
    if source == destination or source in destination.parents:
        raise ValueError('destination cannot be inside the source')
    original = (source / FILENAME).read_bytes()
    nl = b'\r\n' if b'\r\n' in original else b'\n'
    anchor = b'function main()' + nl
    if original.count(anchor) != 1:
        raise ValueError('main anchor not unique')
    patched = original
    for card in CARDS:
        number = str(card).encode('ascii')
        pattern = (rb'(?m)^([ \t]*)for i=1,10 do\s*\r?\n[ \t]*card_use\('
                   + number + rb'\);\s*\r?\n[ \t]*yield\(\)\s*\r?\n[ \t]*end')
        matches = list(re.finditer(pattern, patched))
        if len(matches) != 1:
            raise ValueError(f'card {card}: expected one nested loop, found {len(matches)}')
        match = matches[0]
        prefix = patched[max(0, match.start() - 1200):match.start()]
        clause = prefix.rsplit(b'elseif', 1)[-1]
        if b'card_check(' + number + b')' not in clause or GATE not in clause:
            raise ValueError(f'card {card}: original projectile gate not verified')
        patched = patched[:match.start()] + match.group(1) + b'utsuho_bounded_card_use(' + number + b');' + patched[match.end():]
    if patched.count(GATE) != original.count(GATE):
        raise ValueError('projectile gates changed')
    patched = patched.replace(anchor, HELPER.replace(b'\n', nl) + anchor, 1)
    # copytree fails if another process created destination since the check.
    shutil.copytree(source, destination)
    (destination / FILENAME).write_bytes(patched)
    print('Candidate:', destination)
    print('Source SHA256:', hashlib.sha256(original).hexdigest())
    print('Candidate SHA256:', hashlib.sha256(patched).hexdigest())
    print('Unmodified projectile gates:', original.count(GATE))
    print('Only copied candidate was changed; no running program was touched.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=DEFAULT_SOURCE)
    parser.add_argument('--destination', type=Path, default=DEFAULT_DESTINATION)
    args = parser.parse_args()
    build(args.source, args.destination)
