--霊烏路空用ai
--しなうす式/20220710check/20250522スキル情報のみ更新

require("function_pun_strage.lua")
head_req_list()

function main()
--シード生成、スレッド生成、base_states設定
	set_seedthreadstates()
--キャラ確認
	char_calling()
--ステージが 核融合炉心部 だと超反応モードに
	set_printsabot()

while true do
--スレッド外初期化
	while_top()

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
--AAAA連携
--AA
	elseif my_act==300 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(2)==1 then
		print("コンボ：A>ＡＡ");
		key_event(ACT_A);
	--AAA
		elseif dis<=130 and my_act==320 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(2)==1 then
			print("コンボ：AA>ＡＡＡ");
			key_event(ACT_A);
		--AAAA
			elseif my_act==321 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(2)==1 then
				print("コンボ：AAA>ＡＡＡＡ");
				key_event(ACT_A);
	--6A
		elseif dis>=130 and my_act==320 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(2)==1 then
			print("コンボ：AA>3A");
			key_event2(ACT_A,d_front);
	--3A
		elseif dis>=130 and my_act==320 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(3)==1 then
			print("コンボ：AA>3A");
			key_event2(ACT_A,d_front);
--J5A
	--brank
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(8)==1 then
		print("コンボ：J5A>brank");
		wait(2);
	--J6A
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(9)==1 then
		print("コンボ：J5A>J6A");
		key_event2(ACT_A,front);
	--J8A
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(10)==1 then
		print("コンボ：J5A>J8A");
		key_event2(ACT_A,ACT_UP);
	--J2A
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(11)==1 then
		print("コンボ：J5A>J2A");
		key_event2(ACT_A,ACT_DOWN);
		
	--J5B
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(12)==1 then
		print("コンボ：J5A>J5B");
		key_event(ACT_B);
	--J6B
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(13)==1 then
		print("コンボ：J5A>J6B");
		key_event2(ACT_B,front);
	--J8B
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(18)==1 then
		print("コンボ：J5A>J8A");
		key_event2(ACT_B,ACT_UP);
	--J2B
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(19)==1 then
		print("コンボ：J5A>J2B");
		key_event2(ACT_B,ACT_DOWN);
		
	--J5C
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(14)==1 then
		print("コンボ：J5A>J5C");
		key_event(ACT_C);
	--J6C
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(15)==1 then
		print("コンボ：J5A>J6C");
		key_event2(ACT_C,front);
	--J8C
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(16)==1 then
		print("コンボ：J5A>J8A");
		key_event2(ACT_C,ACT_UP);
	--J2C
	elseif my_act==306 and my_hitstop<=3 and my_hitstop>=2 and is_dir_front==true and math.random(17)==1 then
		print("コンボ：J5A>J2C");
		key_event2(ACT_C,ACT_DOWN);
		
--▼固め▼

--▼攻撃▼

--▼spell card▼

--▼cost1

--「地獄の人工太陽」
	--Ground
		elseif card_check(206)==true and
			my_spell_more(500) and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("「地獄の人工太陽」");
				for i=1,10 do
					card_use(206);
					yield()
				end

--▼cost2

--制御「セルフトカマク」
	--Ground
		elseif card_check(211)==true and
			my_spell_more(1000) and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("制御「セルフトカマク」");
				for i=1,10 do
					card_use(211);
					yield()
				end

--遮光「核熱バイザー」
	--Ground
		elseif card_check(213)==true and
			my_spell_more(1000) and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("遮光「核熱バイザー」");
				for i=1,10 do
					card_use(213);
					yield()
				end

--▼cost3

--爆符「メガフレア」
	--Ground
		elseif card_check(200)==true and
			my_spell_more(1500) and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("爆符「メガフレア」");
				for i=1,10 do
					card_use(200);
					yield()
				end

	--Air
		elseif card_check(200)==true and
			my_spell_more(1000) and
			y>0 and
			ey-y-100>-1*(ex-x)*my_dir and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("爆符「メガフレア」");
				for i=1,10 do
					card_use(200);
					yield()
				end

