---@diagnostic disable: undefined-global
--■key_count_calc関数■
--2014.07.10 一応完成
--これは何？：相手のコマンド入力を認識させるための関数です。キー入力をカウントし、フラグ管理する事で２０フレーム以内に成立するコマンドのフラグを返します。
--なぜ作った？：相手の入力を見て、AIを動かすためです。よく妄言として言われる「COMはコマンドを見てから反応する」云々ですが、本当に見える場合はもっと悲惨であることを示したく、作りました。
--どう使うの？：コマンドの入力具合やガードの方向、回避結界、キーの連打などのタイミングを計り、AIに指示を与えてください。モーションを見てから動かすよりも早く動けるはずです。その代わり、確実性は低下しますが。
--ネタが割れたら意味ないのでは？：使い道は色々ですが、わざわざこれの対策として入力を欺瞞する行為と、それにより起こるプレイングのパフォーマンス低下を天秤にかけた場合、どちらを取るのかは純粋に興味がありますね。

--実装方法：このファイルを読み込ませて、関数をマイクロスレッドに記述して使用します。
--機能：各キー（同時入力含む）のONカウントとOFFカウント、およびコマンドの成立状況と各状況でのカウントを返します。

get_key_map2(0)
while get_key_map2(0)==nil do
get_key_map2(0)
end

get_key_map2(1)
while get_key_map2(1)==nil do
get_key_map2(1)
end

--キー入力周りのカウント変数のグローバル変数宣言my
my_keymap2_up = 0
my_keymap2_down = 0
my_keymap2_left = 0
my_keymap2_right = 0
my_keymap2_a = 0
my_keymap2_b = 0
my_keymap2_c = 0
my_keymap2_d = 0
my_keymap2_ab = 0
my_keymap2_bc = 0
my_keymap2_uleft = 0
my_keymap2_uright = 0
my_keymap2_dleft = 0
my_keymap2_dright = 0

my_keyon_up_count = 0
my_keyon_down_count = 0
my_keyon_left_count = 0
my_keyon_right_count = 0
my_keyon_a_count = 0
my_keyon_b_count = 0
my_keyon_c_count = 0
my_keyon_d_count = 0
my_keyon_ab_count = 0
my_keyon_bc_count = 0
my_keyon_uleft_count = 0
my_keyon_uright_count = 0
my_keyon_dleft_count = 0
my_keyon_dright_count = 0
my_keyon_neutral_count = 0

my_keyoff_up_count = 0
my_keyoff_down_count = 0
my_keyoff_left_count = 0
my_keyoff_right_count = 0
my_keyoff_a_count = 0
my_keyoff_b_count = 0
my_keyoff_c_count = 0
my_keyoff_d_count = 0
my_keyoff_ab_count = 0
my_keyoff_bc_count = 0
my_keyoff_uleft_count = 0
my_keyoff_uright_count = 0
my_keyoff_dleft_count = 0
my_keyoff_dright_count = 0
my_keyoff_neutral_count = 0

my_keystat_up = 0
my_keystat_down = 0
my_keystat_left = 0
my_keystat_right = 0
my_keystat_a = 0
my_keystat_b = 0
my_keystat_c = 0
my_keystat_d = 0
my_keystat_ab = 0
my_keystat_bc = 0
my_keystat_uleft = 0
my_keystat_uright = 0
my_keystat_dleft = 0
my_keystat_dright = 0
my_keystat_neutral = 0

pre_my_keystat_up = 0
pre_my_keystat_down = 0
pre_my_keystat_left = 0
pre_my_keystat_right = 0
pre_my_keystat_a = 0
pre_my_keystat_b = 0
pre_my_keystat_c = 0
pre_my_keystat_d = 0
pre_my_keystat_ab = 0
pre_my_keystat_bc = 0
pre_my_keystat_uleft = 0
pre_my_keystat_uright = 0
pre_my_keystat_dleft = 0
pre_my_keystat_dright = 0
pre_my_keystat_neutral = 0

flag_my_cmd236_2 = 0
flag_my_cmd236_23 = 0
flag_my_cmd236_236 = 0
flag_my_cmd236_236b = 0
flag_my_cmd236_236c = 0

flag_my_cmd214_2 = 0
flag_my_cmd214_21 = 0
flag_my_cmd214_214 = 0
flag_my_cmd214_214b = 0
flag_my_cmd214_214c = 0

flag_my_cmd623_6 = 0
flag_my_cmd623_62 = 0
flag_my_cmd623_623 = 0
flag_my_cmd623_623b = 0
flag_my_cmd623_623c = 0

flag_my_cmd421_4 = 0
flag_my_cmd421_42 = 0
flag_my_cmd421_421 = 0
flag_my_cmd421_421b = 0
flag_my_cmd421_421c = 0

flag_my_cmd252_2 = 0
flag_my_cmd252_25 = 0
flag_my_cmd252_252 = 0
flag_my_cmd252_252b = 0
flag_my_cmd252_252c = 0

flag_my_cmd656_6 = 0
flag_my_cmd656_65 = 0
flag_my_cmd656_656 = 0

flag_my_cmd454_4 = 0
flag_my_cmd454_45 = 0
flag_my_cmd454_454 = 0

flag_my_cmd28_2 = 0
flag_my_cmd28_28 = 0

flag_my_cmd29_2 = 0
flag_my_cmd29_29 = 0

flag_my_cmd27_2 = 0
flag_my_cmd27_27 = 0

flag_my_cmd454_4 = 0
flag_my_cmd454_45 = 0
flag_my_cmd454_454 = 0

flag_my_cmdd5d_d = 0
flag_my_cmdd5d_d5 = 0
flag_my_cmdd5d_d5d = 0

--キー入力周りのカウント変数のグローバル変数宣言enemy
en_keymap2_up = 0
en_keymap2_down = 0
en_keymap2_left = 0
en_keymap2_right = 0
en_keymap2_a = 0
en_keymap2_b = 0
en_keymap2_c = 0
en_keymap2_d = 0
en_keymap2_ab = 0
en_keymap2_bc = 0
en_keymap2_uleft = 0
en_keymap2_uright = 0
en_keymap2_dleft = 0
en_keymap2_dright = 0

en_keyon_up_count = 0
en_keyon_down_count = 0
en_keyon_left_count = 0
en_keyon_right_count = 0
en_keyon_a_count = 0
en_keyon_b_count = 0
en_keyon_c_count = 0
en_keyon_d_count = 0
en_keyon_ab_count = 0
en_keyon_bc_count = 0
en_keyon_uleft_count = 0
en_keyon_uright_count = 0
en_keyon_dleft_count = 0
en_keyon_dright_count = 0
en_keyon_neutral_count = 0

en_keyoff_up_count = 0
en_keyoff_down_count = 0
en_keyoff_left_count = 0
en_keyoff_right_count = 0
en_keyoff_a_count = 0
en_keyoff_b_count = 0
en_keyoff_c_count = 0
en_keyoff_d_count = 0
en_keyoff_ab_count = 0
en_keyoff_bc_count = 0
en_keyoff_uleft_count = 0
en_keyoff_uright_count = 0
en_keyoff_dleft_count = 0
en_keyoff_dright_count = 0
en_keyoff_neutral_count = 0

