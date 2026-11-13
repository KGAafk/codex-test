--魂魄妖夢用ai/
--しなうす式/20250520スキル情報のみ更新

require("function_pun_strage.lua")
head_req_list()
require("youmu_tactics.lua")

function main()
--シード生成、スレッド生成、base_states設定
	set_seedthreadstates()
--キャラ確認
	char_calling()
--ステージが 核融合炉心部 だと超反応モードに
	set_printsabot()
print("[Youmu specialist v2] active")

while true do
--スレッド外初期化
	while_top()
	youmu_tick()

--●どちらかが体力無くなったら待機
	if interbattle_condi()==true then
		interbattle_exe()
--▼開幕行動▼
	elseif kaimaku_condi()==true then
		kaimaku_exe()
--▼移動起き上がり
	elseif my_act==97 or my_act==98 then --基本：画面端より遠ざかる。中央では相手から遠ざか…りたいが、設置技警戒のため、相手側に移動起き上がり。
		movedgetup_exe()

--▼簡易受け身▼：攻撃ないし回避いずれの目的であってもリカバリーポイントは限られるが、そういうことはさておき実装したもの
	elseif recovery_condi()==true then
		recovery_exe()

--▼台風になった時、フラグに従って「緋想の剣」を使用
	elseif y==0 and my_act<=10 and card_check(14) and flag_kishitu==1 then
		print("天候フラグＯＮ　⇒　「緋想の剣」使用");
		card_use(14);

--▼台風▼：近接状態からの強引な状況変更を行う行動。スペカなど使用。
	elseif youmu_confirm_step() then
		-- Confirmed normal hits take priority over neutral reactions.
	elseif react_rejecttaihu_condi()==true then
		react_rejecttaihu_exe()

--▼起き攻め▼
	elseif setplay_ongetup_condi()==true then
		setplay_ongetup_exe()
--▼ＨＪＣ▼
	--地上HJC
	elseif hjc_ground_condi()==true then
		hjc_ground_exe()
	--空中HJC
	elseif hjc_air_condi()==true then
		hjc_air_exe()

--▼反応行動
--反応：下段
	elseif 	react_lowattack_condi()==true then
		react_lowattack_exe()
--反応：地対空
	elseif react_g2a_condi()==true then
		react_g2a_exe()
--反応：低空飛翔
	elseif react_lowj6d_condi()==true then
		react_lowj6d_exe()
--上空追いかけ
	elseif ueoikake_condi()==true then
		ueoikake_exe()
--霊撃 or 霊撃札
	elseif reigeki_condi()==true then 
		print("拒否行動：霊撃　⇒　可能ならば使用");
		card_use(0)
		
--▼グレイズ：相手行動に対する反射or一定距離内のオブジェクト感知▼
--モーション反応グレイズ
	elseif
	graze_condition_xrange()==true and
	state_nottrueguard()==true and 
	my_airEX>=1 and 
	my_rei>=0 
	then--近距離時のグレイズ。のさばらせておくと、誤結界の原因となる。ガードの硬直間際ならok
		print("check 1 -> graze act X Range");
		graze_action_xrange()
			
--▼ ガード行動：簡易ガードルーチン▼
--▼ ガード反撃、龍魚の羽衣 13
	elseif hagoromo_1st_condi()==true or hagoromo_condi()==true then
		hagoromo_exe()

--回避結界
	elseif kekkai_condi()==true then
		kekkai_exe()

--▼ 宵越しの銭 12
	elseif yoikoshi_1st_condi()==true or yoikoshi_condi()==true then
		yoikoshi_exe()

--▼汎用中下段ガード
--基本は行動に対して後退入れ込み。下段のみ抽出して反応。通常射撃も同じく下段で受ける(けどメンドウだから今回は省き)。フラグを抜けてくるものは別個に対応
	elseif lowattack_aflags_condi()==true then
		guard_backexpectlowattack_exe()
	elseif overheadattack_aflags_condi()==true then
		guard_backoverheadattack_exe()
--下段判定をフィルタ
	elseif lowattack_flaged_condi()==true then
		guard_backexpectlowattack_exe()
--フラグを抜けてくるものをフィルタ
	elseif lowattack_unflaged_condi()==true then
		guard_backexpectlowattack_exe()
--屈状態では低空昇り攻撃には立てない
	elseif notstand_overhead_upjump_condi()==true then
		guard_backexpectlowattack_exe()
--以下、何もフィルタされなかった場合、立ちガード
	elseif guard_pun_condi()==true then
		guard_backoverheadattack_exe()