--焔星「フィクストスター」
	--Ground
	--Air
		elseif card_check(203)==true and
			my_spell_more(1500) and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("焔星「フィクストスター」");
				for i=1,10 do
					card_use(203);
					yield()
				end

--核符「クリーピングサン」
	--Ground
	--Air
		elseif card_check(205)==true and
			my_spell_more(1500) and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("核符「クリーピングサン」");
				for i=1,10 do
					card_use(205);
					yield()
				end

--光熱「ハイテンションブレード」
	--Ground
		elseif card_check(208)==true and
			my_spell_more(1500) and
			dis<400 and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("光熱「ハイテンションブレード」");
				for i=1,10 do
					card_use(208);
					yield()
				end

--▼cost4

--焔星「十凶星」
	--Ground
		elseif card_check(204)==true and
			my_spell_more(2000) and
			dis<200 and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("焔星「十凶星」");
				for i=1,10 do
					card_use(204);
					yield()
				end

--地熱「核ブレイズゲイザー」
	--Ground
		elseif card_check(207)==true and
			my_spell_more(2000) and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("地熱「核ブレイズゲイザー」");
				for i=1,10 do
					card_use(207);
					yield()
				end

--鴉符「八咫烏ダイブ」
	--Ground
		elseif card_check(209)==true and
			my_spell_more(2000) and
			dis<200 and
			y==0 and
			ey<=150 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("鴉符「八咫烏ダイブ」");
				for i=1,10 do
					card_use(209);
					yield()
				end

	--Air
		elseif card_check(209)==true and
			my_spell_more(2000) and
			y>0 and
			ey-y-100>-1*(ex-x)*my_dir and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("鴉符「八咫烏ダイブ」");
				for i=1,10 do
					card_use(209);
					yield()
				end

--核熱「核反応制御不能ダイブ」
	--Ground
	--Air
		elseif card_check(210)==true and
			my_spell_more(2000) and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("核熱「核反応制御不能ダイブ」");
				for i=1,10 do
					card_use(210);
					yield()
				end

--「サブタレイニアンサン」
	--Ground
	--Air
		elseif card_check(212)==true and
			my_spell_more(2000) and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("「サブタレイニアンサン」");
				for i=1,10 do
					card_use(212);
					yield()
				end

--▼cost5

--爆符「ギガフレア」
	--Ground
		elseif card_check(201)==true and
			my_spell_more(2500) and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("爆符「ギガフレア」");
				for i=1,10 do
					card_use(201);
					yield()
				end

--「アビスノヴァ」
	--Ground
		elseif card_check(214)==true and
			my_spell_more(2500) and
			y==0 and
			not(my_act>=50 and my_act<180) and my_act<600 and 
			get_fflags(0,32)==true and
			get_fflags(0,8)==false and get_fflags(1,8)==false and 
			enemy_obj_range_in(150,60)==false and 
			is_dir_front==true and 
			subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
				print("「アビスノヴァ」");
				for i=1,10 do
					card_use(214);
					yield()
				end
			
--▼skill card▼


--▼スキル623

--フレアアップ,100,500,
	elseif get_skill_lv(0,0)>=0 and
		my_rei>=400 and 
		dis<140 and
		y==0 and
		--ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("フレアアップ");
			lvr623(ACT_B);
			
	elseif get_skill_lv(0,0)>=0 and
		my_rei>=400 and 
		dis<200 and
		y==0 and
		--ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("フレアアップ");
			lvr623(ACT_C);

	elseif card_check(100)==true and
		my_rei>=400 and
		dis<250 and
		y==0 and
		--ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("フレアアップ");
			for i=1,10 do
				card_use(100);
				yield()
			end
			