en_keystat_up = 0
en_keystat_down = 0
en_keystat_left = 0
en_keystat_right = 0
en_keystat_a = 0
en_keystat_b = 0
en_keystat_c = 0
en_keystat_d = 0
en_keystat_ab = 0
en_keystat_bc = 0
en_keystat_uleft = 0
en_keystat_uright = 0
en_keystat_dleft = 0
en_keystat_dright = 0
en_keystat_neutral = 0

pre_en_keystat_up = 0
pre_en_keystat_down = 0
pre_en_keystat_left = 0
pre_en_keystat_right = 0
pre_en_keystat_a = 0
pre_en_keystat_b = 0
pre_en_keystat_c = 0
pre_en_keystat_d = 0
pre_en_keystat_ab = 0
pre_en_keystat_bc = 0
pre_en_keystat_uleft = 0
pre_en_keystat_uright = 0
pre_en_keystat_dleft = 0
pre_en_keystat_dright = 0
pre_en_keystat_neutral = 0

flag_en_cmd236_2 = 0
flag_en_cmd236_23 = 0
flag_en_cmd236_236 = 0
flag_en_cmd236_236b = 0
flag_en_cmd236_236c = 0

flag_en_cmd214_2 = 0
flag_en_cmd214_21 = 0
flag_en_cmd214_214 = 0
flag_en_cmd214_214b = 0
flag_en_cmd214_214c = 0

flag_en_cmd623_6 = 0
flag_en_cmd623_62 = 0
flag_en_cmd623_623 = 0
flag_en_cmd623_623b = 0
flag_en_cmd623_623c = 0

flag_en_cmd421_4 = 0
flag_en_cmd421_42 = 0
flag_en_cmd421_421 = 0
flag_en_cmd421_421b = 0
flag_en_cmd421_421c = 0

flag_en_cmd252_2 = 0
flag_en_cmd252_25 = 0
flag_en_cmd252_252 = 0
flag_en_cmd252_252b = 0
flag_en_cmd252_252c = 0

flag_en_cmd656_6 = 0
flag_en_cmd656_65 = 0
flag_en_cmd656_656 = 0

flag_en_cmd454_4 = 0
flag_en_cmd454_45 = 0
flag_en_cmd454_454 = 0

flag_en_cmd28_2 = 0
flag_en_cmd28_28 = 0

flag_en_cmd29_2 = 0
flag_en_cmd29_29 = 0

flag_en_cmd27_2 = 0
flag_en_cmd27_27 = 0

flag_en_cmd454_4 = 0
flag_en_cmd454_45 = 0
flag_en_cmd454_454 = 0

flag_en_cmdd5d_d = 0
flag_en_cmdd5d_d5 = 0
flag_en_cmdd5d_d5d = 0

--以下の関数をマイクロスレッドに読み込ませ、そこでの演算結果をメイン関数内で実行する事を想定している。
function key_count_calc()

--get_key_map2(TAG_ENEMY)の一挙取得を１０の変数に分ける。
	my_keymap2_up,my_keymap2_down,my_keymap2_left,my_keymap2_right,my_keymap2_a,my_keymap2_b,my_keymap2_c,my_keymap2_d,my_keymap2_ab,my_keymap2_bc	=	get_key_map2(0)
--斜め入力はないため、別途に作成
--扱いの都合上、上下左右斜めﾆｭｰﾄﾗﾙABCDを作成することとした。
	--8
	if my_keymap2_up>=1 and my_keymap2_left==0 and my_keymap2_right==0 then
		my_keystat_up = 1
	else
		my_keystat_up = 0
	end
	--2
	if my_keymap2_down>=1 and my_keymap2_left==0 and my_keymap2_right==0 then
		my_keystat_down = 1
	else
		my_keystat_down = 0
	end
	--4
	if my_keymap2_left>=1 and my_keymap2_up==0 and my_keymap2_down==0 then
		my_keystat_left = 1
	else
		my_keystat_left = 0
	end
	--6
	if my_keymap2_right>=1 and my_keymap2_up==0 and my_keymap2_down==0 then
		my_keystat_right = 1
	else
		my_keystat_right = 0
	end
	--7
	if my_keymap2_up>=1 and my_keymap2_left>=1 then
		my_keystat_uleft = 1
	else
		my_keystat_uleft = 0
	end
	--9
	if my_keymap2_up>=1 and my_keymap2_right>=1 then
		my_keystat_uright = 1
	else
		my_keystat_uright = 0
	end
	--1
	if my_keymap2_down>=1 and my_keymap2_left>=1 then
		my_keystat_dleft = 1
	else
		my_keystat_dleft = 0
	end
	--3
	if my_keymap2_down>=1 and my_keymap2_right>=1 then
		my_keystat_dright = 1
	else
		my_keystat_dright = 0
	end
	--5
	if my_keymap2_up==0 and my_keymap2_down==0 and my_keymap2_left==0 and my_keymap2_right==0 then
		my_keystat_neutral = 1
	else
		my_keystat_neutral = 0
	end
	--a
	if my_keymap2_a>=1 then
		my_keystat_a = 1
	else
		my_keystat_a = 0
	end
	--b
	if my_keymap2_b>=1 then
		my_keystat_b = 1
	else
		my_keystat_b = 0
	end
	--c
	if my_keymap2_c>=1 then
		my_keystat_c = 1
	else
		my_keystat_c = 0
	end
	--d
	if my_keymap2_d>=1 then
		my_keystat_d = 1
	else
		my_keystat_d = 0
	end
	--ab
	if my_keymap2_ab>=1 then
		my_keystat_ab = 1
	else
		my_keystat_ab = 0
	end
	--bc
	if my_keymap2_bc>=1 then
		my_keystat_bc = 1
	else
		my_keystat_bc = 0
	end

--0->1時に初期化。それ以外ではカウント。キーOnカウント変数。
if my_keystat_up==1 and pre_my_keystat_up==0 then
	my_keyon_up_count = 1
else
	my_keyon_up_count = my_keyon_up_count+1
end
if my_keystat_down==1 and pre_my_keystat_down==0 then
	my_keyon_down_count = 1
else
	my_keyon_down_count = my_keyon_down_count+1
end
if my_keystat_left==1 and pre_my_keystat_left==0 then
	my_keyon_left_count = 1
else
	my_keyon_left_count = my_keyon_left_count+1
end
if my_keystat_right==1 and pre_my_keystat_right==0 then
	my_keyon_right_count = 1
else
	my_keyon_right_count = my_keyon_right_count+1
end
if my_keystat_uleft==1 and pre_my_keystat_uleft==0 then
	my_keyon_uleft_count = 1
else
	my_keyon_uleft_count = my_keyon_uleft_count+1
