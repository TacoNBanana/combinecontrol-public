GM.CurrentLocation	= LOCATION_CITY

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "As you approach the gate a nearby camera beeps with certainty, the gate rises and you see a bus ready to depart for Precinct 6."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "You radio in for the helicopter to Precinct 6, shortly after you hear a loud whir and a hanging ladder falls at your feet ready for departure."
GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(2669, 3912, -1016),
	Vector(2669, 3802, -1016),
	Vector(2669, 3700, -1016),
	Vector(2669, 3610, -1016)
}

function GM:GetCombineCratePos()
	return {Vector(1523, 347, -880), Angle(0, 180, 0)}
end

function GM:GetCombineRationPos()
	return {Vector(1472, 134, -848), Angle(0, 90, 0)}
end

GM.CombineSpawnpoints = {
	Vector(1319,955,-764),
	Vector(1319,793,-764),
	Vector(1319,642,-764),
	Vector(1319,513,-764),
	Vector(1319,366,-764),
	Vector(1319,201,-764)
}
GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = GM.CombineSpawnpoints

function GM:GetHL2CamPos()
	return {Vector(2450, -442, -415), Angle(0, 115, 0)}
end

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(1612, 495, -550), LOCATION_CANAL, 128, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(3310, 1030, -320), LOCATION_CANAL, 128, TRANSITPORT_CITY_COMBINE)
end

