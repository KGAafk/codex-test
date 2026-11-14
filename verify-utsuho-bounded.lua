-- Execute with the same Lua engine as the AI, from the cloud-build directory.
-- Production helper is exercised with frame-by-frame mocked engine calls.
local source = 'youmu/'
local candidate = 'utsuho-test-candidate/'
if not loadfile(candidate .. '18_utsuho_main.lua') then
    candidate = 'D:/soku-ai-research/ai2026-utsuho-bounded/'
end
function require(_) end
function head_req_list() end
assert(loadfile(candidate .. '18_utsuho_main.lua'))()
assert(loadfile(source .. 'def_clc.lua'))()

ACT_BC=9
local casts, resets, present, threat, picks = 0,0,true,false,0
function key_reset() resets=resets+1 end
function card_check(_) return present end
function enemy_obj_range_in(_,_) return threat end
function card_1st(_) picks=picks+1 end
function yield() coroutine.yield() end
function key_event(button)
    assert(button==ACT_BC, 'only BC should be requested')
    casts=casts+1
    for i=1,4 do yield() end
end

local function setup(direction, selected)
    my_char=18; my_dir=direction; my_hp=10000; enemy_hp=10000
    my_act=0; my_card=selected and 211 or 0; is_card_use=true
    casts=0; resets=0; present=true; threat=false; picks=0
end

local function drive(fn, on_tick, max_ticks)
    local co=coroutine.create(fn)
    local ticks=0
    while coroutine.status(co)~='dead' do
        local ok, result=coroutine.resume(co)
        assert(ok, result)
        if coroutine.status(co)=='dead' then return ticks,result end
        ticks=ticks+1
        assert(ticks<=max_ticks,'coroutine exceeded bound')
        if on_tick then on_tick(ticks) end
    end
end

for _, direction in ipairs({-1,1}) do
    for _, card in ipairs({211,212,213,203}) do
        setup(direction, true); my_card=card
        local ticks, used=drive(function() return utsuho_bounded_card_use(card) end,nil,4)
        assert(ticks==4 and used and casts==1,'selected card should fire once, in four yields')
    end
    setup(direction,false)
    local ticks, used=drive(function() return utsuho_bounded_card_use(211) end,nil,8)
    assert(ticks==8 and not used and casts==0 and picks==8,'selection must end after eight frames')
    setup(direction,false)
    ticks, used=drive(function() return utsuho_bounded_card_use(211) end,
                      function(t) if t==3 then my_card=211 end end,12)
    assert(ticks==7 and used and casts==1 and picks==3,'selection then single cast')
    for _, change in ipairs({'hit','my_ko','enemy_ko','missing','threat','spell_action'}) do
        setup(direction,false)
        ticks, used=drive(function() return utsuho_bounded_card_use(211) end,function(t)
            if t==2 then
                if change=='hit' then my_act=50
                elseif change=='my_ko' then my_hp=0
                elseif change=='enemy_ko' then enemy_hp=0
                elseif change=='missing' then present=false
                elseif change=='threat' then threat=true
                elseif change=='spell_action' then my_act=600 end
            end
        end,8)
        assert(ticks==2 and not used and casts==0 and resets>=3,'must abort safely: '..change)
    end
    setup(direction,true); is_card_use=false
    ticks, used=drive(function() return utsuho_bounded_card_use(211) end,nil,0)
    assert(ticks==0 and not used and casts==0,'unusable card must not fire')
end

-- Equivalent original source loop and the actual original card_use function.
-- The Python source test verifies this loop matches the original source.
local function original()
    for i=1,10 do
        card_use(211);
        yield()
    end
end
setup(1,true)
local ticks=drive(original,nil,600)
assert(ticks>=110 and casts>=10,'baseline must demonstrate nested-loop blocking')
print('Utsuho bounded card tests passed; original yielded '..ticks..' frames')
