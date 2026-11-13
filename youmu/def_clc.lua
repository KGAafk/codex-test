--check20210207
--▼判定調査用関数群
function calc_char_atttackarea()

	local left = {}
	local top = {}
	local right = {}
	local bottom = {}

	--if my_attackarea_n>0 then
		for i=1,my_attackarea_n do
			left[i], top[i], right[i], bottom[i] = get_attackarea(0,i-1)
			--[[
			print("/ i =",i,
			my_act,
			my_frame,
			my_act_block,
			my_allframe,
			math.floor(x*100)/100-40,
			math.floor(y*100)/100,
			math.floor(my_xspeed*100)/100,
			math.floor(my_yspeed*100)/100,
			math.floor(m_gs*100)/100,
			math.floor((top[i]	-y+my_yspeed)*100)/100,
			math.floor((bottom[i]	-y+my_yspeed)*100)/100,
			math.floor((left[i]	-x+my_xspeed)*100)/100,
			math.floor((right[i]	-x+my_xspeed)*100)/100
			)
			--]]
		end
		
	--end
end

function calc_obj_atttackarea()

	local left = {}
	local top = {}
	local right = {}
	local bottom = {}

	if my_obj_n>0 then
		for j=1,my_obj_n do
			for i=1,my_obj_attackarea_n[j] do
				left[i], top[i], right[i], bottom[i] = get_obj_attackarea(0,j-1,i-1)
				--[[
				print("/ j,i =",
				j,i,
				my_obj_act[j],
				my_obj_img[j],
				my_obj_frame[j],
				math.floor((my_obj_x[j]-x)*100)/100,
				math.floor((my_obj_y[j]-y)*100)/100,
				math.floor((math.sqrt((my_obj_xspeed[j])^2+(my_obj_yspeed[j])^2))*100)/100,
				math.floor((top[i]	-my_obj_y[j])*100)/100,
				math.floor((bottom[i]	-my_obj_y[j])*100)/100,
				math.floor((left[i]	-my_obj_x[j])*100)/100,
				math.floor((right[i]	-my_obj_x[j])*100)/100
				)
				--]]
			end
		end
		
	end
end

function calc_char_hitarea()

	local left = {}
	local top = {}
	local right = {}
	local bottom = {}

	if my_hitarea_n>0 then
		for i=1,my_hitarea_n do
			left[i], top[i], right[i], bottom[i] = get_hitarea(0,i-1)
			--[[
			print("hitarea =",i,
			my_act,my_frame,my_act_block,
			math.floor(x*100)/100,
			math.floor(ex*100)/100,
			math.floor((top[i]	-y+my_yspeed)*100)/100,
			math.floor((bottom[i]	-y+my_yspeed)*100)/100,
			math.floor((left[i]	-x+my_xspeed)*100)/100,
			math.floor((right[i]	-x+my_xspeed)*100)/100
			)
			--]]
		end
		
	end
end

--get_obj_hitarea関数がエラーをはくため使用不能で凍結
function calc_obj_hitarea()

	local left = {}
	local top = {}
	local right = {}
	local bottom = {}

	if my_obj_n>0 then
		for j=1,my_obj_n do
			if my_obj_hitarea_n[j]>=1 then
			for i=1,my_obj_hitarea_n[j] do
				left[i], top[i], right[i], bottom[i] = get_obj_hitarea(0,j-1,i-1)
				--[[
				print(j,i,
				my_obj_act[j],my_obj_img[j],my_obj_frame[j],
				math.floor((top[i]	-0)*100)/100,
				math.floor((bottom[i]	-0)*100)/100,
				math.floor((left[i]	-0)*100)/100,
				math.floor((right[i]	-0)*100)/100
				)
				--]]
			end
			end
		end
		
	end
end
--▲判定調査用関数群
----------------------------
my_preact = {};
enemy_preact = {};
my_preframe = {};
enemy_preframe = {};
my_allframe = 0;
enemy_allframe = 0;
old_my_allframe = 0;
old_enemy_allframe = 0;

for i=1,10,1 do
my_preact[i] = 0;
enemy_preact[i] = 0;
my_preframe[i] = 0;
enemy_preframe[i] = 0;
end

my_frontside = 0;
enemy_frontside = 0;
----------------------------

old_bt = 0
old_d_bt = 0

old_x = 0;
old_ex = 0;
my_xspeedEX = 0;
enemy_xspeedEX = 0;
old_my_xspeedEX = 0;
old_enemy_xspeedEX = 0;
old_m_ys = 0;
old_e_ys = 0;
m_gs = 0;
e_gs = 0;
old_m_gs = 0;
old_e_gs = 0;

graund_math = 0;
air_math = 0;

my_backside = 0;
enemy_backside = 0;

my_airEX = 0;
enemy_airEX = 0;

--▼気質フラグ
flag_kishitu = 0
function kishitu_switch()
	if my_act==691 and my_allframe>=30 then
		flag_kishitu = 2
	elseif (weather==5 or weather==7 or weather==12 or weather==13) and my_hp<enemy_hp then
		flag_kishitu = 1
	else
		flag_kishitu = 0
	end
end

--▼sabot_activate関数：sabotを多重起動させないためのフラグ。ガードの1F目でのみON。sabot後にOFF。
sabot_activate_flag = 0;
function sabot_activate()
	if sabot_rank >=1 and (my_act>=143 and my_act<=166) and my_act_block==0 and my_frame==0 then
		sabot_activate_flag = 1
	end
end

--▼霊力用評価関数もどき
--標準値1。0.65未満を霊力不足として扱う
my_rfunc = 1
enemy_rfunc = 1
function rei_evaluat()
	my_rfunc = math.floor(((my_rei/1000*3/10)+(my_rmax/1000*6/10)+(1/(my_rei_stop+1))*1/10)*1000)/1000
	enemy_rfunc = math.floor(((enemy_rei/1000*3/10)+(enemy_rmax/1000*6/10)+(1/(enemy_rei_stop+1))*1/10)*1000)/1000
end

--▼各actの始動でリセットするカウンタ
--目安でおｋ。主に強力なオブジェクトの発生や攻撃のタイミングを計る目的で使用する。行動の連打制御でも使えなくもない。
my_act_count = {};
for i=1,999,1 do
my_act_count[i] = 0
end

function my_act_count_calc()
	for i=1,999,1 do
	my_act_count[i] = my_act_count[i] + 1
	end
	
	if my_frame >= 1 and my_frame <=3 and my_act_block == 0 then
		local ii = my_act +1
		local iii = my_frame
		my_act_count[ii] = iii
	end
end

enemy_act_count = {};
for i=1,999,1 do
enemy_act_count[i] = 10000
--注記20230618：0で始めると、nega_count_calc()での設定値を参照とし、AI起動ののち試合開始直後に設定値の時間だけ停止する不具合が生じる。
--理由は不明だが、nega_count回りは使えなくなるかも。
end

function enemy_act_count_calc()
	for i=1,999,1 do
	enemy_act_count[i] = enemy_act_count[i] + 1
	end
	
	if enemy_frame >= 1 and enemy_frame <=3 and enemy_act_block == 0 then
		local ii = enemy_act +1
		local iii = enemy_frame
		enemy_act_count[ii] = iii
	end
end

--▼どれくらい地上or空中にいたのかをカウント▼
function state_fcount()
	if ey==0 then
		air_math = 0;
	elseif ey>0 then
		air_math = air_math+1;
	end
	if ey>0 then
		graund_math = 0;
	elseif ey==0 then
		graund_math = graund_math+1;
	end
end

--▼「サブタレイニアンサン」対策
subs_count = 10000
function subs_func()
	if enemy_char==18 and (enemy_act==612 or enemy_act==662)  and enemy_frame>=60 and enemy_frame<=65 then
		subs_count = 0
	end
	subs_count = subs_count+1
end

key_hold_B = 0
key_hold_C = 0
--key_resetEX関数
function key_resetEX()
	if key_hold_B == 0 and key_hold_C ==0 then
		key_reset()
	elseif key_hold_B ==1 and key_hold_C ==0 then
		key_off(ACT_UP);	key_off(ACT_DOWN);	key_off(ACT_LEFT);	key_off(ACT_RIGHT);	key_off(ACT_A);	key_off(ACT_C);	key_off(ACT_D);	key_off(ACT_AB); key_off(ACT_BC);
	elseif key_hold_B ==0 and key_hold_C ==1 then
		key_off(ACT_UP);	key_off(ACT_DOWN);	key_off(ACT_LEFT);	key_off(ACT_RIGHT);	key_off(ACT_A);	key_off(ACT_B);	key_off(ACT_D);	key_off(ACT_AB); key_off(ACT_BC);
	elseif key_hold_B ==1 and key_hold_C ==1 then
		key_off(ACT_UP);	key_off(ACT_DOWN);	key_off(ACT_LEFT);	key_off(ACT_RIGHT);	key_off(ACT_A);	key_off(ACT_D);	key_off(ACT_AB); key_off(ACT_BC);
	end
