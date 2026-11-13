--サボット関数コントロール用

--サボットランクディシジョンの値をランダムに決定する。
local sabot_rand_decision = math.random(1024)

--サボットランクディシジョンの値に応じてサボットランクを決定する。。
if true then
	sabot_rank = 0
elseif sabot_rand_decision<=2 then
	sabot_rank = 1
elseif sabot_rand_decision<=4 then
	sabot_rank = 2
elseif sabot_rand_decision<=8 then
	sabot_rank = 3
elseif sabot_rand_decision<=16 then
	sabot_rank = 4
elseif sabot_rand_decision<=32 then
	sabot_rank = 5
elseif sabot_rand_decision<=64 then
	sabot_rank = 6
elseif sabot_rand_decision<=128 then
	sabot_rank = 7
elseif sabot_rand_decision<=256 then
	sabot_rank = 8
elseif sabot_rand_decision<=512 then
	sabot_rank = 9
elseif sabot_rand_decision<=1024 then
	sabot_rank = 10
end

--サボットランクが高いほど、サボットアフターガード関数を起動する。
function sabot_wakeup()
	local i= math.random(10)
	--
	if sabot_rank== 1 then
		if i<=1 then sabot_after_guard() end
	elseif sabot_rank== 2 then
		if i<=2 then sabot_after_guard() end
	elseif sabot_rank== 3 then
		if i<=3 then sabot_after_guard() end
	elseif sabot_rank== 4 then
		if i<=4 then sabot_after_guard() end
	elseif sabot_rank== 5 then
		if i<=5 then sabot_after_guard() end
	elseif sabot_rank== 6 then
		if i<=6 then sabot_after_guard() end
	elseif sabot_rank== 7 then
		if i<=7 then sabot_after_guard() end
	elseif sabot_rank== 8 then
		if i<=8 then sabot_after_guard() end
	elseif sabot_rank== 9 then
		if i<=9 then sabot_after_guard() end
	elseif sabot_rank==10 then
		if i<=10 then sabot_after_guard() end
	end
	--]]
end