--ロケットダイブ,104,505
	elseif get_skill_lv(0,4)>=0 and
		my_rei>=400 and 
		dis_y<200 and
		--y==0 and
		--ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(640)==1 then
			print("ロケットダイブ");
			lvr623(ACT_B);
			
	elseif get_skill_lv(0,4)>=0 and
		my_rei>=400 and 
		dis_y<200 and
		--y==0 and
		--ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(641)==1 then
			print("ロケットダイブ");
			lvr623(ACT_C);

	elseif card_check(104)==true and
		my_rei>=400 and
		dis_y<200 and
		--y==0 and
		--ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("ロケットダイブ");
			for i=1,10 do
				card_use(104);
				yield()
			end
			
--メルティング浴びせ蹴り,108,510,
	elseif get_skill_lv(0,8)>=0 and
		my_rei>=400 and 
		dis<200 and
		y==0 and
		ey==0 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("メルティング浴びせ蹴り");
			lvr623(ACT_B);
			
	elseif get_skill_lv(0,8)>=0 and
		my_rei>=400 and 
		dis<200 and
		y==0 and
		ey==0 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(161)==1 then
			print("メルティング浴びせ蹴り");
			lvr623(ACT_C);

	elseif card_check(108)==true and
		my_rei>=400 and
		dis<200 and
		y==0 and
		ey==0 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("メルティング浴びせ蹴り");
			for i=1,10 do
				card_use(108);
				yield()
			end

--▼スキル236

--グラウンドメルト,101,520,
	elseif get_skill_lv(0,1)>=0 and
		my_rei>=400 and 
		dis2>300 and
		--y==0 and
		ey<=0 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("グラウンドメルト");
			lvr236(ACT_B);
			
	elseif get_skill_lv(0,1)>=0 and
		my_rei>=400 and 
		dis2>300 and
		--y==0 and
		ey<=0 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(161)==1 then
			print("グラウンドメルト");
			lvr236(ACT_C);

	elseif card_check(101)==true and
		my_rei>=400 and
		dis2>300 and
		--y==0 and
		ey<=0 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("グラウンドメルト");
			for i=1,10 do
				card_use(101);
				yield()
			end
			
--ヘルゲイザー,105,525,
	elseif get_skill_lv(0,5)>=0 and
		my_rei>=400 and 
		dis<250 and
		y==0 and
		ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("ヘルゲイザー");
			lvr236(ACT_B);
			
	elseif get_skill_lv(0,5)>=0 and
		my_rei>=400 and 
		dis>250 and dis<500 and
		y==0 and
		ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("ヘルゲイザー");
			lvr236(ACT_C);

	elseif card_check(105)==true and
		my_rei>=400 and
		dis<250 and
		y==0 and
		ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("ヘルゲイザー");
			for i=1,10 do
				card_use(105);
				yield()
			end
			
--レイディアントブレード,109,530,
	elseif get_skill_lv(0,9)>=0 and
		my_rei>=400 and 
		dis<400 and
		y==0 and
		ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("レイディアントブレード");
			lvr236(ACT_B);
			
	elseif get_skill_lv(0,9)>=0 and
		my_rei>=400 and 
		dis<400 and
		y==0 and
		ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(161)==1 then
			print("レイディアントブレード");
			lvr236(ACT_C);

	elseif card_check(109)==true and
		my_rei>=400 and
		dis<400 and
		y==0 and
		ey<=150 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("レイディアントブレード");
			for i=1,10 do
				card_use(109);
				yield()
			end


--▼スキル22

--ブレイクサン,102,540,
	elseif get_skill_lv(0,2)>=0 and 
		my_rei>=400 and 
		dis<100 and
		ey>y+100 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("ブレイクサン");
			lvr22(ACT_B);
			
	elseif get_skill_lv(0,2)>=0 and 
		my_rei>=400 and 
		dis<100 and
		ey>y+100 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(161)==1 then
			print("ブレイクサン");
			lvr22(ACT_C);

	elseif card_check(102)==true and
		my_rei>=400 and
		dis<100 and
		ey>y+100 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("ブレイクサン");
			for i=1,10 do
				card_use(102);
				yield()
			end

