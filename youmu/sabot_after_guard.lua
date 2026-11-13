--サボット関数：ガード後のサボリ　※共用
--ガードしたあとの待機時間をコントロールする関数
--実際にガードした方向にキー入力固定ないし、キー入力を解除し、指定された時間wait関数を挟む。
--ただし、霊力状況が厳しくなると実行しない。
--なお、初手のガードをさぼる関数ではないため、不自然なサボリに見えなくもない。
--どれくらい固定ないし解除されるかはsabot_delay_control関数により決定される。
--また、この関数自体の起動は、sabot_rankによりコントロールされており、ランクによって起動の有無がコントロールされる。

--
function sabot_after_guard()

local check_sum = 0
--定常状態とガード状態とで場合を分ける
--定常状態で攻撃を受ける場合：敵ACTが起動した段階でディレイを決定
--ガード状態で攻撃をを受ける場合：モーションの終端でディレイを決定（本当はあらゆるモーションの終端がいい）
if not((my_rmax==1000 and my_rei<=200) or (my_rmax==800 and my_rei<=400) or (my_rmax<=600)) then
	if 	dis2<560 and (
	(enemy_act>=300 and enemy_frame<=2 and enemy_act_block==0) or
	(my_act==143 and my_frame>=4 and my_act_block==2) or
	
	(my_act==150 and my_frame>=8 and my_act_block==0) or 
	(my_act==151 and my_frame>=14 and my_act_block==0) or 
	(my_act==152 and my_frame>=20 and my_act_block==0) or 
	(my_act==153 and my_frame>=26 and my_act_block==0) or
	
	(my_act==154 and my_frame>=8 and my_act_block==0) or 
	(my_act==155 and my_frame>=14 and my_act_block==0) or 
	(my_act==156 and my_frame>=20 and my_act_block==0) or 
	(my_act==157 and my_frame>=26 and my_act_block==0) or
	
	(my_act==158 and my_frame>=18 and my_act_block==0) or
	
	(my_act==159 and my_frame>=10 and my_act_block==0) or 
	(my_act==160 and my_frame>=18 and my_act_block==0) or 
	(my_act==161 and my_frame>=26 and my_act_block==0) or 
	(my_act==162 and my_frame>=30 and my_act_block==0) or
	
	(my_act==163 and my_frame>=10 and my_act_block==0) or 
	(my_act==164 and my_frame>=18 and my_act_block==0) or 
	(my_act==165 and my_frame>=26 and my_act_block==0) or 
	(my_act==166 and my_frame>=30 and my_act_block==0)
	) then
	--立ちっぽいなら立ちガード維持
		if (
			(air_math>60) or --明らかに空中なら立つ
			my_act==3 or 
			my_act==5 or 
			(my_act>=5 and my_act<=59) or 
			(my_act>=70 and my_act<=107) or 
			(my_act==143 and my_frame>=4 and my_act_block==2 and math.random(2)==1) or --割れたらランダム
			(my_act>=145 and my_act<=153) or 
			my_act==158 or
			((my_act>=159 and my_act<=162) and math.random(5)==1) or --誤ガード時は確率でそのままの方向
			(my_act>=180 and my_act<=205) or
			(my_act>=208 and my_act<=215)
			)and flag_my_cmd656_65==0 and flag_my_cmd454_45==0 and flag_my_cmd252_25==0 and flag_my_cmdd5d_d5==0 then
				print("sabot function run : STAND Guard Going my way")
				key_reset()
				if my_dir==1 then
					key_on(ACT_LEFT)
				else
					key_on(ACT_RIGHT)
				end
				sabot_delay_control()
				check_sum = check_sum+1
	--屈っぽいなら屈ガード維持
		elseif 
			my_act==2 or 
			(my_act>=62 and my_act<=65) or
			(my_act==143 and my_frame>=4 and my_act_block==2 and math.random(2)==1) or --割れたらランダム
			(my_act>=154 and my_act<=157) or
			((my_act>=163 and my_act<=166) and math.random(5)==1) --誤ガード時は確率でそのままの方向
			then
				print("sabot function run : UNDER Guard Going my way")
				key_reset()
				key_on(ACT_DOWN)
				if my_dir==1 then
					key_on(ACT_LEFT)
				else
					key_on(ACT_RIGHT)
				end
				sabot_delay_control()
				check_sum = check_sum+1
		
		end
	end
end

--if check_sum>=1 then
--
--else
--
--end

	sabot_activate_flag = 0

end
