
--ヘッダファイル
function head_req_list()

    require("attack-pack.lua")--消したいが、個別で作成した衣玖コンボや固めが入っている

    require("function_command.lua");

    require("def_clc.lua");

    require("sabot_wakeup.lua");
    require("sabot_after_guard.lua");
    require("sabot_delay_control.lua");

    require("key_count_calc.lua");

    require("graze_condition_xrange.lua");
    require("graze_action_xrange.lua");

end

--シード生成、スレッド生成、base_states 設定
function set_seedthreadstates()

    math.randomseed(math.floor(math.floor(math.abs((x+1)*(y+1)*(my_char+1)*(stage_number+1)*(bgm_number+1)))))

    create_thread("calculation")
    
    base_states()

end

--キャラ確認
function char_calling()

    if my_char==0 then
        print();
        print("博麗霊夢用しなうす式、起動します");
        print();
        print("-reimu's AI the shinaus style is Activated-");
        print();
    elseif my_char==1 then
        print();
        print("霧雨魔理沙用しなうす式、起動します");
        print();
        print("-marisa's AI the shinaus style is Activated-");
        print();
    elseif my_char==2 then
        print();
        print("十六夜咲夜用しなうす式、起動します");
        print();
        print("-sakuya's AI the shinaus style is Activated-");
        print();
    elseif my_char==3 then
        print();
        print("アリス・マーガトロイド用しなうす式、起動します");
        print();
        print("-alice's AI the shinaus style is Activated-");
        print();
    elseif my_char==4 then
        print();
        print("パチュリー・ノーレッジ用しなうす式、起動します");
        print();
        print("-patchouli's AI the shinaus style is Activated-");
        print();
    elseif my_char==5 then
        print();
        print("魂魄妖夢用しなうす式、起動します");
        print();
        print("-youmu's AI the shinaus style is Activated-");
        print();
    elseif my_char==6 then
        print();
        print("レミリア・スカーレット用しなうす式、起動します");
        print();
        print("-remilia's AI the shinaus style is Activated-");
        print();
    elseif my_char==7 then
        print();
        print("西行寺幽々子用しなうす式、起動します");
        print();
        print("-yuyuko's AI the shinaus style is Activated-");
        print();
    elseif my_char==8 then
        print();
        print("八雲紫用しなうす式、起動します");
        print();
        print("-yukari's AI the shinaus style is Activated-");
        print();
    elseif my_char==9 then
        print();
        print("伊吹萃香用しなうす式、起動します");
        print();
        print("-suika's AI the shinaus style is Activated-");
        print();
    elseif my_char==10 then
        print();
        print("鈴仙・優曇華院・イナバ用しなうす式、起動します");
        print();
        print("-reisen's AI the shinaus style is Activated-");
        print();
    elseif my_char==11 then
        print();
        print("射命丸文用しなうす式、起動します");
        print();
        print("-aya's AI the shinaus style is Activated-");
        print();
    elseif my_char==12 then
        print();
        print("小野塚小町用しなうす式、起動します");
        print();
        print("-komachi's AI the shinaus style is Activated-");
        print();
    elseif my_char==13 then
        print();
        print("永江衣玖用しなうす式、起動します");
        print();
        print("-Iku's AI the shinaus style is Activated-");
        print();
    elseif my_char==14 then
        print();
        print("比那名居天子用しなうす式、起動します");
        print();
        print("-tenshi's AI the shinaus style is Activated-");
        print();
    elseif my_char==15 then
        print();
        print("東風谷早苗用しなうす式、起動します");
        print();
        print("-sanae's AI the shinaus style is Activated-");
        print();
    elseif my_char==16 then
        print();
        print("チルノ用しなうす式、起動します");
        print();
        print("-chirno's AI the shinaus style is Activated-");
        print();
    elseif my_char==17 then
        print();
        print("紅美鈴用しなうす式、起動します");
        print();
        print("-meirin's AI the shinaus style is Activated-");
        print();
    elseif my_char==18 then
        print();
        print("霊烏路空用しなうす式、起動します");
        print();
        print("-utsuho's AI the shinaus style is Activated-");
        print();
    elseif my_char==19 then
        print();
        print("洩矢諏訪子用しなうす式、起動します");
        print();
        print("-suwako's AI the shinaus style is Activated-");
        print();
    else
        print();
        print("不明");
        print();
        print("-unknown-");
        print();
    end

end

--キャラ確認2
function traingbag_calling()
        print();
        print("サンドバッグAI(しなうす式)、起動します");
        print();
        print("-active trainingbag AI the shinaus style is Activated-");
        print();
end

--キャラ確認3
function vibratedbag_calling()
        print();
        print("振動ガードAI(しなうす式)、起動します");
        print();
        print("-vibrative guard trainingbag AI the shinaus style is Activated-");
        print();
end

--▼ ステージが 核融合炉心部 だと超反応モードに
function set_printsabot()

    if true then
        sabot_rank = 0 --組込
        print("★核融合炉心部ステージ:超反応モード -No delay mode-  ON",sabot_rank,"= not sabot")
    else
        print("☆通常モード")
        print("サボットランク:-sabot delay mode- ON [",sabot_rank,"= Sabot lank ] is activated sabot")
    end

end

--スレッド外初期化
function while_top()

    key_resetEX(); --これ、ループ最初の初期化
    if sabot_activate_flag >= 1 then
        sabot_wakeup()
    end

end

--●どちらかが体力無くなったら待機
--●どちらかが体力無くなったら待機
function interbattle_condi()
	if 
    (my_hp<=0 and my_act>=50 and my_act<=100) or 
    (enemy_hp<=0 and enemy_act>=50 and enemy_act<=100) 
    then
        return true
    else
        return false
    end
end

function interbattle_exe()
    key_resetEX();
    print("待機行動")
    for i=1,10,1 do
        if (
        (my_card>=100 and my_card<=114) or 
        (not(my_card>=100 and my_card<=114) and y==0 and (my_card==4 or my_card==5 or my_card==9 or my_card==10 or my_card==18 or (my_card==19 and get_special_data(0,21)<=1)))
        ) and is_card_use then
            if battle_time%2==0 then
                key_on(ACT_BC);
            else
                key_off(ACT_BC);
            end
        else
            if battle_time%2==0 then
                key_on(ACT_AB);
            else
                key_off(ACT_AB);
            end
        end
        yield();
    end

end


--▼ 開幕行動
function kaimaku_condi()
    if 
    dis>=300 and dis<=340 and 
    ey==0 and
    enemy_act<10 and
    battle_time<=180+my_dir then
        return true
    else
        return false
    end
end

function kaimaku_exe()
    --print(dis)
    if my_char==13 and (stage_number==4 or bgm_number==4) and battle_time<177 then --ステージ『玄雲海』か、曲『黒い海に紅く　～ Legendary Fish』の場合、お座り
        key_on(ACT_DOWN);
    elseif my_char==13 and (stage_number==4 or bgm_number==4) and battle_time>=177 and battle_time<=179 then --上の続き、お座りが維持されればフィーバー
        lvr22(ACT_B);
    elseif dis>=200 and battle_time<120 then
        key_on(ACT_DOWN);
    elseif dis>=200 and battle_time>=140 and battle_time<170 then
        key_on(back);
    elseif dis<200 and battle_time<170 and (x<200 or x>1080)  then
        key_event2(ACT_D,u_front);
    elseif dis<200 and battle_time<170 and x>=200 and x<=1080 then
        key_event2(ACT_D,u_front);
    elseif dis<200 and battle_time>=170 and battle_time<=179 then
        key_on(u_back);
    end
end

--▼移動起き上がりのルーチン▼
function movedgetup_exe()
    key_resetEX();
    if dis<=640 then
        if x<500 then
            print("移動起き上がり -> 右へ");
            key_on(ACT_D);
            key_on(ACT_RIGHT);
        elseif x>780 then
            print("移動起き上がり -> 左へ");
            key_on(ACT_D);
            key_on(ACT_LEFT);
        else 
            print("移動起き上がり -> 相手側へ");
            key_on(ACT_D);
            key_on(front);
        end
    else--離れている場合のみ、その場起き上がり
        key_resetEX();
    end
    wait(20);
end


--▼簡易受け身▼:攻撃ないし回避いずれの目的であってもリカバリーポイントは限られるが、そういうことはさておき実装したもの
function recovery_condi()
    if	
    y-my_yspeed*3>0 and 
    my_act>=50 and 
    my_act<=107 and 
    not(my_act>=97 and my_act<=99) 
    then
        return true
    else
        return false
    end
end

function recovery_exe()
    if weather2==13 then --予報が台風なら受け身を取らない
        yield()
    elseif dis>=400 or --距離が離れている場合か
    weather==18 then --梅雨の場合
        print("簡易受身の試行");
        if my_backside<=300 then --背中に壁が迫っているなら前へリカバリー
            key_on(front);
            yield();
            key_event(ACT_A);
        else --さもなければ、後ろにリカバリー
            key_on(back);
            yield();
            key_event(ACT_A);
        end
    end --距離が近い場合はリカバリーしない
end

--▼台風: 近接状態からの強引な状況変更を行う行動。スペカなど使用。
function react_rejecttaihu_condi()
    if
    weather==13 and 
    dis<=300 and 
    y==0 and
    my_hitstop==0 and
    enemy_act>=300 and 
    enemy_frame<=5 and 
    enemy_act_block==0 and
    (
        (
            card_check(14)==true
        ) or
        (
            my_char==2 and 
            (
                (card_check(201)==true and my_spell_more(2000)) or
                (card_check(209)==true and my_spell_more(2000))
            )
        ) or
        (
            my_char==5 and 
            (
                (card_check(204)==true and my_spell_more(2000))
            )
        ) or
        (
            my_char==8 and 
            (
                (card_check(205)==true and my_spell_more(1500))
            )
        ) or
        (
            my_char==13 and 
            (
                (card_check(210)==true and my_spell_more(2500)) or
                (card_check(207)==true and my_spell_more(2000)) or
                (card_check(209)==true and my_spell_more(1500)) or
                (card_check(203)==true and my_spell_more(1500)) or
                (card_check(202)==true and my_spell_more(1500)) or
                (card_check(201)==true and my_spell_more(1500))
            )
        )
    )
    then
        return true
    else
        return false
    end
end

function react_rejecttaihu_exe()
    if card_check(14) then
        print("反抗:台風 -> 「緋想の剣」");
        card_use(14);
    elseif my_char==13 and card_check(210)==true and my_spell_more(2500) then
        print("反抗:台風 -> スペルカード:龍魚「龍宮の使い遊泳弾」")
        card_use(210)
    elseif my_char==13 and card_check(207)==true and my_spell_more(2000) then
        print("反抗:台風 -> スペルカード:羽衣「羽衣は空の如く」")
        card_use(207)
    elseif my_char==13 and card_check(209)==true and my_spell_more(1500) then
        print("反抗:台風 -> スペルカード:棘符「雷雲棘魚」")
        card_use(209)
    elseif my_char==13 and card_check(203)==true and my_spell_more(1500) then
        print("反抗:台風 -> スペルカード:光星「光龍の吐息」")
        card_use(203)
    elseif my_char==13 and card_check(202)==true and my_spell_more(1500) then
        print("反抗:台風 -> スペルカード:雷符「エレキテルの龍宮」")
        card_use(202)
    elseif my_char==13 and card_check(201)==true and my_spell_more(1500) then
        print("反抗:台風 -> スペルカード:魚符「龍魚ドリル」")
        card_use(201)
    elseif my_char==2 and card_check(209)==true and my_spell_more(2000) then
        print("反抗:台風 -> スペルカード:時符「咲夜特製ストップウォッチ」")
        card_use(209)
    elseif my_char==2 and card_check(201)==true and my_spell_more(2000) then
        print("反抗:台風 -> スペルカード:時符「プライベートスクウェア」")
        card_use(201)
    elseif my_char==5 and card_check(204)==true and my_spell_more(2000) then
        print("反抗:台風 -> スペルカード:断迷剣「迷津慈航斬」")
        card_use(204)
    elseif my_char==8 and card_check(205)==true and my_spell_more(1500) then
        print("反抗:台風 -> スペルカード:結界「客観結界」")
        card_use(205)
    end