--シューティングサン,106,545,
	elseif get_skill_lv(0,6)>=0 and 
		my_rei>=400 and 
		dis>200 and dis<400 and
		y==0 and
		ey<300 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("シューティングサン");
			lvr22(ACT_B);
			
	elseif get_skill_lv(0,6)>=0 and 
		my_rei>=400 and 
		dis>400 and dis<600 and
		y==0 and
		ey<300 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("シューティングサン");
			lvr22(ACT_C);

	elseif card_check(106)==true and
		my_rei>=400 and
		dis>200 and dis<400 and
		y==0 and
		ey<300 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("シューティングサン");
			for i=1,10 do
				card_use(106);
				yield()
			end

--地獄波動砲,110,550,
	elseif get_skill_lv(0,10)>=0 and 
		my_rei>=400 and 
		dis>320 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("地獄波動砲");
			lvr22(ACT_B);
			
	elseif get_skill_lv(0,10)>=0 and 
		my_rei>=400 and 
		dis>320 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(161)==1 then
			print("地獄波動砲");
			lvr22(ACT_C);

	elseif card_check(110)==true and
		my_rei>=400 and
		dis>320 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("地獄波動砲");
			for i=1,10 do
				card_use(110);
				yield()
			end

--▼スキル,214

--シューティングスター,103,560,
	elseif get_skill_lv(0,3)>=0 and 
		my_rei>=800 and
		dis>640 and 
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(640)==1 then
			print("シューティングスター");
			lvr214(ACT_B);
			
	elseif get_skill_lv(0,3)>=0 and 
		my_rei>=800 and 
		dis<640 and my_backside>640 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(640)==1 then
			print("シューティングスター");
			lvr214(ACT_C);

	elseif card_check(103)==true and
		my_rei>=800 and
		dis>640 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("シューティングスター");
			for i=1,10 do
				card_use(103);
				yield()
			end

--レトロ原子核モデル,107,565,
	elseif get_skill_lv(0,7)>=0 and 
		my_rei>=400 and 
		dis>340 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("レトロ原子核モデル");
			lvr214(ACT_B);
			
	elseif get_skill_lv(0,7)>=0 and 
		my_rei>=400 and 
		dis>340 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(162)==1 then
			print("レトロ原子核モデル");
			lvr214(ACT_C);

	elseif card_check(107)==true and
		my_rei>=400 and
		dis>340 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("レトロ原子核モデル");
			for i=1,10 do
				card_use(107);
				yield()
			end

--核熱の怨霊,111,570,
	elseif get_skill_lv(0,11)>=0 and 
		my_rei>=400 and 
		dis>400 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(640)==1 then
			print("核熱の怨霊");
			lvr214(ACT_B);
			
	elseif get_skill_lv(0,11)>=0 and 
		my_rei>=400 and 
		dis>400 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(641)==1 then
			print("核熱の怨霊");
			lvr214(ACT_C);

	elseif card_check(111)==true and
		my_rei>=400 and
		dis>400 and
		not(my_act>=50 and my_act<180) and my_act<600 and 
		get_fflags(0,32)==true and
		get_fflags(0,8)==false and get_fflags(1,8)==false and 
		enemy_obj_range_in(150,60)==false and 
		is_dir_front==true and 
		subs_count>=530 and nega_count ~= 1 and math.random(160)==1 then
			print("核熱の怨霊");
			for i=1,10 do
				card_use(111);
				yield()
			end

--▼空中打撃▼

--J5A:0-160x40-180,11-13f
	elseif	y>0 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(2)==1 and
	(y+my_yspeed*13+(13*(12*m_gs))/2)>0 	and
				(ex-x)*my_dir-(my_xspeedEX+enemy_xspeedEX)*13		<=	160+20 	and
				(ex-x)*my_dir-(my_xspeedEX+enemy_xspeedEX)*13		>=	0-20 	and
				(ey+enemy_yspeed*13+(13*(12*e_gs))/2)	-	(y+my_yspeed*13+(13*(12*m_gs))/2)	<=	180-40		and --自ヒットボックスの上端を、相手ヒットボックスの下端に当てた高さ
				(ey+enemy_yspeed*13+(13*(12*e_gs))/2)	-	(y+my_yspeed*13+(13*(12*m_gs))/2)	>=	40-160 	then  --自ヒットボックスの下端を、相手ヒットボックスの上端に当てた高さ
					print("J5A");
					key_event(ACT_A);
					
