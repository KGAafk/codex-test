from pathlib import Path
import re

root = Path('youmu')
for p in root.iterdir():
    if p.suffix in ('.lua', '.ai'):
        p.read_bytes().decode('cp932')
source = (root / '05_youmu_main.lua').read_bytes().decode('cp932')
start = source.index('--\u25bc\u30b9\u30ad\u30eb22')
end = source.index('-- Youmu-specific neutral:', start)
skills = source[start:end]
assert len(re.findall(r'lvr22\(ACT_[BC]\)', skills)) == 6
assert not re.search(r'lvr214\(ACT_[BC]\)', skills)
for card in (103, 107, 111):
    assert f'youmu_card_once({card})' in skills
assert not re.search(r'for i=1,10 do\s*card_use\(', source)
assert 'my_act==10 and my_preact[1]==404 and y==0' in source
assert 'youmu_confirm_step()' in source and 'youmu_pressure_step()' in source
print('Youmu source integration checks passed')
