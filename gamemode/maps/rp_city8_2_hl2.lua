function GM:GetHL2CamPos()
	return {Vector( 292, 578, 59), Angle(-13, 86, 0)}
end

function GM:GetCombineCratePos()
	return {Vector(816, 2432, 17), Angle(0, 180, 0)}
end

function GM:GetCombineRationPos()
	return {Vector(820,2367,83), Angle(0, 180, 0)}
end

GM.CurrentLocation = LOCATION_CITY

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(-1408,162,-499), LOCATION_CANAL, 256, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(-1694, -5144, 66), LOCATION_CANAL, 256, TRANSITPORT_CITY_SEWER)
	self:CreateLocationPoint(Vector(28, 4200, 620), LOCATION_CANAL, 256, TRANSITPORT_CITY_COMBINE)

--	SW.MaxLightness = "f"
--	SW.MaxDarkness	= "b"
end
 
GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "You can see a sewer access tunnel that leads to the canals."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "There is an access point to the old sewer system here."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "An elevator door here leads to a helicopter, which will bring you to Sector 12"
 
GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(3022, -5057, 126), 
	Vector(3054, -4784, 122)
}
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(-1631, -5217, 128),
	Vector(-1495, -5227, 128)
}
GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector(-1901, 5686, -40),
	Vector(-1795, 5686, -40)
}

GM.VendingMachines = {
	{Vector(580,320,48), Angle(0,180,0)},
	{Vector(-2263,2211,48), Angle(0,180,0)}
}


GM.CombineSpawnpoints = {
	Vector(-106,5714,297),
	Vector(423, 5739, 274), 
	Vector(472, 5280, 255),
	Vector(977,5588,170),
	Vector(895,5588,170),
	Vector(783,5588,170)
}


GM.DoorData = {
	-- Combine Doors
	{Vector(32, 4688, 184), DOOR_COMBINEOPEN, "Nexus Front Door"},
	{Vector(0, 2544, 56), DOOR_COMBINEOPEN, "Ration Depot Back Door"},		
	{Vector(240, 2400, 56), DOOR_COMBINEOPEN, "Ration Depot Mid Door"},	
	{Vector(672, 2192, 56), DOOR_COMBINEOPEN, "Ration Depot Front Door"},	
	{Vector(448, -56, 64), DOOR_COMBINEOPEN, "Street Access"},		
	{Vector(464, -520, 64), DOOR_COMBINEOPEN, "Street Access"},
	{Vector(-2496, 5008, 56), DOOR_COMBINEOPEN, "Nexus Back Door"},	
	{Vector(-2176, 3984, 56), DOOR_COMBINEOPEN, "Tunnel Access"},	
	{Vector(-2368, 2032, 56), DOOR_COMBINEOPEN, "Checkpoint"},	
	{Vector(-2368, 1552, 56), DOOR_COMBINEOPEN, "Checkpoint"},	

	{Vector(480, 2526, 60), DOOR_COMBINELOCK, "Ration Depot Holding Cell"},	
	{Vector(-1432, 6024, -74), DOOR_COMBINELOCK, "Holding Cell 1"},		
	{Vector(-1160, 6072, -74), DOOR_COMBINELOCK, "Holding Cell 2"},	
	{Vector(-920, 6024, -74), DOOR_COMBINELOCK, "Holding Cell 3"},		
	
	-- Workshops and shops
	{Vector(-1656, 3648, 54), DOOR_BUYABLE_ASSIGNABLE, "Garage Workshop", 5, "Garage"},		
	{Vector(-1533, 2752, 55), DOOR_BUYABLE_ASSIGNABLE, "Market Bar", 5, "Market Bar"},	
	{Vector(-1646, 3137, -201), DOOR_UNBUYABLE, "Security Gate", 0, "Market Bar"},	
	{Vector(-2541, 2112, -457), DOOR_UNBUYABLE, "Staff Door", 0, "Market Bar"},	
	{Vector(-2563, 1920, -457), DOOR_UNBUYABLE, "Bar Door", 0, "Market Bar"},		
	
	-- CCH Block A
	{Vector(-508, 744, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH A1", 2, "A1"},	
	{Vector(-964, 384, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH A3", 2, "A3"},	
	{Vector(-1472, 260, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH A5", 2, "A5"},	
	{Vector(-1348, -320, 310), DOOR_UNBUYABLE, "Sewer Access", 0, "A5"},	
	-- CCH Block B
	{Vector(-508, 2088, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH B1", 2, "B1"},	
	{Vector(-508, 1640, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH B2", 2, "B2"},	
	{Vector(-676, 1640, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH B3", 2, "B3"},	
	{Vector(-776, 2564, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH B5", 2, "B5"},	
	-- CCH Block C
	{Vector(-1924, 2664, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH C1", 2, "C1"},	
	{Vector(-1988, 2952, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH C2", 2, "C2"},		
	-- CCH Block D
	{Vector(1216, 1918, 567), DOOR_BUYABLE_ASSIGNABLE, "CCH D1", 2, "D1"},	
	-- CCH Block E
	{Vector(1204, 2647, 310), DOOR_BUYABLE_ASSIGNABLE, "CCH E1", 2, "E1"},	
	{Vector(1204, 2647, 566), DOOR_BUYABLE_ASSIGNABLE, "CCH E2", 2, "E2"},	
	{Vector(1204, 2647, 822), DOOR_BUYABLE_ASSIGNABLE, "CCH E3", 2, "E3"},	
	-- CCH Block F
	{Vector(2628, 1244, 54), DOOR_BUYABLE_ASSIGNABLE, "CCH F1", 2, "F1"},	
	{Vector(2628, 220, 54), DOOR_BUYABLE_ASSIGNABLE, "CCH F2", 2, "F2"},	
	{Vector(3132, 1540, 54), DOOR_UNBUYABLE, "CCH F1", 0, "F1"},
	{Vector(3132, 516, 54), DOOR_UNBUYABLE, "CCH F2", 0, "F2"},		
}

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")