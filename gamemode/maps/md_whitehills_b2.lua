GM.EnableAreaportals = true

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "If you crawl through the hole in the grate, you might be able to find your way back to the city..."

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(2429.902588, -5912.282715, 256.031250), LOCATION_CITY, 300, TRANSITPORT_CITY_GATE)
end

GM.CurrentLocation = LOCATION_CANAL

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")