-- Execute actual patched api.ai in the project's own Lua interpreter.
assert(loadfile('ai/th123_ai/api.ai'))()
local messages = {}
local original_print = print
print = function(message) messages[#messages+1] = tostring(message) end

local function waiting() while true do coroutine.yield() end end
thread_list = {[0]=coroutine.create(function() error('intentional regression probe') end),
               [1]=coroutine.create(waiting)}
thread_param = {[0]={}, [1]={}}
thread_num = 2
thread_main()
assert(#messages == 1 and string.find(messages[1], 'AI_COROUTINE_ERROR,0,', 1, true),
       'runtime failure must be reported once')
assert(string.find(messages[1], 'intentional regression probe', 1, true),
       'runtime error detail must be preserved')

messages = {}
thread_list = {[0]=coroutine.create(function() end), [1]=coroutine.create(waiting)}
thread_param = {[0]={}, [1]={}}
thread_num = 2
thread_main()
assert(#messages == 0, 'normal coroutine completion must remain quiet')
print = original_print
print('Coroutine error and normal completion checks passed')
