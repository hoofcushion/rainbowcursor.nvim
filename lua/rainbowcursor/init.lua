local M={loaded=false}
local Config=require("rainbowcursor.config")
M.options=Config.options
function M.setup(user_options)
 Config.setup(user_options)
 local others=Config.options.others
 if others.create_cmd==true then
  require("rainbowcursor.command").setup()
 end
 if others.create_var==true then
  _G.RainbowCursor=M
 end
 if others.create_api==true then
  M.API=require("rainbowcursor.api")
 end
 if M.options.autostart then
  require("rainbowcursor.function").Actions.RainbowCursor.Start()
 end
 M.loaded=true
end
return M