--[[▼オブジェが至近距離の場合、着地直前にｈｊを仕込む、タッチ＆ゴーグレイズ
	elseif touchandgo_00_condi() then
		touchandgo_00_exe()
--オブジェが至近距離の場合、ガードの前に、離陸
	elseif touchandgo_01_condi() then
		touchandgo_01_exe()
	elseif touchandgo_02_condi() then
		touchandgo_02_exe()
--]]
--オブジェが至近距離の場合、空中から地上へ飛翔　※咲夜：２D：120.0以上、３D：84.9以上必要
	elseif graze_pun_condi()==true then
		graze_pun_exe()
		
--遠距離時のグレイズ
	elseif graze_farground_condi() then
		graze_farground_exe()
	elseif graze_farair_condi() then
		graze_farair_exe()
		
--特定状況におけるガード
	elseif guard_objgimmick_condi()==true then
		guard_backexpectlowattack_exe()
--オブジェが至近距離の場合、ガード:射撃と打撃を重ねられると、しゃがみガードしてしまう。優先順位の変更が必要
	elseif guard_objclosedis_condi()==true then
		guard_backexpectlowattack_exe()
	
--▼起き上がり直後の行動
	elseif move_soonaftergetup_condi()==true then
		move_soonaftergetup_exe()

--▼コンボ▼
--近A始動
--A>AA
	elseif youmu_pressure_step() then
		-- Guard-specific AA cancel after the existing defense checks.
	elseif my_act==300 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 then
		print("A>AA",dis);
		key_event(ACT_A);
	--AA>AAA
			elseif my_act==320 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 then
				print("AA>AAA",dis);
				key_event(ACT_A);
				
			--AAA>スペカ
				elseif my_act==321 and enemy_act>=50 and enemy_act<=89 and my_card==203 and my_spell_more(2500) and my_hitstop<=3 and my_hitstop>=1 then
					if my_hitstop<=3 and my_hitstop>=1 and my_card==203 then
						print("コンボ：ＡＡＡ -> 人鬼「未来永劫斬」");
						key_event(ACT_BC);
					end
				elseif my_act==321 and enemy_act>=50 and enemy_act<=89 and my_card==212 and my_spell_more(1500) and my_hitstop<=3 and my_hitstop>=1 then
					if my_hitstop<=3 and my_hitstop>=1 and my_card==212 then
						print("コンボ：ＡＡＡ -> 転生剣「円心流転斬」");
						key_event(ACT_BC);
					end
				elseif my_act==321 and enemy_act>=50 and enemy_act<=89 and my_card==201 and my_spell_more(1500) and my_hitstop<=3 and my_hitstop>=1 then
					if my_hitstop<=3 and my_hitstop>=1 and my_card==201 then
						print("コンボ：ＡＡＡ -> 断命剣「冥想斬」");
						key_event(ACT_BC);
					end
					
		--AAA>6A>6C>etc
				elseif my_act==321 and ((enemy_act>=50 and enemy_act<=89 and my_frontside>=240 and my_frontside<=640) or (enemy_act>=143 and enemy_act<=166)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 then
					print("AAA>6A",dis);
					key_event2(ACT_A,front);
				--6A>断迷剣「迷津慈航斬」
					elseif my_act==302 and enemy_act>=50 and enemy_act<=89 and my_limit<100 and my_frontside<=450 and enemy_backside>=200 and my_card==204 and my_spell_more(2000) and enemy_hitstop<=3 and enemy_hitstop>=2 then
						card_1st(204);
						if enemy_hitstop<=3 and enemy_hitstop>=2 and my_card==204 then
							print("6A>スペルカード：断迷剣「迷津慈航斬」");
							key_event(ACT_BC);
						end
				--6A>6C
					elseif my_act==302 and enemy_act>=50 and enemy_act<=89 and my_hitstop<=2 and my_hitstop>=1 and my_limit<100 and my_frontside>=240 and my_frontside<=640 and my_rei>=200 then
						print("6A>6C",dis);
						key_event2(ACT_C,front);
						elseif my_act==411 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_allframe>=39 and my_limit<100 then
							key_resetEX();
							key_event(u_front);
					--6C>JA>J6A
						elseif my_act==209 and my_preact[1]==411 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_allframe>=3 and my_limit<100 then
							print("6C>JA",dis);
							key_event(ACT_A);
							elseif my_act==306 and enemy_act>=50 and enemy_act<=89 and my_hitstop<=2 and my_hitstop>=1 and my_limit<100 and my_combo>=5 then
								print("JA>J6A",dis);
								key_event2(ACT_A,front);
					--6C>憑坐の縛
						elseif my_act==411 and (enemy_act>=50 and enemy_act<=89) and my_allframe>=25-5 and my_limit<100 and my_card==103 and is_card_use and enemy_frame<=1 then
							card_1st(103);
							if enemy_frame<=1 then
								print("6C>スキルカード：憑坐の縛",dis);
								youmu_card_once(103);
							end
						elseif my_act==411 and (enemy_act>=50 and enemy_act<=89) and my_allframe>=25-5 and my_limit<100 and get_skill_lv(0,3)>=0 and my_rei>=200 and enemy_frame<=1 then
							print("6C>コマンド：B憑坐の縛",dis);
							key_resetEX();
							yield();
							lvr22(ACT_B);
							wait(2);
		--AAA>AAAA
				elseif my_act==321 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_hitstop<=2 and my_hitstop>=1 and my_limit<100 then
					print("AAA>AAAA",dis);
					key_event(ACT_A);
					
			--AAAA>スペカ
					elseif my_act==322 and enemy_act>=50 and enemy_act<=89 and my_card==207 and my_spell_more(2000) and my_hitstop<=3 and my_hitstop>=1 then
						if my_hitstop<=3 and my_hitstop>=1 and my_card==207 then
							print("コンボ：AAAA -> 断霊剣「成仏得脱斬」");
							key_event(ACT_BC);
						end
					elseif my_act==322 and enemy_act>=50 and enemy_act<=89 and my_card==204 and my_spell_more(2000) and my_hitstop<=3 and my_hitstop>=1 then
						if my_hitstop<=3 and my_hitstop>=1 and my_card==204 then
							print("コンボ：AAAA -> 断迷剣「迷津慈航斬」");
							key_event(ACT_BC);
						end
						
			--AAAA>生死流転斬3hit
					elseif my_act==322 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166 and my_frontside<=300)) and my_limit<100 and my_card==102 and is_card_use and enemy_hitstop<=3 and enemy_hitstop>=1 and ((card_check(200) and my_spell_more(2000)==false) or card_check(200)==false) then
						card_1st(102);
						if enemy_hitstop<=3 and enemy_hitstop>=1 then
							if my_hitstop>=1 then
								wait(my_hitstop)
							end
							wait(5);
							print("AAAA -> スキルカード：生死流転斬");
							youmu_card_once(102);
						end
					elseif my_act==322 and get_skill_lv(0,2)>=0 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and enemy_hitstop<=8 and enemy_hitstop>=1 and my_rei>=200 and ((card_check(200) and my_spell_more(2000)==false) or card_check(200)==false) then
						print("AAAA -> コマンド：C生死流転斬");
						key_resetEX();
						yield();
						lvr214(ACT_C);
						if my_hitstop>=1 then
							wait(my_hitstop)
						end
					elseif my_act>=540 and my_act<=544 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and enemy_hitstop<=8 and enemy_hitstop>=7 then
						print("生死流転斬>生死流転斬：派生");
						key_resetEX();
						wait(15);
						lvr214(ACT_B);
						if my_hitstop>=1 then
							wait(my_hitstop)
						end--]]
			--AAAA>AAAAA
					elseif my_act==322 and enemy_act>=50 and enemy_act<=89 and my_hitstop<=2 and my_hitstop>=1 and my_limit<100 then
						print("AAAA>AAAAA",dis);
						key_event(ACT_A);
						
					--AAAAA>スペカ
						elseif my_act==323 and enemy_act>=50 and enemy_act<=89 and my_card==200 and my_spell_more(1000) and my_allframe>=49 then
							if my_allframe>=49 and my_card==200 then
								print("コンボ：AAAA -> AAAAA ->（ディレイ）人符「現世斬」");
								key_event(ACT_BC);
							end
							
			--AAAAA>etc
					elseif my_act==323 and enemy_act>=50 and enemy_act<=89 and my_allframe>=50-5 and my_limit<100 and my_frontside<=280 and my_rei>=200 and not(my_card==200 and my_spell_more(1000)) then
						print("AAAAA>DA",dis);
						key_reset();
						key_on(front);
						key_on(ACT_D);
						wait(11);
						key_event(ACT_A);
						yield();key_resetEX();
						elseif my_act==305 and (enemy_act>=50 and enemy_act<=89) and my_limit<100 and my_card==101 and is_card_use and enemy_hitstop<=3 and enemy_hitstop>=2 and ey>0 then
							card_1st(101);
							if enemy_hitstop<=3 and enemy_hitstop>=2 then
								if my_hitstop>=1 then
									wait(my_hitstop+10)
								end
								print("DA -> スキルカード：弦月斬");
								youmu_card_once(101);
							end
						elseif my_act==305 and (enemy_act>=50 and enemy_act<=89) and my_limit<100 and enemy_hitstop<=6 and enemy_hitstop>=5 and get_skill_lv(0,1)>=0 and ((my_dir==1 and x>=1000)or(my_dir==-1 and x<=280)) and my_rei>=200 and ey>0 then
							print("DA -> コマンド：C弦月斬");
							key_resetEX();
							if my_hitstop>=1 then
								wait(my_hitstop+10)
							end
							lvr623(ACT_C);
		
