assert(loadfile('attack-pack-test.lua'))()

local checks = 0
local function expect(actual, expected, label)
    checks = checks + 1
    assert(actual == expected, label .. ': expected ' .. tostring(expected)
        .. ', got ' .. tostring(actual))
end

local function setup(direction, aerial_forward)
    my_dir = direction
    enemy_dir = -direction
    ex = 600
    x = ex - direction * 100
    y = 100
    ey = aerial_forward and 300 or 170
    my_yspeed = 0
    enemy_yspeed = 0
    my_xspeedEX = 0
    enemy_xspeedEX = 0
    m_gs = 0
    e_gs = 0
    my_hitstop = 0
    enemy_hitstop = 0
    enemy_hitarea_n = 2
    -- Engine hitboxes are absolute world coordinates, not character offsets.
    local miss = ex - direction * 110
    enemy_hitarea_left = {miss - 10, ex - 20}
    enemy_hitarea_right = {miss + 10, ex + 20}
    enemy_hitarea_top = {ey + 10, ey + 10}
    enemy_hitarea_bottom = {ey - 10, ey - 10}
end

for _, direction in ipairs({1, -1}) do
    for _, move in ipairs({
        {name = 'JA', run = JA_attack_calculation, forward = false},
        {name = 'J6A', run = J6A_attack_calculation, forward = true}
    }) do
        local label = move.name .. ' facing ' .. direction
        setup(direction, move.forward)
        expect(move.run(), true, label .. ' checks second hurtbox')

        enemy_hitarea_left[2] = enemy_hitarea_left[1]
        enemy_hitarea_right[2] = enemy_hitarea_right[1]
        expect(move.run(), false, label .. ' all hurtboxes miss')

        setup(direction, move.forward)
        enemy_hitarea_left[1] = enemy_hitarea_left[2]
        enemy_hitarea_right[1] = enemy_hitarea_right[2]
        enemy_hitarea_n = 1
        expect(move.run(), true, label .. ' first hurtbox still hits')

        setup(direction, move.forward)
        enemy_hitarea_n = 0
        expect(move.run(), false, label .. ' no hurtboxes')

        setup(direction, move.forward)
        my_hitstop = 1
        expect(move.run(), false, label .. ' own hitstop')

        setup(direction, move.forward)
        enemy_hitstop = 1
        expect(move.run(), false, label .. ' opponent hitstop')

        setup(direction, move.forward)
        y = 0
        expect(move.run(), false, label .. ' grounded')

        setup(direction, move.forward)
        my_yspeed = -30
        expect(move.run(), false, label .. ' lands before startup')
    end
end

print('Attack strategy: ' .. checks .. ' hitbox regression checks passed')
