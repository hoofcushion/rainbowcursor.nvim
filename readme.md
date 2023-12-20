# rainbowcursor.nvim

A plugin for Neovim to rainbow the cursor.

## Demo

https://github.com/abcdefg233/rainbowcursor.nvim/assets/32760059/fc28f6be-f9ea-4c02-a5c5-79bcbfc3ddaf

## Important

The `vim.api.nvim_set_hl` and `redraw` could't refresh the cursor color in some terminal simulator , and I don't know why.

| Terminals I tried | Is working |
| :---------------- | ---------- |
| wezterm           | ⭕         |
| konsole           | ❌         |
| xfce4-terminal    | ❌         |

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
   loopover =36,
   -- How many time that the event triggered will loop over the color table.
   group    ="RainbowCursor",
   -- The RainbowCursor Autocmd Group's name .
   event    ={"CursorMoved","CursorMovedI"},
   -- The RainbowCursor Autocmd's trigger event .
  },
  timer       ={
   autostart=true,
   -- Whether or not to automatically start timer after setup.
   loopover=180,
   -- How many time that the timer triggered will loop over the color table.
   interval=100,
   -- The interval of timer to be triggered (in milliseconds).
  },
  channels={
   format="hsl",
   -- Color format, could be "hsl" "rgb" or a function that takes variable parameters and return 3 number: r,g,b.
   -- format=function(a,b,c...x,y,z) return r,g,b end
   -- The inputs are defined by the following array:
   {{0,360,1}},
   -- The 1st input of color format function, default is the hue of hsl
   {{100,100,0}},
   -- The 2nd input of color format function, default is the saturation of hsl
   {{50,50,0}},
   -- The 3rd input of color format function, default is the lightness of hsl
  },
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

| Commands                     | Behaviors                        |
| :--------------------------- | :------------------------------- |
| RainbowCursor Timer Start    | Start the RainbowCursor Timer    |
| RainbowCursor Timer Stop     | Stop the RainbowCursor Timer     |
| RainbowCursor Timer Toggle   | Toggle the RainbowCursor Timer   |
| RainbowCursor Autocmd Start  | Start the RainbowCursor Autocmd  |
| RainbowCursor Autocmd Stop   | Delete the RainbowCursor Autocmd |
| RainbowCursor Autocmd Toggle | Toggle the RainbowCursor Autocmd |

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
  {"<leader>rts",function() _G.RainbowCursor.API.Timer_Start() end,   "RainbowCursor Timer start"},
  {"<leader>rtS",function() _G.RainbowCursor.API.Timer_Stop() end,    "RainbowCursor Timer stop"},
  {"<leader>rtt",function() _G.RainbowCursor.API.Timer_Toggle() end,  "RainbowCursor Timer toggle"},
  {"<leader>ras",function() _G.RainbowCursor.API.Autocmd_Start() end, "RainbowCursor Autocmd start"},
  {"<leader>raS",function() _G.RainbowCursor.API.Autocmd_Stop() end,  "RainbowCursor Autocmd stop"},
  {"<leader>rat",function() _G.RainbowCursor.API.Autocmd_Toggle() end,"RainbowCursor Autocmd toggle"},
 },
}
local default_opts={noremap=true,silent=true}
for modes,key in pairs(keys) do
 local opts=default_opts
 opts.desc=key[3]
 vim.keymap.set(modes,key[1],key[2],opts)
end
```

Lazy keys

```lua
local keys={
 {"<leader>rts",function() _G.RainbowCursor.API.Timer_Start() end,   desc="RainbowCursor Timer start"},
 {"<leader>rtS",function() _G.RainbowCursor.API.Timer_Stop() end,    desc="RainbowCursor Timer stop"},
 {"<leader>rtt",function() _G.RainbowCursor.API.Timer_Toggle() end,  desc="RainbowCursor Timer toggle"},
 {"<leader>ras",function() _G.RainbowCursor.API.Autocmd_Start() end, desc="RainbowCursor Autocmd start"},
 {"<leader>raS",function() _G.RainbowCursor.API.Autocmd_Stop() end,  desc="RainbowCursor Autocmd stop"},
 {"<leader>rat",function() _G.RainbowCursor.API.Autocmd_Toggle() end,desc="RainbowCursor Autocmd toggle"},
}
```

## Example Configuration

Convenient setup for lazy.nvim users

```lua
local spec={
 "abcdefg233/rainbowcursor.nvim",
 cmd={"RainbowCursor"},
 keys={
  {"<leader>rts",function() _G.RainbowCursor.API.Timer_Start() end,   desc="RainbowCursor Timer start"},
  {"<leader>rtS",function() _G.RainbowCursor.API.Timer_Stop() end,    desc="RainbowCursor Timer stop"},
  {"<leader>rtt",function() _G.RainbowCursor.API.Timer_Toggle() end,  desc="RainbowCursor Timer toggle"},
  {"<leader>ras",function() _G.RainbowCursor.API.Autocmd_Start() end, desc="RainbowCursor Autocmd start"},
  {"<leader>raS",function() _G.RainbowCursor.API.Autocmd_Stop() end,  desc="RainbowCursor Autocmd stop"},
  {"<leader>rat",function() _G.RainbowCursor.API.Autocmd_Toggle() end,desc="RainbowCursor Autocmd toggle"},
 },
 opts={
  hlgroup ="RainbowCursor",
  autocmd ={
   autostart=true,
   loopover =36,
   group    ="RainbowCursor",
   event    ={"CursorMoved","CursorMovedI"},
  },
  timer   ={
   autostart=true,
   loopover=180,
   interval=100,
  },
  channels={
   format="hsl",
   {{0,360,1}},
   {{100,100,0}},
   {{50,50,0}},
  },
  others  ={
   create_cmd=true,
   create_var=true,
   create_api=true,
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
 {"<leader>rts",function() _G.RainbowCursor.API.Timer_Start() end,   desc="RainbowCursor Timer start"},
 {"<leader>rtS",function() _G.RainbowCursor.API.Timer_Stop() end,    desc="RainbowCursor Timer stop"},
 {"<leader>rtt",function() _G.RainbowCursor.API.Timer_Toggle() end,  desc="RainbowCursor Timer toggle"},
 {"<leader>ras",function() _G.RainbowCursor.API.Autocmd_Start() end, desc="RainbowCursor Autocmd start"},
 {"<leader>raS",function() _G.RainbowCursor.API.Autocmd_Stop() end,  desc="RainbowCursor Autocmd stop"},
 {"<leader>rat",function() _G.RainbowCursor.API.Autocmd_Toggle() end,desc="RainbowCursor Autocmd toggle"},
}
-- Setup
M.opts={
 hlgroup ="RainbowCursor",
 autocmd ={
  autostart=true,
  loopover =36,
  group    ="RainbowCursor",
  event    ={"CursorMoved","CursorMovedI"},
 },
 timer   ={
  autostart=true,
  loopover=180,
  interval=100,
 },
 channels={
  format="hsl",
  {{0,360,1}},
  {{100,100,0}},
  {{50,50,0}},
 },
 others  ={
  create_cmd=true,
  create_var=true,
  create_api=true,
 },
}
M.dependencies={
 "abcdefg233/hcutil.nvim"
}
return M
```

# [Which-key](https://github.com/folke/which-key.nvim) Binding

```lua
require("which-key").register({
 ["<leader>r"]={
  name="RainbowCursor",
  ["t"]={
   name="Timer",
  },
  ["a"]={
   name="Autocmd",
  },
 },
})
```