--[[J6A
	elseif	y>0 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(2)==1 and
	(y+my_yspeed/5*15)>0 	and
				(ex-x)*my_dir-(my_xspeedEX/5*15+enemy_xspeedEX*15)		<=	220+20 	and
				(ex-x)*my_dir-(my_xspeedEX/5*15+enemy_xspeedEX*15)		>=	60-20 	and
				(ey+enemy_yspeed*5+(5*(4*e_gs))/2)	-	(y+my_yspeed/5*15)	<=	140-40 		and
				(ey+enemy_yspeed*5+(5*(4*e_gs))/2)	-	(y+my_yspeed/5*15)	>=	100-160 	then
					print("J6A");
					key_event2(ACT_A,front); --]]
					
--[[J2A
	elseif	y>0 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and
	is_dir_front==true and
	subs_count>=530 and nega_count ~= 1 and math.random(4)==1 and
	(y+my_yspeed*19+(19*(18*m_gs))/2)>0 	and
				(ex-x)*my_dir-(my_xspeedEX+enemy_xspeedEX)*19		<=	140+20 	and
				(ex-x)*my_dir-(my_xspeedEX+enemy_xspeedEX)*19		>=	-190-20 	and
				(ey+enemy_yspeed*19+(19*(18*e_gs))/2)	-	(y+my_yspeed*19+(19*(18*m_gs))/2)	<=	30-40	and
				(ey+enemy_yspeed*19+(19*(18*e_gs))/2)	-	(y+my_yspeed*19+(19*(18*m_gs))/2)	>=	-50-160 	then
					print("J2A");
					key_event2(ACT_A,ACT_DOWN); --]]
					
--J8A:10-140x160-420y,13-15f,10f+100y
	elseif	y>0 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and
	is_dir_front==true and
	subs_count>=530 and nega_count ~= 1 and math.random(2)==1 and
	(y+my_yspeed*10+(10*(9*m_gs))/2)>0 	and
				(ex-x)*my_dir-(my_xspeedEX+enemy_xspeedEX)*15		<=	140+20 	and
				(ex-x)*my_dir-(my_xspeedEX+enemy_xspeedEX)*15		>=	10-20 	and
				(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+100+my_yspeed*10+(10*(9*m_gs))/2)	<=	420-40		and
				(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+100+my_yspeed*10+(10*(9*m_gs))/2)	>=	160-160 	then
					print("J8A");
					key_event2(ACT_A,ACT_UP);

--▼対空行動

--対空9HJ>J5A:17F,160x40-180y,11-13f
--j/hj攻撃不能時間:6f
	elseif y==0 and 
	(ey>0 or --空中か
		(
			(enemy_char~=19 and (enemy_act==0 or (enemy_act>=5 and enemy_act<=10) or (enemy_act>=150 and enemy_act<=153) or (enemy_act>=159 and enemy_act<=162)) --諏訪子以外の立ち状態か
			) or
			(enemy_char==19 and ((enemy_act>=1 and enemy_act<=3) or (enemy_act>=154 and enemy_act<=157) or (enemy_act>=163 and enemy_act<=166)) --諏訪子のしゃがみ状態
			)
		)
	) and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and
	subs_count>=530 and nega_count ~= 1 and math.random(16)==1 and 
				(ex-x)*my_dir	-	(10*13+enemy_xspeedEX*19)		<=	160+20 	and --自機のhj時におけるx軸速度*発生
				(ex-x)*my_dir	-	(10*13+enemy_xspeedEX*19)		>=	0-20 	and
				(ey+enemy_yspeed*19+(19*(18*e_gs))/2)	-	(y+17*13+(13*(12*-0.75))/2)	<=	180-40 		and --自機のhj時におけるy軸速度*発生(hj時の落下加速度を17としている)
				(ey+enemy_yspeed*19+(19*(18*e_gs))/2)	-	(y+17*13+(13*(12*-0.75))/2)	>=	40-160 	then --hj時の落下加速度を-0.75としている
					print("AA:9HJ>J5A");
					key_event2(ACT_D,u_front)
					wait(3)
					key_event(ACT_A);
					wait(3)
		
