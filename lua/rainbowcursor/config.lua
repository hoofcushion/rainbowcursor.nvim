local HCUtil=require("hcutil")
local M={}
M.options={
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
local default_opts=vim.deepcopy(M.options)
local function number(x)
 return type(x)=="number"
end
local function integer(x)
 return number(x) and x%1==0
end
local validate_table={
 hlgroup ="string",
 autocmd ={
  autostart="boolean",
  loopover ={function(x) return number(x) and x>0 end,"number x, x>0"},
  group    ="string",
  event    ={"string","table"},
 },
 timer   ={
  autostart="boolean",
  loopover={function(x) return number(x) and x>0 end,"number x, x>0"},
  interval={function(x) return integer(x) and x>0 end,"integer x, x>0"},
 },
 channels={
  "array",
  {
   "array",
   {
    "map",{"number","number",{function(x) return number(x) and x>=0 end,"number x, x>=0"}},
   },
  },
 },
 others  ={
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
 HCUtil.Validate.tab(opts,validate_table,"RainbowCursorConfig")
 M.options=opts
end
return M
