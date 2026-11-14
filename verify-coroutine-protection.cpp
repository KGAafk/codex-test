#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include <cstdio>
#include <cstring>

int main(int argc, char **argv) {
    lua_State *L = luaL_newstate();
    if (!L) return 2;
    luaL_openlibs(L);
    protect_flag = (argc > 1 && std::strcmp(argv[1], "unprotected") == 0) ? 0 : 1;
    const char *check =
        "local co=coroutine.create(function() error('controlled error') end);"
        "local ok,err=coroutine.resume(co);"
        "assert(not ok and string.find(err, 'controlled error', 1, true));";
    int result = luaL_dostring(L, check);
    if (result) {
        std::fprintf(stderr, "Unexpected Lua failure: %s\n", lua_tostring(L, -1));
        return 1;
    }
    lua_close(L);
    std::puts("Protected coroutine errors are catchable");
    return 0;
}