--対空8HJ>J5A:17F,160x40-180y,11-13f
	elseif y==0 and 
	(ey>0 or --空中か
		(
			(enemy_char~=19 and (enemy_act==0 or (enemy_act>=5 and enemy_act<=10) or (enemy_act>=150 and enemy_act<=153) or (enemy_act>=159 and enemy_act<=162)) --諏訪子以外の立ち状態か
			) or
			(enemy_char==19 and ((enemy_act>=1 and enemy_act<=3) or (enemy_act>=154 and enemy_act<=157) or (enemy_act>=163 and enemy_act<=166)) --諏訪子のしゃがみ状態
			)
		)
	) and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and
	is_dir_front==true and
	subs_count>=530 and nega_count ~= 1 and math.random(16)==1 and 
				(ex-x)*my_dir	-	(enemy_xspeedEX*19)		<=	160+20 	and --自機のhj時におけるx軸速度*発生
				(ex-x)*my_dir	-	(enemy_xspeedEX*19)		>=	0-20 	and
				(ey+enemy_yspeed*19+(19*(18*e_gs))/2)	-	(y+20*13+(13*(12*-0.75))/2)	<=	180-40 		and --自機のhj時におけるy軸速度*発生(hj時のy軸速度を20としている)
				(ey+enemy_yspeed*19+(19*(18*e_gs))/2)	-	(y+20*13+(13*(12*-0.75))/2)	>=	40-160 	then --hj時の落下加速度を-0.75としている
					print("AA:9HJ>J5A");
					key_event2(ACT_D,u_front)
					wait(3)
					key_event(ACT_A);
					wait(3)
		
--対空3A-1:170x240y,12-14,+0x
	elseif y==0 and 
	--dis<120 and
	ey>0 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and
	is_dir_front==true and
	subs_count>=530 and nega_count ~= 1 and math.random(16)==1 and 
				(ex-x)*my_dir	-	(enemy_xspeedEX*10)				<=	170+20 	and
				(ex-x)*my_dir	-	(enemy_xspeedEX*10)				>=	50-20 	and
				(ey+enemy_yspeed*10+(10*(9*e_gs))/2)			<=	240-40 		and
				(ey+enemy_yspeed*10+(10*(9*e_gs))/2)			>=	50-160 then
					print("AA:3A-1");
					key_event2(ACT_A,d_front);
		
--対空3A-2:230x300y,15-17f,+0x
	elseif y==0 and 
	--dis<120 and
	ey>0 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and
	is_dir_front==true and
	subs_count>=530 and nega_count ~= 1 and math.random(16)==1 and 
				(ex-x)*my_dir	-	(enemy_xspeedEX*17)				<=	230+20 	and
				(ex-x)*my_dir	-	(enemy_xspeedEX*17)				>=	50-20 	and
				(ey+enemy_yspeed*17+(17*(16*e_gs))/2)		<=	300-40 		and
				(ey+enemy_yspeed*17+(17*(16*e_gs))/2)		>=	50-160 then
					print("AA:3A-2");
					key_event2(ACT_A,d_front);
		
--対空4A:110x180,7-8,+60
	elseif y==0 and 
	--dis<120 and
	ey>0 and
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and
	is_dir_front==true and
	subs_count>=530 and nega_count ~= 1 and math.random(2)==1 and 
				(ex-x)*my_dir	-	(enemy_xspeedEX*8)				<=	110+20 	and
				(ex-x)*my_dir	-	(enemy_xspeedEX*8)				>=	50-20 	and
				(ey+enemy_yspeed*8+(8*(7*e_gs))/2)		<=	180-40 		and
				(ey+enemy_yspeed*8+(8*(7*e_gs))/2)		>=	50-160 then
					print("AA:4A");
					key_event2(ACT_A,backEX());
		
