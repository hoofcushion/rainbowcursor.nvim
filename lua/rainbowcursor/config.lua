local M={}
M.options={
 hlgroup="Cursor",
 autostart=true,
 interval=3600,
 color_amount=360,
 hue_start=0,
 saturation=100,
 lightness=50,
 others={
  create_cmd=true,
  create_var=true,
  create_api=true,
 },
}
local function number(arg)
 return type(arg)=="number"
end
local function integer(arg)
 return number(arg) and arg%1==0
end
M.setup=function(user_options)
 local opts=vim.tbl_deep_extend("force",M.options,user_options or {})
 vim.validate({
  hlgroup     ={opts.hlgroup,"string"},
  autostart   ={opts.autostart,"boolean"},
  interval    ={opts.interval,integer,"integer"},
  color_amount={opts.color_amount,function(arg) return integer(arg) and arg>0 end,"integer arg, arg>0"},
  hue_start   ={opts.hue_start,function(arg) return number(arg) and arg>=0 and arg<=360 end,"integer arg, 0<=arg<=360"},
  saturation  ={opts.saturation,function(arg) return number(arg) and arg>=0 and arg<=100 end,"integer arg, 0<=arg<=100"},
  lightness   ={opts.lightness,function(arg) return number(arg) and arg>=0 and arg<=100 end,"integer arg, 0<=arg<=100"},
  others      ={opts.others,function(arg)
   if type(arg)=="table" then
    vim.validate({
     create_cmd={arg.create_cmd,"boolean"},
     create_var={arg.create_var,"boolean"},
     create_api={arg.create_api,"boolean"},
    })
    return true
   end
  end,"{create_cmd=boolean,create_var=boolean,create_api=boolean}"},
 })
 M.options=opts
end
return M