end

--カードゲージの実効を返す関数（コスト１には不要）
--指定した値以上なら真を返す。また、曇天による影響を考慮する。
function my_spell_more(cost)
	if (my_spell>=cost or (weather==2 and my_spell>=cost-500)) then
		return true;
	else
		return false;
	end
end

--現在の手札に指定カードを含まれている場合は真、そうでないなら偽
function card_check(card_ID)--連続で実行するとnillが返るらしい。
	if (get_card_id(0,0)==card_ID or get_card_id(0,1)==card_ID or get_card_id(0,2)==card_ID or get_card_id(0,3)==card_ID or get_card_id(0,4)==card_ID) then
		return true;
	else
		return false;
	end
end

--指定カードを手札の1枚目へと送る関数
function card_1st(card_ID)
	if card_check(card_ID)==true and my_card~=card_ID then
		key_reset()
		if battle_time%2==0 then
			key_on(ACT_AB)
		elseif battle_time%2==1 then
			key_off(ACT_AB)
		end
	end
end

--カードを使用する関数。指定カードが手札の一枚目にない場合、１枚目へと送る。
function card_use(card_ID)
	for i=1,10 do
		key_reset()
		if my_card==card_ID then
			key_event(ACT_BC);
		elseif my_card~=card_ID then
			card_1st(card_ID)
		end
		yield()
	end
end

--▼接近するオブジェクトを感知する関数
--オブジェクトの中心座標がffフレーム後までの間にキャラ判定+range範囲内に至る場合、真を返す。
--2021/02/11版
--オブジェクトの攻撃判定の取得を排除し、オブジェクトの座標により処理する方式に変更。
--特定の状況において、実際には当たり判定がないにも関わらず、attackareaや座標が保持される問題を、aflagsの消失と組み合わせて解消した。
--妖夢の半霊による攻撃も取得可能。
--当たり判定が発生した時点でキャラが判定内にいる場合は無意味。また、objの中心座標から極端に偏った当たり判定のものにも適用できない。（レーザー等が該当する）
function my_obj_range_in(range, ff)
	local inr = 0
	local out = 0
	for F=1,ff,1 do
		for  i=1,enemy_obj_n,1 do
			--テーブル内において固有識別子の座標が変わらなかった場合
			if my_obj_id[i] == pre0_my_obj_id[i] then
						for n=1,my_obj_attackarea_n[i],1 do
							if my_obj_attackarea_n[i]==0 then
								out = out + 1
						--attackareaや座標はobjが消えるまで保持されるが、速度やフラグは消失するため、そこで見分ける。
							elseif my_obj_aflags[i]~=0 and not(my_obj_xspeed[i]==0 and my_obj_yspeed[i]==0) and
									(my_obj_x[i]-ex)*enemy_dir	-(	my_obj_xspeed[i]*F	+	F*(F-1)*my_obj_xaccel[i]/2	)<30+range	and
									(my_obj_x[i]-ex)*enemy_dir	-(	my_obj_xspeed[i]*F	+	F*(F-1)*my_obj_xaccel[i]/2	)>=0	and
									(my_obj_y[i]-ey) 			-(	my_obj_yspeed[i]*F	+	F*(F-1)*my_obj_yaccel[i]/2	)<140+range	and
									(my_obj_y[i]-ey) 			-(	my_obj_yspeed[i]*F	+	F*(F-1)*my_obj_yaccel[i]/2	)>=40	then
								inr = inr + 1
							else
								out = out + 1
							end
						end
			--テーブル内において固有識別子の座標が変わった場合
			elseif my_obj_id[i] ~= pre0_my_obj_id[i] then
				for ii=1,pre0_my_obj_n,1 do
					if my_obj_id[i] == pre0_my_obj_id[ii] then
						for n=1,my_obj_attackarea_n[i],1 do
							if my_obj_attackarea_n[i]==0 then
								out = out + 1
						--attackareaや座標はobjが消えるまで保持されるが、速度やフラグは消失するため、そこで見分ける。
							elseif my_obj_aflags[i]~=0 and not(my_obj_xspeed[i]==0 and my_obj_yspeed[i]==0) and
									(my_obj_x[i]-ex)*enemy_dir	-(	my_obj_xspeed[i]*F	+	F*(F-1)*my_obj_xaccel[i]/2	)<30+range	and
									(my_obj_x[i]-ex)*enemy_dir	-(	my_obj_xspeed[i]*F	+	F*(F-1)*my_obj_xaccel[i]/2	)>=0	and
									(my_obj_y[i]-ey) 			-(	my_obj_yspeed[i]*F	+	F*(F-1)*my_obj_yaccel[i]/2	)<140+range	and
									(my_obj_y[i]-ey) 			-(	my_obj_yspeed[i]*F	+	F*(F-1)*my_obj_yaccel[i]/2	)>=40	then
								inr = inr + 1
							else
								out = out + 1
							end
						end
					end
				end
			end
		end
	end
	
	if inr>=1 then
		return true
	else
		return false
	end
end

function enemy_obj_range_in(range, ff)
	local inr = 0
	local out = 0
	for F=1,ff,1 do
		for  i=1,enemy_obj_n,1 do
			--テーブル内において固有識別子の座標が変わらなかった場合
			if enemy_obj_id[i] == pre0_enemy_obj_id[i] then
						for n=1,enemy_obj_attackarea_n[i],1 do
							if enemy_obj_attackarea_n[i]==0 then
								out = out + 1
						--attackareaや座標はobjが消えるまで保持されるが、速度やフラグは消失するため、そこで見分ける。
							elseif enemy_obj_aflags[i]~=0 and not(enemy_obj_xspeed[i]==0 and enemy_obj_yspeed[i]==0) and
									(enemy_obj_x[i]-x)*my_dir	-(	enemy_obj_xspeed[i]*F	+	F*(F-1)*enemy_obj_xaccel[i]/2	)<130+range	and
									(enemy_obj_x[i]-x)*my_dir	-(	enemy_obj_xspeed[i]*F	+	F*(F-1)*enemy_obj_xaccel[i]/2	)>=0	and
									(enemy_obj_y[i]-y) 			-(	enemy_obj_yspeed[i]*F	+	F*(F-1)*enemy_obj_yaccel[i]/2	)<180+range	and
									(enemy_obj_y[i]-y) 			-(	enemy_obj_yspeed[i]*F	+	F*(F-1)*enemy_obj_yaccel[i]/2	)>=0-range	then
								inr = inr + 1
							else
								out = out + 1
							end
						end
			--テーブル内において固有識別子の座標が変わった場合
			elseif enemy_obj_id[i] ~= pre0_enemy_obj_id[i] then
				for ii=1,pre0_enemy_obj_n,1 do
					if enemy_obj_id[i] == pre0_enemy_obj_id[ii] then
						for n=1,enemy_obj_attackarea_n[i],1 do
							if enemy_obj_attackarea_n[i]==0 then
								out = out + 1
						--attackareaや座標はobjが消えるまで保持されるが、速度やフラグは消失するため、そこで見分ける。
							elseif enemy_obj_aflags[i]~=0 and not(enemy_obj_xspeed[i]==0 and enemy_obj_yspeed[i]==0) and
									(enemy_obj_x[i]-x)*my_dir	-(	enemy_obj_xspeed[i]*F	+	F*(F-1)*enemy_obj_xaccel[i]/2	)<130+range	and
									(enemy_obj_x[i]-x)*my_dir	-(	enemy_obj_xspeed[i]*F	+	F*(F-1)*enemy_obj_xaccel[i]/2	)>=0	and
									(enemy_obj_y[i]-y) 			-(	enemy_obj_yspeed[i]*F	+	F*(F-1)*enemy_obj_yaccel[i]/2	)<180+range	and
									(enemy_obj_y[i]-y) 			-(	enemy_obj_yspeed[i]*F	+	F*(F-1)*enemy_obj_yaccel[i]/2	)>=0-range	then
								inr = inr + 1
							else
								out = out + 1
							end
						end
					end
				end
			end
		end
	end
	
	if inr>=1 then
		return true
	else
		return false
	end
end

--▼特定obj認識関数：相手のobjの位置等と、自分の位置等を大まかに比較し、カウンタを動かす。
--指定したobjないしイメージに加え、仮に設定する判定の範囲、発生からのフレームカウントを設定することで、大まかに特定の攻撃等を判別する関数。
--その昔に作成したゴテゴテの関数だが、正常に設定し、正常に検出できれば、カウントが１以上カウントされるため、それを目安に行動を制御できる。
function caution_state_obj(obj_act,obj_img,X,Y,F1,F2)

	local n = 0;
	
	for i=1,enemy_obj_n,1 do
		if enemy_obj_act[i]==obj_act and enemy_obj_img[i]==obj_img then --actとimgが一致した場合
			if 	enemy_obj_x[i]-X <= x+ 30 and 
				enemy_obj_x[i]+X >= x- 30 and
				enemy_obj_y[i]-Y <= y+180 and
				enemy_obj_y[i]+Y >= y+  0 and
				enemy_obj_frame[i] >= F1 and
				enemy_obj_frame[i] <= F2 then
					n = n + 1;
			end
		end
	end
	
	return n;
	
