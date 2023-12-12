local HCUtil=require("hcutil")
local M={}
local default_opts={
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
M.options=vim.deepcopy(default_opts)
local function number(x)
 return type(x)=="number"
end
local function integer(x)
 return number(x) and x%1==0
end
local function is_string(x)
 return type(x)=="string"
end
local valitab={
 hlgroup     ="string",
 autocmd     ={
  autostart="boolean",
  interval ={function(x) return integer(x) and x>0 or is_string(x) end,"integer x, x>0; or string"},
  group    ="string",
  event    ={"string","table"},
 },
 timer       ={
  autostart="boolean",
  interval={function(x) return integer(x) and x>0 or is_string(x) end,"integer x, x>0; or string"},
 },
 color_amount={function(x) return integer(x) and x>0 end,"integer x, x>0"},
 hue_start   ={function(x) return number(x) and x>=0 and x<=360 end,"integer x, 0<=x<=360"},
 saturation  ={function(x) return number(x) and x>=0 and x<=100 end,"integer x, 0<=x<=100"},
 lightness   ={function(x) return number(x) and x>=0 and x<=100 end,"integer x, 0<=x<=100"},
 others      ={
  create_cmd="boolean",
  create_var="boolean",
  create_api="boolean",
  reuse_opts="boolean",
 },
}
---@param user_options table
function M.setup(user_options)
 if type(user_options)~="table" then
  return
 end
 local opts=vim.tbl_deep_extend("force",default_opts,user_options)
 HCUtil.validate_tab(opts,valitab)
 if opts.others.reuse_opts==true then
  opts=vim.tbl_deep_extend("force",M.options,user_options)
 end
 M.options=opts
end
return M
