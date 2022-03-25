function GM:GetHL2CamPos()
	return {Vector(5061, -2163, 1448), Angle(20, 152, 0)}
end

function GM:GetCombineCratePos()
	return {Vector(-12791, -530, 17), Angle(0, -90, 0)}
end

GM.CombineSpawnpoints = {
	Vector(-12731, 202, -7),
	Vector(-12731, 130, -7),
	Vector(-12732, 44, -7),
}

GM.Stoves = {
	{Vector(-12908, -653, 21), Angle(0, -0, 0), "", true},
}

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(1776, -9515, -147), LOCATION_CITY, 256, TRANSITPORT_CITY_GATE) --done
	self:CreateLocationPoint(Vector(8017, -656, -1330), LOCATION_CITY, 256, TRANSITPORT_CITY_SEWER) --done
	self:CreateLocationPoint(Vector(-12773, -945, 64), LOCATION_CITY, 256, TRANSITPORT_CITY_COMBINE) --done
	-- self:CreateLocationPoint(Vector(8077, -961, -1338), LOCATION_OUTLANDS, 256, TRANSITPORT_CAVES_ENTRY) --done
end

GM.EnableAreaportals = true

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "If you crawl through the hole in the grate, you might be able to find your way back to the city..."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "This door leads to the sewage maintenance tunnels, and it's unlocked. You could get to the city from here."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "Beyond this door is the razor train to the City 17 nexus. If you leave now, you might just make it on board."
GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "The grate is unlocked, and you see antlion tunnels. How are they so close to the city? You could investigate..."
GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "Through this tunnel is freedom - the road from the oppressive city to the wild outlands. The journey is dangerous, the road is long... do you continue?"

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(1678, -9250, -129),
	Vector(1860, -9256, -129),
	Vector(1753, -9109, -137),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector(-2134, 3417, 234),
	Vector(-12781, 52, 87),
	Vector(-12779, 123, 87),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(9928, -1101, -1249),
	Vector(10080, -1101, -1249),
	Vector(10200, -1101, -1249),
}

GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
	Vector(9928, -500, -1249),
	Vector(10080, -500, -1249),
	Vector(10200, -500, -1249),
}

GM.EntryPortSpawns[TRANSITPORT_COAST_ENTRY] = {
	Vector(9928, -700, -1249),
	Vector(10080, -700, -1249),
	Vector(10200, -700, -1249),
	Vector(9928, -800, -1249),
	Vector(10080, -800, -1249),
	Vector(10200, -800, -1249),
}

GM.CurrentLocation = LOCATION_CANAL

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")
