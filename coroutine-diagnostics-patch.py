#!/usr/bin/env python3
"""Report actual Lua coroutine failures in the experimental AI build.

The upstream scheduler silently removes failed coroutines. Normal coroutine
completion remains quiet, and scheduling/removal is otherwise unchanged.
Only the build checkout's api.ai and resource api.bin are modified.
"""
from pathlib import Path


def patch(source):
    root = Path(source)
    path = root / 'api.ai'
    script_path = root / 'script.cpp'
    content = path.read_bytes()
    script = script_path.read_bytes()
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
    # The upstream game resets protect_flag to 0 immediately before start().
    # In that mode errors can invoke panic/exit instead of returning from
    # coroutine.resume. Opt in to protected execution only for diagnostics;
    # leave default behavior unchanged.
    script_nl = b'\r\n' if b'\r\n' in script else b'\n'
    flag_anchor = b'\tprotect_flag = 0;'
    if script.count(flag_anchor) != 1:
        raise ValueError('runtime protection anchor is missing or not unique')
    flag_replacement = (b'\tconst char *diagnostics = getenv("SOKU_AI_DIAGNOSTICS");\n'
                        b'\tprotect_flag = diagnostics && diagnostics[0] == \'1\' && diagnostics[1] == \'\\0\';')
    flag_replacement = flag_replacement.replace(b'\n', script_nl)
    script = script.replace(flag_anchor, flag_replacement, 1)
    modified = content.replace(original, replacement, 1)
    path.write_bytes(modified)
    (root / 'api.bin').write_bytes(modified)
    script_path.write_bytes(script)
    print('Enabled coroutine error reporting (protected mode is opt-in).')


if __name__ == '__main__':
    patch('ai/th123_ai')
