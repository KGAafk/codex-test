assert(loadfile('attack-pack-test.lua'))()
my_dir=1; enemy_hitarea_n=2; y=100; my_yspeed=0; m_gs=0; e_gs=0
my_hitstop=0; enemy_hitstop=0; x=500; ex=600; ey=170
my_xspeedEX=0; enemy_xspeedEX=0; enemy_dir=1; enemy_yspeed=0
enemy_hitarea_right={-100,20}; enemy_hitarea_left={0,0}
enemy_hitarea_top={0,0}; enemy_hitarea_bottom={0,0}
assert(JA_attack_calculation()==true,'second hurtbox should be considered')
enemy_hitarea_right={-100,-100}
assert(JA_attack_calculation()==false,'no matching hurtbox should fail')
print('Lua syntax and hitbox checks passed')
