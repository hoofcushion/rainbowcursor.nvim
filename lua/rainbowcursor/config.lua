local HCUtil=require("hcutil")
local M={}
M.options={
 rainbowcursor={
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
 },
 others       ={
  create_cmd=true,
  create_var=true,
  create_api=true,
 },
}
local default_opts=vim.deepcopy(M.options)
local function number(x)
 return type(x)=="number"
end
local function integer(x)
 return number(x) and x%1==0
end
local validate_table={
 rainbowcursor={
  hlgroup ="string",
  autocmd ={
   autostart="boolean",
   loopover =function(x) return number(x) and x>0,"number x, x>0" end,
   group    ="string",
   event    =HCUtil.Validate.mk_plist("string"),
  },
  timer   ={
   autostart="boolean",
   loopover=function(x) return number(x) and x>0,"number x, x>0" end,
   interval=function(x) return integer(x) and x>0,"integer x, x>0" end,
  },
  channels=HCUtil.Validate.mk_punion(
   {
    format=HCUtil.Validate.mk_enum("hsl","rgb"),
   },
   HCUtil.Validate.mk_square({
    [1]="number",
    [2]="number",
    [3]=function(x) return number(x) and x>=0,"number x, x>=0" end,
   })
  ),
 },
 others       ={
  create_cmd="boolean",
  create_var="boolean",
  create_api="boolean",
 },
}
---@param user_options table
function M.setup(user_options)
 if type(user_options)~="table" then
  return
 end
 local opts=vim.tbl_deep_extend("force",default_opts,user_options)
 HCUtil.Validate.vali(opts,validate_table,"RainbowCursor.options")
 M.options=opts
end
return M
