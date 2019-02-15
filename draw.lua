return function(sw, sh)
	-- local dx = {}

	local cw, ch = guiGetScreenSize()

	function getMouse(relative)
		local cx, cy = getCursorPosition()
		if not cx then return false end
		if relative then
			return Vector2(cx*sw, cy*sh)
		else
			return Vector2(cx*cw, cy*ch)
		end
	end

	function mouseIn(x, y, w, h)
		if isCursorShowing() then
			local cx, cy = getCursorPosition()
			local cx, cy = cx*sw,cy*sh
			if cx >= x and cx <= x+w and cy >= y and cy <= y+h then
				return cx, cy
			end
		end
	end

	addEventHandler("onClientRender", root, function()
		if draw and type(draw) == "function" then
			draw()
		end
	end)

	function browser(...)
		arg[1], arg[2], arg[3], arg[4] = arg[1]/sw*cw, arg[2]/sh*ch, arg[3]/sw*cw, arg[4]/sh*ch
		return guiCreateBrowser(unpack(arg))
	end

	function rect(...)
		arg[1], arg[2], arg[3], arg[4] = arg[1]/sw*cw, arg[2]/sh*ch, arg[3]/sw*cw, arg[4]/sh*ch
		return dxDrawRectangle(arg[1], arg[2], arg[3], arg[4], arg[5], arg[6] )
	end

	function line(...)
		arg[1], arg[2], arg[3], arg[4], arg[6] = arg[1]/sw*cw, arg[2]/sh*ch, arg[3]/sw*cw, arg[4]/sh*ch, (arg[6] or 1)/sw*cw
		return dxDrawLine( arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7] )
	end

	function text(...)
		arg[2], arg[3], arg[4], arg[5], arg[7] = arg[2]/sw*cw, arg[3]/sh*ch, arg[4]/sw*cw, arg[5]/sh*ch, (arg[7] or 1)/sw*cw
		return dxDrawText(arg[1],arg[2],arg[3],(arg[4]or arg[2]),(arg[5]or arg[3]),arg[6],arg[7],(arg[8] or "default"),(arg[9]or "left"),(arg[10]or "top"),arg[11],arg[12],arg[13],arg[14],arg[15],arg[16],arg[17],arg[18])
	end

	function image(...)
		arg[1], arg[2], arg[3], arg[4] = arg[1]/sw*cw, arg[2]/sh*ch, arg[3]/sw*cw, arg[4]/sh*ch
		return dxDrawImage(arg[1],arg[2],arg[3],arg[4],arg[5],arg[6],arg[7],arg[8],arg[9],arg[10])
	end
end