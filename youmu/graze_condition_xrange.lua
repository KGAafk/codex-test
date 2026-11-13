function graze_condition_xrange()
	if
		(
			(--モーション反応型：近距離におけるグレイズ。
				(
					(		enemy_act>=400 and enemy_act<=409 and not(enemy_char==9 and enemy_act==402) and (not(enemy_char==1 or enemy_char==4 or enemy_char==13) and enemy_act~=408)	) or 
					(	(	enemy_char==1 or enemy_char==4 or enemy_char==13) and 	enemy_act==408												) or 
					(		enemy_char~=3 		and 																	enemy_act>=410 and enemy_act<=417 			) or 
					(		enemy_char==19 	and 																	enemy_act==418												) or 
					(																												enemy_act>=419 and enemy_act<=499			) or
					(
						enemy_act>=500 and enemy_act<690 and 
						not(
							(enemy_char==  0 and ((enemy_act>=530 and enemy_act<=534) or (enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=573) or enemy_act==614 or enemy_act==664)) or
							(enemy_char==  1 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=520 and enemy_act<=524) or enemy_act==605 or enemy_act==606 or enemy_act==607 or enemy_act==655 or enemy_act==656 or enemy_act==657)) or
							(enemy_char==  2 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=570 and enemy_act<=574) or enemy_act~=600)) or
							(enemy_char==  3 and ((enemy_act>=545 and enemy_act<=549) or enemy_act==610 or enemy_act==660)) or
							(enemy_char==  4 and ((enemy_act>=510 and enemy_act<=514) or enemy_act==602 or enemy_act==652)) or
							(enemy_char==  5 and ((enemy_act>=520 and enemy_act<=523) or (enemy_act>=540 and enemy_act<=543) or (enemy_act>=545 and enemy_act<=548) or (enemy_act>=550 and enemy_act<=553) or enemy_act==600 or enemy_act==603 or enemy_act==604 or enemy_act==612 or enemy_act==650 or enemy_act==653 or enemy_act==654 or enemy_act==662)) or
							(enemy_char==  6 and ((enemy_act>=500 and enemy_act<=514) or (enemy_act>=520 and enemy_act<=524) or (enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=569) or enemy_act==602 or enemy_act==605 or enemy_act==606 or enemy_act==652 or enemy_act==655 or enemy_act==656)) or
							(enemy_char==  7 and ((enemy_act>=510 and enemy_act<=514) or (enemy_act>=560 and enemy_act<=574))) or 
							(enemy_char==  8 and ((enemy_act>=520 and enemy_act<=524) or (enemy_act>=560 and enemy_act<=569))) or 
							(enemy_char==  9 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=510 and enemy_act<=514) or (enemy_act>=520 and enemy_act<=529) or enemy_act==600 or enemy_act==601 or enemy_act==602 or enemy_act==603 or enemy_act==604 or enemy_act==605 or enemy_act==612 or enemy_act==650 or enemy_act==651 or enemy_act==652 or enemy_act==653 or enemy_act==654 or enemy_act==655 or enemy_act==662)) or 
							(enemy_char==10 and enemy_act>=565 and enemy_act<=569) or
							(enemy_char==11 and ((enemy_act>=520 and enemy_act<=529) or (enemy_act>=545 and enemy_act<=549) or  (enemy_act>=550 and enemy_act<=554) or enemy_act==601 or enemy_act==606 or enemy_act==612 or enemy_act==651 or enemy_act==656 or enemy_act==662)) or 
							(enemy_char==12 and ((enemy_act>=525 and enemy_act<=534) or (enemy_act>=550 and enemy_act<=554) or enemy_act==600 or enemy_act==601 or enemy_act==604 or enemy_act==611 or enemy_act==650 or enemy_act==651 or enemy_act==654 or enemy_act==661)) or 
							(enemy_char==13 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=520 and enemy_act<=524) or (enemy_act>=530 and enemy_act<=530) or (enemy_act>=545 and enemy_act<=546) or enemy_act==601 or enemy_act==651 or enemy_act==610 or enemy_act==660)) or 
							(enemy_char==14 and ((enemy_act>=505 and enemy_act<=509) or (enemy_act>=545 and enemy_act<=549) or (enemy_act>=560 and enemy_act<=574) or enemy_act==601 or enemy_act==602 or enemy_act==605 or enemy_act==608 or enemy_act==651 or enemy_act==652 or enemy_act==655 or enemy_act==658)) or 
							(enemy_char==15 and ((enemy_act>=540 and enemy_act<=544) or enemy_act==605 or enemy_act==655)) or 
							(enemy_char==16 and ((enemy_act>=520 and enemy_act<=534) or (enemy_act>=570 and enemy_act<=574) or enemy_act==603 or enemy_act==607 or enemy_act==608 or enemy_act==653 or enemy_act==657 or enemy_act==658)) or 
							(enemy_char==17 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=510 and enemy_act<=514) or (enemy_act>=520 and enemy_act<=529) or (enemy_act>=540 and enemy_act<=544) or  (enemy_act>=550 and enemy_act<=554) or enemy_act==604 or enemy_act==605 or enemy_act==606 or enemy_act==607 or enemy_act==609 or enemy_act==654 or enemy_act==655 or enemy_act==656 or enemy_act==657 or enemy_act==659)) or 
							(enemy_char==18 and ((enemy_act>=505 and enemy_act<=514) or enemy_act==608 or enemy_act==609 or enemy_act==610 or enemy_act==658 or enemy_act==659 or enemy_act==660)) or 
							(enemy_char==19 and ((enemy_act>=520 and enemy_act<=524) or (enemy_act>=525 and enemy_act<=529) or (enemy_act>=540 and enemy_act<=544) or  (enemy_act>=550 and enemy_act<=554) or enemy_act==600 or enemy_act==602 or enemy_act==605 or enemy_act==650 or enemy_act==652 or enemy_act==655))
						)
					)
				)	and dis2<400 and (get_fflags(1,64) or dis>=200) and my_hitstop==0 and enemy_frame<=5 and enemy_act_block==0
			) or
			(--モーション反応型：レーザー系や判定が反転するなど情報取得がおかしくなるもの
				(
					--(enemy_char==  0 and ((enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=573) or enemy_act==614 or enemy_act==664)) or
					(enemy_char==  1 and ((enemy_act>=430 and enemy_act<=432) or (enemy_act>=565 and enemy_act<=568) or enemy_act==600 or enemy_act==602 or enemy_act==604 or enemy_act==619)) or
					--(enemy_char==  2 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=570 and enemy_act<=574))) or
					(enemy_char==  3 and ((enemy_act>=545 and enemy_act<=547) or enemy_act==602 or enemy_act==652 or enemy_act==605 or enemy_act==606 or enemy_act==607 or enemy_act==657 or enemy_act==609 or enemy_act==659)) or
					(enemy_char==  4 and (enemy_act==600 or enemy_act==603)) or
					--(enemy_char==  5 and (enemy_act==565)) or
					--(enemy_char==  6 and ((enemy_act>=500 and enemy_act<=514) or (enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=569) or enemy_act==602 or enemy_act==605 or enemy_act==606 or enemy_act==652 or enemy_act==655 or enemy_act==656)) or
					(enemy_char==  7 and (enemy_act>=520 and enemy_act<=524)) or 
					(enemy_char==  8 and ((enemy_act==530 or (enemy_act==531 and enemy_allframe>=15)))) or 
					--(enemy_char==  9 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=510 and enemy_act<=514) or (enemy_act>=520 and enemy_act<=529) or enemy_act==600 or enemy_act==601 or enemy_act==602 or enemy_act==603 or enemy_act==604 or enemy_act==605 or enemy_act==612 or enemy_act==650 or enemy_act==651 or enemy_act==652 or enemy_act==653 or enemy_act==654 or enemy_act==655 or enemy_act==662)) or 
					(enemy_char==10 and (enemy_act==604)) or
					--(enemy_char==11 and ((enemy_act>=520 and enemy_act<=529) or (enemy_act>=545 and enemy_act<=549) or  (enemy_act>=550 and enemy_act<=554) or enemy_act==601 or enemy_act==606 or enemy_act==612 or enemy_act==651 or enemy_act==656 or enemy_act==662)) or 
					--(enemy_char==12 and ((enemy_act>=525 and enemy_act<=534) or (enemy_act>=550 and enemy_act<=554) or enemy_act==600 or enemy_act==601 or enemy_act==604 or enemy_act==611 or enemy_act==650 or enemy_act==651 or enemy_act==654 or enemy_act==661)) or 
					--(enemy_char==13 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=520 and enemy_act<=524) or (enemy_act>=530 and enemy_act<=530) or (enemy_act>=545 and enemy_act<=546) or enemy_act==601 or enemy_act==651 or enemy_act==610 or enemy_act==660)) or 
					(enemy_char==14 and ((enemy_act>=540 and enemy_act<=544) or enemy_act==607)) or 
					(enemy_char==15 and ((enemy_act>=545 and enemy_act<=548) or enemy_act==607)) or 
					--(enemy_char==16 and ((enemy_act>=520 and enemy_act<=534) or (enemy_act>=570 and enemy_act<=574) or enemy_act==603 or enemy_act==607 or enemy_act==608 or enemy_act==653 or enemy_act==657 or enemy_act==658)) or 
					--(enemy_char==17 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=510 and enemy_act<=514) or (enemy_act>=520 and enemy_act<=529) or (enemy_act>=540 and enemy_act<=544) or  (enemy_act>=550 and enemy_act<=554) or enemy_act==604 or enemy_act==605 or enemy_act==606 or enemy_act==607 or enemy_act==609 or enemy_act==654 or enemy_act==655 or enemy_act==656 or enemy_act==657 or enemy_act==659)) or 
					(enemy_char==18 and (enemy_act==601 or enemy_act==614)) --or 
					--(enemy_char==19 and ((enemy_act>=520 and enemy_act<=524) or (enemy_act>=525 and enemy_act<=529) or (enemy_act>=540 and enemy_act<=544) or  (enemy_act>=550 and enemy_act<=554) or enemy_act==600 or enemy_act==602 or enemy_act==605 or enemy_act==650 or enemy_act==652 or enemy_act==655))
				)	--and get_fflags(1,64) and enemy_allframe>=15 
				and my_hitstop==0 and enemy_frame<=5 and enemy_act_block==0
			) or
			(--オブジェクト反応型
			(enemy_char== 0 and (dis>=300 or (enemy_act>=400 and enemy_act~=408 and enemy_act~=418 and not(enemy_act>=560 and enemy_act<=574))) and caution_state_obj(817,196,150,300,40-30,420+5)>=1 ) or --常置陣（B:30F, C:40F）
			(enemy_char== 2 and (dis>=300 or (enemy_act>=400 and enemy_act~=408 and enemy_act~=418 and not(enemy_act>=500 and enemy_act<=504))) and caution_state_obj(850,196,350,350,90-30,90+5)>=1 ) or --幻符「殺人ドール」
			(enemy_char== 6 and (dis>=300 or (enemy_act>=400 and not(enemy_act>=500 and enemy_act<=514))) and enemy_act~=540 and enemy_act~=541 and enemy_act~=602 and enemy_act~=605 and caution_state_obj(815,212,50,50,60-30,60+5)>=1 ) or --サーヴァントフライヤー
			(enemy_char== 7 and (dis>=300 or (enemy_act>=400 and enemy_act~=408 and enemy_act~=418 and not(enemy_act>=560 and enemy_act<=574))) and caution_state_obj(812,172,150,150,90-30,90+5)>=1 ) or --スフィアブルーム
			(enemy_char==13 and (((dis>=300 and ey==0) or (dis>=400 and ey>0)) or (enemy_act>=400 and enemy_act~=418 and enemy_act~=500 and enemy_act~=501 and enemy_act~=530 and enemy_act~=531 and enemy_act~=601)) and caution_state_obj(817,272,200,1200,0,45)>=1 and caution_state_obj(817,168,200,1200,0,45)>=1) --対龍神の怒り
			)
		)
	then
		return true
	else
		return false
	end
	
end