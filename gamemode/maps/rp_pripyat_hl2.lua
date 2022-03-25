function GM:GetHL2CamPos()
	return {Vector( -1210, -5408, 101), Angle(-7, 48, 0)}
end


function GM:GetCombineCratePos()
	return {Vector(2168, 4068, 145), Angle(0, -90, 0)}
end

--[[function GM:GetCombineRationPos()
	return {Vector(820,2367,83), Angle(0, 180, 0)}
end
]]--


function GM:MapInitPostEntity()
	self:CreateLocationPoint( Vector( -383, -14036, -4 ), LOCATION_CITY, 100, TRANSITPORT_CITY_GATE );
	self:CreateLocationPoint( Vector( 3838, 9847, -188 ), LOCATION_CITY, 100, TRANSITPORT_CITY_SEWER );
	self:CreateLocationPoint( Vector( 2606, 2556, 637 ), LOCATION_CITY, 200, TRANSITPORT_CITY_COMBINE );
end
 
GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "Beyond this barrier is a road leading back to an unpatrolled area of the city.";
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "This maintenance shaft leads into the city's sewers.";
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "You can summon the helicopter to take you back to the City 17 Nexus here.";

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
Vector( -7343, -12507, -639 ),
Vector( -7342, -12467, -639 ),
Vector( -7341, -12419, -639 ),
Vector( -7340, -12374, -639 ),
Vector( -7277, -12374, -639 ),
Vector( -7278, -12424, -639 ),
Vector( -7279, -12477, -639 ),
Vector( -7280, -12535, -639 ),
Vector( -7230, -12536, -639 ),
Vector( -7229, -12491, -639 ),
Vector( -7228, -12441, -639 ),
Vector( -7227, -12383, -639 ),
Vector( -7164, -12384, -639 ),
Vector( -7165, -12446, -639 ),
Vector( -7167, -12507, -639 ),
Vector( -7168, -12552, -639 ),
};


GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
Vector( -7343, -12507, -639 ),
Vector( -7342, -12467, -639 ),
Vector( -7341, -12419, -639 ),
Vector( -7340, -12374, -639 ),
Vector( -7277, -12374, -639 ),
Vector( -7278, -12424, -639 ),
Vector( -7279, -12477, -639 ),
Vector( -7280, -12535, -639 ),
Vector( -7230, -12536, -639 ),
Vector( -7229, -12491, -639 ),
Vector( -7228, -12441, -639 ),
Vector( -7227, -12383, -639 ),
Vector( -7164, -12384, -639 ),
Vector( -7165, -12446, -639 ),
Vector( -7167, -12507, -639 ),
Vector( -7168, -12552, -639 ),
};

GM.CombineSpawnpoints = {
	Vector( 2351, 2501, 129 ),
	Vector( 2171, 2496, 129 ),
	Vector( 2171, 2564, 129 ),
	Vector( 2244, 2564, 129 ),
	Vector( 2326, 2563, 129 ),
	Vector( 2328, 2635, 129 ),
	Vector( 2256, 2635, 129 ),
	Vector( 2181, 2635, 129 ),
	Vector( 2180, 2721, 129 ),
	Vector( 2251, 2721, 129 ),
	Vector( 2331, 2722, 129 ),
};

GM.CurrentLocation = LOCATION_CITY;

--[[GM.VendingMachines = {
	{Vector(580,320,48), Angle(0,180,0)},
	{Vector(-2263,2211,48), Angle(0,180,0)}
}--]]


GM.CombineSpawnpoints = {
	Vector(2116, 3688, 145),
	Vector(2138, 3774, 145), 
	Vector(2138, 3894, 145),

}


GM.DoorData = {
	-- Combine Doors
	{Vector(2432, 1032, 184), DOOR_COMBINEOPEN, "Nexus Front Door"},
	{Vector(2304, 4088, 184), DOOR_COMBINEOPEN, "Nexus Rear Door"},	
	{Vector(3062, 1920, 184), DOOR_COMBINEOPEN, "Nexus Side Door"},
	{Vector(3064, 3264, 184), DOOR_COMBINEOPEN, "Nexus Tunnel Door"},
	{Vector(3064, 3136, 184), DOOR_COMBINEOPEN, "Nexus Tunnel Door"},	
	{Vector(3314, 3200, 440), DOOR_COMBINEOPEN, "Nexus Top Door"},	
	
	{Vector(2116, 3140, 438), DOOR_COMBINELOCK, "Holding Cell 1"},		
	{Vector(2244, 3240, 438), DOOR_COMBINELOCK, "Holding Cell 2"},	
	
	{Vector(-384, 4784, 56), DOOR_COMBINEOPEN, "North Gate"},	
	{Vector(-2544, 1728, 56), DOOR_COMBINEOPEN, "Construction Gate"},
	{Vector(-1216, -6192, 56), DOOR_COMBINEOPEN, "South Gate"},
	{Vector(-384, -6000, 56), DOOR_COMBINEOPEN, "South Middle Gate"},	
	{Vector(2944, -6000, 56), DOOR_COMBINEOPEN, "South East Gate"},	
	
	{Vector(-800, 4412, 54), DOOR_COMBINELOCK, "Security Gate North"},
	{Vector(-2547, 1536, 54), DOOR_COMBINELOCK, "Security Gate Construction Site"},
	{Vector(-5408, 997, 54), DOOR_COMBINELOCK, "Security Gate West"},
	{Vector(-6016, -5857, 90), DOOR_COMBINELOCK, "Security Gate South West"},
	{Vector(-1275, -5728, 54), DOOR_COMBINELOCK, "Security Gate Main Road"},
	{Vector(3360, -5637, 54), DOOR_COMBINELOCK, "Security Gate South"},
	{Vector(3360, -4101, 54), DOOR_COMBINELOCK, "Security Gate South East"},
	{Vector(4485, 544, 54), DOOR_COMBINELOCK, "Security Gate East"},	
	{Vector(1568, 4739, 54), DOOR_COMBINELOCK, "Security Gate Carpark"},
	
}

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")