--遠A>6A
	elseif my_act==301 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166 and math.random(3)<=2)) then
		print("遠A -> 6A");
		key_event2(ACT_A,front);
--遠A>3A
	elseif my_act==301 and (enemy_act>=143 and enemy_act<=166) and dis<=200 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true then
		print("遠A -> 3A");
		key_event2(ACT_A,d_front);
		
--6A>6B
	elseif my_act==302 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and my_rei>=200 and math.random(5)==1 then
		print("6Ａ -> 6B");
		key_event2(ACT_B,front);
--6A>6B
	elseif my_act==304 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and my_rei>=200 and math.random(5)==1 then
		print("3Ａ -> 6B");
		key_event2(ACT_B,front);
--A>6B
	elseif ey==0 and (my_act==300 or my_act==330) and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and my_rei>=200 and math.random(5)==1 then
		print("コンボ：Ａ -> 6B");
		key_event2(ACT_B,front);
--AA>6B
		elseif ey==0 and my_act==320 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and my_rei>=200 and math.random(5)==1 then
		print("AA>6B",dis);
		key_event2(ACT_B,front);
			
--6A>2C
	elseif my_act==302 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and my_frontside<=340 and my_rei>=200 and math.random(5)==1 then
		print("6Ａ -> 2C");
		key_event2(ACT_C,ACT_DOWN);
