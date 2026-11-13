local paths = {'000_youmu.ai','05_youmu_main.lua','youmu_tactics.lua',
  'attack-pack.lua','def_clc.lua','function_command.lua','function_pun_strage.lua',
  'graze_action_xrange.lua','graze_condition_xrange.lua','key_count_calc.lua',
  'sabot_after_guard.lua','sabot_delay_control.lua','sabot_wakeup.lua'}
for _, path in ipairs(paths) do
  local f, err = loadfile('youmu/'..path)
  assert(f, path..': '..(err or 'syntax error'))
end
assert(loadfile('youmu/youmu_tactics.lua'))()
ACT_UP=0; ACT_DOWN=1; ACT_LEFT=2; ACT_RIGHT=3; ACT_A=4; ACT_B=5
ACT_C=6; ACT_D=7; ACT_AB=8; ACT_BC=9
front=3; back=2; d_front=11
local inputs={}
function key_on(a) inputs[#inputs+1]={'on',a} end
function key_off(a) inputs[#inputs+1]={'off',a} end
function key_event(a) inputs[#inputs+1]={'event',a} end
function key_event2(a,b) inputs[#inputs+1]={'event2',a,b} end
function get_fflags(side,flag) return flag==32 end
function enemy_obj_range_in() return false end
function card_check(id) return id==203 end
function my_spell_more() return true end
my_char=5; my_hp=10000; enemy_hp=10000; battle_time=100
my_act=0; enemy_act=0; my_hitstop=0; my_limit=0; my_rei=1000
y=0; ey=0; x=500; ex=600; dis=100; my_dir=1; enemy_dir=-1
my_xspeedEX=0; enemy_xspeedEX=0; my_yspeed=0; enemy_yspeed=0
m_gs=0; e_gs=0; my_allframe=0; my_combo=0; subs_count=1000; nega_count=1000
is_dir_front=true; is_card_use=true; my_card=203; hanreidis=500; hanreiy=0
my_act=300; enemy_act=50; my_hitstop=2
assert(youmu_confirm_choice()=='A','A hit confirm')
my_act=320; assert(youmu_confirm_choice()=='A','AA hit confirm')
enemy_act=154; assert(youmu_confirm_choice()==nil,'guard is not hit')
assert(youmu_pressure_choice()=='6A','low guard pressure')
enemy_act=150; assert(youmu_pressure_choice()=='3A','high guard pressure')
my_limit=100; assert(youmu_pressure_choice()==nil,'no cancel after limit')
my_limit=0; my_hitstop=0; my_act=0; enemy_act=0
assert(youmu_neutral_choice()=='A','close neutral attack')
my_act=60; assert(youmu_neutral_choice()==nil,'no attack during hitstun')
my_act=0; dis=500; my_rei=100
assert(youmu_neutral_choice()==nil,'no low-spirit shot')
my_rei=500; assert(youmu_neutral_choice()=='6B','ranged shot with spirit')
youmu_neutral_step(); assert(youmu_neutral_choice()==nil,'shot cooldown')
inputs={}; my_card=200
assert(not youmu_card_once(203) and #inputs==0,'do not use wrong card')
my_card=203; assert(youmu_card_once(203) and #inputs==1,'use selected card once')
is_card_use=false; assert(not youmu_card_once(203),'do not use unavailable card')
is_card_use=true; y=100; ey=170; dis=100; x=500; ex=600; my_act=9
my_dir=1; enemy_dir=-1; my_xspeedEX=2; enemy_xspeedEX=3
local a,b=youmu_predict(9)
x=780; ex=680; my_dir=-1; enemy_dir=1
local c,d=youmu_predict(9)
assert(a==c and b==d,'mirrored velocity prediction')
enemy_dir=-1; local same=youmu_predict(9)
assert(same~=c,'same-direction velocities differ from opposite directions')
assert(loadfile('youmu/function_pun_strage.lua'))()
function get_special_data() return 0 end
function get_fflags(side,flag) return side==1 and flag==64 end
function get_aflags() return false end
weather=0; enemy_act=300; dis2=100; x=500; ex=600; enemy_dir=-1
assert(guard_pun_condi(),'guard opponent facing left')
enemy_dir=1; assert(not guard_pun_condi(),'ignore opponent facing away')
x=700; ex=600; enemy_dir=1; assert(guard_pun_condi(),'guard opponent facing right')
enemy_dir=-1; assert(not guard_pun_condi(),'ignore mirrored opponent facing away')
function get_fflags(side,flag) return flag==32 end
enemy_char=3; enemy_act=0; my_act=0; y=0; ey=0; dis=500; my_rei=1000
my_char=5; my_hp=10000; enemy_hp=10000; battle_time=200
subs_count=1000; nega_count=1000; is_dir_front=true
my_card=203; is_card_use=true; inputs={}
assert(youmu_movement_step(),'Alice airborne approach')
local up, dash=false,false
for _,e in ipairs(inputs) do
  if e[1]=='on' and e[2]==ACT_UP then up=true end
  if e[1]=='on' and e[2]==ACT_D then dash=true end
end
assert(up and dash,'approach presses up and dash')
inputs={}; battle_time=201
assert(youmu_movement_step(),'movement remains responsive')
for _,e in ipairs(inputs) do assert(not(e[1]=='on' and e[2]==ACT_UP),'no repeat jump during cooldown') end
print('Youmu syntax and tactical regression checks passed')
