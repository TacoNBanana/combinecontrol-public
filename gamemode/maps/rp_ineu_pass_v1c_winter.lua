function GM:GetHL2CamPos()
	return {Vector(-8552, -2068, -2338), Angle(11.5, 66.4, 0.0)}
end

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(9171, -15380, -960), LOCATION_CITY, 128, TRANSITPORT_CITY_GATE) -- Caved in tunnel
	self:CreateLocationPoint(Vector(-11071, 5547, -2749), LOCATION_CITY, 64, TRANSITPORT_CITY_SEWER) -- soem river bed thing
	self:CreateLocationPoint(Vector(5439, 4564, -387), LOCATION_CITY, 64, TRANSITPORT_CITY_COMBINE) --dropship pod
end

GM.EnableAreaportals = true

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "If you crawl over the debris and follow the tunnel for a long time you might make it to an abandonded highway near the City..."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "If you follow this old frozen water bed you'll find an abandonded water treatment facility which connect to the Canals, bringing you to the city."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "This dropship will take you to the City 17 nexus. If you leave now, you might just make it on board."

-- Using normal spawns
--GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
--	Vector(3562.9711914063, -1443.4263916016, 1.03125),
--	Vector(3655.9772949219, -1442.4755859375, 1.03125),
--	Vector(3772.1020507813, -1443.5701904297, 1.03125),
--	Vector(3773.1369628906, -1588.1538085938, 1.03125),
--	Vector(3677.5336914063, -1589.1313476563, 1.03125),
--	Vector(3587.6967773438, -1592.3310546875, 1.03125),
--	Vector(3588.7778320313, -1697.9118652344, 1.03125),
--	Vector(3679.4248046875, -1696.9853515625, 1.03125),
--	Vector(3768.673828125, -1696.0729980469, 1.03125),
--}

--GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
--	Vector(3952.2626953125, 142.99615478516, 241.03125),
--	Vector(3647.017578125, 141.09060668945, 257.03125),
--	Vector(3485.3000488281, 136.22895812988, 257.03125),
--}

GM.CombineSpawnpoints = {
	Vector(4837.833984, 3807.866455, -381.801758),
	Vector(4832.634277, 3676.547607, -381.801758),
	Vector(4841.135742, 3526.120605, -381.801758),
	Vector(5012.910156, 3568.319092, -381.801758),
	Vector(5058.812988, 3746.068604, -381.801758),
}

GM.CurrentLocation = LOCATION_CANAL

-- I'm too Lazy
--GM.DoorData = {
--	{Vector(3704, -3134, 438), DOOR_COMBINEOPEN, "Civil Protection Outpost"},
--	{Vector(3940, -3133, 438), DOOR_COMBINEOPEN, "Outpost Inner Airlock"},
--	{Vector(3940, -3013, 438), DOOR_COMBINEOPEN, "Airlock Observation Room"},
--	{Vector(4171, -2492, 510), DOOR_COMBINEOPEN, "Outpost Barracks"},
--	{Vector(4171, -2596, 510), DOOR_COMBINEOPEN, "Outpost Medbay"},
--}

-- I have no idea how to do this
--function GM:GetCombineCratePos() 
--	return {Vector(4096,-2272, 472), Angle(0, -90, 0)}
--end

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")