end

--▼特定obj認識関数の改造版：自分のobjの位置等と、相手の位置等を比較し、カウントして、おおまかな目安とする関数
--範囲内にいるかどうかだけ見るため、大した価値はないが、人形やら起爆には有用
--利用前に、目的のobjのact、img、判定の大きさ、有効フレームを調べておくこと

function search_state_obj(obj_act,obj_img,X,Y,F1,F2)

	local n = 0;
	
	--以下のfor文を使って、全てのobjにおける、指定actとimgかどうかを走査する。
	--追記：objの分類は、actとimgのセットで認識しているらしく見える。追加前にどれを追えばいいのか確認すること。
	--一致した場合、そのobjの座標やフレームから、相手との関係性を確認し、有効ならカウンタを回す。そして、次のobjを走査する。
	--フレームを指定しない場合、0～極大を取る。

	for i=1,my_obj_n,1 do
	
		local A=my_obj_act[i]
		local B=my_obj_img[i]
		local C=my_obj_x[i]
		local D=my_obj_y[i]
		local E=my_obj_frame[i]
		
		if A==obj_act and B==obj_img then --actとimgが一致した場合
			if 	math.abs(C-ex)	<= 30+X and
				D-ey	<=	180+Y and
				D-ey	>=	0-Y and
				E >= F1 and
				E <= F2 then
					n = n + 1;
			end
		end
	end
	
	return n;
	
end

--▼自身のobj座標より指定された範囲内に相手キャラが含まれる場合に値を返す関数
--obj_act: objのact id
--obj_img: objのimg番号。同じact idでもimgは別なものが数多くある。
--obj_img_n: imgの枚数を指定。1以上必須。アニメーションがあるものは複数imgのループになっている
--ranginX: objの座標からの判定範囲を指定する。なお、関数内で相手のキャラサイズ補正した値が加えられる。
--ranginY: 上記のy座標分。
--指定範囲内に含まれるかどうかだけ見る。人形の起動等に使用できる。
--利用前に、目的のobjのact、img、img枚数、判定の大きさを調べておくこと

function search_obj_range_in_enemy(obj_act,obj_img,obj_img_n,ranginX,ranginY)

	local n = 0;
	
	if my_obj_n>=1 then
		for i=1,my_obj_n,1 do
		
			local ACT	= my_obj_act[i]
			local IMG	= my_obj_img[i]
			local OX	= my_obj_x[i]
			local OY	= my_obj_y[i]
			
			for j=1,obj_img_n,1 do
				if ACT==obj_act and IMG==obj_img+j-1 then --actとimgが一致した場合
					if 	math.abs(OX-ex)	<= 30+ranginX and
						OY-ey	<=	180+ranginY and
						OY-ey	>=	0-ranginY then
							n = n + 1;
					end
				end
			end
		end
	end
	
	return n;
	
end

--▼アリスのc人形座標保存
--act805＆img360＆frame120以上で後ろから検索。糸が見つかれば人形の位置は確定。そこで一度forループを破棄し、検索していない領域を再度検索する

--obj_act: 805. C人形とその糸のid
--obj_img: 360. 糸のimg
--obj_img_n: 1. 1枚のみ。これのおかげでシーケンスごとにフレームがリセットされない
--ranginX: objの座標からの判定範囲を指定する。なお、関数内で相手のキャラサイズ補正した値が加えられる。
--ranginY: 上記のy座標分。
--指定範囲内に含まれるかどうかだけ見る。人形の起動等に使用できる。
--利用前に、目的のobjのact、img、img枚数、判定の大きさを調べておくこと

doll_later1_x = -10000
doll_later1_y = -10000
doll_later2_x = -10000
doll_later2_y = -10000
doll_later3_x = -10000
doll_later3_y = -10000
doll_later4_x = -10000
doll_later4_y = -10000

function calc_pos_doll()

	if my_char==3 then
	local n = 0
	local nn = 0
	local pos = 0
	
	--later1
	for i=my_obj_n,1,-1 do

		local ACT	= my_obj_act[i]
		--local OX	= my_obj_x[i]
		--local OY	= my_obj_y[i]
		local IMG	= my_obj_img[i]
		local FRM	= my_obj_frame[i]
		--local OXSPD	= my_obj_xspeed[i]
		--local OYSPD	= my_obj_yspeed[i]
		--local OID	= my_obj_id[i]
		
		if ACT == 805 and IMG == 360 and FRM >= 120 then --戻ってくる時の座標を取得してしまうが、しばらくは放置
			local j = i-1
			pos = j-1

			--local ACT2	= my_obj_act[j]
			local OX2	= my_obj_x[j]
			local OY2	= my_obj_y[j]
			--local IMG2	= my_obj_img[j]
			--local FRM2	= my_obj_frame[j]
			local OXSPD2	= my_obj_xspeed[j]
			local OYSPD2	= my_obj_yspeed[j]
			--local OID2	= my_obj_id[j]
			
			if OXSPD2<=0.01 and OYSPD2<=0.01 then --y軸速度が0にならないためこの設定
				doll_later1_x = OX2
				doll_later1_y = OY2
				
				n = n + 1
				nn = nn + 1
			end
			

		end
		if n>=1 then break end
	end
	
	--later2
	local n = 0
	for i=pos,1,-1 do
		
		
		local ACT	= my_obj_act[i]
		--local OX	= my_obj_x[i]
		--local OY	= my_obj_y[i]
		local IMG	= my_obj_img[i]
		local FRM	= my_obj_frame[i]
		--local OXSPD	= my_obj_xspeed[i]
		--local OYSPD	= my_obj_yspeed[i]
		--local OID	= my_obj_id[i]
		
		if ACT == 805 and IMG == 360 and FRM >= 120 then --戻ってくる時の座標を取得してしまうが、しばらくは放置
			
			local j = i-1
			pos = j-1
			
			--local ACT2	= my_obj_act[j]
			local OX2	= my_obj_x[j]
			local OY2	= my_obj_y[j]
			--local IMG2	= my_obj_img[j]
			--local FRM2	= my_obj_frame[j]
			local OXSPD2	= my_obj_xspeed[j]
			local OYSPD2	= my_obj_yspeed[j]
			--local OID2	= my_obj_id[j]
			
			if OXSPD2<=0.01 and OYSPD2<=0.01 then --y軸速度が0にならないためこの設定
				doll_later2_x = OX2
				doll_later2_y = OY2

				n = n + 1
				nn = nn + 1
			end

		end
		if n>=1 then break end
	end
	
	--later3
	local n = 0
	for i=pos,1,-1 do
		
		local ACT	= my_obj_act[i]
		--local OX	= my_obj_x[i]
		--local OY	= my_obj_y[i]
		local IMG	= my_obj_img[i]
		local FRM	= my_obj_frame[i]
		--local OXSPD	= my_obj_xspeed[i]
		--local OYSPD	= my_obj_yspeed[i]
		--local OID	= my_obj_id[i]
		
		if ACT == 805 and IMG == 360 and FRM >= 120 then --戻ってくる時の座標を取得してしまうが、しばらくは放置
			local j = i-1
			pos = j-1
			
			--local ACT2	= my_obj_act[j]
			local OX2	= my_obj_x[j]
			local OY2	= my_obj_y[j]
			--local IMG2	= my_obj_img[j]
			--local FRM2	= my_obj_frame[j]
			local OXSPD2	= my_obj_xspeed[j]
			local OYSPD2	= my_obj_yspeed[j]
			--local OID2	= my_obj_id[j]
			
			if OXSPD2<=0.01 and OYSPD2<=0.01 then --y軸速度が0にならないためこの設定
				doll_later3_x = OX2
				doll_later3_y = OY2

				n = n + 1
				nn = nn + 1
			end

		end
		if n>=1 then break end
	end
	
	--later4
	local n = 0
	for i=pos,1,-1 do
		
		local ACT	= my_obj_act[i]
		--local OX	= my_obj_x[i]
		--local OY	= my_obj_y[i]
		local IMG	= my_obj_img[i]
		local FRM	= my_obj_frame[i]
		--local OXSPD	= my_obj_xspeed[i]
		--local OYSPD	= my_obj_yspeed[i]
		--local OID	= my_obj_id[i]
		
		if ACT == 805 and IMG == 360 and FRM >= 120 then --戻ってくる時の座標を取得してしまうが、しばらくは放置
			local j = i-1
			pos = j-1
			
			--local ACT2	= my_obj_act[j]
			local OX2	= my_obj_x[j]
			local OY2	= my_obj_y[j]
			--local IMG2	= my_obj_img[j]
			--local FRM2	= my_obj_frame[j]
			local OXSPD2	= my_obj_xspeed[j]
			local OYSPD2	= my_obj_yspeed[j]
			--local OID2	= my_obj_id[j]
			
			if OXSPD2<=0.01 and OYSPD2<=0.01 then --y軸速度が0にならないためこの設定
				doll_later4_x = OX2
				doll_later4_y = OY2

				n = n + 1
				nn = nn + 1
			end

		end
		if n>=1 then break end
	end
	
	if nn == 0 then 
		doll_later1_x = -10000
		doll_later1_y = -10000
		doll_later2_x = -10000
		doll_later2_y = -10000
		doll_later3_x = -10000
		doll_later3_y = -10000
		doll_later4_x = -10000
		doll_later4_y = -10000
		
	end
	end
