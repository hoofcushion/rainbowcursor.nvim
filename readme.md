# rainbowcursor.nvim

A plugin for Neovim to rainbow the cursor.

### Demo

https://github.com/abcdefg233/rainbowcursor.nvim/assets/32760059/fc28f6be-f9ea-4c02-a5c5-79bcbfc3ddaf

## Installation

With [Lazy](https://github.com/folke/lazy.nvim)

```lua
local spec={
 "abcdefg233/rainbowcursor.nvim",
 cmd={"RainbowCursor"},
 config=true,
 dependencies={
  "abcdefg233/hcutil.nvim"
 },
}
```

Configuration

```lua
local spec={
 "abcdefg233/rainbowcursor.nvim",
 cmd={"RainbowCursor"},
 opts={
  hlgroup     ="RainbowCursor",
  -- The RainbowCursor High Light Group's name.
  autocmd     ={
   autostart=true,
   -- Whether or not to automatically start autocmd after setup.
   interval =90,
   -- How many time that the event triggered will loop over the color table.
   group    ="RainbowCursor",
   -- The RainbowCursor Autocmd Group's name .
   event    ={"CursorMoved","CursorMovedI"},
   -- The RainbowCursor Autocmd's trigger event .
  },
  timer       ={
   autostart=true,
   -- Whether or not to automatically start timer after setup.
   interval=18000,
   -- How long (in milliseconds) that the timer will need to loop over the color table.
  },
  color_amount=360,
  -- How many colors are in the color table.
  -- If *timer.interval is 18000 and *color_amount is 360, then the color will change in every 50 ms (18000/360)
  -- The speed can't not lower than 1ms, because of the Neovim's limit.
  -- Set less *color_amount make color change seems faster and more will make it smoother.
  hue_start   =0,
  -- The hue of hsl that RainbowCursor start with.
  -- 0 means red, and 360 means red too.
  saturation  =100,
  -- The saturation of hsl, lower than 100 will dim the color.
  lightness   =50,
  -- The lightness of hsl, high or lower than 50 will make color lighter or darker.
  others      ={
   create_cmd=true,
   -- Create command "RainbowCursor" after setup.
   -- If use API, cmd may not necessary.
   create_var=true,
   -- Create Lua global variable "_G.RainbowCursor" after setup.
   create_api=true,
   -- Create a Module API after setup.
   -- require("rainbowcursor").API,
   -- If it sets false, you can still use
   -- require("rainbowcursor.api").
   reuse_opts=false,
   -- New setup reuse old options or base on default options.
  },
 },
 dependencies={
  "abcdefg233/hcutil.nvim"
 },
}
```

## Usage

Lua API

```lua
-- You can get the API by these following ways.
-- If you do not like Lua way, you can disable API
-- by setting *others.create_var and *others.create_api to false,
-- and use command instead.

local API=require("rainbowcursor.api")
-- Works but not elegant.

local API=require("rainbowcursor").API
-- Needs *others.create_api==true.

local API=_G.RainbowCursor.API
-- Needs *others.create_api==true.
-- Needs *others.create_var==true.
```

```lua
_G.RainbowCursor.API.RainbowCursor("Timer" or "Autocmd","Start" or "Stop" or "Toggle")
-- "Start" or "Stop" or "Toggle" the "Timer" or "Autocmd"
_G.RainbowCursor.API.Timer_Toggle()
-- RainbowCursor toggle the timer
_G.RainbowCursor.API.Timer_Start()
-- RainbowCursor start the timer
_G.RainbowCursor.API.Timer_Stop()
-- RainbowCursor stop the timer
_G.RainbowCursor.API.Autocmd_Toggle()
-- RainbowCursor toggle the autocmd
_G.RainbowCursor.API.Autocmd_Start()
-- RainbowCursor start the autocmd
_G.RainbowCursor.API.Autocmd_Stop()
-- RainbowCursor stop the autocmd
_G.RainbowCursor.API.TimerColorIter()
-- RainbowCursor iter the color table in timer way manually
_G.RainbowCursor.API.AutocmdColorIter()
-- RainbowCursor iter the color table in autocmd way manually
```

Commands

If `*others.create_cmd==true`, you will get a command `RainbowCursor` after setup.

You can use it in these following terms

|Commands|Behaviors|
|:--|:--|
|RainbowCursor Timer Start|Start the RainbowCursor Timer|
|RainbowCursor Timer Stop|Stop the RainbowCursor Timer|
|RainbowCursor Timer Toggle|Toggle the RainbowCursor Timer|
|RainbowCursor Autocmd Start|Start the RainbowCursor Autocmd|
|RainbowCursor Autocmd Stop|Delete the RainbowCursor Autocmd|
|RainbowCursor Autocmd Toggle|Toggle the RainbowCursor Autocmd|

Default Commands

```
RainbowCursor Timer Start
RainbowCursor Timer Stop
RainbowCursor Timer Toggle
RainbowCursor Autocmd Start
RainbowCursor Autocmd Stop
RainbowCursor Autocmd Toggle
```

Use by shortcuts

Normal Keys

```lua
local keys={
 [{"n"}]={
  {"<leader>rcts",function() _G.RainbowCursor.API.Timer_Start() end,   "RainbowCursor Timer start"},
  {"<leader>rctS",function() _G.RainbowCursor.API.Timer_Stop() end,    "RainbowCursor Timer stop"},
  {"<leader>rctt",function() _G.RainbowCursor.API.Timer_Toggle() end,  "RainbowCursor Timer toggle"},
  {"<leader>rcas",function() _G.RainbowCursor.API.Autocmd_Start() end, "RainbowCursor Autocmd start"},
  {"<leader>rcaS",function() _G.RainbowCursor.API.Autocmd_Stop() end,  "RainbowCursor Autocmd stop"},
  {"<leader>rcat",function() _G.RainbowCursor.API.Autocmd_Toggle() end,"RainbowCursor Autocmd toggle"},
 },
}
local default_opts={noremap=true,silent=true}
for modes,key in pairs(keys) do
 for _,mode in ipairs(modes) do
  local opts=default_opts
  opts.desc=key[3]
  vim.keymap.set(mode,key[1],key[2],opts)
 end
end
```

Lazy keys

```lua
local keys={
 {"<leader>rcts",function() _G.RainbowCursor.API.Timer_Start() end,   desc="RainbowCursor Timer start"},
 {"<leader>rctS",function() _G.RainbowCursor.API.Timer_Stop() end,    desc="RainbowCursor Timer stop"},
 {"<leader>rctt",function() _G.RainbowCursor.API.Timer_Toggle() end,  desc="RainbowCursor Timer toggle"},
 {"<leader>rcas",function() _G.RainbowCursor.API.Autocmd_Start() end, desc="RainbowCursor Autocmd start"},
 {"<leader>rcaS",function() _G.RainbowCursor.API.Autocmd_Stop() end,  desc="RainbowCursor Autocmd stop"},
 {"<leader>rcat",function() _G.RainbowCursor.API.Autocmd_Toggle() end,desc="RainbowCursor Autocmd toggle"},
}
```

## Example Configuration

Convenient setup for lazy.nvim users

```lua
local spec={
 "abcdefg233/rainbowcursor.nvim",
 cmd={"RainbowCursor"},
 keys={
  {"<leader>rcts",function() _G.RainbowCursor.API.Timer_Start() end,   desc="RainbowCursor Timer start"},
  {"<leader>rctS",function() _G.RainbowCursor.API.Timer_Stop() end,    desc="RainbowCursor Timer stop"},
  {"<leader>rctt",function() _G.RainbowCursor.API.Timer_Toggle() end,  desc="RainbowCursor Timer toggle"},
  {"<leader>rcas",function() _G.RainbowCursor.API.Autocmd_Start() end, desc="RainbowCursor Autocmd start"},
  {"<leader>rcaS",function() _G.RainbowCursor.API.Autocmd_Stop() end,  desc="RainbowCursor Autocmd stop"},
  {"<leader>rcat",function() _G.RainbowCursor.API.Autocmd_Toggle() end,desc="RainbowCursor Autocmd toggle"},
 },
 opts={
  hlgroup     ="RainbowCursor",
  -- The RainbowCursor High Light Group's name.
  autocmd     ={
   autostart=true,
   -- Whether or not to automatically start autocmd after setup.
   interval =90,
   -- How many time that the event triggered will loop over the color table.
   group    ="RainbowCursor",
   -- The RainbowCursor Autocmd Group's name .
   event    ={"CursorMoved","CursorMovedI"},
   -- The RainbowCursor Autocmd's trigger event .
  },
  timer       ={
   autostart=true,
   -- Whether or not to automatically start timer after setup.
   interval=18000,
   -- How long (in milliseconds) that the timer will need to loop over the color table.
  },
  color_amount=360,
  -- How many colors are in the color table.
  -- If *timer.interval is 18000 and *color_amount is 360, then the color will change in every 50 ms (18000/360)
  -- The speed can't not lower than 1ms, because of the Neovim's limit.
  -- Set less *color_amount make color change seems faster and more will make it smoother.
  hue_start   =0,
  -- The hue of hsl that RainbowCursor start with.
  -- 0 means red, and 360 means red too.
  saturation  =100,
  -- The saturation of hsl, lower than 100 will dim the color.
  lightness   =50,
  -- The lightness of hsl, high or lower than 50 will make color lighter or darker.
  others      ={
   create_cmd=true,
   -- Create command "RainbowCursor" after setup.
   -- If use API, cmd may not necessary.
   create_var=true,
   -- Create Lua global variable "_G.RainbowCursor" after setup.
   create_api=true,
   -- Create a Module API after setup.
   -- require("rainbowcursor").API,
   -- If it sets false, you can still use
   -- require("rainbowcursor.api").
   reuse_opts=false,
   -- New setup reuse old options or base on default options.
  },
 },
 dependencies={
  "abcdefg233/hcutil.nvim"
 },
}
```

Modularize

```lua
---@class LazySpec
local M={}
M[1]="abcdefg233/rainbowcursor.nvim"
-- Event
M.cmd={"RainbowCursor"}
M.keys={
 {"<leader>rcts",_G.RainbowCursor.API.Timer_Start,   desc="RainbowCursor Timer start"},
 {"<leader>rctS",_G.RainbowCursor.API.Timer_Stop,    desc="RainbowCursor Timer stop"},
 {"<leader>rctt",_G.RainbowCursor.API.Timer_Toggle,  desc="RainbowCursor Timer toggle"},
 {"<leader>rcas",_G.RainbowCursor.API.Autocmd_Start, desc="RainbowCursor Autocmd start"},
 {"<leader>rcaS",_G.RainbowCursor.API.Autocmd_Stop,  desc="RainbowCursor Autocmd stop"},
 {"<leader>rcat",_G.RainbowCursor.API.Autocmd_Toggle,desc="RainbowCursor Autocmd toggle"},
}
-- Setup
M.opts={
 hlgroup     ="RainbowCursor",
 -- The RainbowCursor High Light Group's name.
 autocmd     ={
  autostart=true,
  -- Whether or not to automatically start autocmd after setup.
  interval =90,
  -- How many time that the event triggered will loop over the color table.
  group    ="RainbowCursor",
  -- The RainbowCursor Autocmd Group's name .
  event    ={"CursorMoved","CursorMovedI"},
  -- The RainbowCursor Autocmd's trigger event .
 },
 timer       ={
  autostart=true,
  -- Whether or not to automatically start timer after setup.
  interval=18000,
  -- How long (in milliseconds) that the timer will need to loop over the color table.
 },
 color_amount=360,
 -- How many colors are in the color table.
 -- If *timer.interval is 18000 and *color_amount is 360, then the color will change in every 50 ms (18000/360)
 -- The speed can't not lower than 1ms, because of the Neovim's limit.
 -- Set less *color_amount make color change seems faster and more will make it smoother.
 hue_start   =0,
 -- The hue of hsl that RainbowCursor start with.
 -- 0 means red, and 360 means red too.
 saturation  =100,
 -- The saturation of hsl, lower than 100 will dim the color.
 lightness   =50,
 -- The lightness of hsl, high or lower than 50 will make color lighter or darker.
 others      ={
  create_cmd=true,
  -- Create command "RainbowCursor" after setup.
  -- If use API, cmd may not necessary.
  create_var=true,
  -- Create Lua global variable "_G.RainbowCursor" after setup.
  create_api=true,
  -- Create a Module API after setup.
  -- require("rainbowcursor").API,
  -- If it sets false, you can still use
  -- require("rainbowcursor.api").
  reuse_opts=false,
  -- New setup reuse old options or base on default options.
 },
}
M.dependencies={
 "abcdefg233/hcutil.nvim"
}
return M
```
