#include "ai/th123_ai/force_player.h"
#include <cassert>
#include <cstdio>
#include <cstdlib>

int main() {
    _putenv_s("SOKU_AI_FORCE_PLAYER", "");
    assert(soku_forced_player() == 0);
    assert(soku_prefer_forced_player(1) == 1);
    assert(soku_prefer_forced_player(2) == 2);
    _putenv_s("SOKU_AI_FORCE_PLAYER", "1");
    assert(soku_forced_player() == 1);
    assert(soku_prefer_forced_player(2) == 1);
    _putenv_s("SOKU_AI_FORCE_PLAYER", "2");
    assert(soku_forced_player() == 2);
    assert(soku_prefer_forced_player(1) == 2);
    _putenv_s("SOKU_AI_FORCE_PLAYER", "12");
    assert(soku_forced_player() == -1);
    _putenv_s("SOKU_AI_FORCE_PLAYER", "garbage");
    assert(soku_forced_player() == -1);
    _putenv_s("SOKU_AI_FORCE_PLAYER", "");
    std::puts("Player lock selection checks passed");
    return 0;
}
