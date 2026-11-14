#!/usr/bin/env python3
"""Add an opt-in, per-process player lock to the cloud build's AI source.

Run after checkout and before MSBuild from the cloud-build root. No INI or game
file is read or changed. Unset/empty env preserves the upstream autodetection.
"""
from pathlib import Path
import argparse

HEADER = b'''#ifndef SOKU_FORCE_PLAYER_H\n#define SOKU_FORCE_PLAYER_H\n#include <cstdlib>\n\n// 0 = automatic, 1/2 = force side, -1 = invalid nonempty configuration.\nstatic int soku_forced_player() {\n    const char *value = std::getenv("SOKU_AI_FORCE_PLAYER");\n    if (!value || !value[0]) return 0;\n    if (value[1] == '\\0' && (value[0] == '1' || value[0] == '2')) return value[0] - '0';\n    return -1;\n}\nstatic int soku_prefer_forced_player(int detected) {\n    const int forced = soku_forced_player();\n    return forced > 0 ? forced : detected;\n}\n#endif\n'''


def replace_once(data, old, new, label):
    count = data.count(old)
    if count != 1:
        raise ValueError(f'{label}: expected exactly one anchor, got {count}')
    return data.replace(old, new, 1)


def apply(source):
    source = Path(source)
    main_path, key_path, header_path = (source / 'main.cpp', source / 'key_manager.cpp',
                                        source / 'force_player.h')
    if header_path.exists():
        raise ValueError('force_player.h already exists; refusing to patch twice')
    main, keys = main_path.read_bytes(), key_path.read_bytes()
    nl_main = b'\r\n' if b'\r\n' in main else b'\n'
    nl_keys = b'\r\n' if b'\r\n' in keys else b'\n'
    for name, data, nl in (('main', main, nl_main), ('keys', keys, nl_keys)):
        if data.count(b'#include "stdafx.h"' + nl) != 1:
            raise ValueError(name + ': precompiled header include not unique')
    main = replace_once(main, b'#include "stdafx.h"' + nl_main,
                        b'#include "stdafx.h"' + nl_main + b'#include "force_player.h"' + nl_main,
                        'main include')
    keys = replace_once(keys, b'#include "stdafx.h"' + nl_keys,
                        b'#include "stdafx.h"' + nl_keys + b'#include "force_player.h"' + nl_keys,
                        'key include')
    anchor = b'\ti = ini_int2(L"Player", 1);'
    keys = replace_once(keys, anchor,
                        b'\t// An explicit per-process side overrides key/character autodetection.\n'
                        b'\tp = soku_prefer_forced_player(p);\n'.replace(b'\n', nl_keys) + anchor,
                        'search_key forced selection')
    # A forced side must be claimed or fail: upstream otherwise flips sides.
    anchor = b'\tif(WAIT_OBJECT_0 != WaitForSingleObject(h,0)) {'
    if main.count(anchor) != 2:
        raise ValueError('expected upstream primary and fallback mutex checks')
    block = (b'\tif(WAIT_OBJECT_0 != WaitForSingleObject(h,0)) {\n'
             b'\t\tif (soku_forced_player() > 0) {\n'
             b'\t\t\tif (h != NULL) CloseHandle(h);\n'
             b'\t\t\tfprintf(stderr, "Forced player slot is already occupied or unavailable.\\n");\n'
             b'\t\t\texit(2);\n'
             b'\t\t}\n').replace(b'\n', nl_main)
    main = main.replace(anchor + nl_main, block, 1)
    anchor = b'\tload_inis();' + nl_main + b'\tchange_player();'
    block = (b'\tload_inis();\n'
             b'\tconst int forced = soku_forced_player();\n'
             b'\tif (forced < 0) {\n'
             b'\t\tfprintf(stderr, "SOKU_AI_FORCE_PLAYER must be 1 or 2.\\n");\n'
             b'\t\texit(2);\n'
             b'\t}\n'
             b'\tif (forced == 1) ini_add(L"Option", L"Player", L"1");\n'
             b'\tif (forced == 2) ini_add(L"Option", L"Player", L"2");\n'
             b'\tchange_player();').replace(b'\n', nl_main)
    main = replace_once(main, anchor, block, 'initial forced selection')
    # Validate everything before the first write.
    main_path.write_bytes(main)
    key_path.write_bytes(keys)
    header_path.write_bytes(HEADER.replace(b'\n', nl_main))
    print('Installed opt-in per-process player lock into build sources.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', default='ai/th123_ai')
    apply(parser.parse_args().source)
