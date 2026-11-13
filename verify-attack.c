#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include <stdio.h>
int main(int argc, char **argv) {
  const char *script = argc > 1 ? argv[1] : "verify-attack.lua";
  lua_State *L = luaL_newstate();
  int result;
  if (!L) {
    fprintf(stderr, "Cannot allocate Lua state\n");
    return 2;
  }
  /* This engine disables protected errors until the host enables them. */
  protect_flag = 1;
  luaL_openlibs(L);
  printf("Running Lua checks: %s\n", script);
  fflush(stdout);
  result = luaL_dofile(L, script);
  if (result) {
    const char *message = lua_tostring(L, -1);
    fprintf(stderr, "Lua check failed (%d): %s\n", result,
            message ? message : "non-string error");
    fflush(stderr);
  }
  lua_close(L);
  return result ? 1 : 0;
}
