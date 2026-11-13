from pathlib import Path
p = Path('ai/th123_ai/main.cpp')
b = p.read_bytes()
for old, new in [(b'seen!=0x08 && seen!=0x09 && seen!=0x0E && seen!=0x0D', b'seen!=0x08 && seen!=0x09'), (b'if(seen != 0x05) {', b'if(seen != 0x05 && seen != 0x0d && seen != 0x0e) {')]:
    assert b.count(old) == 1
    b = b.replace(old, new)
p.write_bytes(b)
