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
 local create_cmd=Config.options.others.create_cmd
 if create_cmd~=registered then
  if create_cmd==true then
   HCUtil.create_user_commands(commands)
   registered=true
  else
   HCUtil.del_user_commands(commands)
   registered=false
  end
 end
end
return M