end
if my_keystat_uright==1 and pre_my_keystat_uright==0 then
	my_keyon_uright_count = 1
else
	my_keyon_uright_count = my_keyon_uright_count+1
end
if my_keystat_dleft==1 and pre_my_keystat_dleft==0 then
	my_keyon_dleft_count = 1
else
	my_keyon_dleft_count = my_keyon_dleft_count+1
end
if my_keystat_dright==1 and pre_my_keystat_dright==0 then
	my_keyon_dright_count = 1
else
	my_keyon_dright_count = my_keyon_dright_count+1
end
if my_keystat_neutral==1 and pre_my_keystat_neutral==0 then
	my_keyon_neutral_count = 1
else
	my_keyon_neutral_count = my_keyon_neutral_count+1
end
if my_keystat_a==1 and pre_my_keystat_a==0 then
	my_keyon_a_count = 1
else
	my_keyon_a_count = my_keyon_a_count+1
end
if my_keystat_b==1 and pre_my_keystat_b==0 then
	my_keyon_b_count = 1
else
	my_keyon_b_count = my_keyon_b_count+1
end
if my_keystat_c==1 and pre_my_keystat_c==0 then
	my_keyon_c_count = 1
else
	my_keyon_c_count = my_keyon_c_count+1
end
if my_keystat_d==1 and pre_my_keystat_d==0 then
	my_keyon_d_count = 1
else
	my_keyon_d_count = my_keyon_d_count+1
end
if my_keystat_ab==1 and pre_my_keystat_ab==0 then
	my_keyon_ab_count = 1
else
	my_keyon_ab_count = my_keyon_ab_count+1
end
if my_keystat_bc==1 and pre_my_keystat_bc==0 then
	my_keyon_bc_count = 1
else
	my_keyon_bc_count = my_keyon_bc_count+1
end

--1->0 時に初期化。それ以外ではカウント。キーOffカウント変数。
if my_keystat_up==0 and pre_my_keystat_up>=1 then
	my_keyoff_up_count = 1
else
	my_keyoff_up_count = my_keyoff_up_count+1
end
if my_keystat_down==0 and pre_my_keystat_down>=1 then
	my_keyoff_down_count = 1
else
	my_keyoff_down_count = my_keyoff_down_count+1
end
if my_keystat_left==0 and pre_my_keystat_left>=1 then
	my_keyoff_left_count = 1
else
	my_keyoff_left_count = my_keyoff_left_count+1
end
if my_keystat_right==0 and pre_my_keystat_right>=1 then
	my_keyoff_right_count = 1
else
	my_keyoff_right_count = my_keyoff_right_count+1
end
if my_keystat_uleft==0 and pre_my_keystat_uleft>=1 then
	my_keyoff_uleft_count = 1
else
	my_keyoff_uleft_count = my_keyoff_uleft_count+1
end
if my_keystat_uright==0 and pre_my_keystat_uright>=1 then
	my_keyoff_uright_count = 1
else
	my_keyoff_uright_count = my_keyoff_uright_count+1
end
if my_keystat_dleft==0 and pre_my_keystat_dleft>=1 then
	my_keyoff_dleft_count = 1
else
	my_keyoff_dleft_count = my_keyoff_dleft_count+1
end
if my_keystat_dright==0 and pre_my_keystat_dright>=1 then
	my_keyoff_dright_count = 1
else
	my_keyoff_dright_count = my_keyoff_dright_count+1
end
if my_keystat_neutral==0 and pre_my_keystat_neutral>=1 then
	my_keyoff_neutral_count = 1
else
	my_keyoff_neutral_count = my_keyoff_neutral_count+1
end
if my_keystat_a==0 and pre_my_keystat_a>=1 then
	my_keyoff_a_count = 1
else
	my_keyoff_a_count = my_keyoff_a_count+1
end
if my_keystat_b==0 and pre_my_keystat_b>=1 then
	my_keyoff_b_count = 1
else
	my_keyoff_b_count = my_keyoff_b_count+1
end
if my_keystat_c==0 and pre_my_keystat_c>=1 then
	my_keyoff_c_count = 1
else
	my_keyoff_c_count = my_keyoff_c_count+1
end
if my_keystat_d==0 and pre_my_keystat_d>=1 then
	my_keyoff_d_count = 1
else
	my_keyoff_d_count = my_keyoff_d_count+1
end
if my_keystat_ab==0 and pre_my_keystat_ab>=1 then
	my_keyoff_ab_count = 1
else
	my_keyoff_ab_count = my_keyoff_ab_count+1
end
if my_keystat_bc==0 and pre_my_keystat_bc>=1 then
	my_keyoff_bc_count = 1
else
	my_keyoff_bc_count = my_keyoff_bc_count+1
end


--▼236コマンド用フラグ▼
--●flag_my_cmd236_236b
if flag_my_cmd236_236>0 and my_keyon_b_count==1 then
	flag_my_cmd236_236b = flag_my_cmd236_236
end
if flag_my_cmd236_236b == flag_my_cmd236_236 then
	flag_my_cmd236_236 = 0
end
if flag_my_cmd236_236b>0 then
	flag_my_cmd236_236b = flag_my_cmd236_236b-1
end
--●flag_my_cmd236_236c
if flag_my_cmd236_236>0 and my_keyon_c_count==1 then
	flag_my_cmd236_236c = flag_my_cmd236_236
end
if flag_my_cmd236_236c == flag_my_cmd236_236 then
	flag_my_cmd236_236 = 0
end
if flag_my_cmd236_236c>0 then
	flag_my_cmd236_236c = flag_my_cmd236_236c-1
end
--●flag_my_cmd236_236
if flag_my_cmd236_23>0 and my_keyon_right_count==1 then
	flag_my_cmd236_236 = flag_my_cmd236_23
end
if flag_my_cmd236_236 == flag_my_cmd236_23 then
	flag_my_cmd236_23 = 0
end
if flag_my_cmd236_236>0 then
	flag_my_cmd236_236 = flag_my_cmd236_236-1
end
--●flag_my_cmd236_23
if flag_my_cmd236_2>0 and my_keyon_dright_count==1 then
	flag_my_cmd236_23 = flag_my_cmd236_2
end
if flag_my_cmd236_23 == flag_my_cmd236_2 then
	flag_my_cmd236_2 = 0
end
if flag_my_cmd236_23>0 then
	flag_my_cmd236_23 = flag_my_cmd236_23-1
end
--●flag_my_cmd236_2
if my_keyoff_down_count>0 then
	flag_my_cmd236_2 = flag_my_cmd236_2-1
end
if my_keyon_down_count<my_keyoff_down_count then
	flag_my_cmd236_2 = 14
end
--▲▲

--▼214コマンド用フラグ▼
--●flag_my_cmd214_214b
if flag_my_cmd214_214>0 and my_keyon_b_count==1 then
	flag_my_cmd214_214b = flag_my_cmd214_214
end
if flag_my_cmd214_214b == flag_my_cmd214_214 then
	flag_my_cmd214_214 = 0
