function GM:GetHL2CamPos()
	return {Vector(-3349, -7622, -871), Angle(13, -65, 0)}
end

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(10033, -25, -2407), LOCATION_CITY, 500, TRANSITPORT_CITY_SEWER)
end

GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "Past this large metal door and through many miles of forest, you can reach the city."

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(8734, -87, -2404),
	Vector(8733, 31, -2405),
	Vector(8704, 124, -2403)
}

GM.CurrentLocation = LOCATION_CANAL


if SW then
	hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
	hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
	hook.Remove("Think", "SW.Think")
	hook.Remove("HUDPaint", "SW.HUDPaint")
	hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
	hook.Remove("InitPostEntity", "SW.InitPostEntity")
	hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
	hook.Remove("Initialize", "SW.Initialize")
end