end



--▼起き攻め▼
function setplay_ongetup_condi()
    if 
    (
        enemy_act==97 or 
        enemy_act==98 or 
        enemy_act==197 or 
        enemy_act==198 or 
        enemy_act==199
    ) or 
    (
        enemy_act>=70 and 
        enemy_act<=107 and 
        my_limit>=100
    ) 
    then
        return true
    else
        return false
    end
end


function setplay_ongetup_exe()
	
	--霊力状況が悪い場合は「マジックポーション」を使用
    if card_check(1)==true and not(enemy_act>=197 and enemy_act<=199) and my_rei<200 and my_rmax<=800 then
        print("起き攻め:システムカード 「マジックポーション」");
        card_use(1);
    --▼ 霊夢
    --敵が倒れてて、自分が画面端でなければ警醒陣で起き攻め。
    elseif my_char==0 and (y==0 or y>=150) and my_act<=10 and dis<600 and dis>120 and my_rei>=801 and x>340 and x<940 and enemy_act==97 and enemy_allframe<15 and (card_check(101) or get_skill_lv(0,1)>=0) then
        --print("起き攻め　⇒　警醒陣");
        if dis>300 and ((x<740 and my_dir==1) or (x>540 and my_dir==-1)) and math.random(2)==1 then
            key_reset();
            if card_check(101) and my_card~=101 then
                card_1st(101);
            elseif my_card==101 then
                card_use(101);
            elseif get_skill_lv(0,1)>=0 then
                key_on(ACT_D)
                yield();
                yield();
                key_off(ACT_D);
                lvr214(ACT_C);
            end
        else
            if card_check(101) and my_card~=101 then
                card_1st(101);
            elseif my_card==101 then
                card_use(101);
            elseif get_skill_lv(0,1)>=0 then
                key_reset();
                key_on(ACT_D)
                yield();
                yield();
                key_off(ACT_D);
                lvr214(ACT_B);
            end
        end
    --敵が倒れてて、自分が中央より相手を押し込んでいる場合、起動しない程度の距離で、常置陣設置
    --離れていても、Ｃ設置で中央付近に設置などする。ただしレベルアップの場合はそのまま使用。
    elseif my_char==0 and y==0 and my_act<=10 and dis>=200 and my_rei>=801 and x>340 and x<940 and enemy_act==97 and enemy_allframe<15 and (card_check(109) or get_skill_lv(0,9)>=0) then
        --print("起き攻め　⇒　常置陣");
        if dis>400 and ((x<740 and my_dir==1) or (x>540 and my_dir==-1)) then
            key_reset();
            if card_check(109) and my_card~=109 then
                card_1st(109);
            elseif my_card==109 then
                card_use(109);
            elseif get_skill_lv(0,9)>=0 then
                key_on(ACT_D)
                yield();
                yield();
                key_off(ACT_D);
                lvr214(ACT_C);
            end
        else
            if card_check(109) and my_card~=109 then
                card_1st(109);
            elseif my_card==109 then
                card_use(109);
            elseif get_skill_lv(0,9)>=0 then
                key_reset();
                key_on(ACT_D)
                yield();
                yield();
                key_off(ACT_D);
                lvr214(ACT_B);
            end
        end
    --▼ 魔理沙
    --グラウンドスターダスト
    elseif my_char==1 and y>=0 and my_act<300 and my_rei>=600 and is_dir_front==true and not(enemy_act>=197 and enemy_act<=199) and get_skill_lv(0,2)>=0 and 
    (
        (y==0) or
        (y>0 and weather~=9 and math.sqrt((dis-300-20*get_skill_lv(0,2)-50)/(0.3+0.2))<=(y/my_yspeed/5)+1+15) or
        (y>0 and weather==9 and math.sqrt((dis-300-180-50)/(0.3+0.2))<=(y/my_yspeed/5)+1+15)
    )	then
        print("起き攻め：Ｃグラウンドスターダスト");
        key_resetEX();
        lvr22h(ACT_C);
        wait(12);
            if weather~=9 and y==0 then
                wait(math.sqrt((dis-300-20*get_skill_lv(0,2)-50)/(0.3+0.1)));
            elseif  weather==9 and y==0 then
                wait(math.sqrt((dis-300-180-50)/(0.3+0.1)));
            elseif weather~=9 and y>0 then
                wait(math.sqrt((dis-300-20*get_skill_lv(0,2)-50)/(0.3+0.2)));
            elseif  weather==9 and y>0 then
                wait(math.sqrt((dis-300-180-50)/(0.3+0.2)));
            end
        key_resetEX();
        wait(5);
        while y>0 and my_act>=540 and my_act<=544 and my_airEX>=1 do
            print("起き攻めＧＳＤ用ｈｊｃ");
            if dis<=150 and y>120 then
                key_event2(ACT_D,ACT_DOWN);
            elseif ey-y<=-1*(ex-x)*my_dir and y>84.9 then
                key_event2(ACT_D,u_front);
            elseif dis<=300 or my_rei<=200 then
                lvr66();
            else
                key_event2(ACT_D,front);
            end
            yield();
        end
    --▼ 咲夜
    elseif my_char==2 and card_check(204)==true and my_spell_more(2500) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：スペルカード　「咲夜の世界」");
        card_use(204);
    elseif my_char==2 and card_check(201)==true and my_spell_more(2000) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：スペルカード　時符「プライベートスクウェア」");
        card_use(201);
    elseif my_char==2 and card_check(200)==true and my_spell_more(1500) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：スペルカード　幻符「殺人ドール」");
        card_use(200);
    --バウンスノーバウンス起き攻め
    elseif my_char==2 and dis>=300 and y==0 and my_act<500 and ((my_rei>=600 and get_skill_lv(0,1)>=0) or card_check(101)) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：バウンスノーバウンス");
        key_resetEX();
        if card_check(101) then
            card_use(101);
        elseif (my_rei>=600 and get_skill_lv(0,1)>=0) then
            lvr214h(ACT_C);
            wait(5+20);
            key_resetEX();
        end
    --スクウェアリコシェ起き攻め
    elseif my_char==2 and dis>=300 and y==0 and my_act<500 and ((my_rei>=600 and get_skill_lv(0,5)>=0) or card_check(105)) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：スクウェアリコシェ");
        key_resetEX();
        if card_check(105) then
            card_use(105);
        elseif (my_rei>=600 and get_skill_lv(0,5)>=0) then
            lvr214h(ACT_C);
            wait(5+20);
            key_resetEX();
        end
    --▼ パチュリー
    elseif my_char==4 and card_check(205)==true and my_spell_more(2500) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：火水木金土符「賢者の石」");
        card_use(205);
    elseif my_char==4 and card_check(206)==true and my_spell_more(1500) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：スペルカード　水符「ジェリーフィッシュプリンセス」");
        card_use(206);
    elseif my_char==4 and card_check(207)==true and my_spell_more(1500) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：スペルカード　月木符「サテライトヒマワリ」");
        card_use(207);
    elseif my_char==4 and card_check(210)==true and my_spell_more(1500) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：スペルカード　日木符「フォトシンセシス」");
        card_use(210);
    --▼ 衣玖
    --龍神の怒り
    elseif my_char==13 and get_skill_lv(0,6)>=0 and weather~=13 and
            y==0 and 
            not(enemy_act>=197 and enemy_act<=199) and 
            not(my_act>=545 and my_act<=546) and 
            my_rei>=700 and
            math.random(2)==1 then
                print("起き攻め:Ｂ龍神の怒り");
                lvr22h(ACT_B)
                wait(2)
                key_hold_B = 1
    elseif my_char==13 and get_skill_lv(0,6)>=0 and
            y==0 and
            not(enemy_act>=197 and enemy_act<=199) and  
            not(my_act>=545 and my_act<=546) and
            my_rei>=700 then
                print("起き攻め:Ｃ龍神の怒り");
                lvr22h(ACT_C)
                wait(2)
                key_hold_C = 1
    --▼ アリス用
    --全てが当てはまらない場合、飛び込みJAを重ねる
    elseif my_char==3 and (enemy_act==197 or enemy_act==198 or enemy_act==199) and enemy_xspeed==0 and y<=0 and dis<=400 and dis>=200 and is_dir_front and
            (	(enemy_act==197 and stand_front	-	enemy_allframe<=15) or
                (enemy_act==198 and stand_back		-	enemy_allframe<=15) or
                (enemy_act==199 and stand_neutral	-	enemy_allframe<=15) 
            ) then
        print("相手起き上がり終了間際　⇒　ＪＡ重ね");
        key_event(ACT_A);
    elseif my_char==3 and (enemy_act==197 or enemy_act==198 or enemy_act==199) and enemy_xspeed==0 and (my_act==202 or my_act==214) and y<=150 and dis<=300 and is_dir_front and
            (	(enemy_act==197 and stand_front	-	enemy_allframe<=15) or
                (enemy_act==198 and stand_back		-	enemy_allframe<=15) or
                (enemy_act==199 and stand_neutral	-	enemy_allframe<=15) 
            ) then
        print("相手起き上がり終了間際　⇒　ＪＡ重ね");
        --wait(2);
        --key_event2(ACT_A,ACT_DOWN);
        key_event(ACT_A);
    --4C>J2C
    elseif my_char==3 and (enemy_act==97 or enemy_act==98 or (enemy_act>=70 and enemy_act<=107 and my_limit>=100)) and y==0 and my_rei>=600 then
        print("起き攻め：４C -> J2C");
        if (my_dir==1 and x>=300) or (my_dir==-1 and x<=980) then
            key_event2(ACT_C,back);
            if 33-my_allframe>=1 then
                wait(33-my_allframe);
            end
        else
            key_event2(ACT_C,front);
            if 19-my_allframe>=1 then
                wait(19-my_allframe);
            end
        end
        key_event(ACT_UP);
        if 4-my_allframe>=1 then
            wait(4-my_allframe);
        end
        
        if not(enemy_act==199 and enemy_allframe>=10) then
            key_event2(ACT_C,ACT_DOWN);
            if 27-my_allframe>=1 then
                wait(27-my_allframe);
            end
            key_event2(ACT_D,front);
        end
        
    elseif my_char==3 then
        print("起き攻め：位置調整");
        print("起き攻め：位置調整",math.floor(ex-x),math.floor((math.sin(math.rad(4)*battle_time))*200+300));
        if ex-x>=math.floor((math.sin(math.rad(4)*battle_time))*200+300*my_dir) then
            key_on(ACT_RIGHT);
        else
            key_on(ACT_LEFT);
        end

    --水蛙神 or 雨を呼ぶ雨蛙
    elseif my_char==19 and
    (get_skill_lv(0,4)>=0 or get_skill_lv(0,8)>=0) and my_rei>=200 and 
    ((my_dir==1 and x<=900) or (my_dir==-1 and x>=380)) and is_dir_front==true and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：水蛙神or雨を呼ぶ雨蛙　使用");
        lvr214(ACT_B);
    --土着神の祟り
    elseif my_char==19 and
    get_skill_lv(0,3)>=0 and my_rei>=200 and 
    (my_act==0 or my_act==2 or (my_act==1 and my_allframe>=13) or (my_act==3 and my_allframe<=11) or (my_act==4 and y==0) or my_act==5) and not(enemy_act>=197 and enemy_act<=199) then
        print("起き攻め：土着神の祟り　使用");
        lvr22h(ACT_B);
        wait(15);
    elseif my_char==19 and
    get_skill_lv(0,3)>=0 and my_rei>=200 and 
    (my_act==0 or my_act==2 or (my_act==1 and my_allframe>=13) or (my_act==3 and my_allframe<=11) or (my_act==4 and y==0) or my_act==5) and my_allframe<=15 then
        print("起き攻め：土着神の祟り　使用");
        lvr22(ACT_B)
    --指定の使用カードがない場合、スキル宣言。
    elseif (card_check(100) or card_check(101) or card_check(102) or card_check(103) or card_check(104) or card_check(105) or card_check(106) or card_check(107) or card_check(108) or card_check(109) or card_check(110) or card_check(111) or card_check(112) or card_check(113) or card_check(114)
    ) and 
    (
        enemy_act==97 or 
        enemy_act==98 or 
        (enemy_act==197 and (stand_front - enemy_allframe)>=70) or 
        (enemy_act==198 and (stand_back - enemy_allframe)>=70) or 
        (enemy_act==199 and (stand_neutral- enemy_allframe)>=70) or 
        (my_limit>=100 and ey>0)
    ) then 
        for i=1,10,1 do 
        print("起き攻め -> スキルカード宣言");
            key_on(back);
            if my_card>=100 and my_card<=114 then
                if battle_time%2==0 then
                    key_on(ACT_BC);
                else
                    key_off(ACT_BC);
                end
            else
                if battle_time%2==0 then
                    key_on(ACT_AB);
                else
                    key_off(ACT_AB);
                end
            end
            yield();
        end
    --上記に引き続き、スキカがない場合、システムカードを宣言。
    elseif (card_check(4) or card_check(5) or card_check(9) or card_check(10) or card_check(18) or (card_check(19) and get_special_data(0,21)<=1)
    ) and 
    (
        enemy_act==97 or 
        enemy_act==98 or 
        (enemy_act==197 and (stand_front - enemy_allframe)>=70) or 
        (enemy_act==198 and (stand_back - enemy_allframe)>=70) or 
        (enemy_act==199 and (stand_neutral- enemy_allframe)>=70) or 
        (my_limit>=100 and ey>0)
    ) then 
        for i=1,10,1 do 
        print("起き攻め -> システムカード宣言");
            if my_card==4 or my_card==5 or my_card==9 or my_card==10 or my_card==18 or my_card==19 then
                if battle_time%2==0 then
                    key_on(ACT_BC);
                else
                    key_off(ACT_BC);
                end
            else
                if battle_time%2==0 then
                    key_on(ACT_AB);
                else
                    key_off(ACT_AB);
                end
            end
            yield();
        end
    --指定の使用カードがない場合、スキル宣言。
    elseif (card_check(100) or card_check(101) or card_check(102) or card_check(103) or card_check(104) or card_check(105) or card_check(106) or card_check(107) or card_check(108) or card_check(109) or card_check(110) or card_check(111) or card_check(112) or card_check(113) or card_check(114)
    ) and 
    (
        enemy_act==97 or 
        enemy_act==98 or 
        (enemy_act==197 and (stand_front - enemy_allframe)>=70) or 
        (enemy_act==198 and (stand_back - enemy_allframe)>=70) or 
        (enemy_act==199 and (stand_neutral- enemy_allframe)>=70) or 
        (my_limit>=100 and ey>0)
    ) then 
        for i=1,10,1 do 
        print("起き攻め -> スキルカード宣言");
            key_on(back);
            if my_card>=100 and my_card<=114 then
                if battle_time%2==0 then
                    key_on(ACT_BC);
                else
                    key_off(ACT_BC);
                end
            else
                if battle_time%2==0 then
                    key_on(ACT_AB);
                else
                    key_off(ACT_AB);
                end
            end
            yield();
        end
    --上記に引き続き、スキカがない場合、システムカードを宣言。
    elseif (card_check(4) or card_check(5) or card_check(9) or card_check(10) or card_check(18) or (card_check(19) and get_special_data(0,21)<=1)
    ) and 
    (
        enemy_act==97 or 
        enemy_act==98 or 
        (enemy_act==197 and (stand_front - enemy_allframe)>=70) or 
        (enemy_act==198 and (stand_back - enemy_allframe)>=70) or 
        (enemy_act==199 and (stand_neutral- enemy_allframe)>=70) or 
        (my_limit>=100 and ey>0)
    ) then 
        for i=1,10,1 do 
        print("起き攻め -> システムカード宣言");
            if my_card==4 or my_card==5 or my_card==9 or my_card==10 or my_card==18 or my_card==19 then
                if battle_time%2==0 then
                    key_on(ACT_BC);
                else
                    key_off(ACT_BC);
                end
            else
                if battle_time%2==0 then
                    key_on(ACT_AB);
                else
                    key_off(ACT_AB);
                end
            end
            yield();
        end


    --▼ 汎用
    elseif math.random(2)==1 then --悩んだ挙句、確率選択。
        while (enemy_act==97 or enemy_act==98 or (enemy_act>=70 and enemy_act<=107 and my_limit>=100) or (enemy_act==197 and (stand_front - enemy_allframe)>=14) or (enemy_act==198 and (stand_back - enemy_allframe)>=14) or (enemy_act==199 and (stand_neutral- enemy_allframe)>=14)) do
    --画面端に居たら前ダッシュで押す
            if y==0 and (my_act<=5 or my_act==200) and my_dir==1 and x<240 then
                print("起き攻め -> 画面端:６方向に６Ｄで押す");
                key_on(ACT_RIGHT);
                if my_char~=6 then
                    key_on(ACT_D);
                end
            elseif y==0 and (my_act<=5 or my_act==200) and my_dir==-1 and x>1040 then
                print("起き攻め -> 画面端:４方向に６Ｄで押す");
                key_on(ACT_LEFT);
                if my_char~=6 then
                    key_on(ACT_D);
                end
    --適当に距離調節
            elseif y==0 and (my_act<=5 or my_act==200) then
                print("起き攻め -> 地上:適当に距離調整");
                if my_rei>=300 then
                    if dis>=600 then
                        key_on(ACT_D);			
                        key_on(front);
                        key_on(ACT_UP);
                    elseif dis<600 and dis>350 then
                        key_on(ACT_D);	
                        key_on(front);
                    elseif dis<350 then
                        if dis<100 and enemy_act==197 and enemy_allframe<1 then
                            if enemy_char~=6 then
                                key_on(ACT_D);	
                                key_on(back);
                            else
                                key_on(back)
                            end
                        else
                            key_on(front);
                        end
                    end
                else
                    wait(3);
                end
            elseif y>=50 and my_air<=1 and my_act~=202 and my_act~=203 and (my_act~=209 or (my_act==209 and my_yspeed<-1)) then
                print("起き攻め -> 空中:適当に距離調整");
                --key_resetEX()
                if x<140 then
                    if enemy_xspeed>=1 and math.random(2)==1 then
                        key_event(ACT_RIGHT);
                        key_event(ACT_RIGHT);
                    else
                        key_on(ACT_RIGHT);
                    end
                elseif x>1140 then
                    if enemy_xspeed>=1 and math.random(2)==1 then
                        key_event(ACT_LEFT);
                        key_event(ACT_LEFT);
                    else
                        key_on(ACT_LEFT);
                    end
                elseif my_rei>=400 and dis>=400 then
                    key_event(front);
                    key_event(front);
                end
                --wait(5)
            end
            yield()
        end
    else
        while (enemy_act==97 or enemy_act==98 or (enemy_act>=70 and enemy_act<=107 and my_limit>=100) or (enemy_act==197 and (stand_front - enemy_allframe)>=14) or (enemy_act==198 and (stand_back - enemy_allframe)>=14) or (enemy_act==199 and (stand_neutral- enemy_allframe)>=14)) do
        --全てが当てはまらない場合、飛び込みJAを重ねる
            if (enemy_act==197 or enemy_act==198 or enemy_act==199) and enemy_xspeed==0 and (my_act==202 or my_act==214) and y<=150 and dis<=300 and is_dir_front==true and
            (	(enemy_act==197 and stand_front	-	enemy_allframe<=15) or
                (enemy_act==198 and stand_back		-	enemy_allframe<=15) or
                (enemy_act==199 and stand_neutral	-	enemy_allframe<=15) 
            ) then
                print("相手起き上がり終了間際 -> ＪＡ重ね");
                wait(2);
                key_event(ACT_A);
            elseif (enemy_act==199) and y>0 and my_allframe>=30 and my_air==0 then
                print("相手:その場起き上がり -> 相手に向かって低空飛翔");
                if my_char==6 then
                    yield()
                    lvr66()
                else
                    key_on(ACT_D);
                    if dis<=200 then
                        key_on(ACT_DOWN);
                    else
                        key_on(d_front);
                    end
                end
            elseif (enemy_act==197 or enemy_act==198) and y>0 then
                if math.random(2)==1 then
                    print("相手正面:移動起き上がり -> 相手に向かって低空飛翔");
                    if my_char==6 then
                        yield()
                        lvr66()
                    else
                        key_on(ACT_D);
                        key_on(front);
                    end
                else
                    print("相手背面:移動起き上がり -> 相手に向かって低空飛翔");
                    wait(10)
                    if my_char==6 then
                        lvr66()
                    else
                        key_on(ACT_D);
                        key_on(front);
                    end
                end
            elseif (enemy_act==98 or enemy_act==197 or enemy_act==198 or enemy_act==199) and y==0 then
                print("起き上がり確認 -> ＨＪ");
                key_event2(ACT_D,ACT_UP);
            elseif (enemy_act==97 or enemy_act==98 or (enemy_act>=70 and enemy_act<=107 and my_limit>=100)) and y==0 then
                print("相手ダウン中 -> ダッシュで接近");
                if my_char~=6 then
                    key_on(ACT_D);
                end
                key_on(front);
            end
            yield()
        end--]]
    end
