# rainbowcursor.nvim

A plugins for Neovim to rainbow the cursor.

### Demo

https://github.com/abcdefg233/rainbowcursor.nvim/assets/32760059/fc28f6be-f9ea-4c02-a5c5-79bcbfc3ddaf

## Installation

With [Lazy](https://github.com/folke/lazy.nvim)

```lua
{
 "abcdefg233/rainbowcursor.nvim",
 cmd={"RainbowCursor"},
 opts={},
}
```

Configuration

```lua
{
 "abcdefg233/rainbowcursor.nvim",
 cmd={"RainbowCursor"},
 opts={
  hlgroup="Cursor",
   -- The rainbowcursor hlgroup's name.
  autostart=true,
   -- Automatically start rainbowcursor right after setup.
  interval=3600,
   -- How long is a rainbow color interval, in millisecond.
  color_amount=360,
   -- How many color are in the rainbow color set.
   -- If opts.interval is 3600 and opts.color_amount is 360, then the color will changes in every 10 ms (3600/360)
   -- The speed of changes will not lower than 1ms, because of the Neovim's limit.
  hue_start=0,
   -- The hue of hsl, 0 means red and 360 means red too.
  saturation=100,
   -- The saturation of hsl, lower than 100 will dim the color.
  lightness=50,
   -- The lightness of hsl, high or lower than 50 will make color lighter or darker.
  others={
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
}
```

## Usage

Lua API

```lua
-- You can get the API by these following ways.
-- If you do not like Lua way, you can disable API
-- by setting options create_var and create_api to false,
-- and use command instead.

require("rainbowcursor.api")
-- Works but not elegant.

require("rainbowcursor").API
-- Needs *others.create_api==true.

_G.RainbowCursor.API
-- Needs *others.create_api==true.
-- Needs *others.create_var==true.
```

```lua
_G.RainbowCursor.API.RainbowCursor("Start" or "Stop" or "Toggle")
 -- See commands below
_G.RainbowCursor.API.Start()
 -- Start Rainbowcursor loop timer
_G.RainbowCursor.API.Stop()
 -- Stop Rainbowcursor loop timer
_G.RainbowCursor.API.Toggle()
 -- Toggle Rainbowcursor loop timer
```

Cmd

If `*others.create_cmd==true`, you will get a command `RainbowCursor` after setup.

You can use it in these following terms

```lua
:RainbowCursor Start
 -- Start Rainbowcursor loop timer
:RainbowCursor Stop
 -- Stop Rainbowcursor loop timer
:RainbowCursor Toggle
 -- Toggle Rainbowcursor loop timer
```

Use by shortcuts

Normal Keys

```lua
local keys={
 [{"n"}]={
  {"<leader>rcs",_G.RainbowCursor.API.Start, "RainbowCursor Start"},
  {"<leader>rcs",_G.RainbowCursor.API.Stop,  "RainbowCursor Stop"},
  {"<leader>rct",_G.RainbowCursor.API.Toggle,"RainbowCursor Toggle"},
 },
}
local default_opts={noremap=true,silent=true}
for modes,key in ipairs(keys) do
 for _,mode in ipairs(modes) do
  local opts=default_opts
  opts.desc=key[3]
  vim.keymap.set(mode,key[1],key[2],opts)
 end
end
```

Lazy keys

```lua
{
 {"<leader>rcs",_G.RainbowCursor.API.Start, desc="RainbowCursor Start", mode="n"},
 {"<leader>rcs",_G.RainbowCursor.API.Stop,  desc="RainbowCursor Stop",  mode="n"},
 {"<leader>rct",_G.RainbowCursor.API.Toggle,desc="RainbowCursor Toggle",mode="n"},
}
```

## Example Configuration

Convenient setup for lazy.nvim users

```lua
{
 "abcdefg233/rainbowcursor.nvim",
 cmd={"RainbowCursor"},
 keys={
  {"<leader>rcs",_G.RainbowCursor.API.Start, "RainbowCursor Start", mode="n"},
  {"<leader>rcs",_G.RainbowCursor.API.Stop,  "RainbowCursor Stop",  mode="n"},
  {"<leader>rct",_G.RainbowCursor.API.Toggle,"RainbowCursor Toggle",mode="n"},
 },
 opts={
  hlgroup="Cursor",
   -- The rainbowcursor hlgroup's name.
  autostart=true,
   -- Automatically start rainbowcursor right after setup.
  interval=3600,
   -- How long is a rainbow color interval, in millisecond.
  color_amount=360,
   -- How many color are in the rainbow color set.
   -- If opts.interval is 3600 and opts.color_amount is 360, then the color will changes in every 10 ms (3600/360)
   -- The speed of changes will not lower than 1ms, because of the Neovim's limit.
  hue_start=0,
   -- The hue of hsl, 0 means red and 360 means red too.
  saturation=100,
   -- The saturation of hsl, lower than 100 will dim the color.
  lightness=50,
   -- The lightness of hsl, high or lower than 50 will make color lighter or darker.
  others={
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
 {"<leader>rcs",_G.RainbowCursor.API.Start, "RainbowCursor Start", mode="n"},
 {"<leader>rcs",_G.RainbowCursor.API.Stop,  "RainbowCursor Stop",  mode="n"},
 {"<leader>rct",_G.RainbowCursor.API.Toggle,"RainbowCursor Toggle",mode="n"},
}
-- Setup
M.opts={
 hlgroup="Cursor",
  -- The rainbowcursor hlgroup's name.
 autostart=true,
  -- Automatically start rainbowcursor right after setup.
 interval=3600,
  -- How long is a rainbow color interval, in millisecond.
 color_amount=360,
  -- How many color are in the rainbow color set.
  -- If opts.interval is 3600 and opts.color_amount is 360, then the color will changes in every 10 ms (3600/360)
  -- The speed of changes will not lower than 1ms, because of the Neovim's limit.
 hue_start=0,
  -- The hue of hsl, 0 means red and 360 means red too.
 saturation=100,
  -- The saturation of hsl, lower than 100 will dim the color.
 lightness=50,
  -- The lightness of hsl, high or lower than 50 will make color lighter or darker.
 others={
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
}
return M
```
