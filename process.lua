return function(t, showline)
	local hit, x, y, z, elem, mx, my, mz, mat, light, piece, wmId, wmpX, wmpY, wmpZ, wmrX, wmrY, wmrZ, wlmId = processLineOfSight(
		t.a, -- startPos
		t.b, -- endPos
		t.buildings or true, --checkBuildings
		t.vehicles or true, --checkVehicles
		t.players or true, --checkPlayers
		t.objects or true, --checkObjects
		t.dummies or true, --checkDummies
		t.seeThrough or false, --seeThroughStuff
		t.ignoreSomeObjectsForCamera or true, --ignoreSomeObjectsForCamera
		t.shootThrough or false, --shootThroughStuff
		t.ignoredElement or nil, --ignoredElement
		t.includeWorldModelInfo or false, --includeWorldModelInformation
		t.inCludeCarTyres or false --bIncludeCarTyres
	)
	local hitdata = {
		pos = Vector3(x,y,z),
		element = elem,
		normal = Vector3(mx,my,mz),
		material = mat,
		lighting = light,
		piece = piece,
		worldModelId = wmId,
		worldModelPos = Vector3(wmpX, wmpY, wmpZ),
		worldModelRot = Vector3(wmrX, wmrY, wmrZ),
		worldLODModelId = wlmId
	}
	if (showline) then
		dxDrawLine3D(a, b, tocolor(255,255,255), 3)
		if (hit) then
			dxDrawLine3D(a, hitdata.pos, tocolor(255, 0, 0), 3)
		end
	end
	return hit and hitdata
end