end

--▼ＨＪＣ▼
--地上HJC
function hjc_ground_condi()
    if get_fflags(0,2097152)==true and y==0 and my_act>=300 then
        return true
    else
        return false
    end
end

function hjc_ground_exe()
    key_on(ACT_D);
    if dis>=600 or (enemy_act>=50 and enemy_act<=199) or (enemy_preact[1]>=50 and enemy_preact[1]<=199)  or (enemy_preact[2]>=50 and enemy_preact[2]<=199) or (enemy_xspeed<0 and y>0) then
        print("地上ｈｊｃ:９HJC");
        key_on(u_front);
    elseif my_backside>=340 and my_frontside<=240 and (dis<=300 or (y==0 and (enemy_act==200 or enemy_act==209)) or (enemy_xspeed>0 and y>0)) then
        print("地上ｈｊｃ:７HJC");
        key_on(u_back);
    elseif my_backside>=340 and math.random(8)==1 then
        print("地上ｈｊｃ:バックステップ");
        key_on(back);
    elseif dis>=300 or (enemy_xspeed<=5 and y>0) then
        print("地上ｈｊｃ:８HJC");
        key_on(ACT_UP);
    else
        print("地上ｈｊｃ:全条件スルーの場合");
        key_on(ACT_UP);
    end
end

--空中HJC
function hjc_air_condi()
    if get_fflags(0,2097152)==true and y>0 and my_airEX>=1 and my_act>=300 then
        return true
    else
        return false
    end
end

function hjc_air_exe()
    if dis>=600 or (enemy_act>=50 and enemy_act<=199) or (enemy_preact[1]>=50 and enemy_preact[1]<=199)  or (enemy_preact[2]>=50 and enemy_preact[2]<=199) or (enemy_xspeed<0 and y>0) then
        print("空中ｈｊｃ:６飛翔");
        if my_char~=5 and my_char~=6 then
            key_on(ACT_D);
            key_on(front);
        else
            lvr66()
        end
    elseif my_backside>=340 and my_frontside<=240 and (dis<=300 or (y==0 and (enemy_act==200 or enemy_act==209)) or (enemy_xspeed>0 and y>0)) then
        print("空中ｈｊｃ:J44");
        lvr44();
    elseif my_backside>=340 and math.random(8)==1 then
        print("空中ｈｊｃ:J44");
        lvr44();
    elseif dis>=300 or (enemy_xspeed<=5 and y>0) then
        print("空中ｈｊｃ:J66");
        lvr66();
    else
        print("空中ｈｊｃ:全条件スルーの場合");
        if my_char~=6 then
            key_on(ACT_D);
            key_on(d_front);
        else
            lvr66()
        end
    end
end

--正ガード状態一式
function state_trueguard()
    if
    (
        (my_act==150) or
        (my_act==151) or
        (my_act==152) or
        (my_act==153) or
        (my_act==154) or
        (my_act==155) or
        (my_act==156) or
        (my_act==157) or
        (my_act==158)
    ) then
        return true
    else
        return false
    end
end

