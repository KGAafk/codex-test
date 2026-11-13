from pathlib import Path

# Apply after ai-net-patch.py, from the cloud build repository root.
# The logger is disabled unless SOKU_AI_TELEMETRY=1 is present when the AI starts.
p = Path('ai/th123_ai/main.cpp')
s = p.read_bytes()
nl = b'\r\n' if b'\r\n' in s else b'\n'
needle = b'\tkeyboard.ProcessEvent();' + nl + b'\tbt = battle_time;'
assert s.count(needle) == 1, 'cannot find unique input processing site'
code = r'''
    // Optional local-only telemetry. "requested" is the AI-side key state,
    // which may differ from game's interpreted key state or delayed events.
    {
        static int enabled = -1;
        static FILE *trace = NULL;
        static int last_frame = -1;
        static int lines = 0;
        if (enabled < 0) {
            const char *flag = getenv("SOKU_AI_TELEMETRY");
            enabled = flag && flag[0] == '1' && flag[1] == '\0';
            if (enabled) {
                trace = fopen("ai_telemetry.csv", "a+");
                if (trace) {
                    fseek(trace, 0, SEEK_END);
                    if (ftell(trace) == 0)
                        fprintf(trace, "wall_ms,scene,frame,player,foreground,requested_mask,my_char,enemy_char,my_x,my_y,enemy_x,enemy_y,my_action,enemy_action,my_frame,enemy_frame,my_hp,enemy_hp,my_rei,enemy_rei,my_hitstop,enemy_hitstop,my_combo,my_limit,my_dir,enemy_dir,my_fflags,enemy_fflags,my_aflags,enemy_aflags,my_key0,my_key1,my_key2,my_key3,my_key4,my_key5,my_key6,my_key7,enemy_key0,enemy_key1,enemy_key2,enemy_key3,enemy_key4,enemy_key5,enemy_key6,enemy_key7\n");
                } else enabled = 0;
            }
        }
        if (enabled && trace && (seen == 0x05 || seen == 0x0d || seen == 0x0e) && battle_time != last_frame) {
            unsigned int requested_mask = 0;
            for (int i = 0; i < 10; ++i) if (get_key_stat(i)) requested_mask |= (1u << i);
            fprintf(trace, "%lu,%d,%d,%d,%d,%u,%d,%d,%.2f,%.2f,%.2f,%.2f,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%d,%d,%u,%u,%u,%u",
                GetTickCount(), seen, battle_time, ini_int2(L"Player", 1), wh == GetForegroundWindow(), requested_mask,
                my_data.char_id, enemy_data.char_id, my_data.x, my_data.y, enemy_data.x, enemy_data.y,
                my_data.action, enemy_data.action, my_data.frame, enemy_data.frame,
                my_data.hp, enemy_data.hp, my_data.rei, enemy_data.rei, my_data.hit_stop, enemy_data.hit_stop,
                my_data.combo.count, my_data.combo.limit, my_data.dir, enemy_data.dir,
                my_data.fflags, enemy_data.fflags, my_data.aflags, enemy_data.aflags);
            for (int i = 0; i < 8; ++i) fprintf(trace, ",%d", my_data.keyState[i]);
            for (int i = 0; i < 8; ++i) fprintf(trace, ",%d", enemy_data.keyState[i]);
            fputc('\n', trace);
            if (++lines % 60 == 0) fflush(trace);
            last_frame = battle_time;
        }
    }
'''.strip('\n').encode('ascii').replace(b'\n', nl)
s = s.replace(needle, code + nl + needle, 1)
p.write_bytes(s)