end

--アリス用ワイヤー関数
function calc_wireworks(obj_act,obj_img,obj_img_n,ranginX,ranginY)

	local n = 0;
	
	--以下のfor文を使って、全てのobjにおける、指定actとimgかどうかを走査する。
	--追記：objの分類は、actとimgのセットで認識しているらしく見える。追加前にどれを追えばいいのか確認すること。
	--一致した場合、そのobjの座標やフレームから、相手との関係性を確認し、有効ならカウンタを回す。そして、次のobjを走査する。
	--フレームを指定しない場合、0～極大を取る。
	if my_obj_n>=1 then
		for i=1,my_obj_n,1 do
		
			local ACT	= my_obj_act[i]
			local IMG	= my_obj_img[i]
			local OX	= my_obj_x[i]
			local OY	= my_obj_y[i]
			local FRM	= my_obj_frame[i]
			
			for j=1,obj_img_n,1 do
				if ACT==obj_act and IMG==obj_img+j-1 then --actとimgが一致した場合
					if 	math.abs(OX-ex)	<= 30+ranginX and
						OY-ey	<=	180+ranginY and
						OY-ey	>=	0-ranginY then
							n = n + 1;
					end
				end
			end
		end
	end
	
	return n;
	
end

--妖夢用半霊演算
hanreix = 10000
hanreiy = 10000
hanreidis = 10000
hanreiex = 10000
hanreiey = 10000
hanreiedis = 10000

function calc_hanrei()
	if my_char==5 then
		hanreix = my_obj_x[1]
		hanreiy = my_obj_y[1]
		hanreidis = (ex-hanreix)*my_dir
		
	end

	if enemy_char==5 then
		hanreiex = enemy_obj_x[1]
		hanreiey = enemy_obj_y[1]
		hanreiedis = (x-hanreiex)*enemy_dir
	end

end



--▼negaカウンタ：行動制御用変数。特定の行動に対して、カウンタを初期化する。そこから値を指定することで、大まかな警戒する時間の目安とする。
--ただし、obj発生後については、専用objを認識できるため、そこから直接objのフレームを確認し、警戒する方式に切り替わるアイデアはある。
nega_count = 10000
function nega_count_calc()
--通常時はカウンタを回しておく
	nega_count = nega_count + 1
--宝具「陰陽鬼神玉」
	if enemy_char==0 and enemy_act_count[610]>0 and enemy_act_count[610]<371 then nega_count = 1 end
--魔廃「ディープエコロジカルボム」
	if enemy_char==1 and enemy_act_count[614]>250 and enemy_act_count[614]<450 then nega_count = 1 end
--幻符「殺人ドール」
	if enemy_char==2 and enemy_act_count[600]>150 and enemy_act_count[600]<208 then nega_count = 1 end
--時符「プライベートスクウェア」
--バトル開始直後のAI停止案件を生起させたenemy_act_count[i]。ここでの設定したenemy_act_countの値の間、なぜか停止する。
	if enemy_char==2 and enemy_act_count[601]>30 and enemy_act_count[601]<400 then nega_count = 1 end
--「咲夜の世界」 
	if enemy_char==2 and enemy_act_count[604]>170 and enemy_act_count[604]<470 then nega_count = 1 end
--ルミネスリコシェ
	if enemy_char==2 and enemy_act_count[608]>9 and enemy_act_count[608]<300 then nega_count = 1 end
--時符「咲夜特製ストップウォッチ」
	if enemy_char==2 and enemy_act_count[609]>151 and enemy_act_count[608]<431 then nega_count = 1 end
--光速「Ｃ.リコシェ」
	if enemy_char==2 and enemy_act_count[610]>250 and enemy_act_count[610]<400 then nega_count = 1 end
--日符「ロイヤルフレア」
	--if enemy_char==4 and enemy_act_count[603]>137 and enemy_act_count[603]<208 then nega_count = 1 end
--賢者の石
	--if enemy_char==4 and enemy_act_count[605]>137 and enemy_act_count[605]<208 then nega_count = 1 end
--悪魔「レミリアストレッチ」
	--if enemy_char==6 and enemy_act_count[609]>137 and enemy_act_count[609]<208 then nega_count = 1 end
--寿命「无寿国への約束手形」 
	if enemy_char==7 and enemy_act_count[605]>1 and enemy_act_count[605]<70 and my_act>=50 and my_act<=100 and my_hitstop>0 then nega_count = 1 end
--結界「客観結界」 
	if enemy_char==8 and enemy_act_count[605]>78 and enemy_act_count[605]<250 then nega_count = 1 end
--鬼神「ミッシングパープルパワー」
	if enemy_char==9 and enemy_act_count[605]>1 and enemy_act_count[605]<600 then nega_count = 1 end
--長視「赤月下(インフレアドムーン)」
	if enemy_char==10 and enemy_act_count[611]>7 and enemy_act_count[611]<550 then nega_count = 1 end
--逆風「人間禁制の道」 
	if enemy_char==11 and enemy_act_count[602]>10 and enemy_act_count[602]<550 then nega_count = 1 end
--魔獣「鎌鼬ベーリング」 
	if enemy_char==11 and enemy_act_count[611]>67 and enemy_act_count[611]<500 and enemy_obj_n>=1 then nega_count = 1 end
--地獄「無間の狭間」
	if enemy_char==12 and enemy_act_count[611]>51 and enemy_act_count[611]<550 and enemy_obj_n>=1 then nega_count = 1 end
--羽衣「羽衣は空の如く」 
	if enemy_char==13 and enemy_act_count[607]>47 and enemy_act_count[607]<900 and enemy_obj_n>=1 then nega_count = 1 end
--棘符「雷雲棘魚」 対策
	if enemy_char==13 and enemy_act_count[609]>10 and enemy_act_count[609]<360 and enemy_obj_n>=1 then nega_count = 1 end
--龍魚「龍宮の使い遊泳弾」 
	if enemy_char==13 and enemy_act_count[610]>17 and enemy_act_count[610]<650 and enemy_obj_n>=1  then nega_count = 1 end
	if enemy_char==13 and enemy_act_count[660]>10 and enemy_act_count[660]<650 and enemy_obj_n>=1  then nega_count = 1 end
--気符「無念無想の境地」 
	if enemy_char==14 and enemy_act_count[606]>31 and enemy_act_count[606]<991 then nega_count = 1 end
--地震「先憂後楽の剣」 
	if enemy_char==14 and enemy_act_count[603]>15 and enemy_act_count[603]<55 then nega_count = 1 end
--秘法「九字刺し」 
	--if enemy_char==15 and enemy_act_count[610]>137 and enemy_act_count[610]<208 then nega_count = 1 end
--凍符「フリーズアトモスフェア」 
	if enemy_char==16 and enemy_act_count[610]>10 and enemy_act_count[610]<360 then nega_count = 1 end
	if enemy_char==16 and enemy_act_count[660]>10 and enemy_act_count[660]<360 then nega_count = 1 end
--気符「猛虎内剄」 
	if enemy_char==17 and enemy_act_count[611]>10 and enemy_act_count[611]<360 then nega_count = 1 end
--焔星「フィクストスター」
	if enemy_char==18 and enemy_act_count[603]>13 and enemy_act_count[603]<360 and enemy_obj_n>=1  then nega_count = 1 end
--制御「セルフトカマク」 
	if enemy_char==18 and enemy_act_count[611]>13 and enemy_act_count[611]<360 and enemy_obj_n>=1  then nega_count = 1 end
--遮光「核熱バイザー」
	if enemy_char==18 and enemy_act_count[613]>13 and enemy_act_count[613]<360 and enemy_obj_n>=1  then nega_count = 1 end
--「サブタレイニアンサン」
	if enemy_char==18 and enemy_act_count[612]>17 and enemy_act_count[612]<530 and enemy_obj_n>=1  then nega_count = 1 end
	if enemy_char==18 and enemy_act_count[662]>17 and enemy_act_count[662]<530 and enemy_obj_n>=1  then nega_count = 1 end
end

