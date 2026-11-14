#!/usr/bin/env python3
"""Extract the actual patched telemetry block into a standalone C++ mock.

Run after telemetry-patch.py in the build checkout. The generated program
exercises logger code without opening a game or injecting input.
"""
import argparse
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('--source', type=Path, default=Path('ai/th123_ai/main.cpp'))
parser.add_argument('--output', type=Path, default=Path('verify-telemetry-generated.cpp'))
args = parser.parse_args()
source = args.source.read_bytes()
start = b'    // Optional local-only telemetry.'
end = b'\tkeyboard.ProcessEvent();'
if source.count(start) != 1 or source.count(end) != 1:
    raise SystemExit('telemetry boundaries missing or ambiguous')
i, j = source.index(start), source.index(end)
if i >= j:
    raise SystemExit('telemetry boundaries reversed')
block = source[i:j].strip()
required = (b'getenv("SOKU_AI_TELEMETRY")', b'getenv("SOKU_AI_TELEMETRY_SCHEMA")',
            b'ai_telemetry_v2.csv', b'ai_telemetry.csv',
            b'battle_time != last_frame', b'GetCurrentProcessId()',
            b'my_data.card[i].id')
if not block.endswith(b'}') or any(block.count(x) != 1 for x in required):
    raise SystemExit('telemetry block anchors missing or ambiguous')
try:
    block = block.decode('ascii')
except UnicodeDecodeError as exc:
    raise SystemExit('non-ASCII telemetry block; inspect before extraction') from exc

prefix = r'''
#include <cstdio>
#include <cstdlib>
#include <cwchar>
// Same scalar widths as x86 MSVC Character / ObjBase. Unsigned shorts in
// printf arguments undergo the same default promotions as the actual code.
struct MockCharacter {
    int char_id;
    float x, y;
    unsigned short action;
    unsigned int frame;
    unsigned short hp, rei, hit_stop;
    struct { unsigned short count, limit; } combo;
    char dir;
    unsigned int fflags, aflags;
    int keyState[8];
    int gauge;
    short card_id;
    struct { short id, cost; } card[5];
};
MockCharacter my_data={}, enemy_data={};
int seen=13, battle_time=100, weather=6;
void *wh=reinterpret_cast<void *>(0x1234);
void *GetForegroundWindow() { return reinterpret_cast<void *>(0x1234); }
unsigned long GetTickCount() { return 12345ul; }
unsigned long GetCurrentProcessId() { return 4242ul; }
int ini_int2(const wchar_t *name, int fallback) {
    if (std::wcscmp(name,L"Player") || fallback!=1) std::exit(10);
    return 2;
}
char get_key_stat(int i) { return (i==1 || i==7) ? 1 : 0; }
void record_one_frame() {
'''
suffix = r'''
}
int main() {
    my_data.char_id=18; enemy_data.char_id=3;
    my_data.x=100.5f; my_data.y=25.25f; enemy_data.x=450.0f; enemy_data.y=75.0f;
    my_data.action=300; enemy_data.action=50; my_data.frame=9; enemy_data.frame=4;
    my_data.hp=9500; enemy_data.hp=9000; my_data.rei=800; enemy_data.rei=700;
    my_data.hit_stop=3; enemy_data.hit_stop=2; my_data.combo.count=2; my_data.combo.limit=40;
    my_data.dir=1; enemy_data.dir=-1; my_data.fflags=32; enemy_data.fflags=8;
    my_data.aflags=2; enemy_data.aflags=4; my_data.gauge=2500; my_data.card_id=211;
    for (int i=0; i<8; ++i) { my_data.keyState[i]=i; enemy_data.keyState[i]=i+10; }
    for (int i=0; i<5; ++i) my_data.card[i].id=201+i;
    record_one_frame();
    record_one_frame(); // duplicate frame must not be appended
    battle_time=101;
    record_one_frame();
    seen=3; battle_time=102;
    record_one_frame(); // non-combat scene must not be appended
    std::fflush(NULL);
    return 0;
}
'''
args.output.write_text(prefix + '\n' + block + '\n' + suffix, encoding='ascii', newline='\n')
print('Generated actual telemetry integration harness:', args.output)