--3A>2C
	elseif my_act==304 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and my_frontside<=340 and my_rei>=200 and math.random(5)==1 then
		print("3Ａ -> 2C");
		key_event2(ACT_C,ACT_DOWN);
--A>2C
	elseif ey==0 and (my_act==300 or my_act==330) and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and my_frontside<=340 and my_rei>=200 and math.random(5)==1 then
		print("コンボ：Ａ -> 2C");
		key_event2(ACT_C,ACT_DOWN);
--AA>2C
		elseif ey==0 and my_act==320 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and my_frontside<=340 and my_rei>=200 and math.random(5)==1 then
		print("AA>2C",dis);
		key_event2(ACT_C,ACT_DOWN);
		
--6A>縛
	elseif my_act==302 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=6 and my_hitstop>=5 and is_dir_front==true and my_rei>=400 and get_skill_lv(0,3)>=0 and math.random(5)==1 then
		print("6Ａ -> 縛");
		lvr22(ACT_B);
		yield();
--3A>縛
	elseif my_act==304 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=6 and my_hitstop>=5 and is_dir_front==true and my_rei>=400 and get_skill_lv(0,3)>=0 and math.random(5)==1 then
		print("3Ａ -> 縛");
		lvr22(ACT_B);
		yield();
--A>縛
	elseif ey==0 and (my_act==300 or my_act==330) and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=6 and my_hitstop>=5 and is_dir_front==true and my_rei>=400 and get_skill_lv(0,3)>=0 and math.random(5)==1 then
		print("コンボ：Ａ -> 縛");
		lvr22(ACT_B);
		yield();
--AA>縛
		elseif ey==0 and my_act==320 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=6 and my_hitstop>=5 and my_rei>=400 and get_skill_lv(0,3)>=0 and math.random(5)==1 then
		print("AA>縛",dis);
		lvr22(ACT_B);
		yield();
			
--AA>6A
		elseif my_act==320 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and math.random(5)==1 then
			print("AA>6A",dis);
			key_event2(ACT_A,front);
--AA>3A
		elseif my_act==320 and dis<=200 and enemy_act>=143 and enemy_act<=166 and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and math.random(5)==1 then
			print("AA>3A",dis);
			key_event2(ACT_A,d_front);
--2A>6A
		elseif my_act==303 and enemy_act>=143 and enemy_act<=166 and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and math.random(5)==1 then
			print("2A>6A",dis);
			key_event2(ACT_A,front);
			if my_hitstop>=1 then
				wait(my_hitstop)
			end
--2A>3A
		elseif my_act==303 and dis<=200 and enemy_act>=143 and enemy_act<=166 and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and math.random(5)==1 then
			print("2A>3A",dis);
			key_event2(ACT_A,d_front);
			if my_hitstop>=1 then
				wait(my_hitstop)
			end