--▼刻み▼
		
--[[刻み2Ａ
	elseif (dis<=120 or (dis<=150 and my_xspeed>0)) and 
	my_act==303 and ey==0 and 
	my_hitstop<=3 and my_hitstop>=2 and 
	enemy_obj_range_in(150,60)==false and 
	(
		(enemy_act>=50 and enemy_act<=89 and math.random(1)<=1) or
		(enemy_act>=143 and enemy_act<=166 and math.random(3)<=2)
	) and 
	subs_count>=530 and nega_count ~= 1 then
		print("刻み2Ａ");
		key_event2(ACT_A,ACT_DOWN);
		wait(5);  --]]
		
--▼通常技/Arts▼

--4A
--S5A:110x180,7-8,+60
	elseif dis<=120 and y==0 and ey<200 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(2)==1 then
		print("S5A");
		key_event(ACT_A);
--L5A:180x140,18-20,+120
	elseif dis<=300 and y==0 and ey<160 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(2)==1 then
	print("L5A");
		key_event(ACT_A);
--6A:160x20y,13-15f,
	elseif dis<=160 and y==0 and ey<40 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(8)==1 then
	print("6A");
		key_event(ACT_A);
--2A:150x60y,10-12f,+0x
	elseif dis<=150 and y==0 and ey<80 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(2)==1 then
	print("2A");
		key_event(ACT_A);
--3A:170x240y~230x300y,12-14~15-17f,+0x
	elseif dis<=230 and y==0 and ey<320 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(16)==1 then
	print("3A");
		key_event(ACT_A);
--DA:180x140y,18-21f,+180x
	elseif dis<=360 and y==0 and ey<160 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(16)==1 then
	print("DA");
		key_on(frontEX());
		key_event2(ACT_D,ACT_A);
--DB
	elseif dis<=360 and y==0 and ey<160 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(64)==1 then
	print("DB");
		key_on(frontEX());
		key_event2(ACT_D,ACT_B);
--DC
	elseif dis<=360 and y==0 and ey<160 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(65)==1 then
	print("DC");
		key_on(frontEX());
		key_event2(ACT_D,ACT_C);

--5B
--6B
--2B
--J5B
--J6B
--J2B

--5C:対空含む
	elseif my_rei>=400 and my_air==0 and
	dis<350 and ey<=y+240 and ey>=y-200 and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(16)==1 then
	print("条件範囲内：C");
		key_event(ACT_C);
--6C
--2C
	elseif my_rei>=400 and my_air==0 and
	dis<350 and y==0 and ey-y<dis and 
	not(my_act>=50 and my_act<180) and my_act<600 and 
	get_fflags(0,32)==true and
	get_fflags(0,8)==false and get_fflags(1,8)==false and 
	enemy_obj_range_in(150,60)==false and 
	is_dir_front==true and 
	subs_count>=530 and nega_count ~= 1 and math.random(16)==1 then
	print("条件範囲内：C");
		key_event(ACT_C);
--J5C
--J6C
--J2C

--]]
--中距離以上からの８ｈｊ
	elseif move_8hjattakeovermidrange_condi()==true then
		print("中距離以上で８ＨＪ");
		key_event2(ACT_D,ACT_UP);
--中距離からのダッシュ
	elseif move_6dattakeovermidrange_condi()==true then
		print("ダッシュ接近");
		key_event2(ACT_D,front);
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
	--▼ 終端機動2
	--ただ動く事で自律性を錯覚させる事が目的の機動。静止やラインの設定に大きな根拠はない。
	--霊力が一定の評価を下回った場合、実行しない。
	elseif move_termination2_condi()==true then
		move_termination2_exe()
	end
	
	yield()
end
end