end
if flag_my_cmd214_214b>0 then
	flag_my_cmd214_214b = flag_my_cmd214_214b-1
end
--●flag_my_cmd214_214c
if flag_my_cmd214_214>0 and my_keyon_c_count==1 then
	flag_my_cmd214_214c = flag_my_cmd214_214
end
if flag_my_cmd214_214c == flag_my_cmd214_214 then
	flag_my_cmd214_214 = 0
end
if flag_my_cmd214_214c>0 then
	flag_my_cmd214_214c = flag_my_cmd214_214c-1
end
--●flag_my_cmd214_214
if flag_my_cmd214_21>0 and my_keyon_left_count==1 then
	flag_my_cmd214_214 = flag_my_cmd214_21
end
if flag_my_cmd214_214 == flag_my_cmd214_21 then
	flag_my_cmd214_21 = 0
end
if flag_my_cmd214_214>0 then
	flag_my_cmd214_214 = flag_my_cmd214_214-1
end
--●flag_my_cmd214_21
if flag_my_cmd214_2>0 and my_keyon_dleft_count==1 then
	flag_my_cmd214_21 = flag_my_cmd214_2
end
if flag_my_cmd214_21 == flag_my_cmd214_2 then
	flag_my_cmd214_2 = 0
end
if flag_my_cmd214_21>0 then
	flag_my_cmd214_21 = flag_my_cmd214_21-1
end
--●flag_my_cmd214_2
if my_keyoff_down_count>0 then
	flag_my_cmd214_2 = flag_my_cmd214_2-1
end
if my_keyon_down_count<my_keyoff_down_count then
	flag_my_cmd214_2 = 14
end
--▲▲

--▼623コマンド用フラグ▼
--●flag_my_cmd623_623b
if flag_my_cmd623_623>0 and my_keyon_b_count==1 then
	flag_my_cmd623_623b = flag_my_cmd623_623
end
if flag_my_cmd623_623b == flag_my_cmd623_623 then
	flag_my_cmd623_623 = 0
end
if flag_my_cmd623_623b>0 then
	flag_my_cmd623_623b = flag_my_cmd623_623b-1
end
--●flag_my_cmd623_623c
if flag_my_cmd623_623>0 and my_keyon_c_count==1 then
	flag_my_cmd623_623c = flag_my_cmd623_623
end
if flag_my_cmd623_623c == flag_my_cmd623_623 then
	flag_my_cmd623_623 = 0
end
if flag_my_cmd623_623c>0 then
	flag_my_cmd623_623c = flag_my_cmd623_623c-1
end
--●flag_my_cmd623_623
if flag_my_cmd623_62>0 and my_keyon_dright_count==1 then
	flag_my_cmd623_623 = flag_my_cmd623_62
end
if flag_my_cmd623_623 == flag_my_cmd623_62 then
	flag_my_cmd623_62 = 0
end
if flag_my_cmd623_623>0 then
	flag_my_cmd623_623 = flag_my_cmd623_623-1
end
--●flag_my_cmd623_62
if flag_my_cmd623_6>0 and my_keyon_down_count==1 then
	flag_my_cmd623_62 = flag_my_cmd623_6
end
if flag_my_cmd623_62 == flag_my_cmd623_6 then
	flag_my_cmd623_6 = 0
end
if flag_my_cmd623_62>0 then
	flag_my_cmd623_62 = flag_my_cmd623_62-1
end
--●flag_my_cmd623_6
if my_keyoff_right_count>0 then
	flag_my_cmd623_6 = flag_my_cmd623_6-1
end
if my_keyon_right_count<my_keyoff_right_count then
	flag_my_cmd623_6 = 14
end
--▲▲

--▼421コマンド用フラグ▼
--●flag_my_cmd421_421b
if flag_my_cmd421_421>0 and my_keyon_b_count==1 then
	flag_my_cmd421_421b = flag_my_cmd421_421
end
if flag_my_cmd421_421b == flag_my_cmd421_421 then
	flag_my_cmd421_421 = 0
end
if flag_my_cmd421_421b>0 then
	flag_my_cmd421_421b = flag_my_cmd421_421b-1
end
--●flag_my_cmd421_421c
if flag_my_cmd421_421>0 and my_keyon_c_count==1 then
	flag_my_cmd421_421c = flag_my_cmd421_421
end
if flag_my_cmd421_421c == flag_my_cmd421_421 then
	flag_my_cmd421_421 = 0
end
if flag_my_cmd421_421c>0 then
	flag_my_cmd421_421c = flag_my_cmd421_421c-1
end
--●flag_my_cmd421_421
if flag_my_cmd421_42>0 and my_keyon_dleft_count==1 then
	flag_my_cmd421_421 = flag_my_cmd421_42
end
if flag_my_cmd421_421 == flag_my_cmd421_42 then
	flag_my_cmd421_42 = 0
end
if flag_my_cmd421_421>0 then
	flag_my_cmd421_421 = flag_my_cmd421_421-1
end
--●flag_my_cmd421_42
if flag_my_cmd421_4>0 and my_keyon_down_count==1 then
	flag_my_cmd421_42 = flag_my_cmd421_4
end
if flag_my_cmd421_42 == flag_my_cmd421_4 then
	flag_my_cmd421_4 = 0
end
if flag_my_cmd421_42>0 then
	flag_my_cmd421_42 = flag_my_cmd421_42-1
end
--●flag_my_cmd421_4
if my_keyoff_left_count>0 then
	flag_my_cmd421_4 = flag_my_cmd421_4-1
end
if my_keyon_left_count<my_keyoff_left_count then
	flag_my_cmd421_4 = 14
end
--▲▲

--▼252コマンド用フラグ▼
--●flag_my_cmd252_252b
if flag_my_cmd252_252>0 and my_keyon_b_count==1 then
	flag_my_cmd252_252b = flag_my_cmd252_252
end
if flag_my_cmd252_252b == flag_my_cmd252_252 then
	flag_my_cmd252_252 = 0
end
if flag_my_cmd252_252b>0 then
	flag_my_cmd252_252b = flag_my_cmd252_252b-1
end
--●flag_my_cmd252_252c
if flag_my_cmd252_252>0 and my_keyon_c_count==1 then
	flag_my_cmd252_252c = flag_my_cmd252_252
end
if flag_my_cmd252_252c == flag_my_cmd252_252 then
	flag_my_cmd252_252 = 0
end
if flag_my_cmd252_252c>0 then
	flag_my_cmd252_252c = flag_my_cmd252_252c-1
end
--●flag_my_cmd252_252
if flag_my_cmd252_25>0 and my_keyon_down_count==1 then
	flag_my_cmd252_252 = flag_my_cmd252_25
end
if flag_my_cmd252_252 == flag_my_cmd252_25 then
	flag_my_cmd252_25 = 0
end
if flag_my_cmd252_252>0 then
	flag_my_cmd252_252 = flag_my_cmd252_252-1
end
--●flag_my_cmd252_25
if flag_my_cmd252_2>0 and my_keyon_neutral_count==1 then
	flag_my_cmd252_25 = flag_my_cmd252_2
