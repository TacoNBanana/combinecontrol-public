function GM:GetHL2CamPos()
	return {Vector(6133, -6219, -6098), Angle(11, 149, 0)}
end

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(-15165, 14332, -10024), LOCATION_CITY, 512, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(-14764, 10108, -10400), LOCATION_CITY, 256, TRANSITPORT_CITY_SEWER)
end

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "The winding streets of this deserted town lead back into the heart of City 17. With some luck and know-how you'll be able to avoid the Metropolice's regular patrols."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "You can slip through the bars of this storm drain and hopefully navigate the tunnels back into the city."

GM.CombineSpawnpoints = {
	Vector(9194, -3773, -7616),
	Vector(9316, -3980, -7616),
	Vector(9418, -3637, -7616),
	Vector(9022, -3733, -7616),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(-15037, 5750, -10041),
	Vector(-14915, 5913, -10043),
	Vector(-15067, 6123, -10038),
	Vector(-15293, 6296, -10056),
	Vector(-15262, 6610, -10063),
	Vector(-15062, 6723, -10059),
	Vector(-14788, 6647, -10061),
	Vector(-14700, 6357, -10047),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(-14457, 9786, -10463),
	Vector(-14269, 9716, -10453),
	Vector(-14257, 9598, -10415),
	Vector(-14195, 9532, -10415),
	Vector(-14123, 9460, -10415),
	Vector(-14359, 9615, -10459),
	Vector(-14266, 9526, -10461),
	Vector(-14152, 9408, -10460),
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