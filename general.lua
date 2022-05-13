r = math.random
rad = math.rad
deg = math.deg
sin = math.sin
cos = math.cos
min = math.max
max = math.min
abs = math.abs
floor = math.floor
ceil = math.ceil
PI = math.pi
sqrt = math.sqrt
foreach = table.foreach
event = addEventHandler
cmd = addCommandHandler
sfw = getScreenFromWorldPosition
wfs = getWorldFromScreenPosition
me = localPlayer

function tcopy(t)
  local new = {}
  for k,v in pairs(t) do
    if type(v) == "table" then
      v = tcopy(v)
    end
    new[k] = v
  end
  return new
end

addEventHandler("onClientKey", root, function(key, p)
  if keyPressed and type(keyPressed) == "function" then
    keyPressed(key, p)
  end
end)

addEventHandler("onClientClick", root, function(btn, state)
  if mousePressed and type(mousePressed) == "function" then
    mousePressed(btn, state)
  end
end)

function findPlayer(str)
  if (str) then
    local plrs = getElementsByType('player');
    for i=1, #plrs do
      if plrs[i].name:gsub("#%x%x%x%x%x%x",""):lower():find(str:lower()) then
        return plrs[i]
      end
    end
  end
end

function plrs()
  return getElementsByType "player"
end

function vehs()
  return getElementsByType "vehicle"
end

function peds()
  return getElementsByType "ped"
end

function objs()
  return getElementsByType "object"
end

function blps()
  return getElementsByType "blip"
end

function js(source, func, ...)
  local args = table.concat(arg, "','")
  source:executeJavascript(func .. "('" .. args .. "')");
end

function dist(...)
  if getUserdataType(arg[1]) == "vector3" or #arg == 6 then
    return getDistanceBetweenPoints3D(unpack(arg))
  elseif getUserdataType(arg[1]) == "vector2" or #arg == 4 then
    return getDistanceBetweenPoints2D(unpack(arg))
  end
end

function round(number, decimals, method)
  decimals = decimals or 0
  local factor = 10 ^ decimals
  if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
  else return tonumber(("%."..decimals.."f"):format(number)) end
end

function mouse(relative)
  local cx, cy = getCursorPosition()
  return cx and cx*cw, cy*ch or false
end

function map(n, start1, stop1, start2, stop2) 
  return ((n-start1)/(stop1-start1))*(stop2-start2)+start2
end

function constrain(num, low, high)
  if not num or not low or not high then error("constrain missing arguments", 2) end
  return (num >= low and num <= high and num) or (num < low and low) or (num > high and high)
end

function findRotation( p1, p2 ) 
    local t = -math.deg( math.atan2( p2.x - p1.x, p2.y - p1.y ) )
    return t < 0 and t + 360 or t
end