end
if flag_my_cmd252_25 == flag_my_cmd252_2 then
	flag_my_cmd252_2 = 0
end
if flag_my_cmd252_25>0 then
	flag_my_cmd252_25 = flag_my_cmd252_25-1
end
--●flag_my_cmd252_2
if my_keyoff_down_count>0 then
	flag_my_cmd252_2 = flag_my_cmd252_2-1
end
if my_keyon_down_count<my_keyoff_down_count then
	flag_my_cmd252_2 = 14
end
--▲▲

--▼656コマンド用フラグ▼
--●flag_my_cmd656_656
if flag_my_cmd656_65>0 and my_keyon_right_count==1 then
	flag_my_cmd656_656 = flag_my_cmd656_65
end
if flag_my_cmd656_656 == flag_my_cmd656_65 then
	flag_my_cmd656_65 = 0
end
if flag_my_cmd656_656>0 then
	flag_my_cmd656_656 = flag_my_cmd656_656-1
end
--●flag_my_cmd656_65
if flag_my_cmd656_6>0 and my_keyon_neutral_count==1 then
	flag_my_cmd656_65 = flag_my_cmd656_6
end
if flag_my_cmd656_65 == flag_my_cmd656_6 then
	flag_my_cmd656_6 = 0
end
if flag_my_cmd656_65>0 then
	flag_my_cmd656_65 = flag_my_cmd656_65-1
end
--●flag_my_cmd656_6
if my_keyoff_right_count>0 then
	flag_my_cmd656_6 = flag_my_cmd656_6-1
end
if my_keyon_right_count<my_keyoff_right_count and my_keyon_right_count==1 then
	flag_my_cmd656_6 = 14
end
--▲▲

--▼454コマンド用フラグ▼
--●flag_my_cmd454_454
if flag_my_cmd454_45>0 and my_keyon_left_count==1 then
	flag_my_cmd454_454 = flag_my_cmd454_45
end
if flag_my_cmd454_454 == flag_my_cmd454_45 then
	flag_my_cmd454_45 = 0
end
if flag_my_cmd454_454>0 then
	flag_my_cmd454_454 = flag_my_cmd454_454-1
end
--●flag_my_cmd454_45
if flag_my_cmd454_4>0 and my_keyon_neutral_count==1 then
	flag_my_cmd454_45 = flag_my_cmd454_4
end
if flag_my_cmd454_45 == flag_my_cmd454_4 then
	flag_my_cmd454_4 = 0
end
if flag_my_cmd454_45>0 then
	flag_my_cmd454_45 = flag_my_cmd454_45-1
end
--●flag_my_cmd454_4
if my_keyoff_left_count>0 then
	flag_my_cmd454_4 = flag_my_cmd454_4-1
end
if my_keyon_left_count<my_keyoff_left_count and my_keyon_left_count==1 then
	flag_my_cmd454_4 = 14
end
--▲▲

--▼d5dコマンド用フラグ▼
--●flag_my_cmdd5d_d5d
if flag_my_cmdd5d_d5>0 and my_keyon_left_count==1 then
	flag_my_cmdd5d_d5d = flag_my_cmdd5d_d5
end
if flag_my_cmdd5d_d5d == flag_my_cmdd5d_d5 then
	flag_my_cmdd5d_d5 = 0
end
if flag_my_cmdd5d_d5d>0 then
	flag_my_cmdd5d_d5d = flag_my_cmdd5d_d5d-1
end
--●flag_my_cmdd5d_d5
if flag_my_cmdd5d_d>0 and my_keyon_neutral_count==1 then
	flag_my_cmdd5d_d5 = flag_my_cmdd5d_d
end
if flag_my_cmdd5d_d5 == flag_my_cmdd5d_d then
	flag_my_cmdd5d_d = 0
end
if flag_my_cmdd5d_d5>0 then
	flag_my_cmdd5d_d5 = flag_my_cmdd5d_d5-1
end
--●flag_my_cmdd5d_d
if my_keyoff_left_count>0 then
	flag_my_cmdd5d_d = flag_my_cmdd5d_d-1
end
if my_keyon_left_count<my_keyoff_left_count and my_keyon_left_count==1 then
	flag_my_cmdd5d_d = 14
end
--▲▲

--get_key_map2(TAG_ENEMY)の一挙取得を１０の変数に分ける。
	en_keymap2_up,en_keymap2_down,en_keymap2_left,en_keymap2_right,en_keymap2_a,en_keymap2_b,en_keymap2_c,en_keymap2_d,en_keymap2_ab,en_keymap2_bc	=	get_key_map2(1)
--斜め入力はないため、別途に作成
--扱いの都合上、上下左右斜めﾆｭｰﾄﾗﾙABCDを作成することとした。
	--8
	if en_keymap2_up>=1 and en_keymap2_left==0 and en_keymap2_right==0 then
		en_keystat_up = 1
	else
		en_keystat_up = 0
	end
	--2
	if en_keymap2_down>=1 and en_keymap2_left==0 and en_keymap2_right==0 then
		en_keystat_down = 1
	else
		en_keystat_down = 0
	end
	--4
	if en_keymap2_left>=1 and en_keymap2_up==0 and en_keymap2_down==0 then
		en_keystat_left = 1
	else
		en_keystat_left = 0
	end
	--6
	if en_keymap2_right>=1 and en_keymap2_up==0 and en_keymap2_down==0 then
		en_keystat_right = 1
	else
		en_keystat_right = 0
	end
	--7
	if en_keymap2_up>=1 and en_keymap2_left>=1 then
		en_keystat_uleft = 1
	else
		en_keystat_uleft = 0
	end
	--9
	if en_keymap2_up>=1 and en_keymap2_right>=1 then
		en_keystat_uright = 1
	else
		en_keystat_uright = 0
	end
	--1
	if en_keymap2_down>=1 and en_keymap2_left>=1 then
		en_keystat_dleft = 1
	else
		en_keystat_dleft = 0
	end
	--3
	if en_keymap2_down>=1 and en_keymap2_right>=1 then
		en_keystat_dright = 1
	else
		en_keystat_dright = 0
	end
	--5
	if en_keymap2_up==0 and en_keymap2_down==0 and en_keymap2_left==0 and en_keymap2_right==0 then
		en_keystat_neutral = 1
	else
		en_keystat_neutral = 0
	end
	--a
	if en_keymap2_a>=1 then
		en_keystat_a = 1
	else
		en_keystat_a = 0
	end
	--b
	if en_keymap2_b>=1 then
		en_keystat_b = 1
	else
		en_keystat_b = 0
	end
	--c
	if en_keymap2_c>=1 then
		en_keystat_c = 1
	else
		en_keystat_c = 0
	end
	--d
	if en_keymap2_d>=1 then
		en_keystat_d = 1
	else
		en_keystat_d = 0
	end
	--ab
	if en_keymap2_ab>=1 then
		en_keystat_ab = 1
	else
		en_keystat_ab = 0
	end
	--bc
	if en_keymap2_bc>=1 then
		en_keystat_bc = 1
	else
		en_keystat_bc = 0
	end

