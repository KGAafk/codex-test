--空中打撃用演算。
function JA_attack_calculation()
	if		my_dir==1 and enemy_hitarea_n>=1 and y>=1 and  y+my_yspeed*15+(15*(14*m_gs))/2>=1 and my_hitstop==0 and enemy_hitstop==0 then --右向き用
		for i=1,enemy_hitarea_n,1 do
			if 			(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	113	-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	188	+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	52	-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	109	-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	72	-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	150	+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	76	-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	131	-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	29	-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	103	+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	101	-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	158	-(enemy_hitarea_bottom[i]-ey) then
				return true;
			end
		end
		return false;
	elseif	my_dir==-1 and enemy_hitarea_n>=1 and y>=1 and  y+my_yspeed*15+(15*(14*m_gs))/2>=1 and my_hitstop==0 and enemy_hitstop==0 then --左向き用
		for i=1,enemy_hitarea_n,1 do
			if 			(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	113	+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	188	+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	52	-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	109	-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	72	+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	150	+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	76	-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	131	-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	29	+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	103	+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	101	-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	158	-(enemy_hitarea_bottom[i]-ey) then
				return true;
			end
		end
		return false;
	else 
		return false;
	end
end

--非仕様。6+7F => 2+11Fの変更。
function J6A_attack_calculation()
	if my_dir==1 and enemy_hitarea_n>=1 and y>=1 and  y+my_yspeed*5+(5*(3*m_gs))/2>=1 and my_hitstop==0 and enemy_hitstop==0 then
		for i=1,enemy_hitarea_n,1 do
			if 			(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)						>=	22-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)						<=	139+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	>=	142-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	<=	193-(enemy_hitarea_bottom[i]-ey)then
				return true;
			elseif 	(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)						>=	97-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)						<=	266+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	>=	167-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	<=	225-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16) )						>=	198-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16) )						<=	337+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	>=	207-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	<=	245-(enemy_hitarea_bottom[i]-ey) then
				return true;
			end
		end
		return false;
	elseif my_dir==-1 and enemy_hitarea_n>=1 and y>=1 and  y+my_yspeed*5+(5*(3*m_gs))/2>=1 and my_hitstop==0 and enemy_hitstop==0 then
		for i=1,enemy_hitarea_n,1 do
			if 			(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)						>=	22+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)						<=	139+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	>=	142-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	<=	193-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16) )						>=	97+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16) )						<=	266+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	>=	167-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	<=	225-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16) )						>=	198+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+((my_xspeedEX*my_dir)*5)+((3*my_dir)*11))	-	(ex+(enemy_xspeedEX*enemy_dir)*16) )						<=	337+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	>=	207-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)			-	(y+my_yspeed*5+(5*(4*e_gs))/2+5*11+(11*(10*(-0.3)))/2)	<=	245-(enemy_hitarea_bottom[i]-ey) then
				return true;
			end
		end
		return false;
	else 
		return false;
	end
end
--
function J2A_attack_calculation()
	if my_dir==1 and enemy_hitarea_n>=1 and y>=1 and  y+my_yspeed*16+(16*(15*m_gs))/2>=1 and my_hitstop==0 and enemy_hitstop==0 then
		for i=1,enemy_hitarea_n,1 do
			if 			(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)	>=	89-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)	<=	172+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		>=	46-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		<=	96-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16) )	>=	138-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16) )	<=	235+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		>=	23-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		<=	81-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16) )	>=	208-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16) )	<=	293+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		>=	-5-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		<=	43-(enemy_hitarea_bottom[i]-ey) then
				return true;
			else
				return false;
			end
		end
	elseif my_dir==-1 and enemy_hitarea_n>=1 and y>=1 and  y+my_yspeed*16+(16*(15*m_gs))/2>=1 and my_hitstop==0 and enemy_hitstop==0 then
		for i=1,enemy_hitarea_n,1 do
			if 			(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16) )	>=	89+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16) )	<=	172+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		>=	46-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		<=	96-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16) )	>=	138+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16) )	<=	235+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		>=	23-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		<=	81-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)	>=	208+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*16)			-	(ex+(enemy_xspeedEX*enemy_dir)*16)	)	<=	293+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		>=	-5-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*16+(16*(15*e_gs))/2)	-	(y+my_yspeed*16+(16*(15*m_gs))/2)		<=	43-(enemy_hitarea_bottom[i]-ey) then
				return true;
			else
				return false;
			end
		end
	else 
		return false;
	end
end

