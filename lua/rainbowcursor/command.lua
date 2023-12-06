local Function=require("rainbowcursor.function")
local M={loaded=false}
M.RainbowCursor=function(cmd)
 local fargs=cmd.fargs
 Function.RainbowCursor(fargs[1])
end
M.setup=function()
 if M.loaded then return end
 M.loaded=true
 vim.api.nvim_create_user_command("RainbowCursor",M.RainbowCursor,{nargs="?"})
end
return M