--0->1時に初期化。それ以外ではカウント。キーOnカウント変数。
if en_keystat_up==1 and pre_en_keystat_up==0 then
	en_keyon_up_count = 1
else
	en_keyon_up_count = en_keyon_up_count+1
end
if en_keystat_down==1 and pre_en_keystat_down==0 then
	en_keyon_down_count = 1
else
	en_keyon_down_count = en_keyon_down_count+1
end
if en_keystat_left==1 and pre_en_keystat_left==0 then
	en_keyon_left_count = 1
else
	en_keyon_left_count = en_keyon_left_count+1
end
if en_keystat_right==1 and pre_en_keystat_right==0 then
	en_keyon_right_count = 1
else
	en_keyon_right_count = en_keyon_right_count+1
end
if en_keystat_uleft==1 and pre_en_keystat_uleft==0 then
	en_keyon_uleft_count = 1
else
	en_keyon_uleft_count = en_keyon_uleft_count+1
end
if en_keystat_uright==1 and pre_en_keystat_uright==0 then
	en_keyon_uright_count = 1
else
	en_keyon_uright_count = en_keyon_uright_count+1
end
if en_keystat_dleft==1 and pre_en_keystat_dleft==0 then
	en_keyon_dleft_count = 1
else
	en_keyon_dleft_count = en_keyon_dleft_count+1
end
if en_keystat_dright==1 and pre_en_keystat_dright==0 then
	en_keyon_dright_count = 1
else
	en_keyon_dright_count = en_keyon_dright_count+1
end
if en_keystat_neutral==1 and pre_en_keystat_neutral==0 then
	en_keyon_neutral_count = 1
else
	en_keyon_neutral_count = en_keyon_neutral_count+1
end
if en_keystat_a==1 and pre_en_keystat_a==0 then
	en_keyon_a_count = 1
else
	en_keyon_a_count = en_keyon_a_count+1
end
if en_keystat_b==1 and pre_en_keystat_b==0 then
	en_keyon_b_count = 1
else
	en_keyon_b_count = en_keyon_b_count+1
end
if en_keystat_c==1 and pre_en_keystat_c==0 then
	en_keyon_c_count = 1
else
	en_keyon_c_count = en_keyon_c_count+1
end
if en_keystat_d==1 and pre_en_keystat_d==0 then
	en_keyon_d_count = 1
else
	en_keyon_d_count = en_keyon_d_count+1
end
if en_keystat_ab==1 and pre_en_keystat_ab==0 then
	en_keyon_ab_count = 1
else
	en_keyon_ab_count = en_keyon_ab_count+1
end
if en_keystat_bc==1 and pre_en_keystat_bc==0 then
	en_keyon_bc_count = 1
else
	en_keyon_bc_count = en_keyon_bc_count+1
end

--1->0 時に初期化。それ以外ではカウント。キーOffカウント変数。
if en_keystat_up==0 and pre_en_keystat_up>=1 then
	en_keyoff_up_count = 1
else
	en_keyoff_up_count = en_keyoff_up_count+1
end
if en_keystat_down==0 and pre_en_keystat_down>=1 then
	en_keyoff_down_count = 1
else
	en_keyoff_down_count = en_keyoff_down_count+1
end
if en_keystat_left==0 and pre_en_keystat_left>=1 then
	en_keyoff_left_count = 1
else
	en_keyoff_left_count = en_keyoff_left_count+1
end
if en_keystat_right==0 and pre_en_keystat_right>=1 then
	en_keyoff_right_count = 1
else
	en_keyoff_right_count = en_keyoff_right_count+1
end
if en_keystat_uleft==0 and pre_en_keystat_uleft>=1 then
	en_keyoff_uleft_count = 1
else
	en_keyoff_uleft_count = en_keyoff_uleft_count+1
end
if en_keystat_uright==0 and pre_en_keystat_uright>=1 then
	en_keyoff_uright_count = 1
else
	en_keyoff_uright_count = en_keyoff_uright_count+1
end
if en_keystat_dleft==0 and pre_en_keystat_dleft>=1 then
	en_keyoff_dleft_count = 1
else
	en_keyoff_dleft_count = en_keyoff_dleft_count+1
end
if en_keystat_dright==0 and pre_en_keystat_dright>=1 then
	en_keyoff_dright_count = 1
else
	en_keyoff_dright_count = en_keyoff_dright_count+1
end
if en_keystat_neutral==0 and pre_en_keystat_neutral>=1 then
	en_keyoff_neutral_count = 1
else
	en_keyoff_neutral_count = en_keyoff_neutral_count+1
end
if en_keystat_a==0 and pre_en_keystat_a>=1 then
	en_keyoff_a_count = 1
else
	en_keyoff_a_count = en_keyoff_a_count+1
end
if en_keystat_b==0 and pre_en_keystat_b>=1 then
	en_keyoff_b_count = 1
else
	en_keyoff_b_count = en_keyoff_b_count+1
end
if en_keystat_c==0 and pre_en_keystat_c>=1 then
	en_keyoff_c_count = 1
else
	en_keyoff_c_count = en_keyoff_c_count+1
end
if en_keystat_d==0 and pre_en_keystat_d>=1 then
	en_keyoff_d_count = 1
else
	en_keyoff_d_count = en_keyoff_d_count+1
end
if en_keystat_ab==0 and pre_en_keystat_ab>=1 then
	en_keyoff_ab_count = 1
else
	en_keyoff_ab_count = en_keyoff_ab_count+1
end
if en_keystat_bc==0 and pre_en_keystat_bc>=1 then
	en_keyoff_bc_count = 1
else
	en_keyoff_bc_count = en_keyoff_bc_count+1
end


--▼236コマンド用フラグ▼
--●flag_en_cmd236_236b
if flag_en_cmd236_236>0 and en_keyon_b_count==1 then
	flag_en_cmd236_236b = flag_en_cmd236_236
end
if flag_en_cmd236_236b == flag_en_cmd236_236 then
	flag_en_cmd236_236 = 0
end
if flag_en_cmd236_236b>0 then
	flag_en_cmd236_236b = flag_en_cmd236_236b-1
end
--●flag_en_cmd236_236c
if flag_en_cmd236_236>0 and en_keyon_c_count==1 then
	flag_en_cmd236_236c = flag_en_cmd236_236
end
if flag_en_cmd236_236c == flag_en_cmd236_236 then
	flag_en_cmd236_236 = 0
end
if flag_en_cmd236_236c>0 then
	flag_en_cmd236_236c = flag_en_cmd236_236c-1
end
--●flag_en_cmd236_236
if flag_en_cmd236_23>0 and en_keyon_right_count==1 then
	flag_en_cmd236_236 = flag_en_cmd236_23
end
if flag_en_cmd236_236 == flag_en_cmd236_23 then
	flag_en_cmd236_23 = 0
