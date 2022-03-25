function GM:GetHL2CamPos()
	return {Vector(-1936, 9311, 96), Angle(16, 0, 0)}
end

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(3650, -2392, 0), LOCATION_CITY, 128, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(3896, -749, 240), LOCATION_CITY, 64, TRANSITPORT_CITY_SEWER)
	self:CreateLocationPoint(Vector(4579, -2542, 458), LOCATION_CITY, 64, TRANSITPORT_CITY_COMBINE)
	self:CreateLocationPoint(Vector(-118, 4499, -44), LOCATION_OUTLANDS, 64, TRANSITPORT_CAVES_ENTRY)
	self:CreateLocationPoint(Vector(-7324, 13628, -274), LOCATION_COAST, 64, TRANSITPORT_COAST_ENTRY)
end

GM.EnableAreaportals = true

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "If you crawl through the hole in the grate, you might be able to find your way back to the city..."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "This door leads to the sewage maintenance tunnels, and it's unlocked. You could get to the city from here."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "Beyond this door is the razor train to the City 17 nexus. If you leave now, you might just make it on board."
GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "The grate is unlocked, and you see antlion tunnels. How are they so close to the city? You could investigate..."
GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "Through this tunnel is freedom - the road from the oppressive city to the wild outlands. The journey is dangerous, the road is long... do you continue?"

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(3562.9711914063, -1443.4263916016, 1.03125),
	Vector(3655.9772949219, -1442.4755859375, 1.03125),
	Vector(3772.1020507813, -1443.5701904297, 1.03125),
	Vector(3773.1369628906, -1588.1538085938, 1.03125),
	Vector(3677.5336914063, -1589.1313476563, 1.03125),
	Vector(3587.6967773438, -1592.3310546875, 1.03125),
	Vector(3588.7778320313, -1697.9118652344, 1.03125),
	Vector(3679.4248046875, -1696.9853515625, 1.03125),
	Vector(3768.673828125, -1696.0729980469, 1.03125),
}
GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
	Vector(-121.24942016602, 4802.3793945313, -43.380271911621),
	Vector(-119.84655761719, 4953.3500976563, -43.608795166016),
}
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(3952.2626953125, 142.99615478516, 241.03125),
	Vector(3647.017578125, 141.09060668945, 257.03125),
	Vector(3485.3000488281, 136.22895812988, 257.03125),
}
GM.EntryPortSpawns[TRANSITPORT_COAST_ENTRY] = {
	Vector(-6828.509765625, 13147.260742188, -274),
	Vector(-6777.673828125, 13086.368164063, -274),
}

GM.CombineSpawnpoints = {
	Vector(4273.853515625, -2462.1652832031, 457.03125),
	Vector(4299.6850585938, -2294.6813964844, 457.03125),
	Vector(4543.9853515625, -2441.6306152344, 457.03125),
	Vector(4544.2373046875, -2361.9907226563, 457.03125),
	Vector(4540.9873046875, -2290.1984863281, 457.03125),
}

GM.CurrentLocation = LOCATION_CANAL

GM.DoorData = {
	{Vector(3704, -3134, 438), DOOR_COMBINEOPEN, "Civil Protection Outpost"},
	{Vector(3940, -3133, 438), DOOR_COMBINEOPEN, "Outpost Inner Airlock"},
	{Vector(3940, -3013, 438), DOOR_COMBINEOPEN, "Airlock Observation Room"},
	{Vector(4171, -2492, 510), DOOR_COMBINEOPEN, "Outpost Barracks"},
	{Vector(4171, -2596, 510), DOOR_COMBINEOPEN, "Outpost Medbay"},
}

function GM:GetCombineCratePos()
	return {Vector(4096,-2272, 472), Angle(0, -90, 0)}
end

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")