--▼正規分布（ガウス分布）による距離に応じたランダム値の設定
--　→　多変量正規分布を用いれば、x軸、y軸、フレームといった多軸で評価できるか。歪正規分布を利用すれば。範囲の中心ではなく先端に確率を寄せることができるか。
--dis: x. 自他の距離をそのまま使用。
--point_x: μ. 平均。対象ACTにおける平均的に効果があると見込まれる座標を指定する。
--range: σ. 分散。値が低いほど分散が絞られ、尖る。実測した結果、rangeと併せて5～20程度が適当か
--scale: 母数を除算して分散する領域を制御する。値が大きい程、分散の範囲が拡大するが、分散の尖り具合は変わらない。rangeと組み合わせて、1～10程度の間で使う。
--math.randomに入れて使う。逆数かつ+1の加算により0になることはない。
--各キャラにおける各actに対して設定が必要か
function gaus_value(point_x,range,scale)
	local value = 1 +	math.floor(
							1/( 
								1/math.sqrt(2*math.pi*range^2) * math.exp(-((dis-point_x)/scale)^2/(2*range^2)) 
							)
						)
	if value>16777215 then value = 16777215 end
	return value
end

--▼各キャラのベースステータス的なの
--超反応霊夢から引っ張ってきた。
--stand_neutral：その場起き上がりのフレーム
--stand_front：前起き上がりのフレーム
--stand_back：後ろ起き上がりのフレーム
--caution_range：超反応霊夢の間合い管理用
--base_chain：超反応霊夢のガード用
--muteki：超反応霊夢の行動条件用
--graze_atk：超反応霊夢の条件用だったもの（使っていない）
stand_neutral = 0
stand_front = 0
stand_back = 0
caution_range = 0
base_chain = 0
muteki = 0
graze_atk = 0
function base_states()
--霊夢
	if enemy_char==0 then
		print("Target = 霊夢")
		stand_neutral = 34;
		stand_front = 54;
		stand_back = 54;
		caution_range = 320;
		base_chain = 4;
		graze_atk = 2;
	
--魔理沙
	elseif enemy_char==1 then
		print("Target = 魔理沙")
		stand_neutral = 36;
		stand_front = 52;
		stand_back = 51;
		base_chain = 4;
		muteki = 1;
		m300_rapid = 7;
--咲夜
	elseif enemy_char==2 then
		print("Target = 咲夜")
		stand_neutral = 38;
		stand_front = 44;
		stand_back = 46;
		base_chain = 4;
		graze_atk = 2;
		m300_rapid = 8;
--アリス
	elseif enemy_char==3 then
		print("Target = アリス")
		stand_neutral = 29;
		stand_front = 49;
		stand_back = 49;
		base_chain = 4;
		caution_range = 400;
		m300_rapid = 9;
--パチュリー
	elseif enemy_char==4 then
		print("Target = パチュリー")
		stand_neutral = 27;
		stand_front = 47;
		stand_back = 47;
		base_chain = 3;
		m300_rapid = 9;
--妖夢
	elseif enemy_char==5 then
		print("Target = 妖夢")
		stand_neutral = 25;
		stand_front = 57;
		stand_back = 57;
		base_chain = 5;
		muteki = 1;
		m300_rapid = 7;
--レミリア
	elseif enemy_char==6 then
		print("Target = レミリア")
		stand_neutral = 29;
		stand_front = 35;
		stand_back = 35;
		base_chain = 4;
		muteki = 1;
		graze_atk = 2;
		m300_rapid = 7;
--幽々子
	elseif enemy_char==7 then
		print("Target = 幽々子")
		stand_neutral = 19;
		stand_front = 63;
		stand_back = 63;
		base_chain = 3;
		graze_atk = 2;
		m300_rapid = 10;
--紫
	elseif enemy_char==8 then
		print("Target = 紫")
		stand_neutral = 58;
		stand_front = 76;
		stand_back = 76;
		base_chain = 4;
		caution_range = 320;
		graze_atk = 2;
		m300_rapid = 9;
--萃香
	elseif enemy_char==9 then
		print("Target = 萃香")
		stand_neutral = 35;
		stand_front = 47;
		stand_back = 47;
		base_chain = 4;
		graze_atk = 2;
		m300_rapid = 9;
--文
	elseif enemy_char==11 then
		print("Target = 文")
		stand_neutral = 36;
		stand_front = 46;
		stand_back = 46;
		base_chain = 4;
		graze_atk = 2;
		m300_rapid = 7;
--うどんげ
	elseif enemy_char==10 then
		print("Target = うどんげ")
		stand_neutral = 43;
		stand_front = 45;
		stand_back = 58;
		base_chain = 4;
		graze_atk = 1;
		m300_rapid = 7;
--小町
	elseif enemy_char==12 then
		print("Target = 小町")
		stand_neutral = 47;
		stand_front = 54;
		stand_back = 54;
		base_chain = 4;
		caution_range = 350;
		graze_atk = 1;
		m300_rapid = 9;
--衣玖
	elseif enemy_char==13 then
		print("Target = 衣玖")
		stand_neutral = 39;
		stand_front = 88;
		stand_back = 88;
		base_chain = 4;
		caution_range = 350;
		m300_rapid = 8;
--天子
	elseif enemy_char==14 then
		print("Target = 天子")
		stand_neutral = 31;
		stand_front = 42;
		stand_back = 42;
		base_chain = 3;
		graze_atk = 2;
		m300_rapid = 9;
--早苗
	elseif enemy_char==15 then
		print("Target = 早苗")
		stand_neutral = 25;
		stand_front = 53;
		stand_back = 58;
		base_chain = 4;
		graze_atk = 2;
		m300_rapid = 7;
--チルノ
	elseif enemy_char==16 then
		print("Target = チルノ")
		stand_neutral = 31;
		stand_front = 54;
		stand_back = 54;
		base_chain = 4;
		m300_rapid = 6;
--美鈴
	elseif enemy_char==17 then
		print("Target = 美鈴")
		stand_neutral = 26;
		stand_front = 44;
		stand_back = 44;
		base_chain = 4;
		graze_atk = 2;
		m300_rapid = 6;
--空
	elseif enemy_char==18 then
		print("Target = 空")
		stand_neutral = 20;
		stand_front = 55;
		stand_back = 55;
		base_chain = 4;
		graze_atk = 1;
		m300_rapid = 7;
--諏訪子
	elseif enemy_char==19 then
		print("Target = 諏訪子")
		stand_neutral = 29;
		stand_front = 81;
		stand_back = 81;
		base_chain = 4;
		m300_rapid = 7;
	end
end

--▼▼obj周りの演算
--2021/02/11版
--オブジェクトの攻撃判定の取得を排除。
--テーブルの再初期化を実装。
--▼my-side
pre0_my_obj_n = 0

my_obj_act = {};
my_obj_x = {};
my_obj_y = {};
my_obj_hp = {};
my_obj_img = {};
my_obj_frame = {};
my_obj_xspeed = {};
my_obj_yspeed = {};
my_obj_id = {};
my_obj_attackarea_n = {};
my_obj_hitarea_n = {};
my_obj_fflags = {};
my_obj_aflags = {};

pre0_my_obj_act = {};
pre0_my_obj_x = {};
pre0_my_obj_y = {};
pre0_my_obj_hp = {};
pre0_my_obj_img = {};
pre0_my_obj_frame = {};
pre0_my_obj_xspeed = {};
pre0_my_obj_yspeed = {};
pre0_my_obj_id = {};
pre0_my_obj_attackarea_n = {};
pre0_my_obj_hitarea_n = {};
pre0_my_obj_fflags = {};
pre0_my_obj_aflags = {};

my_obj_xaccel = {};
my_obj_yaccel = {};

for i=1,1023,1 do
my_obj_act[i] = -1;
my_obj_x[i] = 10000;
my_obj_y[i] = 10000;
my_obj_hp[i] = 0
my_obj_img[i] = -1;
my_obj_frame[i] = -1;
my_obj_xspeed[i] = 0;
my_obj_yspeed[i] = 0;
my_obj_id[i] = -1;
my_obj_attackarea_n[i] = 0;
my_obj_hitarea_n[i] = 0;
my_obj_fflags[i] = 0
my_obj_aflags[i] = 0

pre0_my_obj_act[i] = -1;
pre0_my_obj_x[i] = 10000;
pre0_my_obj_y[i] = 10000;
pre0_my_obj_hp[i] = -10000;
pre0_my_obj_img[i] = -1;
pre0_my_obj_frame[i] = -1;
pre0_my_obj_xspeed[i] = 0;
pre0_my_obj_yspeed[i] = 0;
pre0_my_obj_id[i] = -1;
pre0_my_obj_attackarea_n[i] = 0;
pre0_my_obj_hitarea_n[i] = 0;
pre0_my_obj_fflags[i] = 0
pre0_my_obj_aflags[i] = 0

my_obj_xaccel[i] = 0;
my_obj_yaccel[i] = 0;
end