end
if flag_en_cmd236_236>0 then
	flag_en_cmd236_236 = flag_en_cmd236_236-1
end
--●flag_en_cmd236_23
if flag_en_cmd236_2>0 and en_keyon_dright_count==1 then
	flag_en_cmd236_23 = flag_en_cmd236_2
end
if flag_en_cmd236_23 == flag_en_cmd236_2 then
	flag_en_cmd236_2 = 0
end
if flag_en_cmd236_23>0 then
	flag_en_cmd236_23 = flag_en_cmd236_23-1
end
--●flag_en_cmd236_2
if en_keyoff_down_count>0 then
	flag_en_cmd236_2 = flag_en_cmd236_2-1
end
if en_keyon_down_count<en_keyoff_down_count then
	flag_en_cmd236_2 = 14
end
--▲▲

--▼214コマンド用フラグ▼
--●flag_en_cmd214_214b
if flag_en_cmd214_214>0 and en_keyon_b_count==1 then
	flag_en_cmd214_214b = flag_en_cmd214_214
end
if flag_en_cmd214_214b == flag_en_cmd214_214 then
	flag_en_cmd214_214 = 0
end
if flag_en_cmd214_214b>0 then
	flag_en_cmd214_214b = flag_en_cmd214_214b-1
end
--●flag_en_cmd214_214c
if flag_en_cmd214_214>0 and en_keyon_c_count==1 then
	flag_en_cmd214_214c = flag_en_cmd214_214
end
if flag_en_cmd214_214c == flag_en_cmd214_214 then
	flag_en_cmd214_214 = 0
end
if flag_en_cmd214_214c>0 then
	flag_en_cmd214_214c = flag_en_cmd214_214c-1
end
--●flag_en_cmd214_214
if flag_en_cmd214_21>0 and en_keyon_left_count==1 then
	flag_en_cmd214_214 = flag_en_cmd214_21
end
if flag_en_cmd214_214 == flag_en_cmd214_21 then
	flag_en_cmd214_21 = 0
end
if flag_en_cmd214_214>0 then
	flag_en_cmd214_214 = flag_en_cmd214_214-1
end
--●flag_en_cmd214_21
if flag_en_cmd214_2>0 and en_keyon_dleft_count==1 then
	flag_en_cmd214_21 = flag_en_cmd214_2
end
if flag_en_cmd214_21 == flag_en_cmd214_2 then
	flag_en_cmd214_2 = 0
end
if flag_en_cmd214_21>0 then
	flag_en_cmd214_21 = flag_en_cmd214_21-1
end
--●flag_en_cmd214_2
if en_keyoff_down_count>0 then
	flag_en_cmd214_2 = flag_en_cmd214_2-1
end
if en_keyon_down_count<en_keyoff_down_count then
	flag_en_cmd214_2 = 14
end
--▲▲

--▼623コマンド用フラグ▼
--●flag_en_cmd623_623b
if flag_en_cmd623_623>0 and en_keyon_b_count==1 then
	flag_en_cmd623_623b = flag_en_cmd623_623
end
if flag_en_cmd623_623b == flag_en_cmd623_623 then
	flag_en_cmd623_623 = 0
end
if flag_en_cmd623_623b>0 then
	flag_en_cmd623_623b = flag_en_cmd623_623b-1
end
--●flag_en_cmd623_623c
if flag_en_cmd623_623>0 and en_keyon_c_count==1 then
	flag_en_cmd623_623c = flag_en_cmd623_623
end
if flag_en_cmd623_623c == flag_en_cmd623_623 then
	flag_en_cmd623_623 = 0
end
if flag_en_cmd623_623c>0 then
	flag_en_cmd623_623c = flag_en_cmd623_623c-1
end
--●flag_en_cmd623_623
if flag_en_cmd623_62>0 and en_keyon_dright_count==1 then
	flag_en_cmd623_623 = flag_en_cmd623_62
end
if flag_en_cmd623_623 == flag_en_cmd623_62 then
	flag_en_cmd623_62 = 0
end
if flag_en_cmd623_623>0 then
	flag_en_cmd623_623 = flag_en_cmd623_623-1
end
--●flag_en_cmd623_62
if flag_en_cmd623_6>0 and en_keyon_down_count==1 then
	flag_en_cmd623_62 = flag_en_cmd623_6
end
if flag_en_cmd623_62 == flag_en_cmd623_6 then
	flag_en_cmd623_6 = 0
end
if flag_en_cmd623_62>0 then
	flag_en_cmd623_62 = flag_en_cmd623_62-1
end
--●flag_en_cmd623_6
if en_keyoff_right_count>0 then
	flag_en_cmd623_6 = flag_en_cmd623_6-1
end
if en_keyon_right_count<en_keyoff_right_count then
	flag_en_cmd623_6 = 14
end
--▲▲

--▼421コマンド用フラグ▼
--●flag_en_cmd421_421b
if flag_en_cmd421_421>0 and en_keyon_b_count==1 then
	flag_en_cmd421_421b = flag_en_cmd421_421
end
if flag_en_cmd421_421b == flag_en_cmd421_421 then
	flag_en_cmd421_421 = 0
end
if flag_en_cmd421_421b>0 then
	flag_en_cmd421_421b = flag_en_cmd421_421b-1
end
--●flag_en_cmd421_421c
if flag_en_cmd421_421>0 and en_keyon_c_count==1 then
	flag_en_cmd421_421c = flag_en_cmd421_421
end
if flag_en_cmd421_421c == flag_en_cmd421_421 then
	flag_en_cmd421_421 = 0
end
if flag_en_cmd421_421c>0 then
	flag_en_cmd421_421c = flag_en_cmd421_421c-1
end
--●flag_en_cmd421_421
if flag_en_cmd421_42>0 and en_keyon_dleft_count==1 then
	flag_en_cmd421_421 = flag_en_cmd421_42
end
if flag_en_cmd421_421 == flag_en_cmd421_42 then
	flag_en_cmd421_42 = 0
end
if flag_en_cmd421_421>0 then
	flag_en_cmd421_421 = flag_en_cmd421_421-1
end
--●flag_en_cmd421_42
if flag_en_cmd421_4>0 and en_keyon_down_count==1 then
	flag_en_cmd421_42 = flag_en_cmd421_4
end
if flag_en_cmd421_42 == flag_en_cmd421_4 then
	flag_en_cmd421_4 = 0
end
if flag_en_cmd421_42>0 then
	flag_en_cmd421_42 = flag_en_cmd421_42-1
end
--●flag_en_cmd421_4
if en_keyoff_left_count>0 then
	flag_en_cmd421_4 = flag_en_cmd421_4-1
end
if en_keyon_left_count<en_keyoff_left_count then
	flag_en_cmd421_4 = 14
end
--▲▲

--▼252コマンド用フラグ▼
--●flag_en_cmd252_252b
if flag_en_cmd252_252>0 and en_keyon_b_count==1 then
	flag_en_cmd252_252b = flag_en_cmd252_252
