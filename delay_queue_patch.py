#!/usr/bin/env python3
"""Correct an upstream delayed-opponent state queue shift, idempotently.

The patch is deliberately limited to an exact unique line in yield(). It does
not change the default data_delay=0 or any game files.
"""
import argparse
from pathlib import Path

OLD = b'memmove(act,&act_block[1],sizeof(short)*(delay-1));'
NEW = b'memmove(act_block,&act_block[1],sizeof(short)*(delay-1));'
BEGIN = b'engine->setScriptValue("my_act_block",my_data.act_block);'
END = b'engine->setScriptValueBool("is_th105", ::IsSWR());'


def patch(data):
    if data.count(BEGIN) != 1 or data.count(END) != 1:
        raise ValueError('Could not uniquely locate delayed-state section')
    first, last = data.index(BEGIN), data.index(END)
    if first >= last:
        raise ValueError('Delayed-state boundaries are reversed')
    prefix, section, suffix = data[:first], data[first:last], data[last:]
    if section.count(OLD) == 1 and section.count(NEW) == 0:
        return prefix + section.replace(OLD, NEW, 1) + suffix
    if section.count(OLD) == 0 and section.count(NEW) == 1:
        return data
    raise ValueError('Expected one buggy or one corrected shift in delayed-state section')


def apply(path):
    path = Path(path)
    original = path.read_bytes()
    result = patch(original)
    if result == original:
        print('Delayed opponent state queue already patched.')
    else:
        path.write_bytes(result)
        print('Corrected delayed opponent action-block queue shift.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=Path('ai/th123_ai/main.cpp'))
    apply(parser.parse_args().source)