--遠2A>6A
		elseif my_act==311 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and math.random(5)==1 then
			print("2A>6A",dis);
			key_event2(ACT_A,front);
			if my_hitstop>=1 then
				wait(my_hitstop)
			end
--遠2A>3A
		elseif my_act==311 and dis<=200 and (enemy_act>=143 and enemy_act<=166) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and math.random(5)==1 then
			print("2A>3A",dis);
			key_event2(ACT_A,d_front);
			if my_hitstop>=1 then
				wait(my_hitstop)
			end

--JA>J6A
	elseif my_act==306 and ((ey==0 and my_yspeed>=5)or(ey>0)) and ey<=y+0 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 then
		print("JA>J6A",dis);
		key_event2(ACT_A,front);
--JA>J8A
	elseif my_act==306 and ((ey==0 and my_yspeed>=5)or(ey>0)) and ey>=y+0 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 then
		print("JA>J8A",dis);
		key_event2(ACT_A,ACT_UP);
	--J6A or J8A>J6C
		elseif my_act==307 and ((ey==0 and my_yspeed>=5)or(ey>0)) and enemy_act>=50 and enemy_act<=89 and my_frontside<=640 and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and my_rei>=200 then
			print("JA/J8A>J6C",dis);
			key_event2(ACT_C,front);
		elseif my_act==309 and ((ey==0 and my_yspeed>=5)or(ey>0)) and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=166 and math.random(2)==1)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and my_rei>=200 then
			print("JA/J8A>J6C",dis);
			key_event2(ACT_C,front);
	--J6A or J8A>JB
		elseif (my_act==307 or my_act==309) and ((enemy_act>=50 and enemy_act<=89 and ((my_dir==1 and x<=640)or(my_dir==-1 and x>=640)))or(enemy_act>=143 and enemy_act<=166)) and my_hitstop<=3 and my_hitstop>=2 and my_limit<100 and my_rei>=200 then
			print("JA/J8A>JB",dis);
			key_event2(ACT_B,front);
			
--色んなところから燐気斬
	elseif (my_act==302 or my_act==304 or my_act==305) and (enemy_act>=143 and enemy_act<=166) and my_card==108 and is_card_use and enemy_hitstop<=3 and enemy_hitstop>=2 then
		card_1st(108);
		if enemy_hitstop<=3 and enemy_hitstop>=2 then
			print("攻撃 -> スキルカード：燐気斬");
			youmu_card_once(108);
		end
	elseif (my_act==302 or my_act==304 or my_act==305) and (enemy_act>=143 and enemy_act<=166) and get_skill_lv(0,8)>=0 and enemy_hitstop<=8 and enemy_hitstop>=1 and my_rei>=400 then
		print("攻撃 -> コマンド：B燐気斬");
		key_resetEX(); key_on(ACT_D); yield(); key_resetEX();
		lvr236(ACT_B);
		if my_hitstop>=6 then
			wait(my_hitstop-5)
		end
--2A>弦月斬
	elseif ey==0 and my_act==303 and my_combo>=3 and (enemy_act>=50 and enemy_act<=89) and get_skill_lv(0,1)>=0 and enemy_hitstop<=8 and enemy_hitstop>=1 and my_rei>=400 then
		print("２A>コマンド：C弦月斬");
		lvr623(ACT_C);
		if my_hitstop>=6 then
			wait(my_hitstop-5)
		end
--DA>弦月斬
	elseif (my_act==303 or my_act==305 or my_act==330) and (enemy_act>=50 and enemy_act<=89) and my_card==101 and is_card_use and enemy_hitstop<=3 and enemy_hitstop>=2 then
		card_1st(101);
		if enemy_hitstop<=3 and enemy_hitstop>=2 then
			print("DA>スキルカード：弦月斬");
			youmu_card_once(101);
		end
	elseif ey==0 and (dis<=120 or enemy_backside<=100) and my_act==305 and (enemy_act>=50 and enemy_act<=89) and get_skill_lv(0,1)>=0 and enemy_hitstop<=8 and enemy_hitstop>=1 and my_rei>=400 then
		print("DA>コマンド：C弦月斬");
		lvr623(ACT_C);
		if my_hitstop>=6 then
			wait(my_hitstop-5)
		end
	elseif ey>0 and my_act==305 and (enemy_act>=50 and enemy_act<=89) and get_skill_lv(0,1)>=0 and enemy_hitstop<=8 and enemy_hitstop>=1 and my_rei>=400 then
		print("DA>コマンド：B弦月斬");
		lvr623(ACT_B);
		if my_hitstop>=6 then
			wait(my_hitstop-5)
		end
