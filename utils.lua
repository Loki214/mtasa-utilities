local utils = {}

function utils.round(number, decimals, method)
	decimals = decimals or 0
	local factor = 10 ^ decimals
	if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
	else return tonumber(("%."..decimals.."f"):format(number)) end
end

function utils.mouse(relative)
	local cx, cy = getCursorPosition()
	return cx and Vector2(cx*cw, cy*ch) or false
end

function utils.map(n, start1, stop1, start2, stop2)
	return ((n-start1)/(stop1-start1))*(stop2-start2)+start2
end

function utils.constrain(num, low, high)
	if not num or not low or not high then error("constrain missing arguments", 2) end
	return (num >= low and num <= high and num) or (num < low and low) or (num > high and high)
end

return utils