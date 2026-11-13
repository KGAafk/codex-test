--コマンド66
function lvr66()
if is_dir_front==true then
	key_on(frontEX());yield();
	key_off(frontEX());yield();
	key_on(frontEX());yield();
	key_off(frontEX());yield();
else
	key_on(backEX());yield();
	key_off(backEX());yield();
	key_on(backEX());yield();
	key_off(backEX());yield();
end
end
		
--コマンド44
function lvr44()
if is_dir_front==true then
	key_on(backEX());yield();
	key_off(backEX());yield();
	key_on(backEX());yield();
	key_off(backEX());yield();
else
	key_on(frontEX());yield();
	key_off(frontEX());yield();
	key_on(frontEX());yield();
	key_off(frontEX());yield();
end
end

--コマンド236
function lvr236(button)
if is_dir_front==true then
	key_on(ACT_DOWN);yield();
	key_on(frontEX());yield();
	key_off(ACT_DOWN);
		key_event(button);
	key_off(frontEX());yield();
else
	key_on(ACT_DOWN);yield();
	key_on(backEX());yield();
	key_off(ACT_DOWN);
		key_event(button);
	key_off(backEX());yield();
end
end

function lvr2368(button)
	key_on(ACT_DOWN);yield();
	key_on(front);yield();
	key_off(ACT_DOWN);yield();
	key_off(front);
	if button>=0 and button<=9 then
		key_event2(ACT_UP,button);
	end
end

function lvr236h(button)
if is_dir_front==true then
	key_on(ACT_DOWN);yield();
	key_on(frontEX());yield();
	key_off(ACT_DOWN);
		key_on(button);yield();
	key_off(frontEX());yield();
else
	key_on(ACT_DOWN);yield();
	key_on(backEX());yield();
	key_off(ACT_DOWN);
		key_on(button);yield();
	key_off(backEX());yield();
end
end

--コマンド623
function lvr623(button)
if is_dir_front==true then
	key_on(frontEX());yield();
	key_off(frontEX());
	key_on(ACT_DOWN);yield();
	key_on(frontEX());
		key_event(button);
	key_off(ACT_DOWN);
	key_off(frontEX());yield();
else
	key_on(backEX());yield();
	key_off(backEX());
	key_on(ACT_DOWN);yield();
	key_on(backEX());
		key_event(button);
	key_off(ACT_DOWN);
	key_off(backEX());yield();
end
end

function lvr623h(button)
if is_dir_front==true then
	key_on(frontEX());yield();
	key_off(frontEX());
	key_on(ACT_DOWN);yield();
	key_on(frontEX());
		key_on(button);yield();
	key_off(ACT_DOWN);
	key_off(frontEX());yield();
else
	key_on(backEX());yield();
	key_off(backEX());
	key_on(ACT_DOWN);yield();
	key_on(backEX());
		key_on(button);yield();
	key_off(ACT_DOWN);
	key_off(backEX());yield();
end
end

--コマンド214
function lvr214(button)
if is_dir_front==true then
	key_on(ACT_DOWN);yield();
	key_on(backEX());yield();
	key_off(ACT_DOWN);
		key_event(button);
	key_off(backEX());yield();
else
	key_on(ACT_DOWN);yield();
	key_on(frontEX());yield();
	key_off(ACT_DOWN);
		key_event(button);
	key_off(frontEX());yield();
end
end

function lvr214h(button)
if is_dir_front==true then
	key_on(ACT_DOWN);yield();
	key_on(backEX());yield();
	key_off(ACT_DOWN);
		key_on(button);yield();
	key_off(backEX());yield();
else
	key_on(ACT_DOWN);yield();
	key_on(frontEX());yield();
	key_off(ACT_DOWN);
		key_on(button);yield();
	key_off(frontEX());yield();
end
end

--コマンド421
function lvr421(button)
if is_dir_front==true then
	key_on(backEX());yield();
	key_off(backEX());
	key_on(ACT_DOWN);yield();
	key_on(backEX());
		key_event(button);
	key_off(ACT_DOWN);
	key_off(backEX());yield();
else
	key_on(frontEX());yield();
	key_off(frontEX());
	key_on(ACT_DOWN);yield();
	key_on(frontEX());
		key_event(button);
	key_off(ACT_DOWN);
	key_off(frontEX());yield();
end
end

function lvr421h(button)
if is_dir_front==true then
	key_on(backEX());yield();
	key_off(backEX());
	key_on(ACT_DOWN);yield();
	key_on(backEX());
		key_on(button);yield();
	key_off(ACT_DOWN);
	key_off(backEX());yield();
else
	key_on(frontEX());yield();
	key_off(frontEX());
	key_on(ACT_DOWN);yield();
	key_on(frontEX());
		key_on(button);yield();
	key_off(ACT_DOWN);
	key_off(frontEX());yield();
end
end

--コマンド22
function lvr22(button)
	key_on(ACT_DOWN);yield();
	key_off(ACT_DOWN);yield();
	key_on(ACT_DOWN);
		key_event(button);
	key_off(ACT_DOWN);yield();
end

function lvr22h(button)
	key_on(ACT_DOWN);yield();
	key_off(ACT_DOWN);yield();
	key_on(ACT_DOWN);
		key_on(button);yield();
	key_off(ACT_DOWN);yield();
end

--▼キャラの向きを加味したキー入力▼
--key_frontEX：主に諏訪子用。ガードは相手方向によるが、コマンドはキャラの向きによるため。
function frontEX()
	if my_dir==1 then
		return 3;
	elseif my_dir==-1 then
		return 2;
	end
end
--key_d_frontEX：主に諏訪子用。ガードは相手方向によるが、コマンドはキャラの向きによるため。
function d_frontEX()
	if my_dir==1 then
		return 11;
	elseif my_dir==-1 then
		return 10;
	end
end
--key_u_frontEX：主に諏訪子用。ガードは相手方向によるが、コマンドはキャラの向きによるため。
function u_frontEX()
	if my_dir==1 then
		return 13;
	elseif my_dir==-1 then
		return 12;
	end
end
--key_backEX：主に諏訪子用。ガードは相手方向によるが、コマンドはキャラの向きによるため。
function backEX()
	if my_dir==1 then
		return 2;
	elseif my_dir==-1 then
		return 3;
	end
end
--key_d_backEX：主に諏訪子用。ガードは相手方向によるが、コマンドはキャラの向きによるため。
function d_backEX()
	if my_dir==1 then
		return 10;
	elseif my_dir==-1 then
		return 11;
	end
end
--key_u_backEX：主に諏訪子用。ガードは相手方向によるが、コマンドはキャラの向きによるため。
function u_backEX()
	if my_dir==1 then
		return 12;
	elseif my_dir==-1 then
		return 13;
	end
end