-- Youmu specialist v3. Source ranges/timings are from 05_youmu_main.lua.
-- These are heuristics, not measured frame-perfect collision guarantees.
YOUMU_REVISION = "youmu-specialist-v3"
local last_time = -1
local shot_at = -1000
local card_at = -1000
local jump_at = -1000

function youmu_tick()
    if battle_time < last_time then
        shot_at = -1000
        card_at = -1000
        jump_at = -1000
    end
    last_time = battle_time
end

function youmu_predict(frames)
    -- EX velocities are relative to EACH fighter's facing, not each other.
    local mx = x + my_xspeedEX * my_dir * frames
    local tx = ex + enemy_xspeedEX * enemy_dir * frames
    local my = y + my_yspeed * frames + frames * (frames - 1) * m_gs / 2
    local ty = ey + enemy_yspeed * frames + frames * (frames - 1) * e_gs / 2
    return (tx - mx) * my_dir, math.max(0, ty) - math.max(0, my), my
end

local function contact_window()
    return my_char == 5 and my_hitstop >= 1 and my_hitstop <= 3
        and my_limit < 100 and is_dir_front == true
end

function youmu_confirm_wait()
    -- During a confirmed normal hit, preserve the existing cancel window.
    -- The observation loop can otherwise start a multi-frame reaction before
    -- hitstop reaches the author's 1..3-frame continuation window.
    if my_char ~= 5 or not is_dir_front or my_limit >= 100 or my_hitstop <= 3
        or enemy_act < 50 or enemy_act > 89 then return false end
    if my_act == 300 or my_act == 320 or my_act == 301 then return true end
    if my_act == 306 and (my_combo >= 5 or ey > 0 or my_yspeed >= 5) then return true end
    return false
end

function youmu_confirm_choice()
    if not contact_window() or enemy_act < 50 or enemy_act > 89 then return nil end
    if my_act == 300 or my_act == 320 then return "A" end
    if my_act == 301 then return "6A" end
    if my_act == 306 then
        if my_combo >= 5 then return "6A" end
        if ey > 0 or my_yspeed >= 5 then
            if ey <= y then return "6A" else return "8A" end
        end
    end
    return nil
end

function youmu_pressure_choice()
    -- Do not lock into a slow high/low attack from an observed guard pose:
    -- the defender can change guard or interrupt before it becomes active.
    -- Leave this to the author's existing follow-up until measured in-game.
    return nil
end

function youmu_execute(choice)
    if choice == "A" then key_event(ACT_A)
    elseif choice == "2A" then key_event2(ACT_A, ACT_DOWN)
    elseif choice == "4A" then key_event2(ACT_A, back)
    elseif choice == "6A" then key_event2(ACT_A, front)
    elseif choice == "3A" then
        key_on(front)
        key_event2(ACT_A, ACT_DOWN)
        key_off(front)
    elseif choice == "8A" then key_event2(ACT_A, ACT_UP)
    elseif choice == "6B" then
        shot_at = battle_time
        key_event2(ACT_B, front)
    elseif choice == "2C" then
        shot_at = battle_time
        key_event2(ACT_C, ACT_DOWN)
    else return false end
    return true
end

function youmu_confirm_step()
    return youmu_execute(youmu_confirm_choice())
end

function youmu_pressure_step()
    return youmu_execute(youmu_pressure_choice())
end

function youmu_card_once(id)
    -- Never camp in a nested card-use loop after a cast, interruption or swap.
    if my_char ~= 5 or my_card ~= id or not is_card_use then return false end
    if (my_act >= 50 and my_act < 180) or my_act >= 600 then return false end
    key_event(ACT_BC)
    return true
end

local function safe_neutral()
    return my_char == 5 and my_hp > 0 and enemy_hp > 0
        and subs_count >= 530 and nega_count ~= 1
        and not (my_act >= 50 and my_act < 180) and my_act < 600
        and not (enemy_act >= 97 and enemy_act <= 98)
        and not (enemy_act >= 180 and enemy_act <= 199)
        and get_fflags(0, 8) == false and get_fflags(1, 8) == false
        and enemy_obj_range_in(150, 60) == false
end

function youmu_neutral_choice()
    if not safe_neutral() or not is_dir_front then return nil end
    if y > 0 then
        if my_act == 200 or not get_fflags(0, 32) then return nil end
        local dx, dy, landing = youmu_predict(9)
        if landing > 0 and dx >= -15 and dx <= 125 and dy >= -140 and dy <= 120 then
            return "A"
        end
        dx, dy, landing = youmu_predict(8)
        if landing > 0 and dx >= -20 and dx <= 150 and dy >= 70 and dy <= 370 then
            return "8A"
        end
        return nil
    end
    if my_act > 10 and my_act ~= 200 then return nil end
    if ey > 0 then
        if my_act <= 10 and get_fflags(0, 32) then
            local dx, dy = youmu_predict(9)
            if dx >= -10 and dx <= 130 and dy >= 0 and dy <= 140 then return "4A" end
        end
        return nil
    end
    if my_act == 200 and dis <= 120 and my_allframe >= 10 then return "2A" end
    if my_act <= 10 and dis <= 140 then return "A" end
    -- Keep enough spirit for defense; do not repeatedly throw shots at range.
    if my_act <= 10 and my_rei >= 300 and battle_time - shot_at >= 90 then
        if dis > 480 then return "6B" end
        if dis > 200 and hanreidis and hanreiy
            and math.abs(hanreidis) < 180 and math.abs(hanreiy - ey + 90) < 180 then
            return "2C"
        end
    end
    return nil
end

function youmu_neutral_step()
    return youmu_execute(youmu_neutral_choice())
end

function youmu_prepare_card()
    -- One press while safely far away. Never rotate during a combo window.
    if my_act > 10 or y ~= 0 or dis < 420 or enemy_act > 10
        or battle_time - card_at < 8 or not safe_neutral() then return false end
    local priority = {{203,2500}, {212,1500}, {201,1500}, {207,2000}, {204,2000}, {200,1000}}
    for _, item in ipairs(priority) do
        if card_check(item[1]) and my_spell_more(item[2]) then
            if my_card == item[1] then return false end
            card_at = battle_time
            key_on(ACT_AB)
            return true
        end
    end
    return false
end

function youmu_movement_step()
    -- No random 60-frame pauses or sine-wave retreat. Re-evaluate next frame.
    if not safe_neutral() or y ~= 0 or (my_act > 10 and my_act ~= 200) then return false end
    if not is_dir_front then
        key_on(front) -- engine front follows the opponent's current side
        return true
    end
    if my_rei < 100 or (enemy_act >= 300 and dis < 300) then
        key_on(back)
        return true
    end
    youmu_prepare_card()
    -- General candidate based on the original 8HJ range/resource conditions.
    -- Existing object prediction is incomplete: this is not a safety guarantee.
    -- Release next frame so the defense branches can run again.
    if my_act <= 10 and ey < 160 and dis >= 456
        and dis <= 750 and my_rei >= 500 and my_rfunc > 0.65 and enemy_act <= 10
        and battle_time - jump_at >= 45 then
        jump_at = battle_time
        key_on(front)
        key_on(ACT_UP)
        key_on(ACT_D)
        return true
    end
    if dis > 170 and ey < 160 and enemy_act <= 10 then
        key_on(front)
        key_on(ACT_D)
    elseif dis > 110 then
        key_on(front)
    else
        key_on(back)
    end
    return true
end
