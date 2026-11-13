
function graze_action_xrange()

if sabot_rank>=1 then
	key_on(back)
	react_delay_control()
end

	if enemy_char==9 and enemy_act==402 then--萃香２Ｂ対策。
		key_on(d_back);
	elseif 
		not(my_act>=6 and my_act<=8 and y<100 and my_yspeed>=0) and 
		not(my_act>=208 and my_act<=212 and y<100 and my_yspeed>=0) and 
		not(my_act>=50 and my_act<143) and
		not(	(my_act==150 and my_frame+1< 8) or
				(my_act==151 and my_frame+1<14) or
				(my_act==152 and my_frame+1<20) or
				(my_act==153 and my_frame+1<26) or
				(my_act==154 and my_frame+1< 8) or
				(my_act==155 and my_frame+1<14) or
				(my_act==156 and my_frame+1<20) or
				(my_act==157 and my_frame+1<26) or
				(my_act==158 and my_frame+1<18)
		) 
	then
	--▼90型：パ幽
		if my_char==4 or my_char==7 then
			if dis>600 then
				if y==0 and ey<120 then
					print("モーション反応　⇒　遠距離：地上　⇒　８ｈｊ");
					key_event2(ACT_D,ACT_UP);
				elseif y==0 and ey>120 then
					print("モーション反応　⇒　遠距離：地上　⇒　６D");
					key_event2(ACT_D,front);
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>90.0 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>90.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>63.7 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>63.7　⇒　１飛翔");
						key_on(d_back);
					elseif my_act~=214 and my_act~=203 then
						print("モーション反応　⇒　遠距離：空中　y<=63.7　⇒　J４４");
						key_resetEX();
						yield();
						lvr44();
					end
				end
			elseif dis>300 then
				if y==0 and my_act~=200 then
					if ey>=1*(ex-x)*my_dir then
						print("モーション反応　⇒　中距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif dis<=400 and ey<=200 and my_act~=200 and math.random(4)==1 then
						print("モーション反応　⇒　中距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,u_front);
					elseif math.random(4)<=3 then
						print("モーション反応　⇒　中距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					else
						print("モーション反応　⇒　中距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>90.0 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>90.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>63.7 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>63.7　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　中距離：空中　y<=63.7　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			else
				if y==0 and my_act~=200 then
					if ey<=200 and math.random(4)==1 then
						print("モーション反応　⇒　近距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,front);
					elseif y>=100 then
						print("モーション反応　⇒　近距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif my_backside>=200 then
						print("モーション反応　⇒　近距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,u_back);
					else
						print("モーション反応　⇒　近距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=5 then
					key_reset();
					key_on(ACT_D);
					if y-ey>100.0 and my_backside<=100 and enemy_frontside<=200 and my_act~=214 then
						print("モーション反応　⇒　画面端：空中　飛び越え可能　⇒　６飛翔");
						key_on(front);
					elseif y>90.0 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>90.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>63.7 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>63.7　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　近距離：空中　y<=63.7　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			end
			
	--▼100型：霊紫衣
		elseif my_char==0 or my_char==8 or my_char==13 then
			if dis>600 then
				if y==0 then
					print("モーション反応　⇒　遠距離：地上　⇒　８ｈｊ");
					key_event2(ACT_D,ACT_UP);
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>100.0 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>100.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>70.8 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>70.8　⇒　１飛翔");
						key_on(d_back);
					elseif my_act~=214 and my_act~=203 then
						print("モーション反応　⇒　遠距離：空中　y<=70.8　⇒　J４４");
						key_resetEX();
						yield();
						lvr44();
					end
				end
			elseif dis>300 then
				if y==0 and my_act~=200 then
					if ey>=1*(ex-x)*my_dir then
						print("モーション反応　⇒　中距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif dis<=400 and ey<=200 and my_act~=200 and math.random(4)==1 then
						print("モーション反応　⇒　中距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,u_front);
					elseif math.random(4)<=3 then
						print("モーション反応　⇒　中距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					else
						print("モーション反応　⇒　中距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>100.0 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>100.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>70.8 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>70.8　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　中距離：空中　y<=70.8　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			else
				if y==0 and my_act~=200 then
					if ey<=200 and math.random(4)==1 then
						print("モーション反応　⇒　近距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,front);
					elseif y>=100 then
						print("モーション反応　⇒　近距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif my_backside>=200 then
						print("モーション反応　⇒　近距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,u_back);
					else
						print("モーション反応　⇒　近距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y-ey>100.0 and my_backside<=100 and enemy_frontside<=200 and my_act~=214 then
						print("モーション反応　⇒　画面端：空中　飛び越え可能　⇒　６飛翔");
						key_on(front);
					elseif y>100.0 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>100.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>70.8 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>70.8　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　近距離：空中　y<=70.8　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			end
		
	--▼103.5型：萃う
		elseif my_char==9 or my_char==10 then
			if dis>600 then
				if y==0 then
					print("モーション反応　⇒　遠距離：地上　⇒　８ｈｊ");
					key_event2(ACT_D,ACT_UP);
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>103.5 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>103.5　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>73.2 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>73.2　⇒　１飛翔");
						key_on(d_back);
					elseif my_act~=214 and my_act~=203 then
						print("モーション反応　⇒　遠距離：空中　y<=73.2　⇒　J４４");
						key_resetEX();
						yield();
						lvr44();
					end
				end
			elseif dis>300 then
				if y==0 and my_act~=200 then
					if ey>=1*(ex-x)*my_dir then
						print("モーション反応　⇒　中距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif dis<=400 and ey<=200 and my_act~=200 and math.random(4)==1 then
						print("モーション反応　⇒　中距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,u_front);
					elseif math.random(4)<=3 then
						print("モーション反応　⇒　中距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					else
						print("モーション反応　⇒　中距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>103.5 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>103.5　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>73.2 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>73.2　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　中距離：空中　y<=73.2　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			else
				if y==0 and my_act~=200 then
					if ey<=200 and math.random(4)==1 then
						print("モーション反応　⇒　近距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,front);
					elseif y>=100 then
						print("モーション反応　⇒　近距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif my_backside>=200 then
						print("モーション反応　⇒　近距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,u_back);
					else
						print("モーション反応　⇒　近距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y-ey>100.0 and my_backside<=100 and enemy_frontside<=200 and my_act~=214 then
						print("モーション反応　⇒　画面端：空中　飛び越え可能　⇒　６飛翔");
						key_on(front);
					elseif y>103.5 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>103.5　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>73.2 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>73.2　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　近距離：空中　y<=73.2　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			end
			
	--▼120型：魔咲ア文死天チ紅空
		elseif my_char==1 or my_char==2 or my_char==3 or my_char==11 or my_char==12 or my_char==14 or my_char==16 or my_char==17 or my_char==18 then
			if dis>600 then
				if y==0 and ey<120 then
					print("モーション反応　⇒　遠距離：地上　⇒　８ｈｊ");
					key_event2(ACT_D,ACT_UP);
				elseif y==0 and ey>120 then
					print("モーション反応　⇒　遠距離：地上　⇒　６D");
					key_event2(ACT_D,front);
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>120.0 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>120.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>84.9 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>84.9　⇒　１飛翔");
						key_on(d_back);
					elseif my_act~=214 and my_act~=203 then
						print("モーション反応　⇒　遠距離：空中　y<=84.9　⇒　J４４");
						key_resetEX();
						yield();
						lvr44();
					end
				end
			elseif dis>300 then
				if y==0 and my_act~=200 then
					if ey>=1*(ex-x)*my_dir then
						print("モーション反応　⇒　中距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif dis<=400 and ey<=200 and my_act~=200 and math.random(4)==1 then
						print("モーション反応　⇒　中距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,u_front);
					elseif math.random(4)<=3 then
						print("モーション反応　⇒　中距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					else
						print("モーション反応　⇒　中距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>120.0 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>120.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>84.9 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>84.9　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　中距離：空中　y<=84.9　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			else
				if y==0 and my_act~=200 then
					if ey<=200 and math.random(4)==1 then
						print("react:motion -> 近距離：地上 -> 9hj     -");
						key_event2(ACT_D,front);
					elseif ey>=100 then
						print("react:motion -> 近距離：地上 -> 6D     -");
						key_on(ACT_D);
						key_on(front);
					elseif my_backside>=200 then
						print("react:motion -> 近距離：地上 -> 7hj     -");
						key_event2(ACT_D,u_back);
					else
						print("react:motion -> 近距離：地上 -> 8hj     -");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y-ey>100.0 and my_backside<=100 and enemy_frontside<=200 and my_act~=214 then
						print("モーション反応　⇒　画面端：空中　飛び越え可能　⇒　６飛翔");
						key_on(front);
					elseif y>120.0 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>120.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>84.9 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>84.9　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　近距離：空中　y<=84.9　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			end
--]]
	--▼130.5型：妖夢のみ
		elseif my_char==5 then
			if dis>600 then
				if y==0 then
					print("モーション反応　⇒　遠距離：地上　⇒　８ｈｊ");
					key_event2(ACT_D,ACT_UP);
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>130.5 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>130.5　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>92.28 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>92.28　⇒　１飛翔");
						key_on(d_back);
					elseif my_act~=214 and my_act~=203 then
						print("モーション反応　⇒　遠距離：空中　y<=92.28　⇒　J４４");
						key_resetEX();
						yield();
						lvr44();
					end
				end
			elseif dis>300 then
				if y==0 and my_act~=200 then
					if ey>=1*(ex-x)*my_dir then
						print("モーション反応　⇒　中距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif dis<=400 and ey<=200 and my_act~=200 and math.random(4)==1 then
						print("モーション反応　⇒　中距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,u_front);
					elseif math.random(4)<=3 then
						print("モーション反応　⇒　中距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					else
						print("モーション反応　⇒　中距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>130.5 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>130.5　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>92.28 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>92.28　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　中距離：空中　y<=92.28　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			else
				if y==0 and my_act~=200 then
					if ey<=200 and math.random(4)==1 then
						print("モーション反応　⇒　近距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,front);
					elseif y>=100 then
						print("モーション反応　⇒　近距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif my_backside>=200 then
						print("モーション反応　⇒　近距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,u_back);
					else
						print("モーション反応　⇒　近距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y-ey>100.0 and my_backside<=100 and enemy_frontside<=200 and my_act~=214 then
						print("モーション反応　⇒　画面端：空中　飛び越え可能　⇒　６飛翔");
						key_on(front);
					elseif y>130.5 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>130.5　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>92.28 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>92.28　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　近距離：空中　y<=92.28　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			end
			
	--▼レミリア型：レミリアのみ
		elseif my_char==6 then
			if dis>600 then
				if y==0 then
					print("モーション反応　⇒　遠距離：地上　⇒　８ｈｊ");
					key_event2(ACT_D,ACT_UP);
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>444.0 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>444.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>335.1 and my_act~=214 then
						print("モーション反応　⇒　遠距離：空中　y>335.1　⇒　１飛翔");
						key_on(d_back);
					elseif my_act~=214 and my_act~=203 then
						print("モーション反応　⇒　遠距離：空中　y<=335.1　⇒　J４４");
						key_resetEX();
						yield();
						lvr44();
					end
				end
			elseif dis>300 then
				if y==0 and my_act~=200 then
					if ey>=1*(ex-x)*my_dir then
						print("モーション反応　⇒　中距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif dis<=400 and ey<=200 and my_act~=200 and math.random(4)==1 then
						print("モーション反応　⇒　中距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,u_front);
					elseif math.random(4)<=3 then
						print("モーション反応　⇒　中距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					else
						print("モーション反応　⇒　中距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y>444.0 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>444.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>335.1 and my_act~=214 then
						print("モーション反応　⇒　中距離：空中　y>335.1　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　中距離：空中　y<=335.1　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			else
				if y==0 and my_act~=200 then
					if ey<=200 and math.random(4)==1 then
						print("モーション反応　⇒　近距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,front);
					elseif y>=100 then
						print("モーション反応　⇒　近距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif my_backside>=200 then
						print("モーション反応　⇒　近距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,u_back);
					else
						print("モーション反応　⇒　近距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y-ey>100.0 and my_backside<=100 and enemy_frontside<=200 and my_act~=214 then
						print("モーション反応　⇒　画面端：空中　飛び越え可能　⇒　６飛翔");
						key_on(front);
					elseif y>444.0 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>444.0　⇒　２飛翔");
						key_on(ACT_DOWN);
					elseif y>335.1 and my_act~=214 then
						print("モーション反応　⇒　近距離：空中　y>335.1　⇒　３飛翔");
						key_on(d_front);
					elseif my_act~=214 and my_act~=202 then
						print("モーション反応　⇒　近距離：空中　y<=335.1　⇒　J６６");
						key_resetEX();
						yield();
						lvr66();
					end
				end
			end
			
	--▼早苗型：早苗のみ
		elseif my_char==15 then
			if dis>600 then
				if y==0 then
					print("モーション反応　⇒　遠距離：地上　⇒　８ｈｊ");
					key_event2(ACT_D,ACT_UP);
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					print("モーション反応　⇒　遠距離：空中　⇒　２飛翔");
					key_on(ACT_DOWN);
				end
			elseif dis>300 then
				if y==0 and my_act~=200 then
					if ey>=1*(ex-x)*my_dir then
						print("モーション反応　⇒　中距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif dis<=400 and ey<=200 and my_act~=200 and math.random(4)==1 then
						print("モーション反応　⇒　中距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,u_front);
					elseif math.random(4)<=3 then
						print("モーション反応　⇒　中距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					else
						print("モーション反応　⇒　中距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					print("モーション反応　⇒　遠距離：空中　⇒　２飛翔");
					key_on(ACT_DOWN);
				end
			else
				if y==0 and my_act~=200 then
					if ey<=200 and math.random(4)==1 then
						print("モーション反応　⇒　近距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,front);
					elseif y>=100 then
						print("モーション反応　⇒　近距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif my_backside>=200 then
						print("モーション反応　⇒　近距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,u_back);
					else
						print("モーション反応　⇒　近距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					if y-ey>100.0 and my_backside<=100 and enemy_frontside<=200 and my_act~=214 then
						print("モーション反応　⇒　画面端：空中　飛び越え可能　⇒　６飛翔");
						key_on(front);
					else
						print("モーション反応　⇒　遠距離：空中　⇒　２飛翔");
						key_on(ACT_DOWN);
					end
				end
			end
			
	--▼諏訪子型：諏訪子のみ
		elseif my_char==19 then
			if dis>600 then
				if y==0 then
					print("モーション反応　⇒　遠距離：地上　⇒　８ｈｊ");
					key_event2(ACT_D,ACT_UP);
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					print("モーション反応　⇒　遠距離：空中　⇒　６飛翔");
					key_on(front);
				end
			elseif dis>300 then
				if y==0 and my_act~=200 then
					if ey>=1*(ex-x)*my_dir then
						print("モーション反応　⇒　中距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif dis<=400 and ey<=200 and my_act~=200 and math.random(4)==1 then
						print("モーション反応　⇒　中距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,u_front);
					elseif math.random(4)<=3 then
						print("モーション反応　⇒　中距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					else
						print("モーション反応　⇒　中距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					key_on(ACT_D);
					print("モーション反応　⇒　遠距離：空中　⇒　６飛翔");
					key_on(front);
				end
			else
				if y==0 and my_act~=200 then
					if ey<=200 and math.random(4)==1 then
						print("モーション反応　⇒　近距離：地上　⇒　９ｈｊ");
						key_event2(ACT_D,front);
					elseif y>=100 then
						print("モーション反応　⇒　近距離：地上　⇒　６D");
						key_on(ACT_D);
						key_on(front);
					elseif my_backside>=200 then
						print("モーション反応　⇒　近距離：地上　⇒　７ｈｊ");
						key_event2(ACT_D,u_back);
					else
						print("モーション反応　⇒　近距離：地上　⇒　８ｈｊ");
						key_event2(ACT_D,ACT_UP);
					end
				elseif y>0 and my_yspeed<=0 then
					key_reset();
					if y-ey>100.0 and my_backside<=100 and enemy_frontside<=200 and my_act~=214 then
						print("モーション反応　⇒　画面端：空中　飛び越え可能　⇒　Ｊ６６");
						lvr66();
						yield();
					else
						print("モーション反応　⇒　遠距離：空中　⇒　２飛翔");
						key_on(ACT_D);
						key_on(ACT_DOWN);
					end
				end
			end
			
		end
	
	end

end
