function GM:GetHL2CamPos()

	return {Vector(-6186, 1940, -6097), Angle(-1.87, 38.9, 0.0)}
end

function GM:MapInitPostEntity()
--	self:CreateLocationPoint(Vector(11466, -7884, -13476), LOCATION_CANAL, 256, TRANSITPORT_CITY_SEWER) --canals entrance changed to vort cave to save run time
	self:CreateLocationPoint(Vector(12903, -4631, -5290), LOCATION_CITY, 256, TRANSITPORT_CITY_SEWER) --start of coast09 tunnel	
	self:CreateLocationPoint(Vector(-3236 -8782 -6912), LOCATION_CITY, 256, TRANSITPORT_CITY_COMBINE) --done, red shack by port

	
	--NLO Antlions
	--[[self:AddAntlionSpawn(Vector(-6246, -9989, -13523), 2)
	self:AddAntlionSpawn(Vector(-4399, -8769, -13655), 2)
	self:AddAntlionSpawn(Vector(-4406, -4533, -13644), 2)
	self:AddAntlionSpawn(Vector(-6218, -3302, -13619), 2)	
	self:AddAntlionSpawn(Vector(-5594, -170, -13662), 2)
	self:AddAntlionSpawn(Vector(-7125, 4519, -13638), 2)
	self:AddAntlionSpawn(Vector(-7001, 8426, -13630), 2)
	self:AddAntlionSpawn(Vector(-4764, 8513, -13538), 2)
	self:AddAntlionSpawn(Vector(1732, 8781, -13444), 2)
	self:AddAntlionSpawn(Vector(3713, 5258, -13655), 2)
	self:AddAntlionSpawn(Vector(4061, 2753, -13655), 2)
	self:AddAntlionSpawn(Vector(4447, -2894, -13699), 2)	
	self:AddAntlionSpawn(Vector(3767, -4720, -13704), 2)
	self:AddAntlionSpawn(Vector(-3798, 8085, -13634), 2)
	self:AddAntlionSpawn(Vector(-7472, 3585, -13700), 2)
	self:AddAntlionSpawn(Vector(-7370, -2857, -13539), 2)]]--	
end

GM.EnableAreaportals = true

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "This maintenance shaft leads back into the city."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "This tunnel leads back to the canals."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "You can summon the helicopter to take you back to the City 17 Nexus here."
GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "You come across an enrance to the caves."

--[[ --caves entrance nlo
GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
	Vector(9542, -7809, -13754),
	Vector(9786, -7590, -13662),
	Vector(10024, -7443, -13592),
	Vector(10224, -7335, -13539),
	Vector(9919, -7287, -13596),	
}

--canals entrance coast09 tunnel - done
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(12634, -4537, -5311),
	Vector(12633, -4647, -5311),
	Vector(12476, -4700, -5311),
	Vector(12347, -4658, -5311),
	Vector(12195, -4605, -5311),
	Vector(12034, -4590, -5311),	
} ]]

--combine port dock
GM.CombineSpawnpoints = {
	Vector(-2651, -8571, -6656),
	Vector(-2846, -8586, -6656),
	Vector(-1900, -8550, -6656),
	Vector(-2124, -8587, -6656),
}

GM.CurrentLocation = LOCATION_CANAL

GM.Stoves = { 
	{Vector(8085.911133, 3612.968750, -13335.968750), Angle(18, -90, 0.000000), "NLO"},

}

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")