--終端フレームを除いた正ガード以外の全てをモーション
--正ガード状態とアンド条件で組み合わせることで、モーション終端での入力からの最速行動が可能になる
function state_nottrueguard()
    if
    not(
        (my_act==150 and my_frame+1< 8 and my_act_block==0) or
        (my_act==151 and my_frame+1<14 and my_act_block==0) or
        (my_act==152 and my_frame+1<20 and my_act_block==0) or
        (my_act==153 and my_frame+1<26 and my_act_block==0) or
        (my_act==154 and my_frame+1< 8 and my_act_block==0) or
        (my_act==155 and my_frame+1<14 and my_act_block==0) or
        (my_act==156 and my_frame+1<20 and my_act_block==0) or
        (my_act==157 and my_frame+1<26 and my_act_block==0) or
        (my_act==158 and my_frame+1<18 and my_act_block==0)
    ) then
        return true
    else
        return false
    end
end

--条件）反応:下段回避
function react_targetact_lowatttack()
    if
    ( --各キャラで見てから回避できる特定の下段
        (enemy_char== 0 and (enemy_act==303)) or
        (enemy_char== 1 and (enemy_act==303 or enemy_act==304)) or
        (enemy_char== 2 and (enemy_act==302 or enemy_act==303)) or
        (enemy_char== 3 and (enemy_act==300 or enemy_act==330 or enemy_act==418)) or
        (enemy_char== 4 and (enemy_act==303 or enemy_act==304)) or
        (enemy_char== 5 and (enemy_act==303 or (enemy_act==304 and my_backside>=100))) or
        (enemy_char== 6 and (enemy_act==301 or enemy_act==304)) or
        (enemy_char== 7 and (enemy_act==304)) or 
        (enemy_char== 8 and (enemy_act==303)) or 
        (enemy_char== 9 and (enemy_act==303 or enemy_act==304)) or 
        (enemy_char==10 and (enemy_act==303 or enemy_act==304)) or
        (enemy_char==11 and (enemy_act==303 or enemy_act==304)) or 
        (enemy_char==12 and (enemy_act==302 or enemy_act==303)) or 
        (enemy_char==13 and (enemy_act==303 or enemy_act==304)) or 
        (enemy_char==14 and (enemy_act==303)) or 
        (enemy_char==15 and (enemy_act==301 or enemy_act==303 or enemy_act==304)) or 
        (enemy_char==16 and (enemy_act==304)) or 
        (enemy_char==17 and (enemy_act==303 or enemy_act==304)) or 
        (enemy_char==18 and (enemy_act==302 or enemy_act==303)) or 
        (enemy_char==19 and (enemy_act==301 or enemy_act==303 or enemy_act==305 or enemy_act==331))
    ) then
        return true
    else
        return false
    end
end

--条件）概ね空中で行動可能な状態
function intheairfreefall()
    if
    (
        (my_act>=6 and my_act<=9) or 
        (my_act==158 and my_frame+1>=18 and my_act_block==0) or
        (my_act>=180 and my_act<=181) or 
        (my_act>=208 and my_act<=214)
    ) then
        return true
    else
        return false
    end
end

--反応:下段
function react_lowattack_condi()
    if 	y==0 and 
    (
        my_act<=10 or (my_act==200 and my_char~=19) and 
        state_nottrueguard()==true
    ) and
    react_targetact_lowatttack()==true and 
    enemy_allframe==1 and 
    math.random(6)==1 then
        return true
    else
        return false
    end
end

function react_lowattack_exe()
    print("反応:下段");
    if my_backside<=140 then
        key_event2(ACT_D,ACT_UP);
    else
        key_event2(ACT_D,u_back);
    end
end

--▼反応:地対空
function react_g2a_condi()
    if dis<=500 and 
    y>50 and ey==0 and 
    intheairfreefall()==true and 
    enemy_act>=300 and enemy_act<400 and enemy_allframe<=5 and 
    my_airEX>=1 and 
    math.random(5)==1 then
        return true
    else
        return false
    end
end

function react_g2a_exe()
    print("反応:地対空");
    key_on(ACT_D);
    if y>=240 and my_backside<=300 then
        key_on(front);
        for i=1,40,1 do 
            yield();
        end
    elseif my_backside<=300 then
        key_on(u_front);
        yield();
        for i=1,40,1 do 
            yield();
        end
    else
        lvr44();
    end
end

--▼反応:低空飛翔
function react_lowj6d_condi()
    if dis<=500 and 
    y==0 and ey<=200 and 
    my_act<300 and not(my_act>=50 and my_act<=199) and 
    enemy_act==214 and enemy_allframe<=3 and 
    is_dir_front==true and 
    math.random(16)==1 then
        return true
    else
        return false
    end
end

function react_lowj6d_exe()
    print("反応:低空飛翔");
    --key_event2(ACT_D,u_front);
    key_event2(ACT_D,ACT_UP);
end

--▼上空追いかけ
function ueoikake_condi()
    if dis<=200 and
    y==0 and ey>=200 and
    my_act<300 and not(my_act>=50 and my_act<=199) and 
    (enemy_act==9 or enemy_act==180 or enemy_act==181 or enemy_act==214) and 
    math.random(32)==1 then
        return true
    else
        return false
    end
end

function ueoikake_exe()
    print("上空追いかけ");
    if is_dir_front==true then
        key_event2(ACT_D,ACT_UP);
    else
        key_event2(ACT_D,u_back);
    end
end

function react_reflex00()
    --▼ 霊夢:反射行動

    --神技「天覇風神脚」
        if 
        dis<150 and 
        y==0 and 
        ey+enemy_yspeed*15+(15*(14*e_gs))/2>=0 and ey+enemy_yspeed*15+(15*(14*e_gs))/2<=120 and
        my_act<=5 and 
        enemy_act>=302 and enemy_act<700 and enemy_act~=303 and 
        enemy_allframe<=15 and 
        is_dir_front and 
        card_check(214) and 
        my_spell_more(1500) and 
        math.random(32)==1 then
            --print("反射行動 -> 神技「天覇風神脚」")
            key_reset()
            card_use(214)

    --神技「八方鬼縛陣」
        elseif 
        dis<150 and 
        y==0 and 
        ey+enemy_yspeed*15+(15*(14*e_gs))/2>=0 and ey+enemy_yspeed*15+(15*(14*e_gs))/2<=120 and
        my_act<=5 and 
        enemy_act>=302 and enemy_act<700 and enemy_act~=303 and 
        enemy_allframe<=15 and 
        --is_dir_front and 
        card_check(206) and 
        my_spell_more(2000) and 
        math.random(32)==1 then
            --print("反射行動 -> 神技「八方鬼縛陣」")
            key_reset()
            card_use(206)

    --宝具「陰陽鬼神玉」
        elseif 
        dis>200 and dis<450 
        and y==0 and 
        ey+enemy_yspeed*15+(15*(14*e_gs))/2>=0 and ey+enemy_yspeed*15+(15*(14*e_gs))/2<=200 and
        my_act<=5 and 
        enemy_act>=301 and enemy_act<700 and enemy_act~=303 and 
        enemy_allframe<=15 and 
        is_dir_front and
        card_check(210) and 
        my_spell_more(2000) and 
        math.random(16)==1 then
            --print("反射行動 -> 宝具「陰陽鬼神玉」")
            key_reset()
            card_use(210)

    --夢符「封魔陣」
        elseif 
        dis<150 and 
        y==0 and 
        ey+enemy_yspeed*15+(15*(14*e_gs))/2>=0 and ey+enemy_yspeed*15+(15*(14*e_gs))/2<=120 and
        my_act<=5 and 
        enemy_act>=302 and enemy_act<700 and enemy_act~=303 and 
        enemy_allframe<=15 and 
        --is_dir_front and 
        card_check(204) and 
        my_spell_more(1000) and 
        math.random(32)==1 then
            --print("反射行動 -> 夢符「封魔陣」")
            key_reset()
            card_use(204)

    --昇天脚を狙う。無敵付加されるまでは、上空の相手のみ。無敵付加後は地上相手にも。
        elseif 
        dis<150 and 
        y==0 and	
        ey+enemy_yspeed*15+(15*(14*e_gs))/2>=0 and ey+enemy_yspeed*15+(15*(14*e_gs))/2<=180 and  
        my_act<=5 and 
        enemy_act>=300 and enemy_act<500 and 
        enemy_allframe<=5 and 
        is_dir_front and 
        card_check(103) and 
        (
            get_skill_lv(0,3)>=3 or
            weather==9
        ) and 
        math.random(1)==1 then
            --print("反射行動 -> スキルカード：昇天脚")
            key_reset()
            card_use(103)

        elseif
        dis<150 and 
        y==0 and	
        ey+enemy_yspeed*15+(15*(14*e_gs))/2>=0 and ey+enemy_yspeed*15+(15*(14*e_gs))/2<=180 and  
        my_act<=5 and 
        enemy_act>=300 and enemy_act<500 and 
        enemy_allframe<=5 and 
        is_dir_front and 
        get_skill_lv(0,3)>=0 and 
        (
            get_skill_lv(0,3)>=4 or
            weather==9
        ) and 
        math.random(16)==1 then
            --print("反射行動 -> コマンド：昇天脚")
            key_reset()
            lvr623(ACT_B)
            
        elseif
        dis<150 and 
        y==0 and	
        ey+enemy_yspeed*15+(15*(14*e_gs))/2>=100 and ey+enemy_yspeed*15+(15*(14*e_gs))/2<=180 and
        my_act<=5 and 
        enemy_act>=300 and enemy_act<500 and 
        enemy_allframe<=5 and 
        is_dir_front and 
        card_check(103) and 
        (
            get_skill_lv(0,3)<=2 or
            weather~=9
        ) and 
        math.random(1)==1 then
            --print("反射行動 -> スキルカード：昇天脚")
            key_reset()
            card_use(103)

        elseif 
        dis<150 and 
        y==0 and 
        ey+enemy_yspeed*15+(15*(14*e_gs))/2>=0 and ey+enemy_yspeed*15+(15*(14*e_gs))/2<=180 and
        my_act<=5 and 
        enemy_act>=300 and enemy_act<500 and 
        enemy_allframe<=5 and 
        is_dir_front and 
        get_skill_lv(0,3)>=0 and 
        (
            get_skill_lv(0,3)<=3 or
            weather~=9
        ) and 
        math.random(16)==1 then
            --print("反射行動 -> コマンド：昇天脚")
            key_reset()
            lvr623(ACT_B)
        end
end
    --]]

