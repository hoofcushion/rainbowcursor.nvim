local M={}
---@param p number
---@param q number
---@param h number
local function hue_to_rgb(p,q,h)
 if h<0 then h=h+1 elseif -h<-1 then h=h-1 end
 if h<1/6 then return p+(q-p)*6*h end
 if h<1/2 then return q end
 if h<2/3 then return p+(q-p)*(2/3-h)*6 end
 return p
end
---@param h number # Hue
---@param s number # Saturation
---@param l number # Lightness
---@return ... integer
function M.hsl(h,s,l)
 l=l/100
 if s==0 then
  l=math.floor(l*255)
  return l,l,l
 end
 h,s=h/360,s/100
 local q=l<0.5 and l*(1+s) or l+s-l*s
 local p=2*l-q
 local r,g,b=hue_to_rgb(p,q,h+1/3),hue_to_rgb(p,q,h),hue_to_rgb(p,q,h-1/3)
 return math.floor(r*255),math.floor(g*255),math.floor(b*255)
end
function M.rgb(r,g,b)
 return r,g,b
end
return M