--▼objの静的初期化2021/02/11
function my_obj_init()
	for i=1,1023,1 do
		my_obj_act[i] = -1;
		my_obj_x[i] = 10000;
		my_obj_y[i] = 10000;
		my_obj_hp[i] = 0;
		my_obj_img[i] = -1;
		my_obj_frame[i] = -1;
		my_obj_xspeed[i] = 0;
		my_obj_yspeed[i] = 0;
		my_obj_id[i] = -1;
		my_obj_attackarea_n[i] = 0;
		my_obj_hitarea_n[i] = 0;
		my_obj_fflags[i] = 0
		my_obj_aflags[i] = 0

		my_obj_xaccel[i] = 0;
		my_obj_yaccel[i] = 0;
	end
end

function my_obj_calc()
--▼objの静的初期化2021/02/11
	my_obj_init()
--obj各個変数化
	for i=1,my_obj_n,1 do
		my_obj_act[i],my_obj_x[i],my_obj_y[i],my_obj_hp[i],my_obj_img[i],my_obj_frame[i],my_obj_xspeed[i],my_obj_yspeed[i],my_obj_id[i],my_obj_attackarea_n[i],my_obj_hitarea_n[i],my_obj_fflags[i],my_obj_aflags[i] = get_obj_data(0,i-1);
	end
--テーブルの動的再初期化。うまくいっているのかよくわからない。値はnilになる。
--objの判定が残る件で凍結2021/02/11
--	local ii=#my_obj_act
--	if my_obj_n<ii then
--		table.remove(my_obj_act)
--		table.remove(my_obj_x)
--		table.remove(my_obj_y)
--		table.remove(my_obj_hp)
--		table.remove(my_obj_img)
--		table.remove(my_obj_frame)
--		table.remove(my_obj_xspeed)
--		table.remove(my_obj_yspeed)
--		table.remove(my_obj_id)
--		table.remove(my_obj_attackarea_n)
--		table.remove(my_obj_hitarea_n)
--		table.remove(my_obj_fflags)
--		table.remove(my_obj_aflags)
--	end
--obj_attackareaは正確に値を取れないため削除。objの角度が必要となる。
--obj加速度
	for i=1,my_obj_n,1 do
		if my_obj_id[i] == pre0_my_obj_id[i] and my_obj_attackarea_n[i]>=1 then
			if battle_time-old_bt==1 then
					my_obj_xaccel[i] 	= math.floor((my_obj_xspeed[i]-pre0_my_obj_xspeed[i])*1000)/1000
					my_obj_yaccel[i] 	= math.floor((my_obj_yspeed[i]-pre0_my_obj_yspeed[i])*1000)/1000
			elseif battle_time-old_bt>=2 then
					my_obj_xaccel[i] 	= math.floor((my_obj_xspeed[i]-pre0_my_obj_xspeed[i])*1000)/1000/(battle_time-old_bt)
					my_obj_yaccel[i] 	= math.floor((my_obj_yspeed[i]-pre0_my_obj_yspeed[i])*1000)/1000/(battle_time-old_bt)
			end
		elseif my_obj_id[i] ~= pre0_my_obj_id[i] then
			for ii=1,pre0_my_obj_n,1 do
			if battle_time-old_bt==1 then
				if my_obj_id[i] == pre0_my_obj_id[ii] and my_obj_attackarea_n[i]>=1 then
					my_obj_xaccel[i] 	= math.floor((my_obj_xspeed[i]-pre0_my_obj_xspeed[ii])*1000)/1000
					my_obj_yaccel[i] 	= math.floor((my_obj_yspeed[i]-pre0_my_obj_yspeed[ii])*1000)/1000
				end
			elseif battle_time-old_bt>=2 then
				if my_obj_id[i] == pre0_my_obj_id[ii] and my_obj_attackarea_n[i]>=1 then
					my_obj_xaccel[i] 	= math.floor((my_obj_xspeed[i]-pre0_my_obj_xspeed[ii])*1000)/1000/(battle_time-old_bt)
					my_obj_yaccel[i] 	= math.floor((my_obj_yspeed[i]-pre0_my_obj_yspeed[ii])*1000)/1000/(battle_time-old_bt)
				end
			end
			end
		end
	end
end

--▼enemy-side
pre0_enemy_obj_n = 0

enemy_obj_act = {};
enemy_obj_x = {};
enemy_obj_y = {};
enemy_obj_hp = {};
enemy_obj_img = {};
enemy_obj_frame = {};
enemy_obj_xspeed = {};
enemy_obj_yspeed = {};
enemy_obj_id = {};
enemy_obj_attackarea_n = {};
enemy_obj_hitarea_n = {};
enemy_obj_fflags = {};
enemy_obj_aflags = {};

pre0_enemy_obj_act = {};
pre0_enemy_obj_x = {};
pre0_enemy_obj_y = {};
pre0_enemy_obj_hp = {};
pre0_enemy_obj_img = {};
pre0_enemy_obj_frame = {};
pre0_enemy_obj_xspeed = {};
pre0_enemy_obj_yspeed = {};
pre0_enemy_obj_id = {};
pre0_enemy_obj_attackarea_n = {};
pre0_enemy_obj_hitarea_n = {};
pre0_enemy_obj_fflags = {};
pre0_enemy_obj_aflags = {};

enemy_obj_xaccel = {};
enemy_obj_yaccel = {};

for i=1,1023,1 do
enemy_obj_act[i] = -1;
enemy_obj_x[i] = 0
enemy_obj_y[i] = 0
enemy_obj_hp[i] = 0
enemy_obj_img[i] = -1;
enemy_obj_frame[i] = -1;
enemy_obj_xspeed[i] = 0;
enemy_obj_yspeed[i] = 0;
enemy_obj_id[i] = -1;
enemy_obj_attackarea_n[i] = 0;
enemy_obj_hitarea_n[i] = 0;
enemy_obj_fflags[i] = 0
enemy_obj_aflags[i] = 0

pre0_enemy_obj_act[i] = -1;
pre0_enemy_obj_x[i] = 10000;
pre0_enemy_obj_y[i] = 10000;
pre0_enemy_obj_hp[i] = -10000;
pre0_enemy_obj_img[i] = -1;
pre0_enemy_obj_frame[i] = -1;
pre0_enemy_obj_xspeed[i] = 0;
pre0_enemy_obj_yspeed[i] = 0;
pre0_enemy_obj_id[i] = -1;
pre0_enemy_obj_attackarea_n[i] = 0;
pre0_enemy_obj_hitarea_n[i] = 0;
pre0_enemy_obj_fflags[i] = 0
pre0_enemy_obj_aflags[i] = 0

enemy_obj_xaccel[i] = 0;
enemy_obj_yaccel[i] = 0;
end

--▼objの静的初期化2021/02/11
function enemy_obj_init()
	for i=1,1023,1 do
		enemy_obj_act[i] = -1;
		enemy_obj_x[i] = 10000
		enemy_obj_y[i] = 10000
		enemy_obj_hp[i] = 0
		enemy_obj_img[i] = -1;
		enemy_obj_frame[i] = -1;
		enemy_obj_xspeed[i] = 0;
		enemy_obj_yspeed[i] = 0;
		enemy_obj_id[i] = -1;
		enemy_obj_attackarea_n[i] = 0;
		enemy_obj_hitarea_n[i] = 0;
		enemy_obj_fflags[i] = 0
		enemy_obj_aflags[i] = 0

		enemy_obj_xaccel[i] = 0;
		enemy_obj_yaccel[i] = 0;
	end
end

function enemy_obj_calc()
--▼objの静的初期化2021/02/11
	enemy_obj_init()
--obj各個変数化
	for i=1,enemy_obj_n,1 do
		enemy_obj_act[i],enemy_obj_x[i],enemy_obj_y[i],enemy_obj_hp[i],enemy_obj_img[i],enemy_obj_frame[i],enemy_obj_xspeed[i],enemy_obj_yspeed[i],enemy_obj_id[i],enemy_obj_attackarea_n[i],enemy_obj_hitarea_n[i],enemy_obj_fflags[i],enemy_obj_aflags[i] = get_obj_data(1,i-1);
	end