end
if flag_en_cmd252_252b == flag_en_cmd252_252 then
	flag_en_cmd252_252 = 0
end
if flag_en_cmd252_252b>0 then
	flag_en_cmd252_252b = flag_en_cmd252_252b-1
end
--●flag_en_cmd252_252c
if flag_en_cmd252_252>0 and en_keyon_c_count==1 then
	flag_en_cmd252_252c = flag_en_cmd252_252
end
if flag_en_cmd252_252c == flag_en_cmd252_252 then
	flag_en_cmd252_252 = 0
end
if flag_en_cmd252_252c>0 then
	flag_en_cmd252_252c = flag_en_cmd252_252c-1
end
--●flag_en_cmd252_252
if flag_en_cmd252_25>0 and en_keyon_down_count==1 then
	flag_en_cmd252_252 = flag_en_cmd252_25
end
if flag_en_cmd252_252 == flag_en_cmd252_25 then
	flag_en_cmd252_25 = 0
end
if flag_en_cmd252_252>0 then
	flag_en_cmd252_252 = flag_en_cmd252_252-1
end
--●flag_en_cmd252_25
if flag_en_cmd252_2>0 and en_keyon_neutral_count==1 then
	flag_en_cmd252_25 = flag_en_cmd252_2
end
if flag_en_cmd252_25 == flag_en_cmd252_2 then
	flag_en_cmd252_2 = 0
end
if flag_en_cmd252_25>0 then
	flag_en_cmd252_25 = flag_en_cmd252_25-1
end
--●flag_en_cmd252_2
if en_keyoff_down_count>0 then
	flag_en_cmd252_2 = flag_en_cmd252_2-1
end
if en_keyon_down_count<en_keyoff_down_count then
	flag_en_cmd252_2 = 14
end
--▲▲

--▼656コマンド用フラグ▼
--●flag_en_cmd656_656
if flag_en_cmd656_65>0 and en_keyon_right_count==1 then
	flag_en_cmd656_656 = flag_en_cmd656_65
end
if flag_en_cmd656_656 == flag_en_cmd656_65 then
	flag_en_cmd656_65 = 0
end
if flag_en_cmd656_656>0 then
	flag_en_cmd656_656 = flag_en_cmd656_656-1
end
--●flag_en_cmd656_65
if flag_en_cmd656_6>0 and en_keyon_neutral_count==1 then
	flag_en_cmd656_65 = flag_en_cmd656_6
end
if flag_en_cmd656_65 == flag_en_cmd656_6 then
	flag_en_cmd656_6 = 0
end
if flag_en_cmd656_65>0 then
	flag_en_cmd656_65 = flag_en_cmd656_65-1
end
--●flag_en_cmd656_6
if en_keyoff_right_count>0 then
	flag_en_cmd656_6 = flag_en_cmd656_6-1
end
if en_keyon_right_count<en_keyoff_right_count and en_keyon_right_count==1 then
	flag_en_cmd656_6 = 14
end
--▲▲

--▼454コマンド用フラグ▼
--●flag_en_cmd454_454
if flag_en_cmd454_45>0 and en_keyon_left_count==1 then
	flag_en_cmd454_454 = flag_en_cmd454_45
end
if flag_en_cmd454_454 == flag_en_cmd454_45 then
	flag_en_cmd454_45 = 0
end
if flag_en_cmd454_454>0 then
	flag_en_cmd454_454 = flag_en_cmd454_454-1
end
--●flag_en_cmd454_45
if flag_en_cmd454_4>0 and en_keyon_neutral_count==1 then
	flag_en_cmd454_45 = flag_en_cmd454_4
end
if flag_en_cmd454_45 == flag_en_cmd454_4 then
	flag_en_cmd454_4 = 0
end
if flag_en_cmd454_45>0 then
	flag_en_cmd454_45 = flag_en_cmd454_45-1
end
--●flag_en_cmd454_4
if en_keyoff_left_count>0 then
	flag_en_cmd454_4 = flag_en_cmd454_4-1
end
if en_keyon_left_count<en_keyoff_left_count and en_keyon_left_count==1 then
	flag_en_cmd454_4 = 14
end
--▲▲

--▼d5dコマンド用フラグ▼
--●flag_en_cmdd5d_d5d
if flag_en_cmdd5d_d5>0 and en_keyon_left_count==1 then
	flag_en_cmdd5d_d5d = flag_en_cmdd5d_d5
end
if flag_en_cmdd5d_d5d == flag_en_cmdd5d_d5 then
	flag_en_cmdd5d_d5 = 0
end
if flag_en_cmdd5d_d5d>0 then
	flag_en_cmdd5d_d5d = flag_en_cmdd5d_d5d-1
end
--●flag_en_cmdd5d_d5
if flag_en_cmdd5d_d>0 and en_keyon_neutral_count==1 then
	flag_en_cmdd5d_d5 = flag_en_cmdd5d_d
end
if flag_en_cmdd5d_d5 == flag_en_cmdd5d_d then
	flag_en_cmdd5d_d = 0
end
if flag_en_cmdd5d_d5>0 then
	flag_en_cmdd5d_d5 = flag_en_cmdd5d_d5-1
end
--●flag_en_cmdd5d_d
if en_keyoff_left_count>0 then
	flag_en_cmdd5d_d = flag_en_cmdd5d_d-1
end
if en_keyon_left_count<en_keyoff_left_count and en_keyon_left_count==1 then
	flag_en_cmdd5d_d = 14
end
--▲▲
pre_my_keystat_up = my_keystat_up
pre_my_keystat_down = my_keystat_down
pre_my_keystat_left = my_keystat_left
pre_my_keystat_right = my_keystat_right
pre_my_keystat_uleft = my_keystat_uleft
pre_my_keystat_uright = my_keystat_uright
pre_my_keystat_dleft = my_keystat_dleft
pre_my_keystat_dright = my_keystat_dright
pre_my_keystat_neutral = my_keystat_neutral
pre_my_keystat_a = my_keystat_a
pre_my_keystat_b = my_keystat_b
pre_my_keystat_c = my_keystat_c
pre_my_keystat_d = my_keystat_d
pre_my_keystat_ab = my_keystat_ab
pre_my_keystat_bc = my_keystat_bc
--
pre_en_keystat_up = en_keystat_up
pre_en_keystat_down = en_keystat_down
pre_en_keystat_left = en_keystat_left
pre_en_keystat_right = en_keystat_right
pre_en_keystat_uleft = en_keystat_uleft
pre_en_keystat_uright = en_keystat_uright
pre_en_keystat_dleft = en_keystat_dleft
pre_en_keystat_dright = en_keystat_dright
pre_en_keystat_neutral = en_keystat_neutral
pre_en_keystat_a = en_keystat_a
pre_en_keystat_b = en_keystat_b
pre_en_keystat_c = en_keystat_c
pre_en_keystat_d = en_keystat_d
pre_en_keystat_ab = en_keystat_ab
pre_en_keystat_bc = en_keystat_bc

end