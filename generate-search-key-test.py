#!/usr/bin/env python3
"""Emit a standalone C++ test of the actual patched search_key function.

Run after explicit-player-patch.py, from the Actions checkout root. The emitted
test uses the actual force_player.h. Only Windows/game integration is mocked;
this checks key-map/INI selection, not OS keyboard injection or the mutex.
"""
import argparse
import re
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('--source', type=Path, default=Path('ai/th123_ai'))
parser.add_argument('--output', type=Path, default=Path('verify-search-key-generated.cpp'))
args = parser.parse_args()
source = (args.source / 'key_manager.cpp').read_bytes()
header = args.source / 'force_player.h'
if not header.is_file():
    raise SystemExit('force_player.h missing: patch must be applied first')
start = b'void search_key(CHAR_ID operation_char) {'
end = b'void on_check(int n) {'
if source.count(start) != 1 or source.count(end) != 1:
    raise SystemExit('search_key boundaries missing or ambiguous')
begin, finish = source.index(start), source.index(end)
if finish <= begin:
    raise SystemExit('search_key boundaries reversed')
function = source[begin:finish]
anchor = b'p = soku_prefer_forced_player(p);'
if function.count(anchor) != 1 or function.count(b'key[i] = map[p-1][i];') != 1:
    raise SystemExit('force or key-map anchor absent; refusing to test an unpatched source')
# Japanese comments are irrelevant to the extracted function and may be in
# CP932, whereas the generated harness is ASCII. Remove comments only.
function = re.sub(rb'//[^\r\n]*', b'', function)
try:
    function = function.decode('ascii')
except UnicodeDecodeError as exc:
    raise SystemExit('unexpected non-ASCII code in search_key') from exc

prefix = r'''
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cwchar>
#include "force_player.h"
typedef int CHAR_ID;
const int ADDR_1PKEYMAP=1, ADDR_2PKEYMAP=2, ADDR_LCHARID=3, ADDR_RCHARID=4;
const int DIK_UP=1, DIK_DOWN=2, DIK_LEFT=3, DIK_RIGHT=4, DIK_Z=5;
const int DIK_X=6, DIK_C=7, DIK_A=8, DIK_S=9, DIK_D=10;
int key[10], ph=0, last_on_key=-1, ini_player=1, change_count=0;
int maps[2][10];
void ReadProcessMemory(int, int address, int *out, int bytes) {
    if ((address != ADDR_1PKEYMAP && address != ADDR_2PKEYMAP) || bytes != 40) {
        std::fprintf(stderr,"unexpected key map read\n"); std::exit(10);
    }
    std::memcpy(out,maps[address-ADDR_1PKEYMAP],40);
}
void ReadProcessMemory(int, int address, int &out) {
    if (address != ADDR_LCHARID && address != ADDR_RCHARID) {
        std::fprintf(stderr,"unexpected character read\n"); std::exit(11);
    }
    out = address == ADDR_LCHARID ? 17 : 18;
}
int ini_int2(const wchar_t *name, int) {
    if (std::wcscmp(name,L"Player")) std::exit(12);
    return ini_player;
}
void ini_add(const wchar_t *section, const wchar_t *name, const wchar_t *value) {
    if (std::wcscmp(section,L"Option") || std::wcscmp(name,L"Player")) std::exit(13);
    if (!std::wcscmp(value,L"1")) ini_player=1;
    else if (!std::wcscmp(value,L"2")) ini_player=2;
    else std::exit(14);
}
void change_player() { ++change_count; }
unsigned MapVirtualKey(unsigned code, unsigned) { return code; }
'''
suffix = r'''
void exercise(const char *label, const char *env, int guess, int initial, int expected) {
    if (_putenv_s("SOKU_AI_FORCE_PLAYER", env)) std::exit(20);
    ini_player=initial; change_count=0;
    for (int i=0; i<10; ++i) { maps[0][i]=50+i; maps[1][i]=70+i; key[i]=-1; }
    // Upstream heuristic chooses the opposite side when a map's first four
    // entries are identical (indicating that side is a controller).
    int disabled=guess==1 ? 1 : 0;
    for (int i=0; i<4; ++i) maps[disabled][i]=200;
    search_key(99);
    if (ini_player!=expected) { std::fprintf(stderr,"%s: INI side %d != %d\n",label,ini_player,expected); std::exit(21); }
    for (int i=0; i<10; ++i) if (key[i]!=maps[expected-1][i]) {
        std::fprintf(stderr,"%s: index %d used %d, expected %d\n",label,i,key[i],maps[expected-1][i]);
        std::exit(22);
    }
    int expected_changes = initial == expected ? 0 : 1;
    if (change_count!=expected_changes) { std::fprintf(stderr,"%s: change_player calls %d != %d\n",label,change_count,expected_changes); std::exit(23); }
    std::printf("%s passed (side %d)\n",label,expected);
}
int main() {
    // Match initialized INI to forced side, as patched init() actually does.
    exercise("force P2 despite autodetect P1","2",1,2,2);
    exercise("force P1 despite autodetect P2","1",2,1,1);
    exercise("automatic P1 replaces initial P2","",1,2,1);
    exercise("automatic P2 replaces initial P1","",2,1,2);
    exercise("force P2 already detected","2",2,2,2);
    exercise("force P1 already detected","1",1,1,1);
    return 0;
}
'''
args.output.write_text(prefix + '\n' + function + '\n' + suffix, encoding='ascii', newline='\n')
print('Generated actual patched search_key integration harness:', args.output)
