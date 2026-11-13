from pathlib import Path
p = Path('ai/th123_ai/main.cpp')
b = p.read_bytes()
for old, new in [(b'seen!=0x08 && seen!=0x09 && seen!=0x0E && seen!=0x0D', b'seen!=0x08 && seen!=0x09'), (b'if(seen != 0x05) {', b'if(seen != 0x05 && seen != 0x0d && seen != 0x0e) {')]:
    assert b.count(old) == 1
    b = b.replace(old, new)
old = b'void check_th105(void) {\r\n\tHMODULE mh;'
new = b'void check_th105(void) {\r\n\tbool cleared_net_keys = false;\r\n\tHMODULE mh;'
if old not in b:
    old = old.replace(b'\r\n', b'\n'); new = new.replace(b'\r\n', b'\n')
assert b.count(old) == 1
b = b.replace(old, new)
old = b'\t\ttitle_message();\r\n\t\tSleep(50);'
new = b'\t\tif (!cleared_net_keys) { key_reset(); keyboard.Clear(); cleared_net_keys = true; }\r\n\t\ttitle_message();\r\n\t\tSleep(50);'
if old not in b:
    old = old.replace(b'\r\n', b'\n'); new = new.replace(b'\r\n', b'\n')
assert b.count(old) == 1
b = b.replace(old, new)
p.write_bytes(b)

q = Path('ai/inc_version/inc_version.cpp')
b = q.read_bytes()
q.write_bytes(b'#include <iostream>\r\n' + b)
project = Path('ai/th123_ai/th123_ai.vcxproj')
s = project.read_text(encoding='utf-8')
s = s.replace('luac.exe -s -o api.bin %(FullPath)', 'copy /Y %(FullPath) api.bin')
project.write_text(s, encoding='utf-8')
Path('ai/th123_ai/api.bin').write_bytes(Path('ai/th123_ai/api.ai').read_bytes())
p = Path('ai/th123_ai/main.cpp')
b = p.read_bytes()
old = b'::FindWindowW(name.c_str(), text.c_str())'
new = b'::FindWindowW(name.c_str(), name == L"th123_110a" ? NULL : text.c_str())'
assert b.count(old) == 1
p.write_bytes(b.replace(old, new))
