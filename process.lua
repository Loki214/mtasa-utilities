return function(t, showline)
	local hit, x, y, z, elem, mx, my, mz, mat, light, piece, wmId, wmpX, wmpY, wmpZ, wmrX, wmrY, wmrZ, wlmId = processLineOfSight(
		(a[1]or a.x), -- startPos
		(a[2]or a.y), -- startPos
		(a[3]or a.z), -- startPos
		(b[1]or b.x), -- endPos
		(b[2]or b.y), -- endPos
		(b[3]or b.z), -- endPos
		(t.world or false), --checkBuildings
		(t.vehicles or false), --checkVehicles
		(t.players or false), --checkPlayers
		(t.objects or false), --checkObjects
		(t.dummies or false), --checkDummies
		(t.seeThrough or false), --seeThroughStuff
		(t.ignoreSomeObjectsForCamera or false), --ignoreSomeObjectsForCamera
		(t.shootThrough or false), --shootThroughStuff
		t.ignoredElement, --ignoredElement
		(t.includeWorldModelInfo or false), --includeWorldModelInformation
		(t.inCludeCarTyres or false) --bIncludeCarTyres
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
		dxDrawLine3D((a[1]or a.x),(a[2]or a.y),(a[3]or a.z),(b[1]or b.x),(b[2]or b.y),(b[3]or b.z), -1, 3);
		if (hit) then
			dxDrawLine3D((a[1]or a.x),(a[2]or a.y),(a[3]or a.z), hitdata.pos.x, hitdata.pos.y, hitdata.pos.z, tocolor(255,0,0), 3);
		end
	end
	return hit and hitdata
end
