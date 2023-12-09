local HCUtil=require("hcutil")
local Config=require("rainbowcursor.config")
local Function=require("rainbowcursor.function")
local M={}
local registered=false
local RainbowCursor=function(cmd)
 Function.RainbowCursor(unpack(cmd.fargs))
end
local commands={
 {"RainbowCursor",RainbowCursor,{nargs="*"}},
}
function M.setup()
 if Config.options.others.create_cmd then
  if registered==false then
   HCUtil.create_user_commands(commands)
   registered=true
  end
 else
  if registered==true then
   HCUtil.del_user_commands(commands)
   registered=false
  end
 end
end
return M