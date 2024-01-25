local HCUtil=require("hcutil")
local Config=require("rainbowcursor.config")
local Function=require("rainbowcursor.function")
local M={}
local registered=false
local RainbowCursor=function(cmd)
 Function.RainbowCursor(unpack(cmd.fargs))
end
local completions={
 RainbowCursor={
  {{"Start","Stop","Toggle","Autocmd","Timer"}},
  Timer={
   {{"Start","Stop","Toggle"}},
  },
  Autocmd={
   {{"Start","Stop","Toggle"}},
  },
 },
}
local function complete(_,CmdLine)
 local cmp=completions
 for arg in string.gmatch(CmdLine,"%S+") do
  if cmp[arg] then cmp=cmp[arg] else return nil end
 end
 if cmp[1].func then cmp[1]:func() end
 return cmp[1][1]
end
local commands={
 {"RainbowCursor",RainbowCursor,{nargs="*",complete=complete}},
}
function M.setup()
 if registered~=Config.options.others.create_cmd then
  if registered==false then
   HCUtil.create_user_commands(commands)
  else
   HCUtil.del_user_commands(commands)
  end
  registered=Config.options.others.create_cmd
 end
end
return M