--JB着地硬直>6C
	elseif my_act==10 and my_preact[1]==404 and y==0 and my_rei>=400 and (is_dir_front==false or (is_dir_front==true and dis<=60)) then
		print("JB>6C",dis);
		--key_event2(ACT_C,ACT_DOWN);
		key_event2(ACT_C,front);

			
		--]]
	
--▼コンボ・固め兼用▼

--▼spell card▼

--▼cost2

--人符「現世斬」,200,600,g
	--Ground
	elseif my_card==200 and card_check(200)==true and
	my_spell_more(1000) and
	dis<500 and
	y==0 and
	--ey<50 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("人符「現世斬」");
		youmu_card_once(200);

--魂符「幽明の苦輪」,202,602,g
	--Ground
	elseif my_card==202 and card_check(202)==true and
	my_spell_more(1000) and
	--dis<320 and
	y==0 and
	--ey<50 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	--is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("魂符「幽明の苦輪」");
		youmu_card_once(202);

--▼cost3

--断命剣「冥想斬」,201,601,g
	--Ground
	elseif my_card==201 and card_check(201)==true and
	my_spell_more(1500) and
	dis<400 and
	y==0 and
	ey<100 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("断命剣「冥想斬」");
		youmu_card_once(201);

--剣伎「桜花閃々」,206,606,g
	--Ground
	elseif my_card==206 and card_check(206)==true and
	my_spell_more(1500) and
	dis<300 and
	y==0 and
	dis_y<100 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	--is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("剣伎「桜花閃々」");
		youmu_card_once(206);

--転生剣「円心流転斬」,212,612,g
	--Ground
	elseif my_card==212 and card_check(212)==true and
	my_spell_more(1500) and
	dis<300 and
	y==0 and
	dis_y<100 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("転生剣「円心流転斬」");
		youmu_card_once(212);

--▼cost4

--断迷剣「迷津慈航斬」,204,604,g
	--Ground
	elseif my_card==204 and card_check(204)==true and
	my_spell_more(2000) and
	dis<500 and
	y==0 and
	ey<100 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("断迷剣「迷津慈航斬」");
		youmu_card_once(204);

--断霊剣「成仏得脱斬」,207,607,g
	--Ground
	elseif my_card==207 and card_check(207)==true and
	my_spell_more(2000) and
	dis<400 and
	y==0 and
	--dis_y<50 and
	--ey<100 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("断霊剣「成仏得脱斬」");
		youmu_card_once(207);

--▼cost5

--人鬼「未来永劫斬」,203,603,g
	--Ground
	elseif my_card==203 and card_check(203)==true and
	my_spell_more(2500) and
	dis<600 and
	y==0 and
	ey<50 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("人鬼「未来永劫斬」");
		youmu_card_once(203);

--魂魄「幽明求聞持聡明の法」,205,605,g
	--Ground
	elseif my_card==205 and card_check(205)==true and
	my_spell_more(2500) and
	--dis<250 and
	y==0 and
	--ey<100 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	--is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("魂魄「幽明求聞持聡明の法」");
		youmu_card_once(205);

--空観剣「六根清浄斬」,208,608,g
	--Ground
	elseif my_card==208 and card_check(208)==true and
	my_spell_more(2500) and
	dis<250 and
	y==0 and
	ey<100 and
	enemy_yspeed<=0 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	--enemy_obj_range_in(150,60)==false and 
	--is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
		print("空観剣「六根清浄斬」");
		youmu_card_once(208);