--[[▼ 妖夢:反射
--弦月斬
	elseif 
    (
        my_act<=10 or 
        my_act==200 or 
        my_act==404
    ) and 
    (
		(
		    not(enemy_char==9 and enemy_act==402) and
            enemy_act>=400 and enemy_act<=409 and enemy_act~=408
        ) or 
		(
            (enemy_char==1 or enemy_char==4 or enemy_char==13) and 
            enemy_act==408
        ) or 
		(
            enemy_char~=3 and
            enemy_act>=410 and enemy_act<=417
        ) or 
		(
            enemy_char==19 and 
            enemy_act==418
        ) or 
		(
            enemy_act>=419 and enemy_act<=499
        ) or
		(
            enemy_act>=500 and enemy_act<690 and 
			not(
                (enemy_char==  0 and ((enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=573) or enemy_act==614 or enemy_act==664)) or
                (enemy_char==  1 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=520 and enemy_act<=524) or enemy_act==605 or enemy_act==606 or enemy_act==607 or enemy_act==655 or enemy_act==656 or enemy_act==657)) or
                (enemy_char==  2 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=570 and enemy_act<=574))) or
                (enemy_char==  3 and ((enemy_act>=545 and enemy_act<=549) or enemy_act==610 or enemy_act==660)) or
                (enemy_char==  4 and ((enemy_act>=510 and enemy_act<=514) or enemy_act==602 or enemy_act==652)) or
                (enemy_char==  5 and ((enemy_act>=520 and enemy_act<=523) or (enemy_act>=540 and enemy_act<=543) or (enemy_act>=545 and enemy_act<=548) or (enemy_act>=550 and enemy_act<=553) or enemy_act==600 or enemy_act==603 or enemy_act==604 or enemy_act==612 or enemy_act==650 or enemy_act==653 or enemy_act==654 or enemy_act==662)) or
                (enemy_char==  6 and ((enemy_act>=500 and enemy_act<=514) or (enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=569) or enemy_act==602 or enemy_act==605 or enemy_act==606 or enemy_act==652 or enemy_act==655 or enemy_act==656)) or
                (enemy_char==  7 and (enemy_act>=560 and enemy_act<=574)) or 
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
	) and 
    enemy_allframe<=2 and 
    y==0 and 
    dis2<=250 and 
    my_hitstop<=2 and 
    get_skill_lv(0,1)>=0 and 
    (
        (my_rei<=200) or 
        (my_rei<=400 and battle_time%2<=1) or 
        (my_rei<=600 and battle_time%4==1) or 
        (my_rei<=800 and battle_time%8==1) or 
        (my_rei<=1000 and battle_time%16==1)
    ) then 
		print("反射行動 -> C弦月斬");
		key_resetEX();
		lvr623(ACT_C);
		yield();
		
	elseif (my_act<=10 or my_act==200) and not(
		(enemy_act>=400 and enemy_act<=409 and enemy_act~=408 and 
		not(enemy_char==9 and enemy_act==402)) or 
		((enemy_char==1 or enemy_char==4 or enemy_char==13) and enemy_act==408) or 
		(enemy_act>=410 and enemy_act<=417 and enemy_char~=3) or 
		(enemy_char==19 and enemy_act==418) or 
		(enemy_act>=419 and enemy_act<=499) or
			(enemy_act>=500 and enemy_act<690 and 
				not(	(enemy_char==  0 and ((enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=573) or enemy_act==614 or enemy_act==664)) or
							(enemy_char==  1 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=520 and enemy_act<=524) or enemy_act==605 or enemy_act==606 or enemy_act==607 or enemy_act==655 or enemy_act==656 or enemy_act==657)) or
							(enemy_char==  2 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=570 and enemy_act<=574))) or
							(enemy_char==  3 and ((enemy_act>=545 and enemy_act<=549) or enemy_act==610 or enemy_act==660)) or
							(enemy_char==  4 and ((enemy_act>=510 and enemy_act<=514) or enemy_act==602 or enemy_act==652)) or
							(enemy_char==  5 and ((enemy_act>=520 and enemy_act<=523) or (enemy_act>=540 and enemy_act<=543) or (enemy_act>=545 and enemy_act<=548) or (enemy_act>=550 and enemy_act<=553) or enemy_act==600 or enemy_act==603 or enemy_act==604 or enemy_act==612 or enemy_act==650 or enemy_act==653 or enemy_act==654 or enemy_act==662)) or
							(enemy_char==  6 and ((enemy_act>=500 and enemy_act<=514) or (enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=569) or enemy_act==602 or enemy_act==605 or enemy_act==606 or enemy_act==652 or enemy_act==655 or enemy_act==656)) or
							(enemy_char==  7 and (enemy_act>=560 and enemy_act<=574)) or 
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
	) and enemy_act>=300 and enemy_allframe<=2 and y==0 and dis2<=250 and my_hitstop<=2 and card_check(101)==true and ((my_rei<=200) or (my_rei<=400 and battle_time%2<=1) or (my_rei<=600 and battle_time%4==1) or (my_rei<=800 and battle_time%8==1) or (my_rei<=1000 and battle_time%16==1)) then 
		print("反射行動 -> 弦月斬");
		card_use(101);
		
	elseif (my_act<=10 or my_act==200) and not(
		(enemy_act>=400 and enemy_act<=409 and enemy_act~=408 and 
		not(enemy_char==9 and enemy_act==402)) or 
		((enemy_char==1 or enemy_char==4 or enemy_char==13) and enemy_act==408) or 
		(enemy_act>=410 and enemy_act<=417 and enemy_char~=3) or 
		(enemy_char==19 and enemy_act==418) or 
		(enemy_act>=419 and enemy_act<=499) or
			(enemy_act>=500 and enemy_act<690 and 
				not(	(enemy_char==  0 and ((enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=573) or enemy_act==614 or enemy_act==664)) or
							(enemy_char==  1 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=520 and enemy_act<=524) or enemy_act==605 or enemy_act==606 or enemy_act==607 or enemy_act==655 or enemy_act==656 or enemy_act==657)) or
							(enemy_char==  2 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=570 and enemy_act<=574))) or
							(enemy_char==  3 and ((enemy_act>=545 and enemy_act<=549) or enemy_act==610 or enemy_act==660)) or
							(enemy_char==  4 and ((enemy_act>=510 and enemy_act<=514) or enemy_act==602 or enemy_act==652)) or
							(enemy_char==  5 and ((enemy_act>=520 and enemy_act<=523) or (enemy_act>=540 and enemy_act<=543) or (enemy_act>=545 and enemy_act<=548) or (enemy_act>=550 and enemy_act<=553) or enemy_act==600 or enemy_act==603 or enemy_act==604 or enemy_act==612 or enemy_act==650 or enemy_act==653 or enemy_act==654 or enemy_act==662)) or
							(enemy_char==  6 and ((enemy_act>=500 and enemy_act<=514) or (enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=569) or enemy_act==602 or enemy_act==605 or enemy_act==606 or enemy_act==652 or enemy_act==655 or enemy_act==656)) or
							(enemy_char==  7 and (enemy_act>=560 and enemy_act<=574)) or 
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
	) and enemy_act>=300 and enemy_allframe<=2 and y==0 and dis2<=250 and my_hitstop<=2 and get_skill_lv(0,1)>=1 and ((my_rei<=200) or (my_rei<=400 and battle_time%2<=1) or (my_rei<=600 and battle_time%4==1) or (my_rei<=800 and battle_time%8==1) or (my_rei<=1000 and battle_time%16==1)) then 
		print("反射行動 -> B弦月斬");
		key_resetEX();
		lvr623(ACT_B);
		yield();

    --]]

--霊撃 or 霊撃札
function reigeki_condi()
    if 
    dis<=250 and
    y==0 and
    ey+enemy_yspeed*16+(16*(15*e_gs))/2<=250 and
    my_act<=10 and
    enemy_act>=300 and enemy_act<700 and enemy_allframe<=5 and
    my_hitstop<=2 and card_check(0)==true and
    (my_rei<=200 or weather2==13) and weather~=13 then 
        return true
    else
        return false
    end
end

--▼ ガード反撃、龍魚の羽衣 13
function hagoromo_1st_condi()
	if my_rei<=600 and
	dis<=300 and 
	my_act>=143 and my_act<=166 and my_frame<=11 and 
	my_hitstop<=2 and 
	card_check(13)==true and my_card~=13 then
        return true
    else
        return false
    end
end

function hagoromo_condi()
    if
    dis<=300 and
    y==0 and ey==0 and
    my_act>=150 and my_act<=157 and 
    enemy_act>=301 and enemy_act<700 and 
    enemy_act~=330 and not(enemy_char==2 and enemy_act==302) and 
    my_hitstop<=2 and
    (my_rei<=200 or weather2==13) and 
    card_check(13)==true and weather~=13 then 
        return true
    else
        return false
    end
end

function hagoromo_exe()
    if hagoromo_1st_condi()==true then
        print("龍魚の羽衣：準備");
        card_1st(13);
    elseif hagoromo_condi()==true then
        print("拒否行動：龍魚の羽衣　⇒　可能ならば使用");
        card_use(13)
    end
end



--▼ 回避結界
function kekkai_condi()
    if 
    my_act>=150 and my_act<=158 and 
    (
        (
            enemy_act>=400 and enemy_act<=409 and 
            enemy_act~=408 and 
            not(enemy_char==9 and enemy_act==402)
        ) or 
        (
            (enemy_char==1 or enemy_char==4 or enemy_char==13) and 
            enemy_act==408
        ) or 
        (
            enemy_act>=410 and enemy_act<=417 and 
            enemy_char~=3
        ) or 
        (
            enemy_char==19 and 
            enemy_act==418
        ) or 
        (
            enemy_act>=419 and enemy_act<=499
        ) or
        (
            enemy_act>=500 and enemy_act<690 and 
                not(
                    (enemy_char== 0 and ((enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=573) or enemy_act==614 or enemy_act==664)) or
                    (enemy_char== 1 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=520 and enemy_act<=524) or enemy_act==605 or enemy_act==606 or enemy_act==607 or enemy_act==655 or enemy_act==656 or enemy_act==657)) or
                    (enemy_char== 2 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=570 and enemy_act<=574))) or
                    (enemy_char== 3 and ((enemy_act>=545 and enemy_act<=549) or enemy_act==610 or enemy_act==660)) or
                    (enemy_char== 4 and ((enemy_act>=510 and enemy_act<=514) or enemy_act==602 or enemy_act==652)) or
                    (enemy_char== 5 and ((enemy_act>=520 and enemy_act<=523) or (enemy_act>=540 and enemy_act<=543) or (enemy_act>=545 and enemy_act<=548) or (enemy_act>=550 and enemy_act<=553) or enemy_act==600 or enemy_act==603 or enemy_act==604 or enemy_act==612 or enemy_act==650 or enemy_act==653 or enemy_act==654 or enemy_act==662)) or
                    (enemy_char== 6 and ((enemy_act>=500 and enemy_act<=514) or (enemy_act>=540 and enemy_act<=544) or (enemy_act>=560 and enemy_act<=569) or enemy_act==602 or enemy_act==605 or enemy_act==606 or enemy_act==652 or enemy_act==655 or enemy_act==656)) or
                    (enemy_char== 7 and (enemy_act>=560 and enemy_act<=574)) or 
                    (enemy_char== 8 and ((enemy_act>=520 and enemy_act<=524) or (enemy_act>=560 and enemy_act<=569))) or 
                    (enemy_char== 9 and ((enemy_act>=500 and enemy_act<=504) or (enemy_act>=510 and enemy_act<=514) or (enemy_act>=520 and enemy_act<=529) or enemy_act==600 or enemy_act==601 or enemy_act==602 or enemy_act==603 or enemy_act==604 or enemy_act==605 or enemy_act==612 or enemy_act==650 or enemy_act==651 or enemy_act==652 or enemy_act==653 or enemy_act==654 or enemy_act==655 or enemy_act==662)) or 
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
        )--or
        --(weather==5)
    ) and --enemy_allframe<=200 and my_hitstop<=4 and my_hitstop>=0 and 
    (my_rei<=200 or weather==0 or weather==8)
    then
        return true
    else
        return false
    end
end

function kekkai_exe()
    print("拒否行動:回避結界 -> できれば使用");
    key_reset();
    key_on(ACT_D);yield();
    key_off(ACT_D);yield();
    key_on(ACT_D);
    if y==0 then
        if (my_dir==1 and x<=100) or (my_dir==-1 and x>=1180) then
            key_on(ACT_DOWN);
        else
            key_on(d_back);
        end
    elseif y>0 then
        if (my_dir==1 and x<=100) or (my_dir==-1 and x>=1180) then
            key_on(front);
        else
            key_on(back);
        end
    end
    if my_hitstop>=1 then
        wait(my_hitstop);
    else
        yield();
    end
end


--▼ 宵越の銭 12
function yoikoshi_1st_condi()
    if my_rei>600 and
    dis<=300 and 
    my_act>=143 and my_act<=166 and my_frame<=11 and my_hitstop<=2 and 
    card_check(12)==true and my_card~=12 then
        return true
    else
        return false
    end
end

function yoikoshi_condi()
    if 
    (
        (my_rei< 100) or 
        (my_rei> 900)
    ) and
    dis<=300 and
    y==0 and
    my_card==12 and 
    get_key_stat(ACT_BC)==0 and
    (	
        (	
            state_trueguard()==true and 
            my_hitstop<=3 and my_hitstop>=2 and 
            not(x<=40 or x>=1240)
        ) or
        (--画面端の場合、ヒットバックが終わってから銭を機動しないとうまく機能しないとかなとかだったか
            state_trueguard()==true and
            state_nottrueguard()==true and 
            (x<=40 or x>=1240) 
        )
    ) 
    then
        return true
    else
        return false
    end
end