--テーブルの動的再初期化。うまくいっているのかよくわからない。値はnilになる。
--objの判定が残る件で凍結2021/02/11
--	local ii=#enemy_obj_act
--	if enemy_obj_n<ii then
--		table.remove(enemy_obj_act)
--		table.remove(enemy_obj_x)
--		table.remove(enemy_obj_y)
--		table.remove(enemy_obj_hp)
--		table.remove(enemy_obj_img)
--		table.remove(enemy_obj_frame)
--		table.remove(enemy_obj_xspeed)
--		table.remove(enemy_obj_yspeed)
--		table.remove(enemy_obj_id)
--		table.remove(enemy_obj_attackarea_n)
--		table.remove(enemy_obj_hitarea_n)
--		table.remove(enemy_obj_fflags)
--		table.remove(enemy_obj_aflags)
--	end--]]
--obj_attackareaは正確に値を取れないため削除。objの角度が必要となる。
--obj加速度
	for i=1,enemy_obj_n,1 do
		if enemy_obj_id[i] == pre0_enemy_obj_id[i] and enemy_obj_attackarea_n[i]>=1 then
			if battle_time-old_bt==1 then
					enemy_obj_xaccel[i] 	= math.floor((enemy_obj_xspeed[i]-pre0_enemy_obj_xspeed[i])*1000)/1000
					enemy_obj_yaccel[i] 	= math.floor((enemy_obj_yspeed[i]-pre0_enemy_obj_yspeed[i])*1000)/1000
			elseif battle_time-old_bt>=2 then
					enemy_obj_xaccel[i] 	= math.floor((enemy_obj_xspeed[i]-pre0_enemy_obj_xspeed[i])*1000)/1000/(battle_time-old_bt)
					enemy_obj_yaccel[i] 	= math.floor((enemy_obj_yspeed[i]-pre0_enemy_obj_yspeed[i])*1000)/1000/(battle_time-old_bt)
			end
		elseif enemy_obj_id[i] ~= pre0_enemy_obj_id[i] then
			for ii=1,pre0_enemy_obj_n,1 do
			if battle_time-old_bt==1 then
				if enemy_obj_id[i] == pre0_enemy_obj_id[ii] and enemy_obj_attackarea_n[i]>=1 then
					enemy_obj_xaccel[i] 	= math.floor((enemy_obj_xspeed[i]-pre0_enemy_obj_xspeed[ii])*1000)/1000
					enemy_obj_yaccel[i] 	= math.floor((enemy_obj_yspeed[i]-pre0_enemy_obj_yspeed[ii])*1000)/1000
				end
			elseif battle_time-old_bt>=2 then
				if enemy_obj_id[i] == pre0_enemy_obj_id[ii] and enemy_obj_attackarea_n[i]>=1 then
					enemy_obj_xaccel[i] 	= math.floor((enemy_obj_xspeed[i]-pre0_enemy_obj_xspeed[ii])*1000)/1000/(battle_time-old_bt)
					enemy_obj_yaccel[i] 	= math.floor((enemy_obj_yspeed[i]-pre0_enemy_obj_yspeed[ii])*1000)/1000/(battle_time-old_bt)
				end
			end
			end
		end
	end
end

--▼落下加速度の演算▼
function calc_gs()
	if battle_time>old_bt then
		if m_gs>=-1 and m_gs<=0 then
			m_gs = (my_yspeed - old_m_ys)/(battle_time-old_bt)
		end
	end
	if my_act==my_preact[1] and m_gs==old_m_gs*2 then
		m_gs = old_m_gs
	end
	if m_gs>0 then
		m_gs = 0
	end
	if m_gs<-1 then
		m_gs = old_m_gs
	end
	if m_gs==0 and my_yspeed~=0 then
		m_gs = old_m_gs
	end
	
	if battle_time>old_bt then
		if e_gs>=-1 and e_gs<=0 then
			e_gs = (enemy_yspeed - old_e_ys)/(battle_time-old_bt)
		end
	end
	if enemy_act==enemy_preact[1] and e_gs==old_e_gs*2 then
		e_gs = old_e_gs
	end
	if e_gs>0 then
		e_gs = 0
	end
	if e_gs<-1 then
		e_gs = old_e_gs
	end
	if e_gs==0 and enemy_yspeed~=0 then
		e_gs = old_e_gs
	end
end

--▼絶対座標に対する速度と座標より算出した速度▼
	function calc_xspeedEX()
	
		if my_hitstop==0 and battle_time-old_bt>=1 then
			my_xspeedEX = ((x-old_x)*my_dir)/(battle_time-old_bt)
		end
		if my_hitstop>0 then
			my_xspeedEX = old_my_xspeedEX
		end
		if my_act==my_preact[1] and my_allframe-old_my_allframe>=2 then
			my_xspeedEX = ((x-old_x)*my_dir)/(my_allframe-old_my_allframe)
			if my_xspeedEX==old_my_xspeedEX/2 then
				my_xspeedEX = my_xspeedEX*2
			end
		end
		if my_act==my_preact[1] and my_xspeedEX==0 and my_allframe==old_my_allframe then
			my_xspeedEX = old_my_xspeedEX
		end
		if my_act==my_preact[1] and my_xspeedEX==0 and old_my_xspeedEX~=0 and x==old_x and old_x2~=x then
			my_xspeedEX = old_my_xspeedEX
		end
		if old_Dbt==0 and my_xspeedEX==old_my_xspeedEX*2 then
			my_xspeedEX = my_xspeedEX/2
		end
	
		if enemy_hitstop==0 and battle_time-old_bt>=1 then
			enemy_xspeedEX = ((ex-old_ex)*enemy_dir)/(battle_time-old_bt)
		end
		if enemy_hitstop>0 then
			enemy_xspeedEX = old_enemy_xspeedEX
		end
		if enemy_act==enemy_preact[1] and enemy_allframe-old_enemy_allframe>=2 then
			enemy_xspeedEX = ((ex-old_ex)*enemy_dir)/(enemy_allframe-old_enemy_allframe)
			if enemy_xspeedEX==old_enemy_xspeedEX/2 then
				enemy_xspeedEX = enemy_xspeedEX*2
			end
		end
		if enemy_act==enemy_preact[1] and enemy_xspeedEX==0 and enemy_allframe==old_enemy_allframe then
			enemy_xspeedEX = old_enemy_xspeedEX
		end
		if enemy_act==enemy_preact[1] and enemy_xspeedEX==0 and old_enemy_xspeedEX~=0 and ex==old_ex and old_ex2~=ex then
			enemy_xspeedEX = old_enemy_xspeedEX
		end
		if old_Dbt==0 and enemy_xspeedEX==old_enemy_xspeedEX*2 then
			enemy_xspeedEX = enemy_xspeedEX/2
		end

	end
	
--▼過去のモーション、フレームの格納▼
function elder_preact_calc()
--act_blockの導入
	if my_frame==0 and my_act_block==0 then
		my_allframe = my_frame+1
	end
	if enemy_frame==0 and enemy_act_block==0 then
		enemy_allframe = enemy_frame+1
	end
--東方緋想天　AI関連スレッド1 >>80より
--直前actと異なっていたら、もしくは同じact番号でもframeが巻き戻っていたら記録する(自分)
	if not(my_preact[1] == my_act and my_preframe[1] <= my_frame) then
		for i=6,2,-1 do
			my_preact[i] = my_preact[i-1];
			my_preframe[i] = my_preframe[i-1];
		end
	end
--直前actと異なっていたら、もしくは同じact番号でもframeが巻き戻っていたら記録する(相手)
	if not(enemy_preact[1] == enemy_act and enemy_preframe[1] <= enemy_frame) then
		for i=6,2,-1 do
			enemy_preact[i] = enemy_preact[i-1];
			enemy_preframe[i] = enemy_preframe[i-1];
		end
	end
--フレーム総数の記録(自分)
	if my_act == my_preact[2] and my_act == my_preact[3] and my_act == my_preact[4] and my_act == my_preact[5] and my_act == my_preact[6] then
		my_allframe = my_frame + my_preframe[2] + my_preframe[3] + my_preframe[4] + my_preframe[5] + my_preframe[6] + 5 + 1 ;
	elseif my_act == my_preact[2] and my_act == my_preact[3] and my_act == my_preact[4] and my_act == my_preact[5] then
		my_allframe = my_frame + my_preframe[2] + my_preframe[3] + my_preframe[4] + my_preframe[5] + 4 + 1 ;
	elseif my_act == my_preact[2] and my_act == my_preact[3] and my_act == my_preact[4] then
		my_allframe = my_frame + my_preframe[2] + my_preframe[3] + my_preframe[4] + 3 + 1 ;
	elseif my_act == my_preact[2] and my_act == my_preact[3] then
		my_allframe = my_frame + my_preframe[2] + my_preframe[3] + 2 + 1 ;
	elseif my_act == my_preact[2] then
		my_allframe = my_frame + my_preframe[2] + 1 + 1 ;
	else
		my_allframe = my_frame + 1 ;
	end
--フレーム総数の記録(相手)
	if enemy_act == enemy_preact[2] and enemy_act == enemy_preact[3] and enemy_act == enemy_preact[4] and enemy_act == enemy_preact[5] and enemy_act == enemy_preact[6] then
		enemy_allframe = enemy_frame + enemy_preframe[2] + enemy_preframe[3] + enemy_preframe[4] + enemy_preframe[5] + enemy_preframe[6] + 5 + 1 ;
	elseif enemy_act == enemy_preact[2] and enemy_act == enemy_preact[3] and enemy_act == enemy_preact[4] and enemy_act == enemy_preact[5] then
		enemy_allframe = enemy_frame + enemy_preframe[2] + enemy_preframe[3] + enemy_preframe[4] + enemy_preframe[5] + 4 + 1 ;
	elseif enemy_act == enemy_preact[2] and enemy_act == enemy_preact[3] and enemy_act == enemy_preact[4] then
		enemy_allframe = enemy_frame + enemy_preframe[2] + enemy_preframe[3] + enemy_preframe[4] + 3 + 1 ;
	elseif enemy_act == enemy_preact[2] and enemy_act == enemy_preact[3] then
		enemy_allframe = enemy_frame + enemy_preframe[2] + enemy_preframe[3] + 2 + 1 ;
	elseif enemy_act == enemy_preact[2] then
		enemy_allframe = enemy_frame + enemy_preframe[2] + 1 + 1 ;
	else
		enemy_allframe = enemy_frame + 1 ;
	end
