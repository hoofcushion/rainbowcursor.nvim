local Function        =require("rainbowcursor.function")
local M               ={}
M.AutocmdColorIter    =Function.AutocmdColorIter
M.TimerColorIter      =Function.TimerColorIter
M.RainbowCursor       =Function.RainbowCursor
M.RainbowCursor_Toggle=Function.Actions.RainbowCursor.Toggle
M.RainbowCursor_Start =Function.Actions.RainbowCursor.Start
M.RainbowCursor_Stop  =Function.Actions.RainbowCursor.Stop
M.Timer_Toggle        =Function.Actions.Timer.Toggle
M.Timer_Start         =Function.Actions.Timer.Start
M.Timer_Stop          =Function.Actions.Timer.Stop
M.Autocmd_Toggle      =Function.Actions.Autocmd.Toggle
M.Autocmd_Start       =Function.Actions.Autocmd.Start
M.Autocmd_Stop        =Function.Actions.Autocmd.Stop
return M