function yoikoshi_exe()
    if yoikoshi_1st_condi()==true then
        print("宵越しの銭：準備");
        card_1st(12);
    elseif yoikoshi_condi()==true then
        print("宵越しの銭：使用");
        key_on(ACT_BC);
        yield();
        key_off(ACT_BC);
    end
end


--▼汎用中下段ガード

--▼ 下段フラッグ検知時
function lowattack_aflags_condi()
    if 
    (my_act<=10 or my_act>=180 and my_act<300) and
    enemy_act>=300 and enemy_act<400 and
    dis2<=200 and 
    y<50 and
    get_special_data(0,10)<=20 and 
    get_aflags(1,32768)==true and 
    weather~=13
    then
        return true
    else
        return false
    end
end

--▼ 中段フラグ検知時
function overheadattack_aflags_condi()
    if 
    (my_act<=10 or my_act>=180 and my_act<300) and
    enemy_act>=300 and enemy_act<400 and 
    dis2<=200 and 
    y<50 and
    get_special_data(0,10)<=20 and 
    get_aflags(1,16384)==true and 
    weather~=13 
    then
        return true
    else
        return false
    end
end

function guard_backoverheadattack_exe()
    print("overhead attack -> guard on back");
    key_on(back)
end

--▼フラグで検知できる下段攻撃
function lowattack_flaged_condi()
    if 
    enemy_act>=300 and --打撃、射撃、スキル、スペル、シスカをすべてフィルタ
    dis<=500 and
    weather~=13 and --台風をフィルタ
    get_special_data(0,10)<=20 and --無念無想をフィルタ
    (
        get_fflags(1,64) or 
        get_aflags(1,8192) or 
        get_aflags(1,16384) or 
        get_aflags(1,32768)
    ) and --被ＣＨ、空中攻撃判定、中段判定、下段判定をフィルタ
    (
    (enemy_char== 0 and (enemy_act==303 or (enemy_act==304 and enemy_allframe>=20) or enemy_act==408 or enemy_act==541 or enemy_act==565 or enemy_act==566)) or
    (enemy_char== 1 and (enemy_act==303 or enemy_act==304)) or
    (enemy_char== 2 and (enemy_act==302 or enemy_act==303)) or
    (enemy_char== 3 and (enemy_act==300 or enemy_act==303 or enemy_act==305 or enemy_act==320 or enemy_act==321 or enemy_act==330 or enemy_act==418 or enemy_act==610)) or
    (enemy_char== 4 and (enemy_act==303 or enemy_act==304 or enemy_act==305)) or
    (enemy_char== 5 and (enemy_act==300 or enemy_act==303 or enemy_act==304 or enemy_act==311 or enemy_act==320 or enemy_act==322 or enemy_act==330 or enemy_act==408 or ((enemy_act==540 or enemy_act==541)and ey==0) or enemy_act==545 or enemy_act==546)) or
    (enemy_char== 6 and (enemy_act==300 or enemy_act==301 or enemy_act==303 or enemy_act==304)) or
    (enemy_char== 7 and (enemy_act==303 or enemy_act==304 or enemy_act==311)) or 
    (enemy_char== 8 and (enemy_act==301 or enemy_act==303 or enemy_act==304 or enemy_act==418 or enemy_act==565 or enemy_act==566)) or 
    (enemy_char== 9 and (enemy_act==303 or enemy_act==304 or enemy_act==311 or enemy_act==402 or enemy_act==408 or enemy_act==510 or enemy_act==511 or enemy_act==525 or enemy_act==526)) or 
    (enemy_char==10 and (enemy_act==303 or enemy_act==304 or enemy_act==311 or enemy_act==408)) or
    (enemy_char==11 and (enemy_act==303 or enemy_act==304 or enemy_act==311)) or 
    (enemy_char==12 and (enemy_act==302 or enemy_act==303 or enemy_act==408)) or 
    (enemy_char==13 and (enemy_act==303 or enemy_act==304)) or 
    (enemy_char==14 and (enemy_act==303 or enemy_act==320 or enemy_act==322 or enemy_act==408 or enemy_act==505 or enemy_act==560 or enemy_act==561)) or 
    (enemy_char==15 and (enemy_act==301 or enemy_act==303 or enemy_act==304)) or 
    (enemy_char==16 and (enemy_act==303 or enemy_act==304 or enemy_act==418)) or 
    (enemy_char==17 and (enemy_act==303 or enemy_act==304 or enemy_act==418 or enemy_act==540 or enemy_act==541)) or 
    (enemy_char==18 and (enemy_act==302 or enemy_act==303 or enemy_act==321 or enemy_act==510 or enemy_act==511)) or 
    (enemy_char==19 and (enemy_act==300 or enemy_act==301 or enemy_act==303 or enemy_act==309 or enemy_act==320 or enemy_act==330))
    )
    then
        return true
    else
        return false
    end
end

--▼フラグで検知できない中段攻撃
--主にobjで攻撃するアリス対策

--▼フラグで検知できない下段攻撃
function lowattack_unflaged_condi()
    if dis<=500 and 
    get_special_data(0,10)<=20 and 
    (
    (enemy_char== 0 and ((enemy_act==300 and enemy_frame<=9) or (enemy_act==320 and enemy_frame<=8) or (enemy_act==330 and enemy_frame<=9))) or
    (enemy_char== 1 and ((enemy_act==300 and enemy_frame<=8) or (enemy_act==320 and enemy_frame<=8) or (enemy_act==330 and enemy_frame<=8))) or
    (enemy_char== 2 and ((enemy_act==300 and enemy_frame<=9) or (enemy_act==320 and enemy_frame<=8) or (enemy_act==330 and enemy_frame<=9))) or
    (enemy_char== 3 and ((enemy_act==300 and enemy_frame<=11) or (enemy_act==320 and enemy_frame<=10) or (enemy_act==330 and enemy_frame<=11))) or
    (enemy_char== 5 and ((enemy_act==300 and enemy_frame<=9) or (enemy_act==303 and enemy_frame<=10) or (enemy_act==320 and enemy_frame<=9) or (enemy_act==330 and enemy_frame<=9))) or
    (enemy_char== 6 and ((enemy_act==300 and enemy_frame<=9) or (enemy_act==320 and enemy_frame<=9) or (enemy_act==330 and enemy_frame<=9))) or
    (enemy_char== 8 and ((enemy_act==300 and enemy_frame<=11) or (enemy_act==303 and enemy_frame<=10) or (enemy_act==320 and enemy_frame<=11) or (enemy_act==330 and enemy_frame<=11))) or
    (enemy_char==10 and ((enemy_act==300 and enemy_frame<=8) or (enemy_act==303 and enemy_frame<=8) or (enemy_act==320 and enemy_frame<=8) or (enemy_act==330 and enemy_frame<=8))) or
    (enemy_char==11 and ((enemy_act==300 and enemy_frame<=8) or (enemy_act==303 and enemy_frame<=9) or (enemy_act==320 and enemy_frame<=9) or (enemy_act==330 and enemy_frame<=8))) or
    (enemy_char==12 and ((enemy_act==303 and enemy_frame<=10) or (enemy_act==305 and enemy_frame<=15))) or
    (enemy_char==13 and ((enemy_act==320 and enemy_frame<=12))) or
    (enemy_char==15 and ((enemy_act==300 and enemy_frame<=8) or (enemy_act==303 and enemy_frame<=8) or (enemy_act==330 and enemy_frame<=8))) or
    (enemy_char==16 and ((enemy_act==300 and enemy_frame<=7) or (enemy_act==303 and enemy_frame<=6) or (enemy_act==320 and enemy_frame<=7) or (enemy_act==330 and enemy_frame<=7))) or
    (enemy_char==17 and ((enemy_act==300 and enemy_frame<=7) or (enemy_act==303 and enemy_frame<=8) or (enemy_act==320 and enemy_frame<=7) or (enemy_act==330 and enemy_frame<=7))) or
    (enemy_char==19 and ((enemy_act==300 and enemy_frame<=8) or (enemy_act==302 and enemy_allframe<=14) or (enemy_act==320 and enemy_frame<=9) or (enemy_act==330 and enemy_frame<=8)))
    ) and weather~=13 then
        return true
    else
        return false
    end
end

--▼屈状態では低空昇り攻撃には立てない
function notstand_overhead_upjump_condi()
    if air_math<30 and 
    (my_act==2 or 
    (my_act>=62 and my_act<=65) or
    (my_act>=154 and my_act<=157) or
    (my_act>=163 and my_act<=166)
    ) and enemy_act>=300 and ey>0 and ey<80 then
        return true
    else
        return false
    end
end

--▼以下、何もフィルタされなかった場合、立ちガード
--ガードに必須の条件をパックしたもの
--上記の下段攻撃等で、予め入力される条件をフィルタしておけば、立ちガードの条件として成立させることができる
function guard_pun_condi()
    if 
    enemy_act>=300 and 
    dis2<=250 and
    ((x<ex and enemy_dir==-1) or (ex<x and enemy_dir==1)) and
    get_special_data(0,10)<=20 and --無念無想をフィルタ
    weather~=13 and
    (
        get_fflags(1,64) or 
        get_aflags(1,8192) or 
        get_aflags(1,16384) or 
        get_aflags(1,32768)
    ) 
    then
        return true
    else
        return false
    end
end

--▼自己状態依存型ガード
--汎用中下段ガードは相手の状態を見てガードするもの
--これはガードした結果から次のガードを決定するレバー入れ込み
--立ち⇒立ち
--[[
地上ガードクラッシュ	143	全体:50F
空中ガードクラッシュ	145	受身不可
立ちガード硬直:微	150	全体:10F
立ちガード硬直:小	151	全体:16F
立ちガード硬直:中	152	全体:22F
立ちガード硬直:大	153	全体:28F
しゃがみガード硬直:微	154	全体:10F
しゃがみガード硬直:小	155	全体:16F
しゃがみガード硬直:中	156	全体:22F
しゃがみガード硬直:大	157	全体:28F
空中ガード	158	全体:20F
立ちガード硬直(誤):微	159	全体:12F
立ちガード硬直(誤):小	160	全体:20F
立ちガード硬直(誤):中	161	全体:28F
立ちガード硬直(誤):大	162	全体:32F
しゃがみガード硬直(誤):微	163	全体:12F
しゃがみガード硬直(誤):小	164	全体:20F
しゃがみガード硬直(誤):中	165	全体:28F
しゃがみガード硬直(誤):大	166	全体:32F
--]]
g2g_flag = 0
function guard_2_guard_delay_condi()
    if 
    my_act>=143 and my_act<=166 and
    my_frame<=1 and my_act_block==0
    then
        if g2g_flag==0 then
            g2g_flag = 1
            return true
        else
            g2g_flag = 0
            return false
        end
    end
end

function guard_2_guard_delay_exe()
    print("gurad 2 gurad delay")
    if 
    (
        my_act==150 or --立ちガード正
        my_act==151 or
        my_act==152 or
        my_act==153 
    ) and
    my_frame<=1 and my_act_block==0 then
        key_on(backEX())
        if math.random(2)==1 then
            key_on(ACT_DOWN)
        end
        local i = math.random(5)
        wait(7*i)
    end
    
    if 
    (
        my_act==154 or --屈ガード正
        my_act==155 or
        my_act==156 or
        my_act==157 
    ) and
    my_frame<=1 and my_act_block==0 then
        key_on(backEX())
        if math.random(2)==1 then
            key_on(ACT_DOWN)
        end
        local i = math.random(5)
        wait(7*i)
    end
    
    if 
    (
        my_act==159 or --立ちガード誤
        my_act==160 or
        my_act==161 or
        my_act==162 
    ) and
    my_frame<=1 and my_act_block==0 then
        key_on(backEX())
        if math.random(2)==1 then
            key_on(ACT_DOWN)
        end
        local i = math.random(5)
        wait(7*i)
    end
    
    if 
    (
        my_act==163 or --屈ガード誤
        my_act==164 or
        my_act==165 or
        my_act==166 
    ) and
    my_frame<=1 and my_act_block==0 then
        key_on(backEX())
        if math.random(2)==1 then
            key_on(ACT_DOWN)
        end
        local i = math.random(5)
        wait(7*i)
    end
    
    if 
    (
        my_act==143 --クラッシュ
    ) and
    my_frame<=1 and my_act_block==0 then
        local i = math.random(5)
        wait(7*i)
    end
