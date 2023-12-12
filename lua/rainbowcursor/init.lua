local M={}
local loaded=false
function M.setup(user_options)
 local Config=require("rainbowcursor.config")
 local Function=require("rainbowcursor.function")
 local Command=require("rainbowcursor.command")
 Config.setup(user_options)
 Function.setup()
 Command.setup()
 if Config.options.others.create_var==true then
  _G.RainbowCursor=M
 elseif _G.RainbowCursor~=nil then
  _G.RainbowCursor=nil
 end
 if Config.options.others.create_api==true then
  M.API=require("rainbowcursor.api")
 elseif M.API~=nil then
  M.API=nil
 end
 if loaded==false then
  if Config.options.autocmd.autostart==true then
   Function.Actions.RainbowCursor.Autocmd.Start()
  end
  if Config.options.timer.autostart==true then
   Function.Actions.RainbowCursor.Timer.Start()
  end
  loaded=true
 end
end
return M
