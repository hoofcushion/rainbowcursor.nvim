local Config=require("rainbowcursor.config")
local Function=require("rainbowcursor.function")
local Command=require("rainbowcursor.command")
local M={}
local loaded=false
M.options=Config.options
function M.setup(user_options)
 Config.setup(user_options)
 Command.setup()
 local opts=Config.options
 if opts.others.create_var then
  _G.RainbowCursor=M
 else
  _G.RainbowCursor=nil
 end
 if opts.others.create_api then
  M.API=require("rainbowcursor.api")
 else
  M.API=nil
 end
 if loaded then
  Function.setup() -- reset parameter
 else
  if opts.autocmd.autostart then
   Function.Actions.RainbowCursor.Autocmd.Start()
  end
  if opts.timer.autostart then
   Function.Actions.RainbowCursor.Timer.Start()
  end
  loaded=true
 end
end
return M