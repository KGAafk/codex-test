#!/usr/bin/env python3
"""Run generated logger mock in isolated temp dirs and verify both CSV schemas."""
import argparse
import csv
import os
import subprocess
import tempfile
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument('exe', nargs='?', default='verify-telemetry-generated.exe', type=Path)
args = parser.parse_args()
exe = args.exe.resolve(strict=True)

base_header = ('wall_ms,scene,frame,player,foreground,requested_mask,my_char,enemy_char,'
               'my_x,my_y,enemy_x,enemy_y,my_action,enemy_action,my_frame,enemy_frame,'
               'my_hp,enemy_hp,my_rei,enemy_rei,my_hitstop,enemy_hitstop,my_combo,my_limit,'
               'my_dir,enemy_dir,my_fflags,enemy_fflags,my_aflags,enemy_aflags,'
               'my_key0,my_key1,my_key2,my_key3,my_key4,my_key5,my_key6,my_key7,'
               'enemy_key0,enemy_key1,enemy_key2,enemy_key3,enemy_key4,enemy_key5,enemy_key6,enemy_key7').split(',')
v2_extra = 'process_id,my_gauge,my_card_cached,my_hand0,my_hand1,my_hand2,my_hand3,my_hand4,weather'.split(',')
assert len(base_header) == 46 and len(v2_extra) == 9


def exercise(name, telemetry, schema):
    with tempfile.TemporaryDirectory(prefix='soku-telemetry-') as temp:
        env = os.environ.copy()
        env.pop('SOKU_AI_TELEMETRY', None)
        env.pop('SOKU_AI_TELEMETRY_SCHEMA', None)
        if telemetry is not None:
            env['SOKU_AI_TELEMETRY'] = telemetry
        if schema is not None:
            env['SOKU_AI_TELEMETRY_SCHEMA'] = schema
        run = subprocess.run([str(exe)], cwd=temp, env=env, text=True,
                             stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=20)
        if run.returncode != 0:
            raise AssertionError(f'{name}: mock exited {run.returncode}: {run.stderr}')
        directory = Path(temp)
        files = sorted(p.name for p in directory.iterdir())
        if telemetry != '1':
            assert not files, f'{name}: disabled logger wrote {files}'
            print(name, 'passed (no files)')
            return
        v2 = schema == '2'
        filename = 'ai_telemetry_v2.csv' if v2 else 'ai_telemetry.csv'
        assert files == [filename], f'{name}: wrong files {files}'
        with (directory / filename).open(encoding='ascii', newline='') as stream:
            rows = list(csv.reader(stream))
        expected_header = base_header + (v2_extra if v2 else [])
        assert rows and rows[0] == expected_header, f'{name}: wrong header'
        assert len(rows) == 3, f'{name}: expected exactly two frames, got {len(rows)-1}'
        assert all(len(row) == len(expected_header) for row in rows), f'{name}: uneven column count'
        data = [dict(zip(expected_header, row)) for row in rows[1:]]
        assert [row['frame'] for row in data] == ['100', '101'], f'{name}: duplicate/incorrect frames'
        for row in data:
            expected = {'scene':'13','player':'2','foreground':'1','requested_mask':'130',
                        'my_char':'18','enemy_char':'3','my_action':'300','enemy_action':'50',
                        'my_x':'100.50','enemy_x':'450.00','my_hp':'9500','enemy_hp':'9000',
                        'my_dir':'1','enemy_dir':'-1','my_key7':'7','enemy_key7':'17'}
            if v2:
                expected.update({'process_id':'4242','my_gauge':'2500','my_card_cached':'211',
                                 'my_hand0':'201','my_hand1':'202','my_hand2':'203',
                                 'my_hand3':'204','my_hand4':'205','weather':'6'})
            for key, value in expected.items():
                assert row[key] == value, f'{name}: {key}={row[key]}, expected {value}'
        print(name, f'passed ({len(expected_header)} columns, 2 frames)')


exercise('disabled', None, None)
exercise('schema2 but disabled', None, '2')
exercise('invalid enable flag', '10', '2')
exercise('default', '1', None)
exercise('schema v2', '1', '2')
