local Config=require("rainbowcursor.config")
local M={}
---@param p number
---@param q number
---@param t number
local function hue_to_rgb(p,q,t)
 if t<0 then t=t+1 elseif -t<-1 then t=t-1 end
 if t<1/6 then return p+(q-p)*6*t end
 if t<1/2 then return q end
 if t<2/3 then return p+(q-p)*(2/3-t)*6 end
 return p
end
---@param ... number
local function percent_to_8bit(...)
 local args={...}
 for i=1,#args do
  args[i]=math.floor(args[i]*255)
 end
 return unpack(args)
end
---@param h integer # Hue
---@param s integer # Saturation
---@param l integer # Lightness
local function hsl_to_rgb(h,s,l)
 ---@diagnostic disable-next-line: cast-local-type
 h,s,l=h/360,s/100,l/100
 local r,g,b
 if s==0 then
  r,g,b=l,l,l
 else
  local q=l<0.5 and l*(1+s) or l+s-l*s
  local p=2*l-q
  r,g,b=hue_to_rgb(p,q,h+1/3),hue_to_rgb(p,q,h),hue_to_rgb(p,q,h-1/3)
 end
 return percent_to_8bit(r,g,b)
end
local function rgb_to_colorcode(r,g,b)
 return string.format("#%02x%02x%02x",r,g,b)
end
local function make_hue_table()
 local hue_start=Config.options.hue_start
 local color_amount=Config.options.color_amount
 local saturation=Config.options.saturation
 local lightness=Config.options.lightness
 local hue_table={}
 for hue=hue_start,360,360/color_amount do
  table.insert(hue_table,rgb_to_colorcode(hsl_to_rgb(hue,saturation,lightness)))
 end
 return hue_table
end
local function get_rainbowcursor_schedule()
 local hue_table=make_hue_table()
 local pos=1
 return vim.schedule_wrap(function()
  vim.api.nvim_set_hl(0,Config.options.hlgroup,{bg=hue_table[pos]})
  pos=pos%Config.options.color_amount+1
 end)
end
local timer=vim.loop.new_timer()
local function set_cursor_hlgroup(hlgroup)
 local guicursor={}
 for item in string.gmatch(vim.o.guicursor,"[^,]+") do
  item=string.match(item,"^.+:[^-]+")
  if hlgroup then
   item=item.."-"..hlgroup
  end
  table.insert(guicursor,item)
 end
 vim.opt.guicursor=guicursor
end
local Actions={}
Actions.RainbowCursor={
 Start=function()
  if vim.loop.is_active(timer) then
   print("RainbowCursor: Start faild, The Timer is already active.")
  else
   local interval=math.floor(Config.options.interval/Config.options.color_amount)
   timer:start(0,interval,get_rainbowcursor_schedule())
   set_cursor_hlgroup(Config.options.hlgroup)
  end
 end,
 Stop=function()
  if vim.loop.is_active(timer) then
   timer:stop()
   set_cursor_hlgroup(nil)
  else
   print("RainbowCursor: Stop faild, The Timer is already inactive.")
  end
 end,
 Toggle=function()
  if vim.loop.is_active(timer) then
   Actions.RainbowCursor.Stop()
  else
   Actions.RainbowCursor.Start()
  end
 end,
}
function M.RainbowCursor(arg)
 if not arg then return end
 local action=Actions.RainbowCursor[arg]
 if action then
  action()
 end
end
M.Actions=Actions
return M