--非仕様。発生12-27F ベクトル変更13F~
function J8A_attack_calculation()
	if my_dir==1 and enemy_hitarea_n>=1 and y>=1 and  y+my_yspeed*15+(15*(14*m_gs))/2>=1 and my_hitstop==0 and enemy_hitstop==0 then
		for i=1,enemy_hitarea_n,1 do
			if 			(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	16-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	109+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	169-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	240-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	36-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	96+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	210-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	266-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	53-(enemy_hitarea_right[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	93+(enemy_hitarea_left[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	253-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	298-(enemy_hitarea_bottom[i]-ey) then
				return true;
			else
				return false;
			end
		end
	elseif my_dir==-1 and enemy_hitarea_n>=1 and y>=1 and  y+my_yspeed*15+(15*(14*m_gs))/2>=1 and my_hitstop==0 and enemy_hitstop==0 then
		for i=1,enemy_hitarea_n,1 do
			if 			(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	16+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	109+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	169-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	240-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	36+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	96+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	210-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	266-(enemy_hitarea_bottom[i]-ey) then
				return true;
			elseif 	(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	>=	53+(enemy_hitarea_left[i]-ex) and
						(my_dir*-1)*(	(x+(my_xspeedEX*my_dir)*15)			-	(ex+(enemy_xspeedEX*enemy_dir)*15)	)	<=	93+(enemy_hitarea_right[i]-ex) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		>=	253-(enemy_hitarea_top[i]-ey) and
										(ey+enemy_yspeed*15+(15*(14*e_gs))/2)	-	(y+my_yspeed*15+(15*(14*m_gs))/2)		<=	298-(enemy_hitarea_bottom[i]-ey) then
				return true;
			else
				return false;
			end
		end
	else 
		return false;
	end
end

--コンボ。対地or対空、ヒットorＣＨ時等に分けて考えられるが、詳細は後回し。
--ヒット判断は、自他のモーションとヒットストップで大雑把に判断。
function Combo()
if (enemy_act>=50 and enemy_act<=89) then

--対地JAが当たった場合。暫定設定。
	if y==0 and dis_y==0 and (my_act==10) and (enemy_act>=50 and enemy_act<=71) then
		key_resetEX();
		if dis>=150 and dis<250 then
			key_event(ACT_A);
		elseif dis<150 then
			key_event2(ACT_A,ACT_DOWN);
		elseif dis>=250 then
			key_event2(ACT_C,front);
		end
	end
		
--JA始動。
	if my_act==306 and ((enemy_act>=50 and enemy_act<=89) or (enemy_act>=143 and enemy_act<=165)) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--J8A：
		if J8A_attack_calculation()==true then
			key_event2(ACT_A,ACT_UP);
			key_resetEX();
	--J6A：
		elseif J6A_attack_calculation()==true then
			key_event2(ACT_A,front);
			key_resetEX();
	--J2A：
		elseif J2A_attack_calculation()==true then
			key_event2(ACT_A,ACT_DOWN);
			key_resetEX();
	--J6C：
		else
			if (ey-y)>=-80 and (ey-y)<=170 and my_rei>400 and y+my_yspeed/4*15>0 then
				key_event2(ACT_C,front);
				key_resetEX();
			end
		end
	end

--J6A始動。
	if my_act==307 and (enemy_act>=50 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--J5C
			key_event2(ACT_C,front);
			key_resetEX();
	end

--J2A始動。
	

--J8A始動
	if my_act==309 and (enemy_act>=50 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--J5C
			key_on(ACT_B);
			wait(18);
			key_resetEX();
			
	end

--SA始動。
	if my_act==300 and (enemy_act>=50 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--AA
		if ey==0 then
			key_resetEX();
			key_event(ACT_A);
		end
	--6C
		if ey>0 and my_rei>=400 then
			key_resetEX();
			key_event2(ACT_C,front);
		end
	end
--[[AA始動。mortion_ID:321である点に注意。緋仕様。
	if my_act==321 and (enemy_act>=88 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--AAA
		if my_rei<200 then
			key_resetEX();
			key_event(ACT_A);
	--5C
		elseif my_rei>200 then
			key_resetEX();
			key_event(ACT_C);
	--6C
		elseif my_rei>200 then
			key_resetEX();
			key_event2(ACT_C,front);
		end
	end--]]
	
--AA始動。mortion_ID:321。非仕様。打ち上げ。
	if my_act==321 and (enemy_act==71 or enemy_act<=74) and (my_hitstop>=2 and my_hitstop<=4) and is_dir_front then
	--AAA
		if my_rei<200 then
			key_resetEX();
			key_event(ACT_A);
	--5C
		elseif my_rei>200 and dis<105 and ((my_dir==1 and x<950) or (my_dir==-1 and x>330)) then
			key_resetEX();
			key_event(ACT_C);
	--6C
		elseif my_rei>200 and dis>=105 then
			key_resetEX();
			key_event2(ACT_C,front);
		end
	end--]]
	
--AAA始動。mortion_ID:322。非仕様。打ち下ろし。
	if my_act==322 and (enemy_act==88 or enemy_act==89) and (my_hitstop>=2 and my_hitstop<=4) and is_dir_front then
	--AAAA
		if my_rei<200 then
			key_resetEX();
			key_event(ACT_A);
	--5C
		elseif my_rei>200 and ((my_dir==1 and x<950) or (my_dir==-1 and x>330)) then
			key_resetEX();
			key_event(ACT_C);
	--6C
		elseif my_rei>200 then
			key_resetEX();
			key_event2(ACT_C,front);
		end
	end--]]
	
--[[AAAA始動。mortion_ID:323。非仕様。スペカのみでキャンセル可能。
	if my_act==323 and (enemy_act>=88 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--AAA
		if my_rei<200 then
			key_resetEX();
			key_event(ACT_A);
	--5C
		--elseif my_rei>200 then
		--	key_resetEX();
		--	key_event(ACT_C);
	--6C
		elseif my_rei>200 then
			key_resetEX();
			key_event2(ACT_C,front);
		end
	end--]]

--LA始動。
	if my_act==301 and (enemy_act>=50 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--3A
		if dis<200 and ey==0 then
			key_resetEX();
			key_event2(ACT_A,d_front);
	--6C
		elseif (dis>200 or ey>0) then
			key_resetEX();
			key_event2(ACT_C,front);
		end
	end
	
--6A始動。
	if my_act==301 and (enemy_act>=50 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--6C
			key_resetEX();
			key_event2(ACT_C,front);
	end
	
--3A始動。
	if my_act==304 and (enemy_act>=50 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	print("LINE ==",358)
	--2B
	--6C
		print("3A>6C")
		key_resetEX();
		key_event2(ACT_C,front);
		wait(27)
		key_event(u_front)
		wait(5)
		key_event2(ACT_C,front)
	end

--2A
	if my_act==303 and (enemy_act>=50 and enemy_act<=89) and (my_hitstop>=3 and my_hitstop<=4) and is_dir_front then
	--6A
	--3A
		if dis<200 then
			key_resetEX();
			key_event2(ACT_A,d_front);
	--6C
		elseif dis>=200 and my_rei>=200 then
			key_resetEX();
			key_event2(ACT_C,front);
		end
	end

--5B
--5B+
--2B
--2B+
--5C
	if my_act==410 and (enemy_act>=50 and enemy_act<=89) and get_fflags(0,2097152)==true and is_dir_front then
	--44
	--8HJ
	--9HJ
		if ((my_dir==1 and x<1040) or (my_dir==-1 and x>240)) then
			key_event(u_front);
	--7HJ
		elseif ((my_dir==1 and x>=1040) or (my_dir==-1 and x<=240)) then
			key_event(u_back);
		end
	end
--6C
--6C+
--DA
--DB
--DC

--Ｊ２Ｃ -> 超ドリル（暫定）
--追加で、地面バウンド時の追撃（暫定）
	if enemy_act>=88 and enemy_act<=89 and my_act~=321 then


	--J2A（CH） -> Bドリル（２ヒット） -> （補正切り）エレキ
		if y==0 and enemy_act==89 and enemy_yspeed<4 and enemy_yspeed~=0 and my_correction>=32 and (my_act<=10 or (my_act>=180 and my_act<300)) and ((x>=330 and x<480 and my_dir==-1) or (x>800 and x<=950 and my_dir==1)) and card_check(202)==true and my_spell_more(1500) then
			key_resetEX();yield();
			key_on(ACT_D);yield();key_off(ACT_D);
			lvr236(ACT_B);
			wait(54);
			card_use(202);
	--壁際CH時(遠距離)：Bドリル -> LA -> Bドリル
		elseif y==0 and enemy_act==89 and enemy_yspeed<4 and enemy_yspeed~=0 and my_correction>=32 and (my_act<=10 or (my_act>=180 and my_act<300)) and ((x>=360 and x<480 and my_dir==-1) or (x>800 and x<=920 and my_dir==1)) then
			key_resetEX();yield();
			key_on(ACT_D);yield();key_off(ACT_D);
			lvr236(ACT_B);
			wait(68);
			if my_act<=5 then
				key_event(ACT_A);
				wait(19);
				if my_act==301 and my_hitstop>=0 and my_hitstop<=9 then
					lvr236(ACT_B);
				end
			end
	--壁際CH時(中距離)：Bドリル -> SA>AA>水羽衣
		elseif y==0 and enemy_act==89 and enemy_yspeed<4 and enemy_yspeed~=0 and my_correction>=32 and (my_act<=10 or (my_act>=180 and my_act<300)) and ((x<360 and x>=270 and my_dir==-1) or (x>920 and x<=1010 and my_dir==1)) then
			key_resetEX();yield();
			key_on(ACT_D);yield();key_off(ACT_D);
			lvr236(ACT_B);
			wait(76);
			if y==0 and my_act<=5 and dis_y<=140 and dis_y>=50 then
				key_event(ACT_A);
				wait(14);
				if my_act==300 and my_hitstop>=0 and my_hitstop<=9 and my_allframe>=8 and my_allframe<=10 then
					key_event(ACT_A);
					wait(32);
					if my_act==321 and my_hitstop>=0 and my_hitstop<=9 and my_allframe>=24 and my_allframe<=28 then
						lvr623(ACT_B);
					end
				end
			end
	--壁際CH時(近距離)：SA>AA>Bドリル
		elseif y==0 and enemy_act==89 and enemy_yspeed<0 and dis<=120 and dis_y<=100 and dis_y>50 and my_correction>=32 and (my_act<=10 or (my_act>=180 and my_act<300)) and ((x<270 and my_dir==-1) or (x>1010 and my_dir==1)) then
			key_resetEX();yield();
			key_event(ACT_A);
			wait(14);
			if my_act==300 and my_hitstop>=0 and my_hitstop<=9 and my_allframe>=8 and my_allframe<=10 then
				key_event(ACT_A);
				wait(32);
				if my_act==321 and my_hitstop>=0 and my_hitstop<=9 and my_allframe>=24 and my_allframe<=28 then
					lvr236(ACT_B);
				end
			end
			
	--近距離：J2A -> Dh -> DC -> Bドリル--(and dis<=340) 
		elseif y==0 and dis<=340 and (card_check(201)==false or (card_check(201)==true and my_spell_more(1500)==false) or my_spell_more(1500)==false) and (enemy_act==88 or enemy_act==89) and my_combo<=1 and my_limit<100 and my_correction<=31 then
			key_resetEX();
			key_on(ACT_D)
			key_on(front);
			if y==0 and (ey+enemy_yspeed*29+(29*(28*e_gs))/2)>0 and (ey+enemy_yspeed*29+(29*(28*e_gs))/2)<=30 and enemy_act==89 and my_combo<=1 and my_limit<100 then
				key_resetEX();
				key_on(front);
				key_event2(ACT_D,ACT_C);
				key_resetEX();
				wait(50);
				if dis<=360 and my_combo==2 and my_limit<100 then
					wait(10);key_resetEX();
					key_on(ACT_D);yield();key_off(ACT_D);
					lvr236(ACT_B);
				end
			end
	--中距離：J2A -> J6C -> ９飛翔 -> J6A -> DB
		elseif y>0 and y<=250 and dis>230 and dis<=350 and y+my_yspeed/4*20>0 and my_act==308 and (enemy_act==88 or enemy_act==89) and my_hitstop>=1 and my_hitstop<=2 and (card_check(201)==false or (card_check(201)==true and my_spell_more(1500)==false) or my_spell_more(1500)==false) and ((my_correction<=31) or (my_correction>=32 and ((x>=480 and my_dir==-1) or (x<=800 and my_dir==1)))) then
			key_resetEX();
			key_event2(ACT_C,front);
			wait(20);
			if y<130 then
				key_on(ACT_D);key_on(u_front);wait(6);key_off(ACT_D);key_off(u_front);
			elseif y>=130 and y<330 then
				key_on(ACT_D);key_on(front);wait(6);key_off(ACT_D);key_off(front);
			end
			wait(16);
			if JA_attack_calculation()==true then
				key_resetEX();
				key_event(ACT_A);
				wait(14);
				key_event2(ACT_A,front);
			elseif dis-(my_xspeed+enemy_xspeed)*15<=340 then
				wait(2);
				key_event2(ACT_A,ACT_DOWN);
				wait(30);
				if my_combo>=2 and my_combo<=5 and my_limit<100 and my_correction>=2 and enemy_act==89 then
					key_resetEX();
					key_on(front);
					key_event2(ACT_D,ACT_B);
					key_resetEX();
				end
			end
	--遠距離：J2A -> 6C -> J6C
		elseif y==0 and dis>340 and (card_check(201)==false or (card_check(201)==true and my_spell_more(1500)==false) or my_spell_more(1500)==false) and (enemy_act==88 or enemy_act==89) and my_limit<100 and (ey+enemy_yspeed*29+(29*(28*e_gs))/2)>0 and ((my_correction<=31) or (my_correction>=32 and ((x>=480 and my_dir==-1) or (x<=800 and my_dir==1)))) then
			key_resetEX();
			key_event2(ACT_C,front);
			wait(24);
			key_event(u_front);
			wait(2);
			key_event2(ACT_C,front);

		elseif is_dir_front and card_check(201)==true and my_spell_more(1500) and (my_act<=10 or (my_act>=180 and my_act<300)) and ((x>480 and my_dir==1) or (x<800 and my_dir==-1)) and y==0 and ey<120 and ey>=60 and enemy_yspeed<0 and enemy_act==89 and my_combo<=2 and my_combo>=1 then
			key_resetEX();
			card_use(201);
		elseif is_dir_front and card_check(201)==true and my_spell_more(1500) and (my_act<=10 or (my_act>=180 and my_act<300)) and ((x>480 and my_dir==1) or (x<800 and my_dir==-1)) and y==0 and ey>=120 and enemy_yspeed>=0 and enemy_act==89 and my_combo<=2 and my_combo>=1 then
			key_resetEX();
		elseif is_dir_front and card_check(201)==true and my_spell_more(1500) and (my_act<=10 or (my_act>=180 and my_act<300)) and ((x<=480 and my_dir==1) or (x>=800 and my_dir==-1)) and y==0 and enemy_act==89 and my_combo<=2 and my_combo>=1 then
			key_resetEX();
			key_on(ACT_D);
			key_on(front);
		elseif is_dir_front and card_check(201)==true and my_spell_more(1500) and y>0 and (enemy_act==88 or enemy_act==89) then
			card_1st(201);
			
		else --以上の条件に当てはまらない場合、歩きによる接近あるいは離脱。
			key_resetEX();
			if y==0 and ((x<270 and my_dir==-1) or (x>1010 and my_dir==1)) and my_act<=10 and enemy_act==89 and enemy_yspeed>0 and ey>30 then
				key_on(front);
			elseif y==0 and ((x>=440 and my_dir==-1) or (x<=800 and my_dir==1)) and my_act<=10 and enemy_act==89 and enemy_yspeed>0 and ey>30 then
				key_event2(ACT_D,front);
			elseif y==0 and not((x<270 and my_dir==-1) or (x>1010 and my_dir==1)) and not((x>=440 and my_dir==-1) or (x<=800 and my_dir==1)) and my_act<=10 and enemy_act==89 and enemy_yspeed>0 and ey>30 then
				key_on(back);
			end
			
	--追撃不可：Dｈで接近
		end
	end

end
end


function Combo2()
--SA始動
--SA>AAルート
	--SA>AA>6C>JA>J2A>J6C>J66>J2A　中央限定。560<=x<=720くらい（妖夢）
			--風雨限定。SA>AA>6C>JA>J2A>J6C>J44 受身可能。J6Aの攻撃圏内。
	if my_act==300 and enemy_act>=50 and enemy_act<=89 and my_hitstop>=1 and my_hitstop<=3 and is_dir_front then
		--if 			ey==0 	and my_correction<=31 then --相手地上、ノーマルヒット
			if enemy_act>=50 and enemy_act<=53 and dis<=90 then --AA
				key_resetEX();
				key_event(ACT_A);
				wait(21);
				if my_act==321 and enemy_act>=69 and enemy_act<=79 and my_hitstop>=1 and my_hitstop<=3 and is_dir_front then
					key_resetEX();
					key_event2(ACT_C,front);
					wait(25);
					if my_act==411 and enemy_act>=69 and enemy_act<=79 and is_dir_front then
						key_resetEX();
						key_event(u_front);
						wait(3);
						if y>0 and my_act>=208 and my_act<=210 and is_dir_front then
							key_resetEX();
							key_event(ACT_A);
							wait(17);--17
							
							if weather~=10 and my_act==306 and enemy_act>=69 and enemy_act<=79 and my_hitstop>=1 and my_hitstop<=3 and is_dir_front then
								key_resetEX();
								key_event2(ACT_A,ACT_DOWN);
								wait(25);
								if my_act==308 and is_dir_front then
									key_resetEX();
									key_event2(ACT_C,front);
									wait(22);
									if my_act==415 then
										key_resetEX();
										lvr66();
										wait(9);
										if my_act==202 then
											key_resetEX();
											key_event2(ACT_A,ACT_DOWN);
										end
									end
								end
									
							elseif weather==10 and ((x>=230 and my_dir==-1) or (x<=1050 and my_dir==1)) and my_act==306 and enemy_act>=69 and enemy_act<=79 and my_hitstop>=1 and my_hitstop<=4 and is_dir_front then
								key_resetEX();
								key_event2(ACT_A,ACT_DOWN);
								wait(45);
								if my_act==308 and y>=50 and is_dir_front then
									key_resetEX();
									key_event2(ACT_C,front);
									wait(22);
									if my_act==415 then
										key_resetEX();
										lvr44();
									end
								end
								
							end
						end
					end
				end
			end--]]
		--elseif 	ey==0 	and my_correction>=32 then
		--elseif 	ey>0 	and my_correction<=31 then
		--elseif 	ey>0 	and my_correction>=32 then
		--end
--SA>3A
	end
	
--2A始動
--2A>6Aルート（ドリコンルート）
--2A>3Aルート（安定ルート）
	--2A>3A>6C>JA>J2A
	if ((dis<=180 and my_correction<=31)or(dis<=120 and my_correction>=32)) and ey==0 and ((x>=380 and my_dir==-1) or (x<=900 and my_dir==1)) and my_act==303 and enemy_act>=50 and enemy_act<=89 and my_hitstop>=1 and my_hitstop<=3 and is_dir_front then 
		key_resetEX();
		key_event2(ACT_A,d_front);
		wait(18);
		if my_act==304 and enemy_act>=50 and enemy_act<=89 and my_hitstop>=1 then
			key_resetEX();
			key_event2(ACT_C,front);
			wait(33);
				key_resetEX();
				key_event(u_front);
				wait(3);
					key_resetEX();
					key_event(ACT_A);
					wait(17);
					if my_act==306 and enemy_act>=50 and enemy_act<=89 and my_hitstop>=1 then
						key_resetEX();
						key_event2(ACT_A,ACT_DOWN);
					end
		end
						
	--2A>3A>6C>水羽衣or天女or風羽衣？　画面端の運用なので風羽衣も当たるかもしれない。
	elseif ((dis<=195 and my_correction<=31)or(dis<=150 and my_correction>=32)) and ey==0 and my_act==303 and enemy_act>=50 and enemy_act<=89 and my_hitstop>=1 and my_hitstop<=3 and is_dir_front then 
		key_resetEX();
		key_event2(ACT_A,d_front);
		wait(26);
		if my_act==304 and enemy_act>=50 and enemy_act<=89 and my_hitstop>=1 then
			key_resetEX();
			key_event2(ACT_C,front);
			wait(20);
				key_resetEX();
				lvr623(ACT_B);
		end
				
--ヒットするもコンボ不可。なので打撃ドリルを被せる。なお打撃無敵技対策のため、射撃を撃っておく。
	elseif dis>195 and my_correction<=31 and ey==0 and my_act==303 and enemy_act>=50 and enemy_act<=89 and my_hitstop>=1 and my_hitstop<=3 and is_dir_front then 
		key_resetEX();
		key_event2(ACT_C,front);
		wait(10);
			key_resetEX();
			yield();
			lvr236(ACT_B);
		
--CH限定。2A>6C>6C>J2A>DB
	elseif (dis>150 and my_correction>=32) and ey==0 and my_act==303 and enemy_act>=50 and enemy_act<=89 and my_hitstop>=1 and my_hitstop<=3 and is_dir_front then 
		key_resetEX();
		key_event2(ACT_C,front);
		wait(26);
			key_resetEX();
			key_event(ACT_UP);
			wait(2);
			if enemy_act>=50 and enemy_act<=89 then
				key_resetEX();
				key_event2(ACT_C,front);
				wait(23);
					key_resetEX();
					lvr66();
					wait(9+5);
					if enemy_act>=50 and enemy_act<=89 then
						key_resetEX();
						key_event2(ACT_A,ACT_DOWN)
						wait(44);
						if y==0 and enemy_act>=50 and enemy_act<=89 then
							key_resetEX();
							key_on(ACT_D);
							key_event2(ACT_B,front);
							key_resetEX();
						end
					end
			end
	end
end


--固め。
function rock()
	if (enemy_act>=143 and enemy_act<=166) or (((enemy_act<=10 or (enemy_act>=200 and enemy_act<=226) ) and enemy_allframe<=15) and ((enemy_preact[1]>=143 and enemy_preact[1]<=165) or (enemy_preact[2]>=143 and enemy_preact[2]<=165) or (enemy_preact[3]>=143 and enemy_preact[3]<=165) )) then
--以下の行動をガードした場合の派生。とりあえず正誤割関係なし。

--着地直前JAおよびJ2A。その硬直からの固め始動。ガードさせれば、その後LAルートに切り替わる。
		if y==0 and dis_y==0 and (my_act==306 or my_act==308 or my_act==10) and (enemy_act>=143 and enemy_act<=165) then
			key_resetEX();
			if dis>54 and dis<250 then --とりあえず霊夢実測射程から-60程度を目安。
				key_event(ACT_A);
			elseif dis>54 and dis<150 then
				key_event2(ACT_A,ACT_DOWN);
			elseif dis<=44 and (ex<=45 or ex>=1235) and weather~=12 then
				key_event2(ACT_A,front);
				wait(15);
				key_resetEX();
				key_event(ACT_B);
			elseif dis<=54 and (ex<=55 or ex>=1225) and weather~=12 then
				key_event2(ACT_A,d_front);
				wait(15);
				key_resetEX();
				key_event(ACT_B);
			end

--SA
		elseif y==0 and ( ( (my_act==300 and my_allframe>=8) and (enemy_act>=143 and enemy_act<=165) ) or ( (my_act==300 and my_allframe==25) and ( (enemy_act<=8 or (enemy_act>=200 and enemy_act<=226) ) and enemy_allframe<=10) ) ) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=8 and my_allframe<=9 and my_hitstop>=1 and my_hitstop<=2 then
	--6A
				if math.random(12)==1 and (dis<180 or (weather==12 and dis<150)) then
					key_resetEX();
					if math.random(15)==1 then
						key_on(front);
						key_on(ACT_A);
						wait(16);
						key_resetEX();
					else
						key_event2(ACT_A,front);
					end
	--3A。連ガではないので注意。
				elseif math.random(12)==1 and (dis<200 or (weather==12 and dis<170)) then
					key_resetEX();
					if math.random(15)==1 then
						key_on(d_front);
						key_on(ACT_A);
						wait(17);
						key_resetEX();
					else
						key_event2(ACT_A,d_front);
					end
	--B
				elseif math.random(12)==1 then
					key_resetEX();
					if math.random(12)==1 then
						key_on(ACT_B);
						wait(19);
						key_resetEX();
					else
						key_event(ACT_B);
					end
	--2B
				elseif math.random(13)==1 then
					key_resetEX();
					if math.random(6)==1 then
						key_on(ACT_DOWN);
						key_on(ACT_B);
						wait(17);
						key_resetEX();
					else
						key_event2(ACT_B,ACT_DOWN);
					end
	--6C
				elseif math.random(24)==1 then
					key_resetEX();
					if math.random(12)==1 then
						key_on(front);
						key_on(ACT_C);
						wait(15);
						key_resetEX();
					else
						key_event2(ACT_C,front);
					end
				end
	--目押し。硬直の最終Ｆに行動を入力。
			else
	--ディレイ６Ａ。
				if dis<=250 and my_allframe==13 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,front);
	--目押し２Ａ
				elseif dis<=210 and my_allframe==25 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に、近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and my_allframe==25 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--LA
		elseif y==0 and ( ( (my_act==301 and my_allframe>=16) and (enemy_act>=143 and enemy_act<=165) ) or ( (my_act==301 and my_allframe==43) and ( (enemy_act<=8 or (enemy_act>=200 and enemy_act<=226) ) and enemy_allframe<=10) ) ) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=16 and my_allframe<=18 and my_hitstop>=1 and my_hitstop<=2 then
	--6A
				if math.random(12)==1 and (dis<180 or (weather==12 and dis<150)) then
					key_resetEX();
					if math.random(16)==1 then
						key_on(front);
						key_on(ACT_A);
						wait(16);
						key_resetEX();
					else
						key_event2(ACT_A,front);
					end
	--3A。連ガではないので注意。
				elseif math.random(12)==1 and (dis<200 or (weather==12 and dis<170)) then
					key_resetEX();
					if math.random(16)==1 then
						key_on(d_front);
						key_on(ACT_A);
						wait(17);
						key_resetEX();
					else
						key_event2(ACT_A,d_front);
					end
	--B
				elseif math.random(12)==1 then
					key_resetEX();
					if math.random(12)==1 then
						key_on(ACT_B);
						wait(19);
						key_resetEX();
					else
						key_event(ACT_B);
					end
	--2B
				elseif math.random(13)==1 then
					key_resetEX();
					if math.random(12)==1 then
						key_on(ACT_DOWN);
						key_on(ACT_B);
						wait(17);
						key_resetEX();
					else
						key_event2(ACT_B,ACT_DOWN);
					end
	--C
				elseif math.random(24)==1 and ((my_dir==1 and x<940) or (my_dir==-1 and x>340)) then
					key_resetEX();
					key_event(ACT_C);
	--6C
				elseif math.random(24)==1 then
					key_resetEX();
					if math.random(16)==1 then
						key_on(front);
						key_on(ACT_C);
						wait(15);
						key_resetEX();
					else
						key_event2(ACT_C,front);
					end
	--龍魚の一撃。
				elseif dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--目押し。硬直の最終Ｆに行動を入力。
			else
	--delay龍魚の一撃。
				if dis>80 and my_allframe==23 and math.random(4)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--delay６Ａ。
				elseif dis<=250 and my_allframe==31 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,front);
	--目押し２Ａ
				elseif dis<=210 and my_allframe==43 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に全くなにもせずに終わることはない。近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and my_allframe==43 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--6A
		elseif y==0 and ( ( (my_act==302 and my_allframe>=16) and (enemy_act>=143 and enemy_act<=165) ) or ( (my_act==302 and my_allframe==45) and ( (enemy_act<=8 or (enemy_act>=200 and enemy_act<=226) ) and enemy_allframe<=10) ) ) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=16 and my_allframe<=20 and my_hitstop>=2 and my_hitstop<=3 then
	--B(連続ガード確定時)
				if dis<=44 and (ex<=45 or ex>=1235) and weather~=12 then
					key_resetEX();
					key_event(ACT_B);
	--2B(連続ガード確定時)
				elseif dis<=54 and (ex<=55 or ex>=1225) and weather~=12 then
					key_resetEX();
					key_event2(ACT_B,ACT_DOWN);
	--B
				elseif math.random(12)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(ACT_B);
						wait(19);
						key_resetEX();
					else
						key_event(ACT_B);
					end
	--2B
				elseif math.random(13)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(ACT_DOWN);
						key_on(ACT_B);
						wait(17);
						key_resetEX();
					else
						key_event2(ACT_B,ACT_DOWN);
					end
	--C
				elseif math.random(24)==1 and ((my_dir==1 and x<940) or (my_dir==-1 and x>340)) then
					key_resetEX();
					key_event(ACT_C);
	--6C
				elseif math.random(14)==1 then
					key_resetEX();
					if math.random(16)==1 then
						key_on(front);
						key_on(ACT_C);
						wait(15);
						key_resetEX();
					else
						key_event2(ACT_C,front);
					end
	--龍魚の一撃。近いためミスりやすい。
				elseif dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--目押し。硬直の最終Ｆに行動を入力。しかし、どういうわけか２Ｆ遅れる（手動なら最速で振れる）。
			else
	--目押し２Ａ
				if dis<=210 and dis>119 and my_allframe==45 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に全くなにもせずに終わることはない。近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and dis>210 and my_allframe==45 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--2A
		elseif y==0 and (((my_act==303 and my_allframe>=12) and (enemy_act>=143 and enemy_act<=165)) or ((my_act==303 and my_allframe==29) and ( (enemy_act<=8 or (enemy_act>=200 and enemy_act<=226) ) and enemy_allframe<=10) ) ) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=12 and my_allframe<=19 and my_hitstop>=1 and my_hitstop<=2 then
	--6A
				if math.random(12)==1 and (dis<180 or (weather==12 and dis<150)) then
					key_resetEX();
					if math.random(16)==1 then
						key_on(front);
						key_on(ACT_A);
						wait(16);
						key_resetEX();
					else
						key_event2(ACT_A,front);
					end
	--3A。連ガではないので注意。
				elseif math.random(12)==1 and (dis<200 or (weather==12 and dis<170)) then
					key_resetEX();
					if math.random(15)==1 then
						key_on(d_front);
						key_on(ACT_A);
						wait(17);
						key_resetEX();
					else
						key_event2(ACT_A,d_front);
					end
	--B
				elseif math.random(12)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(ACT_B);
						wait(19);
						key_resetEX();
					else
						key_event(ACT_B);
					end
	--2B
				elseif math.random(13)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(ACT_DOWN);
						key_on(ACT_B);
						wait(17);
						key_resetEX();
					else
						key_event2(ACT_B,ACT_DOWN);
					end
	--C
				elseif math.random(24)==1 and ((my_dir==1 and x<940) or (my_dir==-1 and x>340)) then
					key_resetEX();
					key_event(ACT_C);
	--6C
				elseif math.random(24)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(front);
						key_on(ACT_C);
						wait(15);
						key_resetEX();
					else
						key_event2(ACT_C,front);
					end
	--龍魚の一撃。近いためミスりやすく、潜り込みやすい。
				elseif dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--目押し。硬直の最終Ｆに行動を入力。しかし、どういうわけか２Ｆ遅れる（手動なら最速で振れる）。
			else
	--ディレイ６Ａ。６Ｆ空くようにキャンセルする。無敵技等には無力。
				if dis<=250 and my_allframe==17 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,front);
	--目押し２Ａ
				elseif dis<=210 and my_allframe==29 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に全くなにもせずに終わることはない。近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and my_allframe==29 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--3A
		elseif y==0 and ( ( (my_act==304 and my_allframe>=17) and (enemy_act>=143 and enemy_act<=165) ) or ( (my_act==304 and my_allframe==48) and ( (enemy_act<=8 or (enemy_act>=200 and enemy_act<=226) ) and enemy_allframe<=10) ) ) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=17 and my_allframe<=22 and my_hitstop>=1 and my_hitstop<=2 then
	--B(連続ガード確定時)
				if dis<=44 and (ex<=45 or ex>=1235) then
					key_resetEX();
					key_event(ACT_B);
	--2B(連続ガード確定時)
				elseif dis<=54 and (ex<=55 or ex>=1225) then
					key_resetEX();
					key_event2(ACT_B,ACT_DOWN);
	--B
				elseif math.random(13)==1 then
					key_resetEX();
					if math.random(16)==1 then
						key_on(ACT_B);
						wait(19);
						key_resetEX();
					else
						key_event(ACT_B);
					end
	--2B
				elseif math.random(12)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(ACT_DOWN);
						key_on(ACT_B);
						wait(17);
						key_resetEX();
					else
						key_event2(ACT_B,ACT_DOWN);
					end
	--C
				elseif math.random(24)==1 and ((my_dir==1 and x<940) or (my_dir==-1 and x>340)) then
					key_resetEX();
					key_event(ACT_C);
	--6C
				elseif math.random(14)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(front);
						key_on(ACT_C);
						wait(15);
						key_resetEX();
					else
						key_event2(ACT_C,front);
					end
	--龍魚の一撃。近いためミスりやすい。
				elseif dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--目押し。硬直の最終Ｆに行動を入力。しかし、どういうわけか２Ｆ遅れる（手動なら最速で振れる）。
			else
	--目押し２Ａ
				if dis<=210 and dis>119 and my_allframe==48 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に全くなにもせずに終わることはない。近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and dis>210 and my_allframe==48 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--DA
--JA
--J6A
--J2A
--J8A
--AA(321)
--AAA(322)

--B
		elseif y==0 and (((my_act==400 and my_allframe>=19) and (enemy_act>=143 and enemy_act<=165)) or ((my_act==400 and my_allframe==51) and ((enemy_act<=8 or (enemy_act>=200 and enemy_act<=226)) and enemy_allframe<=10))) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=19 and my_allframe<=20 then
	--C
				if math.random(24)==1 and ((my_dir==1 and x<940) or (my_dir==-1 and x>340)) then
					key_resetEX();
					key_event(ACT_C);
	--6C
				elseif math.random(24)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(front);
						key_on(ACT_C);
						wait(15);
						key_resetEX();
					else
						key_event2(ACT_C,front);
					end
	--龍魚の一撃。近いためミスりやすく、潜り込みやすい。
				elseif dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--目押し。硬直の最終Ｆに行動を入力。しかし、どういうわけか２Ｆ遅れる（手動なら最速で振れる）。
			else
	--目押し６Ａ。無敵技等には無力。
				if dis<=250 and my_allframe==51 and math.random(8)==1 then
					key_resetEX();
					key_event2(ACT_A,front);
	--目押し２Ａ
				elseif dis<=210 and my_allframe==51 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に全くなにもせずに終わることはない。近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and my_allframe==51 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--6B

--2B
		elseif y==0 and (((my_act==402 and my_allframe>=18) and (enemy_act>=143 and enemy_act<=165)) or ((my_act==402 and my_allframe==48) and ((enemy_act<=8 or (enemy_act>=200 and enemy_act<=226)) and enemy_allframe<=10))) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=18 and my_allframe<=19 then
	--C
				if math.random(24)==1 and ((my_dir==1 and x<940) or (my_dir==-1 and x>340)) then
					key_resetEX();
					key_event(ACT_C);
	--6C
				elseif math.random(24)==1 then
					key_resetEX();
					if math.random(15)==1 then
						key_on(front);
						key_on(ACT_C);
						wait(15);
						key_resetEX();
					else
						key_event2(ACT_C,front);
					end
	--龍魚の一撃。近いためミスりやすく、潜り込みやすい。
				elseif dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--目押し。硬直の最終Ｆに行動を入力。しかし、どういうわけか２Ｆ遅れる（手動なら最速で振れる）。
			else
	--目押し６Ａ。無敵技等には無力。
				if dis<=250 and my_allframe==48 and math.random(8)==1 then
					key_resetEX();
					key_event2(ACT_A,front);
	--目押し２Ａ
				elseif dis<=210 and my_allframe==48 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に全くなにもせずに終わることはない。近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and my_allframe==48 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--JB
--DB

--C
		elseif y==0 and (((my_act==410 and my_allframe>=25) and (enemy_act>=143 and enemy_act<=165)) or ((my_act==410 and my_allframe==66) and ((enemy_act<=8 or (enemy_act>=200 and enemy_act<=226)) and enemy_allframe<=10))) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=25 and my_allframe<=26 then
	--龍魚の一撃。近いためミスりやすく、潜り込みやすい。
				if dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--HJC。
			elseif my_allframe>=36 and my_allframe<=37 and math.random(4)==1 then
				key_resetEX();
				key_event(ACT_UP);
				wait(10);
				if y>=100 then
					key_resetEX();
					key_event2(ACT_D,front);
				end
	--ディレイキャンセル。
	--龍魚の一撃。
			elseif my_allframe>=44 and my_allframe<=45 then	--龍魚の一撃。近いためミスりやすく、潜り込みやすい。
				if dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--目押し。硬直の最終Ｆに行動を入力。但し、最速ではない。
			else
	--目押し６Ａ。
				if dis<=250 and my_allframe==66 and math.random(8)==1 then
					key_resetEX();
					key_event2(ACT_A,front);
	--目押し２Ａ
				elseif dis<=210 and my_allframe==66 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に全くなにもせずに終わることはない。近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and my_allframe==66 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--6C
		elseif y==0 and (((my_act==411 and my_allframe>=15) and (enemy_act>=143 and enemy_act<=165)) or ((my_act==411 and my_allframe==56) and ((enemy_act<=8 or (enemy_act>=200 and enemy_act<=226)) and enemy_allframe<=10))) then
	--キャンセル。のべ２Ｆのみキャンセルタイミングを設定。いずれも最速（ヒットストップ中）。
			if my_allframe>=15 and my_allframe<=16 then
			
	--龍魚の一撃。近いためミスりやすく、潜り込みやすい。
				if dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--ディレイキャンセル。
	--龍魚の一撃。
			elseif my_allframe>=24 and my_allframe<=25 then	--龍魚の一撃。近いためミスりやすく、潜り込みやすい。
				if dis>80 and math.random(24)==1 and get_skill_lv(0,0)>=0 then
					key_resetEX();key_on(ACT_D);yield();key_off(ACT_D);yield();
					lvr236(ACT_B);
	--羽衣は水の如く。近接ならばしゃがみでも当たる。
				elseif dis<180 and math.random(24)==1 and get_skill_lv(0,1)>=0 then
					key_resetEX();
					lvr623(ACT_B);
				end
	--目押し。硬直の最終Ｆに行動を入力。但し、最速ではない。
			else
	--目押し６Ａ。無敵技等には無力。
				if dis<=250 and my_allframe==56 and math.random(8)==1 then
					key_resetEX();
					key_event2(ACT_A,front);
	--目押し２Ａ
				elseif dis<=210 and my_allframe==56 and math.random(2)==1 then
					key_resetEX();
					key_event2(ACT_A,ACT_DOWN);
	--目押しＡ。最終的に全くなにもせずに終わることはない。近ければＳＡ。遠ければＬＡになる。
				elseif dis<=300 and my_allframe==56 then
					key_resetEX();
					key_event(ACT_A);
				end
			end

--2C
--JC
--J6C
--J2C
--J1C
--DC
--龍魚の一撃
--羽衣は水の如く
--龍魚の怒り
--静電誘導弾
--龍神の一撃
--羽衣は風の如く
--龍神の怒り
--龍神の稲光り
--龍の眼
--電符「雷鼓弾」
--魚符「龍魚ドリル」
--雷符「エレキテルの龍宮」
--光星「光龍の吐息」
--雷魚「雷雲魚遊泳弾」
--羽衣「羽衣は空の如く」
--棘符「雷雲棘魚」
--龍魚「龍宮の使い遊泳弾」

		end
	end
end