GM.DoorData = {
	{Vector(1347, 735.38000488281, -1226), DOOR_COMBINELOCK, "Cell #4"},
	{Vector(1347, 555.38000488281, -1226), DOOR_COMBINELOCK, "Cell #5"},
	{Vector(1347, 375.38000488281, -1226), DOOR_COMBINELOCK, "Cell #6"},
	{Vector(1729, 516.61999511719, -1226), DOOR_COMBINELOCK, "Cell #3"},
	{Vector(1729, 696.61999511719, -1226), DOOR_COMBINELOCK, "Cell #2"},
	{Vector(1729, 876.62097167969, -1226), DOOR_COMBINELOCK, "Cell #1"},
	{Vector(1150.75, -664, -962.25), DOOR_COMBINELOCK, "CCH-X", 0, "CCHX"},
	{Vector(1057.2600097656, -664, -962.25), DOOR_COMBINELOCK, "CCH-X", 0, "CCHX"},
	{Vector(1623, -1102, -738), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-1-1", 2, "Apartment X-1-1"},
	{Vector(1419, -1102, -738), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-1-2", 2, "Apartment X-1-2"},
	{Vector(1217, -1102, -738), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-1-3", 2, "Apartment X-1-3"},
	{Vector(1623, -1102, -606), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-2-1", 2, "Apartment X-2-1"},
	{Vector(1419, -1102, -606), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-2-2", 2, "Apartment X-2-2"},
	{Vector(1217, -1102, -606), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-2-3", 2, "Apartment X-2-3"},
	{Vector(1217, -1102, -474), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-3-3", 2, "Apartment X-3-3"},
	{Vector(1419, -1102, -474), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-3-2", 2, "Apartment X-3-2"},
	{Vector(1623, -1102, -474), DOOR_BUYABLE_ASSIGNABLE, "Apartment X-3-1", 2, "Apartment X-3-1"},
	{Vector(1623, -1230, -341), DOOR_BUYABLE_ASSIGNABLE, "Unfinished Penthouse", 10, "Penthouse5"},
	{Vector(1569, -833, -341), DOOR_BUYABLE_ASSIGNABLE, "Unfinished Penthouse", 10, "Penthouse5"},
	{Vector(1435, -882, -342), DOOR_BUYABLE_ASSIGNABLE, "Unfinished Penthouse", 10, "Penthouse5"},
	{Vector(1077, -833, -342), DOOR_BUYABLE_ASSIGNABLE, "Unfinished Penthouse", 10, "Penthouse5"},
	{Vector(2696, -778, -1028), DOOR_BUYABLE, "Cafe American", 15, "Storeplace1"},
	{Vector(2808, -778, -1028), DOOR_BUYABLE, "Cafe American", 15, "Storeplace1"},
	{Vector(2628, -1251, -1034), DOOR_BUYABLE, "Cafe American", 15, "Storeplace1"},
	{Vector(3255, -1171, -1034), DOOR_UNBUYABLE, "Bathroom", 0, "Storeplace1"},
	{Vector(3179, -1170, -1034), DOOR_UNBUYABLE, "Bathroom", 0, "Storeplace1"},
	{Vector(1400, 383, -582), DOOR_COMBINELOCK, "Helipad Control"},
	{Vector(3607, -1515, -1034), DOOR_UNBUYABLE, "Checkpoint Control"},
	{Vector(3585, -1650, -1034), DOOR_UNBUYABLE, "Checkpoint Storage"},
	{Vector(3700.5, -3827, -1010.8099975586), DOOR_UNBUYABLE, "D2 Checkpoint"},
	{Vector(3651.0700683594, -3664.9899902344, -1034.6300048828), DOOR_UNBUYABLE, "Checkpoint Storage"},
	{Vector(3629.0700683594, -3799.9899902344, -1034.6300048828), DOOR_UNBUYABLE, "Checkpoint Control"},
	{Vector(3539.2299804688, -3826.7099609375, -1008.6300048828), DOOR_UNBUYABLE, "D2 Checkpoint"},
	{Vector(2282.0900878906, -5888, -833.71997070313), DOOR_UNBUYABLE, "Bunkroom 1", 0, "DiordnaHostel1"},
	{Vector(2229, -5787.91015625, -697.71899414063), DOOR_UNBUYABLE, "Bunkroom 2", 0, "DiordnaHostel1"},
	{Vector(2239.3898925781, -5794.4501953125, -978), DOOR_UNBUYABLE, "Bathroom", 0, "DiordnaHostel1"},
	{Vector(2401, -5907, -442), DOOR_COMBINELOCK, "Rooftop", 0, "DiordnaHostel1"},
	{Vector(3859, -5414, -1027), DOOR_BUYABLE, "Old Bar", 15, "OldBar1"},
	{Vector(4376, -5057, -1026), DOOR_UNBUYABLE, "Bathroom", 0, "OldBar1"},
	{Vector(3192, -6011.91015625, -1026), DOOR_COMBINELOCK, "Ration Terminal", 0, "Nexus"},
	{Vector(3962, -5397, -894), DOOR_UNBUYABLE, "Office", 0, "OldBar1"},
	{Vector(-794, -4, -1034), DOOR_BUYABLE, "CHANGE Back Door", 5, "change"},
	{Vector(-1080, 370, -1036), DOOR_BUYABLE, "CHANGE Shop", 5, "change"},
	{Vector(-968, 370, -1036), DOOR_BUYABLE, "CHANGE Shop", 5, "change"},
	{Vector(-2148, 424, -1024), DOOR_BUYABLE, "Distribution Street Shop", 5, "dstrib"},
	{Vector(-2060, 336, -1024), DOOR_BUYABLE, "Distribution Street Shop", 5, "dstrib"},
	{Vector(1056, 499, -842), DOOR_COMBINELOCK, "Nexus Rear Entrance"},
	{Vector(1276, 56, -1028), DOOR_BUYABLE, "Store", 6, "Storeplace2"},
	{Vector(1276, -56, -1028), DOOR_BUYABLE, "Store", 6, "Storeplace2"},
	{Vector(520, 834, -776), DOOR_BUYABLE, "Workshop", 5},
	{Vector(1535, 767, -841.71899414063), DOOR_COMBINELOCK, "Lobby Overlook"},
	{Vector(3314.0900878906, 576.09002685547, -1028), DOOR_BUYABLE, "Bar", 6, "Cafebuilding2"},
	{Vector(3393.2900390625, 655.28997802734, -1028), DOOR_BUYABLE, "Bar", 6, "Cafebuilding2"},
	{Vector(3640, -444, -1034), DOOR_COMBINELOCK, "Generator Room", 0, "Generators1"},
	{Vector(3396, -248, -650), DOOR_COMBINELOCK, "Generator Room", 0, "Generators1"},
	{Vector(1438, 819, -967), DOOR_COMBINEOPEN, "Nexus", 0, "Nexus"},
	{Vector(1440, 664, -967), DOOR_COMBINEOPEN, "Nexus", 0, "Nexus"},
	{Vector(3536, -1490, -1008), DOOR_UNBUYABLE, "D2 Checkpoint"},
	{Vector(3696.5, -1490, -1008), DOOR_UNBUYABLE, "D2 Checkpoint"},
	{Vector(1344, 1085, -572), DOOR_COMBINEOPEN, "Nexus", 0, "Nexus"},
	{Vector(-560, -4035, -842), DOOR_COMBINELOCK, "Catwalk Access"},
	{Vector(-674, -4035, -842), DOOR_COMBINELOCK, "Catwalk Access"},
	{Vector(-839, -4033, -522), DOOR_COMBINELOCK, "Catwalk Access"},
	{Vector(-609, -4739, -802), DOOR_BUYABLE, "Generator Room", 5, "GeneratorArea"},
	{Vector(-1188, -4798, -794), DOOR_BUYABLE, "Generator Room", 5, "GeneratorArea"},
	{Vector(-1188, -4847, -522), DOOR_BUYABLE, "Generator Room", 5, "GeneratorArea"},
	{Vector(-570.46997070313, -5149, -522), DOOR_BUYABLE, "Generator Room", 5, "GeneratorArea"},
	{Vector(1930, 3640, -778), DOOR_BUYABLE_ASSIGNABLE, "Apartment 1-2", 6},
	{Vector(2168, 3535, -777.5), DOOR_BUYABLE_ASSIGNABLE, "Apartment 1-1", 6},
	{Vector(2062, 3304, -777.5), DOOR_UNBUYABLE, "Laundry"},
	{Vector(2473, 2425, -954), DOOR_COMBINELOCK, "Abandoned Apartment Complex"},
	{Vector(2617, 2749, -953.71899414063), DOOR_BUYABLE, "Abandoned Apartment", 7, "apartmentthing"},
	{Vector(1248, 2427, -1002), DOOR_COMBINELOCK, "Laurence Apartment Complex"},
	{Vector(1068, 2426.9099121094, -1002), DOOR_BUYABLE, "Michaelangelo's Coffee House", 3},
	{Vector(973, 2083, -858), DOOR_UNBUYABLE, "Stairwell"},
	{Vector(-664, 4325, -988), DOOR_COMBINELOCK, "Yukon Apartment Complex"},
	{Vector(-552, 4325, -988), DOOR_COMBINELOCK, "Yukon Apartment Complex"},
	{Vector(-691, 4507, -853), DOOR_BUYABLE_ASSIGNABLE, "CCH-Y 1-1", 5},
	{Vector(-593, 4507, -853), DOOR_BUYABLE_ASSIGNABLE, "CCH-Y 1-2", 5},
	{Vector(-425, 4507, -853), DOOR_BUYABLE_ASSIGNABLE, "CCH-Y 1-3", 5},
	{Vector(-691, 4507, -715), DOOR_BUYABLE_ASSIGNABLE, "CCH-Y 2-1", 5},
	{Vector(-593, 4507, -715), DOOR_BUYABLE_ASSIGNABLE, "CCH-Y 2-2", 5},
	{Vector(-425, 4507, -715), DOOR_BUYABLE_ASSIGNABLE, "CCH-Y 2-3", 5},
	{Vector(3516, 2044, -1060.5), DOOR_BUYABLE, "Store", 6},
	{Vector(603, 6242, -1026), DOOR_BUYABLE, "SMU Complex", 25, "SMU"},
	{Vector(358, 6281, -1026), DOOR_UNBUYABLE, "SMU Complex", 0, "SMU"},
	{Vector(310, 6329, -1169.7199707031), DOOR_UNBUYABLE, "SMU Complex", 0, "SMU"},
	{Vector(522, 6036, -1169.7199707031), DOOR_UNBUYABLE, "SMU Complex", 0, "SMU"},
	{Vector(379, 5633, -1169.7199707031), DOOR_UNBUYABLE, "SMU Complex", 0, "SMU"},
	{Vector(187, 5825, -1169.7199707031), DOOR_UNBUYABLE, "SMU Complex", 0, "SMU"},
	{Vector(187, 6115, -1169.7199707031), DOOR_UNBUYABLE, "SMU Complex", 0, "SMU"},
	{Vector(2855, -4981, -1024), DOOR_BUYABLE, "Warehouse", 5, "Warehouse_rations"},
	{Vector(2936, -5062, -1024), DOOR_BUYABLE, "Warehouse", 5, "Warehouse_rations"},
	{Vector(973, 1949, -858), DOOR_UNBUYABLE, "Public Dining Area"},
	{Vector(1250, 1697, -858), DOOR_UNBUYABLE, "Public Kitchen"},
	{Vector(1246, 1815, -704), DOOR_BUYABLE_ASSIGNABLE, "CCH-L 1-1", 5, "cch-l 1"},
	{Vector(1217, 2217, -704), DOOR_BUYABLE_ASSIGNABLE, "CCH-L 1-3", 5},
	{Vector(1033, 2217, -704), DOOR_BUYABLE_ASSIGNABLE, "CCH-L 1-2", 5},
	{Vector(1030, 2217, -550), DOOR_BUYABLE_ASSIGNABLE, "CCH-L 2-2", 5},
	{Vector(1214, 2217, -550), DOOR_BUYABLE_ASSIGNABLE, "CCH-L 2-3", 5},
	{Vector(1246, 1815, -550), DOOR_BUYABLE_ASSIGNABLE, "CCH-L 2-1", 5},
	{Vector(2037, 3560, -627), DOOR_BUYABLE_ASSIGNABLE, "Apartment 2-1", 6},
	{Vector(2381, 2556, -448), DOOR_BUYABLE, "Abandoned Apartment", 7, "apartmentthing"},
	{Vector(1276.5, 1185.8100585938, -1226), DOOR_COMBINELOCK, "Detainment Control"},
	{Vector(1448, 1189.8100585938, -1225.7199707031), DOOR_COMBINELOCK, "Room 100"},
	{Vector(1640, 1190.0400390625, -1225.7199707031), DOOR_COMBINELOCK, "Room 101"},
	{Vector(1735, 1081.8100585938, -1225.7199707031), DOOR_COMBINELOCK, "Room 102"},
	{Vector(-147.5, -3475, -768), DOOR_UNBUYABLE, "Garage"},
	{Vector(628, 522, -818), DOOR_BUYABLE, "Workshop", 5},
	{Vector(1348, 1094, -322), DOOR_COMBINEOPEN, "Broadcast Room"},
	{Vector(1858.1400146484, 456, -968), DOOR_COMBINELOCK, "Nexus", 0, "Nexus"},
	{Vector(1858.1199951172, 568, -968), DOOR_COMBINELOCK, "Nexus", 0, "Nexus"},
	{Vector(4665.91015625, 1827, -1026), DOOR_BUYABLE, "Workshop", 3},
	{Vector(4740, 1781, -1026), DOOR_BUYABLE, "Workshop", 3},
	{Vector(2369, 2711, -954), DOOR_COMBINELOCK, "Abandoned Apartment Complex"},
	{Vector(1833, 3064, -922), DOOR_COMBINELOCK, "Canusha Apartments"},
}

GM.Stoves = {
	{Vector(1466,-1068,-772), Angle(0,0,0), "Apartment X-1-1", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(1264,-1068,-772), Angle(0,0,0), "Apartment X-1-2", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(1058,-1068,-772), Angle(0,0,0), "Apartment X-1-3", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(1466,-1068,-639), Angle(0,0,0), "Apartment X-2-1", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(1264,-1068,-639), Angle(0,0,0), "Apartment X-2-2", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(1058,-1068,-639), Angle(0,0,0), "Apartment X-2-3", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(1466,-1068,-508), Angle(0,0,0), "Apartment X-3-1", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(1264,-1068,-508), Angle(0,0,0), "Apartment X-3-2", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(1058,-1068,-508), Angle(0,0,0), "Apartment X-3-3", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(2791,-1211,-1068), Angle(0,-90,0), "Storeplace1"}
}

GM.VendingMachines = {
	{Vector(-1130, 1174, -1040), Angle(0, -90, 0)},
	{Vector(3560, -5638, -1032), Angle(0, 90, 0)},
	{Vector(1211, -3031, -839), Angle(0, -90, 0)}
}

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")