end

--▼ 
function guard_on_5050_exe()
    print("振動ガード");
    
    if battle_time%2==1 then
        key_on(backEX())
        if math.random(64)==1 then
            key_on(ACT_DOWN)
        end
    else
        key_on(backEX())
        key_on(ACT_DOWN)
        if math.random(64)==1 then
            key_off(ACT_DOWN)
        end
    end
end


    
--▼ オブジェが至近距離の場合、着地直前にｈｊを仕込む、タッチ＆ゴーで継続グレイズ
function touchandgo_00_condi()
    if 
    y>0 and 
    my_act==214 and 
    y+my_yspeed*6<=0 and 
    enemy_obj_range_in(150,20)==true and
    (
        dis2>=350 or 
        weather==5 or 
        enemy_act>=600
    ) and 
    my_rei>=10 then
        return true
    else
        return false
    end
end

--▼ 00 exe
function touchandgo_00_exe()
    print("obj至近距離:着地直前 -> グレイズ「タッチ＆ゴー」");
    yield();
    key_on(ACT_DOWN);
    wait(1);
    key_on(u_front);
    wait(1)
    key_off(u_front);
    while (y>0 and my_yspeed<=0) do
        yield();
    end
end

--▼オブジェが至近距離の場合、ガードの前に、離陸
function touchandgo_01_condi()
    if 
    y==0 and 
    my_act==200 and 
    enemy_obj_range_in(150,20)==true and
    (
        dis2>=350 or 
        weather==5 or 
        enemy_act>=600
    ) and 
    my_rei>=10 then
        return true
    else
        return false
    end
end

--▼ 01 exe
function touchandgo_01_exe()
    print("obj至近距離:地上:ダッシュ -> ダッシュ＆テイクオフ");
    key_event(ACT_DOWN);
    key_event(ACT_UP);
end

--▼ 02 condi
function touchandgo_02_condi()
    if 
    y==0 and 
    my_act==204 and 
    my_allframe>=15 and 
    my_allframe<=16 and 
    enemy_obj_range_in(150,20)==true and --キャラごとに硬直が違う点に注意。問題がでたら修正すること。
    (
        dis2>=350 or 
        weather==5 or 
        enemy_act>=600
    ) and 
    my_rei>=10 then
        return true
    else
        return false
    end
end

--▼ 02 exe
function touchandgo_02_exe()
    print("obj至近距離:地上:ブレーキ -> ダッシュ＆テイクオフ");
    key_event2(ACT_D,ACT_UP);
end

--▼オブジェが至近距離の場合、空中から地上へ飛翔 ※咲夜:２D:120.0以上、３D:84.9以上必要
function graze_pun_condi()
    if 
    y>0 and  
    not(my_act>=6 and my_act<=8 and y<100 and my_yspeed>=0) and 
    not(my_act>=208 and my_act<=212 and y<100 and my_yspeed>=0) and 
    not(my_act>=50 and my_act<143) and
    state_nottrueguard()==true and
    enemy_obj_range_in(150,20)==true and
    my_air<=0 and
    (
        dis2>=350 or 
        (weather==5) or 
        enemy_act>=600
    ) and 
    my_rei>=10 
    then
        return true
    else
        return false
    end
end

--▼
function graze_pun_exe()
    key_on(ACT_D);
    --▼90型:パ幽
    if my_char==4 or my_char==7 then
        if y>90.0 then
            print("obj至近距離:空中 y>90.0 -> ２飛翔");
            key_on(ACT_DOWN);
        elseif y>63.7 then
            print("obj至近距離:空中 y>63.7 -> ３飛翔");
            key_on(d_back);
        else
            print("obj至近距離:空中 y<=63.7 -> J44");
            yield();
            lvr66();
        end
    
    --▼100型:霊紫衣
    elseif my_char==0 or my_char==8 or my_char==13 then
        if y>100.0 then
            print("obj至近距離:空中 y>100.0 -> ２飛翔");
            key_on(ACT_DOWN);
        elseif y>70.8 then
            print("obj至近距離:空中 y>70.8 -> ３飛翔");
            key_on(d_back);
        else
            print("obj至近距離:空中 y<=70.8 -> J44");
            yield();
            lvr66();
        end
    
    --▼103.5型:萃う
    elseif my_char==9 or my_char==10 then
        if y>103.5 then
            print("obj至近距離:空中 y>103.5 -> ２飛翔");
            key_on(ACT_DOWN);
        elseif y>73.2 then
            print("obj至近距離:空中 y>73.2 -> ３飛翔");
            key_on(d_back);
        else
            print("obj至近距離:空中 y<=73.2 -> J44");
            yield();
            lvr66();
        end
    
    --▼120型:魔咲ア文死天チ紅空
    elseif my_char==1 or my_char==2 or my_char==3 or my_char==11 or my_char==12 or my_char==14 or my_char==16 or my_char==17 or my_char==18 then
        if y>120.0 then
            print("obj至近距離:空中 y>120.0 -> ２飛翔");
            key_on(ACT_DOWN);
        elseif y>84.9 then
            print("obj至近距離:空中 y>84.9 -> ３飛翔");
            key_on(d_back);
        else
            print("obj至近距離:空中 y<=84.9 -> J44");
            yield();
            lvr66();
        end
    
    --▼130.5型:妖夢のみ
    elseif my_char==5 then
        if y>130.5 then
            print("obj至近距離:空中 y>130.5 -> ２飛翔");
            key_on(ACT_DOWN);
        elseif y>92.28 then
            print("obj至近距離:空中 y>92.28 -> ３飛翔");
            key_on(d_back);
        else
            print("obj至近距離:空中 y<=92.28 -> J44");
            yield();
            lvr66();
        end
    
    --▼レミリア型:レミリアのみ
    elseif my_char==6 then
        if y>444.0 then
            print("obj至近距離:空中 y>444.0 -> ２飛翔");
            key_on(ACT_DOWN);
        elseif y>335.1 then
            print("obj至近距離:空中 y>335.1 -> ３飛翔");
            key_on(d_back);
        else
            print("obj至近距離:空中 y<=335.1 -> J44");
            yield();
            lvr66();
        end
    
    --▼早苗型:早苗のみ
    elseif my_char==15 then
        if y>120.0 then
            print("obj至近距離:空中 y>120.0 -> ２飛翔");
            key_on(ACT_DOWN);
        elseif y>63.7 then
            print("obj至近距離:空中 y>63.7 -> ３飛翔");
            key_on(d_back);
        else
            print("obj至近距離:空中 y<=63.7 -> J44");
            yield();
            lvr66();
        end
    
    --▼諏訪子型:諏訪子のみ
    elseif my_char==19 then
        if y>120.0 then
            print("obj至近距離:空中 y>120.0 -> ２飛翔");
            key_on(ACT_DOWN);
        elseif y>63.7 then
            print("obj至近距離:空中 y>63.7 -> ３飛翔");
            key_on(d_back);
        else
            print("obj至近距離:空中 y<=63.7 -> J44");
            yield();
            lvr66();
        end

    end
end
    

--▼グレイズ、遠距離、地上
function graze_farground_condi()
    if 
    y==0 and 
    enemy_obj_range_in(150,20)==true and 
    dis2>=350 and 
    not(my_act>=150 and my_act<=165) and 
    my_rei>=10 
    then
        return true
    else
        return false
    end
end

--▼
function graze_farground_exe()
    print("オブジェ:至近距離 & 相手:遠い -> グレイズ");
    if math.random(2)==1 then
        key_event2(ACT_D,front)
    elseif math.random(3)<=2 then
        key_event2(ACT_D,u_front)
    else
        key_event2(ACT_D,ACT_UP)
    end
end

--▼グレイズ、遠距離、空中
function graze_farair_condi()
    if 
    y>0 and 
    enemy_obj_range_in(150,20)==true and 
    dis2>=350 and 
    not(my_act>=150 and my_act<=165) and 
    my_air<=0 and 
    my_rei>=10 
    then
        return true
    else
        return false
    end
end

--▼
function graze_farair_exe()
    print("オブジェ:至近距離 & 相手:遠い > グレイズ")
    if my_char==6 then
        if math.random(4)==1 then
            key_event2(ACT_D,ACT_DOWN)
        elseif math.random(4)==2 then
            key_event2(ACT_D,d_front)
        elseif math.random(4)==3 then
            key_event2(ACT_D,front)
        else
            lvr66()
        end
    else
        if math.random(3)==1 then
            key_event2(ACT_D,ACT_DOWN)
        elseif math.random(3)==2 then
            key_event2(ACT_D,d_front)
        else
            key_event2(ACT_D,front)
        end
    end
end

--▼ 特定状況におけるガード
function guard_objgimmick_condi()
    if
    --常置陣
    --マジカル産廃利用ボム
    --魔廃「ディープエコロジカルボム」
    --Ｃ射系人形
    --人形伏兵（優先度は低いがメタが強力
    --大江戸からくり人形
    --人形置操
    --人形振起（始動モーションと合わせて管理
    (enemy_char== 0 and caution_state_obj(817,196,150,100,40-30,420+5)>=1 ) or --常置陣（B:30F, C:40F）
    (enemy_char== 2 and caution_state_obj(850,196,150,150,90-30,90+5)>=1 ) or --幻符「殺人ドール」
    (enemy_char== 6 and caution_state_obj(815,212,50,50,60-30,60+5)>=1 ) or --サーヴァントフライヤー
    (enemy_char== 7 and caution_state_obj(812,172,150,150,90-30,90+5)>=1 ) or --スフィアブルーム
    (enemy_char==13 and caution_state_obj(817,272,200,1200,0,45)>=1 and caution_state_obj(817,168,200,1200,0,45)>=1) --竜神の怒り
    then
        return true
    else
        return false
    end
end

--▼オブジェが至近距離の場合、ガード:射撃と打撃を重ねられると、しゃがみガードしてしまう。優先順位の変更が必要
--下のものは少なくともそういうものじゃないが…
function guard_objclosedis_condi()
    if
    (
        enemy_obj_range_in(100,10)==true or 
        (
            enemy_char==13 and
            caution_state_obj(817,272,200,1200,44,49)>=1 and 
            caution_state_obj(817,168,200,1200,44,49)>=1
        )
    ) and 
    weather~=13 and 
    get_special_data(0,10)<=20 then
        return true
    else
        return false
    end
end

--▼ 射撃オブジェクトガード用後退。下段が来た時はしゃがむ。
function guard_backexpectlowattack_exe()
    print("attack obj within close distance -> back on guard expect for lowattack")
    --下段を検出したらしゃがむ。相手が遠い場合もしゃがむ。
        --あとで中段には立ちガードする条件を付与すること(2022/7/6)
    if
    lowattack_aflags_condi()==true or
    lowattack_flaged_condi()==true or
    lowattack_unflaged_condi()==true or
    notstand_overhead_upjump_condi()==true
    then
        key_on(ACT_DOWN)
    end
    key_on(back)
end

--▼ 起き上がり直後の行動
function move_soonaftergetup_condi()
    if 
    enemy_act<300 and my_allframe<=5 and
    (
        (my_preact[1]==197 or my_preact[1]==198 or my_preact[1]==199) or
        (my_preact[2]==197 or my_preact[2]==198 or my_preact[2]==199) 
    ) and math.random(1)==1 
    then
        return true
    else
        return false
    end
end

function move_soonaftergetup_exe()
    print("起き上がり直後の行動");
    key_on(back)
end

--▼ 運動 機動

--中距離以上からの８ｈｊ
function move_8hjattakeovermidrange_condi()
    if 
    my_rfunc>0.65 and 
    dis>=(140+11*8)*2 and
    y==0 and 
    my_act<=10 and 
    is_dir_front==true and 
    subs_count>=530 and 
    nega_count ~= 1 and 
    math.random(24)==1 
    then
        return true
    else
        return false
    end
end

--中距離からのダッシュ
function move_6dattakeovermidrange_condi()
    if 
    my_rfunc>0.65 and 
    dis<=(140+11*8)*2 and 
    dis>140+11*8 and 
    y==0 and 
    my_act<=10 and 
    enemy_char~=3 and --アリス相手だと的になるから除外
    is_dir_front==true and 
    subs_count>=530 and 
    nega_count ~= 1 and 
    math.random(24)==1 
    then
        return true
    else
        return false
    end
