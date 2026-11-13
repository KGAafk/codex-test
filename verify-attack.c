#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include <stdio.h>
int main(void) {
  lua_State *L=luaL_newstate(); luaL_openlibs(L);
  if (luaL_dofile(L,"verify-attack.lua")) { fprintf(stderr,"%s\n",lua_tostring(L,-1)); return 1; }
  lua_close(L); return 0;
}