end

--▼端までの距離計算。0～1200▼
function dis_backside()
	if my_dir == 1 then
		my_frontside = 1240 - x
	else
		my_frontside = x - 40
	end

	if enemy_dir == 1 then
		enemy_frontside = 1240 - ex
	else
		enemy_frontside = ex - 40
	end
----
	if my_dir == 1 then
		my_backside = x - 40
	else
		my_backside = 1240 - x
	end

	if enemy_dir == 1 then
		enemy_backside = ex - 40
	else
		enemy_backside = 1240 - ex
	end
end

--▼飛翔の残り回数の演算▼
function air_remain_calc()
	if weather~=10 then
		if my_air==0 then
			my_airEX = 2
		elseif my_air==1 then
			my_airEX = 1
		elseif my_air>=2 then
			my_airEX = 0
		end
	else
		if my_air==0 then
			my_airEX = 3
		elseif my_air==1 then
			my_airEX = 2
		elseif my_air==2 then
			my_airEX = 1
		elseif my_air>=3 then
			my_airEX = 0
		end
	end
	if weather~=10 then
		if enemy_air==0 then
			enemy_airEX = 2
		elseif enemy_air==1 then
			enemy_airEX = 1
		elseif enemy_air>=2 then
			enemy_airEX = 0
		end
	else
		if enemy_air==0 then
			enemy_airEX = 3
		elseif enemy_air==1 then
			enemy_airEX = 2
		elseif enemy_air==2 then
			enemy_airEX = 1
		elseif enemy_air>=3 then
			enemy_airEX = 0
		end
	end
end

old_Dbt = 0
old_x2 = 0
old_ex2 = 0
--▼１更新前の値をまとめて格納
function oldvalue_calc()
	old_Dbt = battle_time-old_bt
--if battle_time-old_bt~=0 then
	old_x2 = old_x
	old_ex2 = old_ex
	old_x = x
	old_ex = ex
	old_my_xspeedEX = my_xspeedEX
	old_enemy_xspeedEX = enemy_xspeedEX
	old_m_ys = my_yspeed
	old_e_ys = enemy_yspeed
	old_m_gs = m_gs
	old_e_gs = e_gs

	my_preact[1] = my_act;
	my_preframe[1] = my_frame;
	enemy_preact[1] = enemy_act;
	enemy_preframe[1] = enemy_frame;
	old_my_allframe = my_allframe
	old_enemy_allframe = enemy_allframe
	----
	--▼▼pre_obj変数
	--▼my-side
	for i=1,my_obj_n,1 do
		pre0_my_obj_act[i] 			= my_obj_act[i]
		pre0_my_obj_x[i] 			= my_obj_x[i]
		pre0_my_obj_y[i] 			= my_obj_y[i]
		pre0_my_obj_hp[i] 			= my_obj_hp[i]
		pre0_my_obj_img[i] 			= my_obj_img[i]
		pre0_my_obj_frame[i] 		= my_obj_frame[i]
		pre0_my_obj_xspeed[i] 		= my_obj_xspeed[i]
		pre0_my_obj_yspeed[i] 		= my_obj_yspeed[i]
		pre0_my_obj_id[i] 			= my_obj_id[i]
		pre0_my_obj_attackarea_n[i] = my_obj_attackarea_n[i]
		pre0_my_obj_hitarea_n[i] 	= my_obj_hitarea_n[i]
		pre0_my_obj_fflags[i] 		= my_obj_fflags[i]
		pre0_my_obj_aflags[i] 		= my_obj_aflags[i]
	end

	for i=1,my_obj_n,1 do
		pre0_my_obj_attackarea_n[i] = my_obj_attackarea_n[i]
	end

	pre0_my_obj_n = my_obj_n;
	
	--▼enemy-side
	for i=1,enemy_obj_n,1 do
		pre0_enemy_obj_act[i] 			= enemy_obj_act[i]
		pre0_enemy_obj_x[i] 			= enemy_obj_x[i]
		pre0_enemy_obj_y[i] 			= enemy_obj_y[i]
		pre0_enemy_obj_hp[i] 			= enemy_obj_hp[i]
		pre0_enemy_obj_img[i] 			= enemy_obj_img[i]
		pre0_enemy_obj_frame[i] 		= enemy_obj_frame[i]
		pre0_enemy_obj_xspeed[i] 		= enemy_obj_xspeed[i]
		pre0_enemy_obj_yspeed[i] 		= enemy_obj_yspeed[i]
		pre0_enemy_obj_id[i] 			= enemy_obj_id[i]
		pre0_enemy_obj_attackarea_n[i] 	= enemy_obj_attackarea_n[i]
		pre0_enemy_obj_hitarea_n[i] 	= enemy_obj_hitarea_n[i]
		pre0_enemy_obj_fflags[i] 		= enemy_obj_fflags[i]
		pre0_enemy_obj_aflags[i] 		= enemy_obj_aflags[i]
	end

	for i=1,enemy_obj_n,1 do
		pre0_enemy_obj_attackarea_n[i] = enemy_obj_attackarea_n[i]
	end

	pre0_enemy_obj_n = enemy_obj_n;

	old_d_bt = battle_time - old_bt
	old_bt = battle_time
--end
end

--▼my-side
my_hitarea_right = {};
my_hitarea_left = {};
my_hitarea_top = {};
my_hitarea_bottom = {};
for i=0,10,1 do
my_hitarea_right[i] = 10000;
my_hitarea_left[i] = 10000;
my_hitarea_top[i] = 10000;
my_hitarea_bottom[i] = 10000;
end
--▼enemy-side
enemy_hitarea_right = {};
enemy_hitarea_left = {};
enemy_hitarea_top = {};
enemy_hitarea_bottom = {};
for i=0,10,1 do
enemy_hitarea_right[i] = 10000;
enemy_hitarea_left[i] = 10000;
enemy_hitarea_top[i] = 10000;
enemy_hitarea_bottom[i] = 10000;
end

--環境変数演算関数（マイクロスレッド組込用）
function calculation()
while true do

--▼sabot関数群を起動するためのフラグ
	sabot_activate()

--▼過去のモーション、フレームの格納
	elder_preact_calc()
	
--▼絶対座標に対する速度と座標より算出した速度▼
	calc_xspeedEX()
	
--▼落下加速度の演算▼
	calc_gs()
	
--▼obj周りの演算
	my_obj_calc()
	enemy_obj_calc()

	calc_pos_doll()
	
--▼コマンド等認識用カウンタ
	key_count_calc()
	
--▼actカウンタ
	my_act_count_calc()
	enemy_act_count_calc()
	
--▼どれくらい地上or空中にいたのかをカウント
	state_fcount()

--▼negativeカウンタ
	nega_count_calc()

--▼霊力の状況を評価
	rei_evaluat()

--▼端までの距離計算。0～1200▼
	dis_backside()
	
--▼飛翔の残り回数の演算▼
	air_remain_calc()
	
--▼「サブタレイニアンサン」対策
	subs_func()

--▼緋想の剣用フラグ
	kishitu_switch()

--▼妖夢半霊用座標演算
	calc_hanrei()

--▼キャラとobjの攻撃判定演算
	--calc_char_atttackarea()
	--calc_obj_atttackarea()
	--calc_char_hitarea()
	--calc_obj_hitarea() --get_obj_hitarea関数がエラーをはくため使用不能とみなし凍結
	
--]]
--赤魂残滓、青魂残滓：act826-img222、スキル青魂：act827-img223、スペカ青魂：act855-img223
--[[
	if my_obj_n>=1 then
		for i=1,my_obj_n,1 do
			print(
				i,
				my_obj_act[i],
				my_obj_img[i]
			)
		end
	end
--]]
--[[
--local n1 = (enemy_obj_x[3]-x)*my_dir-(enemy_obj_xspeed[3]*1+1*(1-1)*enemy_obj_xaccel[3]/2)
--local n2 = enemy_obj_x[3]
local n1 = math.floor(x*100)/100
local n2 = math.floor(y*100)/100
local n3 = math.floor(my_xspeedEX*100)/100
local n4 = math.floor(my_yspeed*100)/100
--
print(
		battle_time-old_bt,
		my_act,
		my_frame,
		my_act_block,
		my_allframe,
		n1-40,
		n2,
		n3,
		n4,
		math.floor(m_gs*100)/100
		
		
		);
--end
--]]
--print(my_act,my_act_block,my_img)

--▼１更新前の値をまとめて格納
	oldvalue_calc()

yield();
end
end