end

--低空飛翔で接近
function move_approachbylowflaying_condi()
    if 
    my_rfunc>0.65 and 
    dis<=(140+11*8)*2 and 
    dis>140+11*8 and 
    y==0 and 
    ey==0 and 
    my_act<300 and not(my_act>=50 and my_act<=199) and 
    enemy_act<300 and not(enemy_act>=6 and enemy_act<=219) and 
    enemy_char~=3 and 
    subs_count>=530 and 
    nega_count ~= 1 and 
    math.random(24)==1 
    then
        return true
    else
        return false
    end
end

function move_approachbylowflaying_exe()
    print("低空飛翔で接近",dis);
    key_event2(ACT_D,ACT_UP);
    wait(8);
    if enemy_act<300 and not(enemy_act>=6 and enemy_act<=219) then
        key_event2(ACT_D,front);
    end
end

--８８３飛翔
function move_approachby883d_condi()
    if 
    y==0 and 
    ey==0 and 
    dis<=300 and 
    dis>=200-50 and 
    my_act<300 and not(my_act>=50 and my_act<=199) and 
    enemy_act<300 and not(enemy_act>=6 and enemy_act<=219) and 
    subs_count>=530 and 
    nega_count ~= 1 and 
    math.random(24)==1 
    then
        return true
    else
        return false
    end
end

function move_approachby883d_exe()
    print("８８３飛翔",dis)
    key_event2(ACT_D,ACT_UP)
    wait(8)
    if enemy_act<300 and not(enemy_act>=6 and enemy_act<=219) then
        key_event2(ACT_D,ACT_UP);
        wait(16)
        if enemy_act<300 and not(enemy_act>=6 and enemy_act<=219) then
            key_event2(ACT_D,d_front)
        else
            key_event2(ACT_D,d_back)
        end
    end
end

--▼ 相手上空へ飛び上がった際の処理
--元は画面端で壁背で上を取った場合の対処でこねくり回したやつだったはず
function move_attakeoverhead_condi()
    --print("move_attakeoverhead_condi",dis)
    if 
    y>=200 and 
    not(my_act>=50 and my_act<=200) and 
    (
        my_air<=1 or 
        (my_air<=2 and weather==10)
    )
    then
        return true
    else
        return false
    end
end

function move_attakeoverhead_exe()
    --print("move_attakeoverhead_exe",dis)
    key_resetEX()
    yield()
    if move_termination1_condi()==false then
        if dis>=960 then
            key_on(ACT_D)
            key_on(frontEX())
            wait(15)
        elseif math.random(2)==1 then
            key_on(ACT_D)
            key_on(frontEX())
            key_on(ACT_DOWN)
            wait(15)
        elseif math.random(3)==1 then
            key_on(ACT_D)
            key_on(ACT_DOWN)
            wait(15)
        end
    else
        if dis>=960 then
            key_on(ACT_D)
            key_on(frontEX())
            wait(15)
        elseif math.random(2)==1 then
            key_on(ACT_D)
            key_on(frontEX())
            key_on(ACT_DOWN)
            wait(15)
        elseif math.random(3)==1 then
            key_on(ACT_D)
            key_on(ACT_DOWN)
            wait(15)
        end
    end
end


--
--▼ 終端機動:台風かつ近接時
function move_terminationtaihu_condi()
    if
    weather==13 and 
    dis<300 
    then
        return true
    else
        return false
    end
end

--▼ 対台風時:逃げ　⇒　基本後退。近すぎる場合、７ＨＪ。画面端を背にしているなら８ＨＪ。一定以上なら飛び越える。ＨＪ後、相手がすぐに追ってきたら、即座に２飛翔。
function move_terminationtaihu_exe()
    --レミでなく、割と低空で、相手よりも高く、ｈｊで、相手もｈｊで、飛翔等未使用で、ほぼ壁背の場合 -> ２飛翔で着地する
        if 
        my_char~=6 and 
        y<=200 and 
        y>ey and 
        my_act>=208 and my_act<=212 and 
        enemy_act>=208 and enemy_act<=212 and 
        my_air==0 and 
        (
            (my_dir==1 and x<=300 and x<=ex) or 
            (my_dir==-1 and x>=980 and ex<=x)
        )
        then
            print("台風時：相手ＨＪ確認　⇒　切り替えし飛翔");
            key_event2(ACT_D,ACT_DOWN)

    --台風で、至近距離で、相手より150以上上空かつ相手が昇りか、相手より150以上下かつ相手が下りか、Δy200以上かつ攻撃の時で、飛翔等未使用で、壁背の場合 -> 高度に関わらず６Ｄ
        elseif 
        (
            (y>=ey+150 and enemy_yspeed<=0) or 
            (y<=ey-150 and enemy_yspeed>=0) or 
            (dis_y>=200 and enemy_act>=300)
        ) and 
        my_air==0 and 
        (
            (my_dir==1 and x<=300 and x<=ex) or 
            (my_dir==-1 and x>=980 and ex<=x)
        )
        then
            print("台風時：画面端　⇒　飛び越し or 潜り抜け");
            key_event2(ACT_D,front)

    --台風で、至近距離で、自分が地上で、壁背の場合 -> ８ＨＪ
        elseif 
        y==0 and 
        (
            (my_dir==1 and x<=300 and x<=ex) or 
            (my_dir==-1 and x>=980 and ex<=x)
        )
        then
            print("台風時：画面端に追い詰められた　⇒　8HJ");
            key_event2(ACT_D,ACT_UP)

    --レミでなく、空中で、飛翔等未使用で、画面端の場合 -> j44
        elseif 
        my_char~=6 and 
        y>0 and 
        my_air==0 and 
        (
            (my_dir==1 and x<=300 and x<=ex) or 
            (my_dir==-1 and x>=980 and ex<=x)
        ) 
        then
            print("台風時：空中接近　⇒　7HJ");
            lvr44()

    --GvA
    --端気味以外
        elseif 
        y==0 and 
        ey>200 and
        not(
            (my_dir==1 and x<=400 and x<=ex) or 
            (my_dir==-1 and x>=880 and ex<=x)
        ) 
        then
            print("終端-台風:画面端が遠いなら7hj")
            key_event2(ACT_D,u_back)
            wait(5)

    --端気味
        elseif 
        y==0 and 
        ey>200 and
        (
            (my_dir==1 and x<=400 and x<=ex) or 
            (my_dir==-1 and x>=880 and ex<=x)
        ) 
        then
            print("終端-台風:画面端が近いなら8hj")
            key_on(frontEX())
            wait(5)

        
    --GvG
    --端気味以外、7hj
        elseif 
        y==0 and 
        ey<150 and
        not(
            (my_dir==1 and x<=400 and x<=ex) or 
            (my_dir==-1 and x>=880 and ex<=x)
        ) 
        then
            print("終端-台風:GvG-L -> 7hj")
            key_event2(ACT_D,u_back)
            wait(5)

    --端気味、8hj
        elseif 
        y==0 and 
        ey<150 and
        (
            (my_dir==1 and x<=400 and x<=ex) or 
            (my_dir==-1 and x>=880 and ex<=x)
        ) 
        then
            print("終端-台風:GvG-S -> 8hj")
            key_event2(ACT_D,ACT_UP)
            wait(5)

    --else
    --台風は基本後ろ入れ込み
        else
            print("終端-台風:基本後退入れ込み")
            key_on(backEX())
            wait(5)
        end

end


--▼ 通常時:
function move_termination1_condi()
    if 
    y>=0 and 
    dis<=240 and 
    my_air==0 and 
    (
        (y>=ey+200 and enemy_yspeed<=0) or 
        (y<=ey-200 and enemy_yspeed>=0) or 
        (dis_y>=200 and enemy_act>=300)
    ) and 
    (
        (my_dir==1 and x<=240 and x<=ex) or 
        (my_dir==-1 and x>=1040 and ex<=x)
    ) then
        return true
    else
        return false
    end
end


function move_termination1_exe()
    print("画面端＆高度差あり　⇒　前方へ脱出")
    key_on(ACT_D)
    key_on(frontEX())
    wait(28)
end
--]]


--▼ 終端機動２
--ただ動く事で自律性を錯覚させる事が目的の機動。静止やラインの設定に大きな根拠はない。
--霊力が一定の評価を下回った場合、実行しない。
function move_termination2_condi()
    if 
    not(enemy_act>=50 and enemy_act<180) and 
    y==0 and 
    my_rfunc>0.65 and 
    subs_count>=530 and 
    nega_count ~= 1 
    then
        return true
    else
        return false
    end
end


function move_termination2_exe()
    --ランダムで静止する
    if my_act~=0 and my_act~=2 and enemy_act<=10 and math.random(128)==1 then
        --print(1)
        for i = 0,60,1 do
            yield()
            if enemy_act>10 then break end
        end

    --ライン移動
    --ダッシュ等のコマンドフラグ成立時は実行しない事で、ダッシュ等の誤爆を抑止する構造としている。
    --時間経過により周期的にラインが変化する。
    elseif dis>400 + math.floor((math.sin(math.rad(4)*battle_time))*300) and enemy_frontside>480 and x<ex and flag_my_cmd656_65==0 and flag_my_cmd454_45==0 and flag_my_cmd252_25==0 and flag_my_cmdd5d_d5==0 then
            key_on(ACT_RIGHT)

    elseif dis>400 + math.floor((math.sin(math.rad(4)*battle_time))*300) and enemy_frontside>480 and ex<x and flag_my_cmd656_65==0 and flag_my_cmd454_45==0 and flag_my_cmd252_25==0 and flag_my_cmdd5d_d5==0 then
            key_on(ACT_LEFT)

    elseif dis<350 + math.floor((math.sin(math.rad(4)*battle_time))*300) and enemy_frontside>480 and x<ex and flag_my_cmd656_65==0 and flag_my_cmd454_45==0 and flag_my_cmd252_25==0 and flag_my_cmdd5d_d5==0 then
            key_on(ACT_LEFT)

    elseif dis<350 + math.floor((math.sin(math.rad(4)*battle_time))*300) and enemy_frontside>480 and ex<x and flag_my_cmd656_65==0 and flag_my_cmd454_45==0 and flag_my_cmd252_25==0 and flag_my_cmdd5d_d5==0 then
            key_on(ACT_RIGHT)
    
    
    elseif enemy_dir==1 then --相手が右向きの場合
        --print(2)
        if air_math>20 and
        (
            (my_act==2) or 
            (my_act>=62 and my_act<=65) or
            (my_act==143 and my_frame>=4 and my_act_block==2 and math.random(2)==1) or 
            (my_act>=154 and my_act<=157) or
            (my_act>=163 and my_act<=166) 
        )
        then
            --print(3)
            key_on(ACT_RIGHT)

        elseif 	
        (
            (my_act==2) or 
            (my_act>=62 and my_act<=65) or
            (my_act==143 and my_frame>=4 and my_act_block==2 and math.random(2)==1) or 
            (my_act>=154 and my_act<=157) or
            (my_act>=163 and my_act<=166) 
        )
        then
            key_on(ACT_DOWN)
            key_on(ACT_RIGHT)

        else
            key_on(ACT_RIGHT)
        end

    else --相手が左向きの場合
        --print(3)

        if air_math>20 and
        (
            (my_act==2) or 
            (my_act>=62 and my_act<=65) or
            (my_act==143 and my_frame>=4 and my_act_block==2 and math.random(2)==1) or 
            (my_act>=154 and my_act<=157) or
            (my_act>=163 and my_act<=166) 
        )
        then
            key_on(ACT_LEFT)


        elseif	
        (
            enemy_dir==2 or 
            (my_act>=62 and my_act<=65) or
            (my_act==143 and my_frame>=4 and my_act_block==2 and math.random(2)==1) or 
            (my_act>=154 and my_act<=157) or
            (my_act>=163 and my_act<=166) 
        )
        then
            key_on(ACT_DOWN)
            key_on(ACT_LEFT)
            
        else
            key_on(ACT_LEFT)
        end

    end
end
