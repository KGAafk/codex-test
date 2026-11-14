#!/usr/bin/env python3
"""Report actual Lua coroutine failures in the experimental AI build.

The upstream scheduler silently removes failed coroutines. Normal coroutine
completion remains quiet, and scheduling/removal is otherwise unchanged.
Only the build checkout's api.ai and resource api.bin are modified.
"""
from pathlib import Path


def patch(source):
    path = Path(source) / 'api.ai'
    content = path.read_bytes()
    newline = b'\r\n' if b'\r\n' in content else b'\n'
    original = (b'\t\t\tret = coroutine.resume(thread_list[i],unpack(thread_param[i],1));\n'
                b'\t\t\tthread_param[i] = {};').replace(b'\n', newline)
    replacement = (b'\t\t\tlocal was_dead = coroutine.status(thread_list[i]) == "dead";\n'
                   b'\t\t\tlocal detail;\n'
                   b'\t\t\tif was_dead then ret = false;\n'
                   b'\t\t\telse ret, detail = coroutine.resume(thread_list[i],unpack(thread_param[i],1)); end\n'
                   b'\t\t\tif not ret and not was_dead then\n'
                   b'\t\t\t\tprint("AI_COROUTINE_ERROR," .. tostring(i) .. "," .. tostring(detail));\n'
                   b'\t\t\tend\n'
                   b'\t\t\tthread_param[i] = {};').replace(b'\n', newline)
    if content.count(original) != 1:
        raise ValueError('scheduler anchor is missing or not unique')
    modified = content.replace(original, replacement, 1)
    path.write_bytes(modified)
    (Path(source) / 'api.bin').write_bytes(modified)
    print('Enabled coroutine error reporting in experimental build.')


if __name__ == '__main__':
    patch('ai/th123_ai')
