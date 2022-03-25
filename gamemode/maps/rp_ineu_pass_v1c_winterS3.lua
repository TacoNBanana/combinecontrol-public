function GM:GetHL2CamPos()

	return {Vector(-8552, -2068, -2338), Angle(11.5, 66.4, 0.0)}
end

function GM:MapInitPostEntity()
--	self:CreateLocationPoint(Vector(11466, -7884, -13476), LOCATION_CANAL, 256, TRANSITPORT_CITY_SEWER) -- Ignoring for this map
	self:CreateLocationPoint(Vector(9171, -15380, -960), LOCATION_CANAL, 256, TRANSITPORT_COAST_ENTRY) --Caved in road tunnel	
--	self:CreateLocationPoint(Vector( 14462, -14687, 80), LOCATION_CITY, 256, TRANSITPORT_CITY_COMBINE) --COTA don't need transistions
--	self:CreateLocationPoint(Vector(11466, -7884, -13476), LOCATION_CAVES, 256, TRANSITPORT_CAVES_ENTRY) -- Ignoring for this map

	
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

-- GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "This maintenance shaft leads back into the city."
GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "Continuing through this tunnel leads you to an abandoned subway station"
--GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "You can summon the dropship to take you back to the City 17 Nexus here."
-- GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "You come across an enrance to the caves."

--caves entrance nlo -- NOT USED
-- GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
--	Vector(9542, -7809, -13754),
--	Vector(9786, -7590, -13662),
--	Vector(10024, -7443, -13592),
--	Vector(10224, -7335, -13539),
--	Vector(9919, -7287, -13596),	
--}

--canals entrance USING NORMAL SPAWNS
--GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
--	Vector(-14451, 12436, 64),
--	Vector(-14387, 12555, 64),
--	Vector(-14292, 12730, 64),
--	Vector(-14049, 12603, 64),
--	Vector(-14136, 12423, 64),
--	Vector(-14198, 12276, 64),	
--}

--combine port dock USING NORMAL SPAWNS
--GM.CombineSpawnpoints = {
--	Vector(11506, -14545, 99),
--	Vector(11669, -14513, 99),
--	Vector(11727, -14339, 99),
--	Vector(11534, -14295, 98),
--}

GM.CurrentLocation = LOCATION_COAST

-- NO STOVES
--GM.Stoves = { 
--	{Vector(8085.911133, 3612.968750, -13335.968750), Angle(18, -90, 0.000000), "NLO"},

--}

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")