--
--▼skill card▼

	--▼スキル236

		--反射下界斬,100,500,500,g
			--g,B,C
				elseif get_skill_lv(0,0)>=0 and my_rei>=400 and 
					--dis>300 and
					--dis_y<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==true and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("反射下界斬");
						lvr236(ACT_B);
					
				elseif my_card==100 and card_check(100)==true and my_rei>=400 and
					--dis>300 and
					--dis_y<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==true and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("反射下界斬");
						youmu_card_once(100);
		
		--結跏趺斬,104,505,506,g
			--g,a
				elseif get_skill_lv(0,4)>=0 and my_rei>=400 and 
					dis>200 and
					dis_y<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("結跏趺斬");
						lvr236(ACT_B);
					
				elseif get_skill_lv(0,4)>=0 and my_rei>=400 and 
					dis>300 and
					dis_y<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("結跏趺斬");
						lvr236(ACT_C);
					
				elseif my_card==104 and card_check(104)==true and my_rei>=400 and
					dis>200 and
					dis_y<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("結跏趺斬");
						youmu_card_once(104);
		
		--燐気斬,108,510,511,g

				elseif get_skill_lv(0,8)>=0 and my_rei>=400 and 
					--dis>100 and 
					dis<300 and
					dis_y<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("燐気斬");
						lvr236(ACT_B);
					
				elseif get_skill_lv(0,8)>=0 and my_rei>=400 and 
					dis>100 and
					dis<400 and
					dis_y<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("燐気斬");
						lvr236(ACT_C);
					
				elseif my_card==108 and card_check(108)==true and my_rei>=400 and
					--dis>100 and 
					dis<300 and
					dis_y<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("燐気斬");
						youmu_card_once(108);
		
	--▼スキル623

		--弦月斬,101,520,521,g

				elseif get_skill_lv(0,1)>=0 and my_rei>=400 and 
					dis<150 and
					y==0 and
					ey<200 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("弦月斬");
						lvr623(ACT_B);
					
				elseif get_skill_lv(0,1)>=0 and my_rei>=400 and 
					dis<150 and
					y==0 and
					ey<200 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					--enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("弦月斬");
						lvr623(ACT_C);
					
				elseif my_card==101 and card_check(101)==true and my_rei>=400 and
					dis<150 and
					y==0 and
					ey<200 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("弦月斬");
						youmu_card_once(101);
		
		--折伏無間,105,525,526,g,追撃,529
			--g
				elseif get_skill_lv(0,5)>=0 and my_rei>=400 and 
					dis<50 and
					y==0 and
					ey==0 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("折伏無間");
						lvr623(ACT_B);
					
				elseif get_skill_lv(0,5)>=0 and my_rei>=400 and 
					dis<50 and
					y==0 and
					ey==0 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(65)==1 then
						print("折伏無間");
						lvr623(ACT_C);
					
				elseif my_card==105 and card_check(105)==true and my_rei>=400 and
					dis<50 and
					y==0 and
					ey==0 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("折伏無間");
						youmu_card_once(105);
		
		--炯眼剣,109,530,531,g
			--g,a
				elseif get_skill_lv(0,9)>=0 and my_rei>=400 and 
					dis<200 and
					y==0 and
					ey<200 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(128)==1 then
						print("炯眼剣");
						lvr623(ACT_B);
					
				elseif get_skill_lv(0,9)>=0 and my_rei>=400 and 
					dis<300 and
					y==0 and
					ey<200 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(128)==1 then
						print("炯眼剣");
						lvr623(ACT_C);
					
				elseif my_card==109 and card_check(109)==true and my_rei>=400 and
					dis<200 and
					y==0 and
					ey<200 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(128)==1 then
						print("炯眼剣");
						youmu_card_once(109);

	--▼スキル214
		--生死流転斬,102,540,541,g,追加入力２段目以降,540
			--g
				elseif get_skill_lv(0,2)>=0 and my_rei>=400 and 
					dis<200 and
					y==0 and
					ey<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					--is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("生死流転斬");
						lvr421(ACT_B);
					
				elseif get_skill_lv(0,2)>=0 and my_rei>=400 and 
					dis<300 and
					y==0 and
					ey<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					--is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("生死流転斬");
						lvr421(ACT_C);
					
				elseif my_card==102 and card_check(102)==true and my_rei>=400 and
					dis<200 and
					y==0 and
					ey<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					--is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("生死流転斬");
						youmu_card_once(102);
		
		--心抄斬,106,545,546,g
			--g,a
				elseif get_skill_lv(0,6)>=0 and my_rei>=400 and 
					dis<300 and
					y==0 and
					ey<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					--enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("心抄斬");
						lvr421(ACT_B);
					
				elseif get_skill_lv(0,6)>=0 and my_rei>=400 and 
					dis<500 and
					y==0 and
					ey<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					--enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("心抄斬");
						lvr421(ACT_C);
					
				elseif my_card==106 and card_check(106)==true and my_rei>=400 and
					dis<300 and
					y==0 and
					ey<50 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					--enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("心抄斬");
						youmu_card_once(106);
		
		--頭上花剪斬,110,550,551,g,hold
			--g
				elseif get_skill_lv(0,10)>=0 and my_rei>=400 and 
					dis<300 and
					y==0 and
					ey<100 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					enemy_act>300 and
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					--is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("頭上花剪斬");
						lvr421(ACT_B);
					
				elseif get_skill_lv(0,10)>=0 and my_rei>=400 and 
					dis<300 and
					y==0 and
					ey<100 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==true and 
					--is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(65)==1 then
						print("頭上花剪斬");
						lvr421(ACT_C);
					
				elseif my_card==110 and card_check(110)==true and my_rei>=400 and
					dis<300 and
					y==0 and
					ey<100 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					enemy_act>300 and
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					--is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("頭上花剪斬");
						youmu_card_once(110);

	--▼スキル22
		--憑坐の縛,103,560,561,g
			--g,a
				elseif get_skill_lv(0,3)>=0 and my_rei>=400 and 
					hanreidis>-100 and 
					hanreiy-ey+90>-100 and hanreiy-ey+90<100 and
					dis>200 and
					y==0 and
					ey<300 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("憑坐の縛");
						lvr22(ACT_B);
					
				elseif get_skill_lv(0,3)>=0 and my_rei>=400 and 
					hanreidis>-100 and 
					hanreiy-ey+90>-100 and hanreiy-ey+90<100 and
					dis>200 and
					y==0 and
					ey<300 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(65)==1 then
						print("憑坐の縛");
						lvr22(ACT_C);
					
				elseif my_card==103 and card_check(103)==true and my_rei>=400 and
					hanreidis>-100 and 
					hanreiy-ey+90>-100 and hanreiy-ey+90<100 and
					dis>200 and
					y==0 and
					ey<300 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("憑坐の縛");
						youmu_card_once(103);
		
		--悪し魂,107,565,566,g
			--g
				elseif get_skill_lv(0,7)>=0 and my_rei>=400 and 
					hanreidis>-200 and hanreidis<200 and 
					hanreiy-ey+90>-200 and hanreiy-ey+90<200 and
					dis>200 and
					y==0 and
					ey<300 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("悪し魂");
						lvr22(ACT_B);
					
				elseif get_skill_lv(0,7)>=0 and my_rei>=400 and 
					hanreidis>-200 and hanreidis<200 and 
					hanreiy-ey+90>-200 and hanreiy-ey+90<200 and
					dis>200 and
					y==0 and
					ey<300 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(65)==1 then
						print("悪し魂");
						lvr22(ACT_C);
					
				elseif my_card==107 and card_check(107)==true and my_rei>=400 and
					hanreidis>-200 and hanreidis<200 and 
					hanreiy-ey+90>-200 and hanreiy-ey+90<200 and
					dis>200 and
					y==0 and
					ey<300 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("悪し魂");
						youmu_card_once(107);
		
		--奇び半身,111,570,571,572,573,g,a
			--g
				elseif get_skill_lv(0,11)>=0 and my_rei>=400 and 
					ey-hanreiy>-0.5*hanreidis and ey-hanreiy<-0.2*dis and
					dis>200 and
					ey-y>-0.5*dis+150 and ey-y<0.5*dis+150 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					--is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("奇び半身");
						lvr22(ACT_B);
					
				elseif get_skill_lv(0,11)>=0 and my_rei>=400 and 
					ey-hanreiy>-0.5*hanreidis and ey-hanreiy<-0.2*dis and
					dis>200 and
					ey-y>-0.5*dis+150 and ey-y<0.5*dis+150 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(65)==1 then
						print("奇び半身");
						lvr22(ACT_C);
					
				elseif my_card==111 and card_check(111)==true and my_rei>=400 and
					ey-hanreiy>-0.5*hanreidis and ey-hanreiy<-0.2*dis and
					dis>200 and
					ey-y>-0.5*dis+150 and ey-y<0.5*dis+150 and
					not(my_act>=50 and my_act<180) and my_act<600 and 
					get_fflags(0,32)==true and
					get_fflags(0,8)==false and get_fflags(1,8)==false and 
					enemy_obj_range_in(150,60)==false and 
					--is_dir_front==true and 
					subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
						print("奇び半身");
						youmu_card_once(111);
--]]
			

-- Youmu-specific neutral: deterministic geometry and resource checks.
	elseif youmu_neutral_step() then
		-- Inputs already submitted by the specialist.
--低空飛翔で接近
	elseif move_approachbylowflaying_condi()==true then
		move_approachbylowflaying_exe()
--８８３飛翔
	elseif move_approachby883d_condi()==true then
		move_approachby883d_exe()
--▼ 終端運動
--▼ 相手上空へ飛び上がった際の処理
	elseif move_attakeoverhead_condi()==true then
		move_attakeoverhead_exe()
--▼ 終端機動
	--▼ 対台風時
	elseif move_terminationtaihu_condi()==true then
		move_terminationtaihu_exe()
	--▼ 終端機動1
	--台風じゃない時だが…
	elseif move_termination1_condi()==true then
		move_termination1_exe()
	-- Ground fallback for Youmu, evaluated once per game frame.
	elseif youmu_movement_step() then
		-- No multi-frame idle or arbitrary range oscillation.

	end
	
	yield()
end
end