local HCUtil=require("hcutil")
local Config=require("rainbowcursor.config")
local floor=math.floor
local M={}
local H={}
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
---@param h number # Hue
---@param s number # Saturation
---@param l number # Lightness
---@return ... integer
local function hsl_to_rgb(h,s,l)
 l=l/100
 if s==0 then
  l=floor(l*255)
  return l,l,l
 end
 h,s=h/360,s/100
 local q=l<0.5 and l*(1+s) or l+s-l*s
 local p=2*l-q
 local r,g,b=hue_to_rgb(p,q,h+1/3),hue_to_rgb(p,q,h),hue_to_rgb(p,q,h-1/3)
 return floor(r*255),floor(g*255),floor(b*255)
end
local function rgb_to_colorcode(r,g,b)
 return string.format("#%02x%02x%02x",r,g,b)
end
local function make_color_table()
 local color_table={}
 local hue        =Config.options.hue_start
 local saturation =Config.options.saturation
 local lightness  =Config.options.lightness
 local step       =360/Config.options.color_amount
 while hue<360 do
  table.insert(color_table,rgb_to_colorcode(hsl_to_rgb(hue,saturation,lightness)))
  hue=hue+step
 end
 return color_table
end
local function create_color_iter(step)
 local hlgroup     =Config.options.hlgroup
 local color_amount=Config.options.color_amount
 local hl_opts     ={}
 return function()
  local int_pos=floor(H.color_pos)
  if int_pos>=H.color_pos then
   hl_opts.bg=H.color_table[int_pos]
   vim.api.nvim_set_hl(0,hlgroup,hl_opts)
  end
  H.color_pos=H.color_pos%color_amount+step
 end
end
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
---@param target boolean
local function update_cursor_hlgroup(target)
 if target==H.hlgroup_on then
  return
 end
 if H.hlgroup_on==false then
  set_cursor_hlgroup(Config.options.hlgroup)
  H.hlgroup_on=true
 elseif H.main_timer:is_active()==false and H.autocmd_obj.active==false then
  set_cursor_hlgroup(false)
  H.hlgroup_on=false
 end
end
local Actions={}
M.Actions=Actions
Actions.Timer={
 Start=function()
  if H.main_timer:is_active() then
   print("RainbowCursor: Timer Start failed, The Timer is active.")
  else
   local interval=floor(Config.options.timer.interval/Config.options.color_amount)
   update_cursor_hlgroup(true)
   H.main_timer:start(0,interval,H.scheduled_color_iter)
  end
 end,
 Stop=function()
  if H.main_timer:is_active() then
   H.main_timer:stop()
   update_cursor_hlgroup(false)
  else
   print("RainbowCursor: Timer Stop failed, The Timer is already inactive.")
  end
 end,
 Toggle=function()
  if H.main_timer:is_active() then
   Actions.Timer.Stop()
  else
   Actions.Timer.Start()
  end
 end,
}
Actions.Autocmd={
 Start=function()
  if H.autocmd_obj.active then
   print("RainbowCursor: Autocmd Start failed, The Autocmd is active.")
  else
   update_cursor_hlgroup(true)
   H.autocmd_obj:start()
  end
 end,
 Stop=function()
  if H.autocmd_obj.active then
   H.autocmd_obj:delete()
   update_cursor_hlgroup(false)
  else
   print("RainbowCursor: Autocmd Stop failed, The Autocmd is active.")
  end
 end,
 Toggle=function()
  if H.autocmd_obj.active then
   Actions.Autocmd.Start()
  else
   Actions.Autocmd.Stop()
  end
 end,
}
Actions.RainbowCursor={
 Timer=Actions.Timer,
 Autocmd=Actions.Autocmd,
}
function M.RainbowCursor(...)
 local args={...}
 local action=Actions.RainbowCursor
 for i=1,#args do
  action=action[args[i]]
  if not action then return end
  if type(action)=="function" then
   action()
   return
  end
 end
end
local function satus_setup()
 H.hlgroup_on      =false
 H.color_table=make_color_table()
 H.color_pos  =1
end
local function timer_setup()
 H.main_timer          =vim.loop.new_timer()
 H.timer_color_iter    =create_color_iter(1)
 H.scheduled_color_iter=vim.schedule_wrap(H.timer_color_iter)
end
local function autocmd_setup()
 H.autocmd_color_iter=create_color_iter(Config.options.color_amount/Config.options.autocmd.interval)
 H.autocmd_obj       =HCUtil.create_autocmd_object(Config.options.autocmd.group,{
  func={Config.options.autocmd.event,{
   callback=H.autocmd_color_iter,
  }},
 })
end
function M.setup()
 H={}
 satus_setup()
 timer_setup()
 autocmd_setup()
 M.TimerColorIter  =H.timer_color_iter
 M.AutocmdColorIter=H.autocmd_color_iter
end
return M
