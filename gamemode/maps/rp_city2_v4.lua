function GM:GetHL2CamPos()

	return { Vector( 2500, 4146, 898 ), Angle( 31, 0, 0 ) }

end

function GM:GetCACamPos()

	return Vector( 885, 2276, 1741 )

end

function GM:GetCombineCratePos()

	return {Vector(441, 2960, 477), Angle(0, -89, -0)}

end

function GM:GetCombineRationPos()

	return {Vector(439, 2973, 524), Angle(0, -90, 0)}

end

GM.EnableAreaportals = true

GM.IntroCamData = { }
GM.IntroCamData[1] = { { Vector( 2427, 4141, 748 ), Vector( 2264, 4141, 851 ) }, { Angle( -39, 180, 0 ), Angle( -9, 180, 0 ) } }
GM.IntroCamData[2] = { { Vector( 1417, -265, 170 ), Vector( 1225, -265, 170 ) }, { Angle( 25, -90, 0 ), Angle( 25, -90, 0 ) } }
GM.IntroCamData[3] = { { Vector( 76, 900, 687 ), Vector( 560, 900, 687 ) }, { Angle( -32, 70, 0 ), Angle( -32, 110, 0 ) } }
GM.IntroCamData[4] = { { Vector( 583, -1347, 83 ), Vector( 523, -1265, 83 ) }, { Angle( 36, -143, 0 ), Angle( 36, -143, 0 ) } }
GM.IntroCamData[5] = { { Vector( 563, 2467, 724 ), Vector( 541, 2798, 724 ) }, { Angle( 14, 166, 0 ), Angle( 27, -172, 0 ) } }
GM.IntroCamData[6] = { { Vector( 2026, 4140, 670 ), Vector( 2026, 4140, 873 ) }, { Angle( 22, 0, 0 ), Angle( 22, 0, 0 ) } }

GM.CurrentLocation = LOCATION_CITY;

function GM:MapInitPostEntity()

	self:CreateLocationPoint( Vector( -4329, 1566, 1203 ), LOCATION_CANAL, 50, TRANSITPORT_CITY_GATE )
	self:CreateLocationPoint( Vector( -3456, -2942, -971 ), LOCATION_CANAL, 128, TRANSITPORT_CITY_SEWER )
	self:CreateLocationPoint( Vector( -1230, 2034, 644 ), LOCATION_CANAL, 50, TRANSITPORT_CITY_COMBINE )

	ents.FindByName("jw_button")[1]:Remove()

end

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "Behind this door lies an unguarded area - it seems like the Combine haven't noticed yet. There's an entranceway to a small concrete maintenance area."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "The sewage pipe looks like you can climb through it. Down a ways, you see a light - it looks like it leads into a concrete maintenance area."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "This door leads to the helicopter pad where transport awaits to the canals."

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector( -4292, 1748, 1153 ),
	Vector( -4292, 1672, 1153 ),
	Vector( -4225, 1748, 1153 ),
	Vector( -4225, 1672, 1153 ),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(-3560, -2396, -1135),
	Vector(-3502, -2395, -1135),
	Vector(-3438, -2394, -1135),
	Vector(-3381, -2394, -1135),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector( -1232, 2114, 597 ),
	Vector( -1183, 2114, 597 ),
	Vector( -1135, 2113, 597 ),
	Vector( -1086, 2113, 597 ),
}

GM.EntNamesToRemove = {
}

GM.EntPositionsToRemove = {
	-- broken doors
	Vector(-625, 2564, 650.28100585938), -- cafeteria
	Vector(-720, 2231, 650), -- unnamed office
	Vector(-720, 1955, 650.28100585938), -- deployment
	Vector( -327, 2211, 650.5 ), -- not broken but a ballache for cops
}

function GM:OnJWOn()
end

function GM:OnJWOff()
end

GM.Microphones = {}

GM.Stoves = {
	{ Vector( -4061, 1319, 661 ), Angle( 0, -90, 0 ), "B11", true },
	{ Vector( -4319, 1783, 789 ), Angle( 0, -90, 0 ), "B21", true },
	{ Vector( -4319, 1490, 789 ), Angle( 0, -90, 0 ), "B22", true },
	{ Vector( -4319, 1783, 917 ), Angle( 0, -90, 0 ), "B31", true },
	{ Vector( -4319, 1491, 917 ), Angle( 0, -89, 0 ), "B32", true },
	{ Vector( -4319, 1783, 1045 ), Angle( 0, -90, 0 ), "B41", true },
	{ Vector( -4297, 1165, 501 ), Angle( 0, -0, 0 ), "MISC4", true },
	{ Vector( -337, 270, 429 ), Angle( 0, 0, 0 ), "D1", true },
	{ Vector( -703, 312, 293 ), Angle( 0, -0, 0 ), "D2", true },
	{ Vector( 754, 408, 885 ), Angle( 0, -90, 0 ), "T1" },
	{ Vector( 754, 408, 1013 ), Angle( 0, -90, 0 ), "T2" },
	{ Vector( 754, 408, 1141 ), Angle( 0, -90, 0 ), "T3" },
	{ Vector( 754, 408, 1269 ), Angle( 0, -90, 0 ), "T4" },
	{ Vector( 754, 408, 1405 ), Angle( 0, -90, 0 ), "T5" },
	{ Vector( 757, 1274, 630 ), Angle( 0, 0, 0 ), "BALTIC" },
	{ Vector( 516, 2957, 481 ), Angle( 0, -90, 0 ), "", true },
	{ Vector( 272, 376, 221 ), Angle( 0, -90, 0 ), "E1", true },
	{ Vector( -162, 376, 221 ), Angle( 0, -90, 0 ), "E2", true },
	{ Vector( -1205, 2307, 181 ), Angle( 0, -0, 0 ), "C1", true },
	{ Vector( -1590, 1508, -27 ), Angle( 0, 90, 0 ), "C2", true },
	{ Vector( -1742, 1766, -27 ), Angle( 0, -0, 0 ), "C3", true },
	{ Vector( -1489, 2140, -27 ), Angle( 0, 0, 0 ), "C4", true },
	{ Vector( -1288, 1098, 21 ), Angle( 0, 180, 0 ), "MISC1", true },
	{ Vector( -224, 1339, 5 ), Angle( 0, 180, 0 ), "MISC3", true },
	{ Vector( -647, -2802, 49 ), Angle( 0, 90, 0 ), "XCCR", true },
	{ Vector( 272, -3343, 49 ), Angle( 0, 0, 0 ), "A11" },
	{ Vector( 689, -3342, 49 ), Angle( 0, 0, 0 ), "A12" },
	{ Vector( 273, -3342, 305 ), Angle( 0, 0, 0 ), "A21" },
	{ Vector( 688, -3342, 305 ), Angle( 0, 0, 0 ), "A22" },
}

GM.CombineSpawnpoints = {
	Vector(-1103, 2392, 597),
	Vector(-1099, 2353, 597),
	Vector(-1099, 2313, 597),
	Vector(-1099, 2272, 597),
	Vector(-1054, 2272, 597),
	Vector(-1054, 2309, 597),
	Vector(-1055, 2352, 597),
	Vector(-1055, 2392, 597),
	Vector(-1011, 2393, 597),
	Vector(-1011, 2348, 597),
	Vector(-1010, 2309, 597),
	Vector(-1010, 2270, 597),
}

GM.DoorData = {
	{ Vector( 325.5, 2300.5, 654 ), DOOR_COMBINEOPEN, "Detainment" },
	{ Vector( 310.13000488281, 2300.5, 654 ), DOOR_COMBINEOPEN, "Detainment" },
	{ Vector( 733.98999023438, 2062.4899902344, 650 ), DOOR_COMBINEOPEN, "Ration Distribution" },
	{ Vector( 178.99000549316, 2091.4899902344, 650 ), DOOR_COMBINEOPEN, "Nexus" },
	{ Vector( 362, 1718, 706 ), DOOR_COMBINELOCK, "Nexus" },
	{ Vector( 268, 1718, 706 ), DOOR_COMBINELOCK, "Nexus" },
	{ Vector( 411, 2081, 474.25 ), DOOR_COMBINELOCK, "Room 101" },
	{ Vector( 411, 1926, 474.25 ), DOOR_COMBINELOCK, "Room 102" },
	{ Vector( 466, 1864, 474.5 ), DOOR_COMBINEOPEN, "Detainment Storage" },
	{ Vector( 569, 2168, 484 ), DOOR_UNBUYABLE, "Waste Disposal" },
	{ Vector( 7, 2606, 510 ), DOOR_COMBINELOCK, "Cell 1" },
	{ Vector( 7, 2746, 510 ), DOOR_COMBINELOCK, "Cell 2" },
	{ Vector( 7, 2886, 510 ), DOOR_COMBINELOCK, "Cell 3" },
	{ Vector( 7, 2606, 646 ), DOOR_COMBINELOCK, "Cell 4" },
	{ Vector( 7, 2746, 646 ), DOOR_COMBINELOCK, "Cell 5" },
	{ Vector( 7, 2886, 646 ), DOOR_COMBINELOCK, "Cell 6" },
	{ Vector( 204, 2891, 456.5 ), DOOR_UNBUYABLE, "Solitary Confinement" },
	--{ Vector( -327, 2211, 650.5 ), DOOR_COMBINEOPEN, "" },
	--{ Vector(-625, 2564, 650.28100585938), DOOR_COMBINELOCK, "Cafeteria" },
	--{ Vector(-720, 2231, 650), DOOR_COMBINEOPEN, "Deployment" },
	--{ Vector(-720, 1955, 650.28100585938), DOOR_COMBINELOCK, "" } ,
	{ Vector( 101, 2253, 1784 ), DOOR_COMBINEOPEN, "Upper Nexus" },
	{ Vector( 101, 2125, 1784 ), DOOR_COMBINEOPEN, "Upper Nexus" },
	{ Vector( 280, 1716, 1728 ), DOOR_COMBINEOPEN, "Balcony" },
	{ Vector( 350, 1716, 1728 ), DOOR_COMBINEOPEN, "Balcony" },
	{ Vector( 823, 2171, 1718 ), DOOR_COMBINEOPEN, "Broadcasting" },
	{ Vector( 554, 446, 662 ), DOOR_COMBINELOCK, "Terminal Hotel" },
	{ Vector( 658, 446, 662 ), DOOR_COMBINELOCK, "Terminal Hotel" },
	{ Vector( 863, 324, 662 ), DOOR_UNBUYABLE, "Terminal Hotel" },
	{ Vector( 734, 994, 662.28100585938 ), DOOR_BUYABLE, "Cafe Baltic", 10, "BALTIC" },
	{ Vector( 845, 1188, 662.28100585938 ), DOOR_UNBUYABLE, "Kitchen", 0, "BALTIC" },
	{ Vector( -381, 1284, 694 ), DOOR_COMBINELOCK, "Ticket Booth" },
	{ Vector( 458, 353, 919.28100585938 ), DOOR_BUYABLE, "Apartment T-1", 5, "T1" },
	{ Vector( 721, 356, 919 ), DOOR_UNBUYABLE, "Kitchen", 0, "T1" },
	{ Vector( 651, 279, 919.28100585938 ), DOOR_UNBUYABLE, "Bathroom", 0, "T1" },
	{ Vector( 458, 353, 1047.2800292969 ), DOOR_BUYABLE, "Apartment T-2", 5, "T2" },
	{ Vector( 721, 356, 1047 ), DOOR_UNBUYABLE, "Kitchen", 0, "T2" },
	{ Vector( 651, 279, 1047.2800292969 ), DOOR_UNBUYABLE, "Bathroom", 0, "T2" },
	{ Vector( 459, 357, 1175.2800292969 ), DOOR_BUYABLE, "Apartment T-3", 5, "T3" },
	{ Vector( 721, 356, 1175 ), DOOR_UNBUYABLE, "Kitchen", 0, "T3" },
	{ Vector( 651, 279, 1175.2800292969 ), DOOR_UNBUYABLE, "Bathroom", 0, "T3" },
	{ Vector( 458, 357, 1303.2800292969 ), DOOR_BUYABLE, "Apartment T-4", 5, "T4" },
	{ Vector( 721, 356, 1303 ), DOOR_UNBUYABLE, "Kitchen", 0, "T4" },
	{ Vector( 651, 279, 1303.2800292969 ), DOOR_UNBUYABLE, "Bathroom", 0, "T4" },
	{ Vector( 458, 357, 1439.2800292969 ), DOOR_BUYABLE, "Apartment T-5", 5, "T5" },
	{ Vector( 721, 356, 1439 ), DOOR_UNBUYABLE, "Kitchen", 0, "T5" },
	{ Vector( 651, 279, 1439.2800292969 ), DOOR_UNBUYABLE, "Bathroom", 0, "T5" },
	{ Vector( 48, 444, 662 ), DOOR_BUYABLE, "Change Shop", 10, "CHANGE" },
	{ Vector( 29.5, 251.99000549316, 674 ), DOOR_UNBUYABLE, "", 0, "CHANGE" },
	{ Vector( -105, 252, 662 ), DOOR_UNBUYABLE, "Backroom", 0, "CHANGE" },
	{ Vector( -304, 532, 662.28100585938 ), DOOR_BUYABLE, "Foto Shop", 10, "FOTO" },
	{ Vector( -246.5, 387.98999023438, 674 ), DOOR_UNBUYABLE, "", 0, "FOTO" },
	{ Vector( -436, 388, 662.28100585938 ), DOOR_UNBUYABLE, "Backroom", 0, "FOTO" },
	{ Vector( 696.76300048828, 3623.6999511719, 683.25 ), DOOR_COMBINEOPEN, "Checkpoint Administration" },
	{ Vector( 587.76300048828, 3542.6999511719, 683.28100585938 ), DOOR_COMBINELOCK, "Office 1" },
	{ Vector( 351.76300048828, 3542.6999511719, 683.28100585938 ), DOOR_COMBINELOCK, "Office 2" },
	{ Vector( 1093, 1910, 666.28100585938 ), DOOR_COMBINELOCK, "Trainstation Lobby" },
	{ Vector( 1187, 1910, 666.28100585938 ), DOOR_COMBINELOCK, "Trainstation Lobby" },
	{ Vector( 1055, 1711, 664 ), DOOR_COMBINELOCK, "" },
	{ Vector( 1005.5100097656, 1459, 664 ), DOOR_COMBINELOCK, "" },
	{ Vector( 1270, 1711, 665 ), DOOR_COMBINELOCK, "" },
	{ Vector( 1221, 1458, 665 ), DOOR_COMBINELOCK, "" },
	{ Vector( 1507, 1416, 185 ), DOOR_COMBINELOCK, "Sewer Access" },
	{ Vector( -1434, -598, 68 ), DOOR_BUYABLE, "Warehouse 0", 10, "WH0" },
	{ Vector( -1434, -486, 68 ), DOOR_BUYABLE, "Warehouse 0", 10, "WH0" },
	{ Vector( 700, -442, 124 ), DOOR_BUYABLE, "Warehouse 2", 10, "WH2" },
	{ Vector( 812, -442, 124 ), DOOR_BUYABLE, "Warehouse 2", 10, "WH2" },
	{ Vector( 600, -816, 132 ), DOOR_UNBUYABLE, "Warehouse 2", 0, "WH2" },
	{ Vector( 600, -944, 132 ), DOOR_UNBUYABLE, "Warehouse 2", 0, "WH2" },
	{ Vector( -290, -895, 57 ), DOOR_COMBINELOCK, "" },
	{ Vector( -438, -754, 58.5 ), DOOR_BUYABLE, "Northern Petrol", 10 },
	{ Vector( -1038, 1780, 6 ), DOOR_COMBINELOCK, "Sewer Maintenance" },
	{ Vector( -999, 2194, 70 ), DOOR_UNBUYABLE, "CCH-C" },
	{ Vector( -1262, 2106, 214 ), DOOR_BUYABLE, "Apartment C-1", 5, "C1" },
	{ Vector( -1078.9899902344, 2267, 214 ), DOOR_UNBUYABLE, "Kitchen", 0, "C1" },
	{ Vector( -1432, 1732, 6.28125 ), DOOR_BUYABLE, "Apartment C-2", 5, "C2" },
	{ Vector( -1469, 1767, 6.28125 ), DOOR_BUYABLE, "Apartment C-3", 5, "C3" },
	{ Vector( -1432, 1849, 6.28125 ), DOOR_BUYABLE, "Apartment C-4", 5, "C4" },
	{ Vector( -1347, 1338, 54 ), DOOR_BUYABLE, "Misc Store", 10, "MISC1" },
	{ Vector( -1386, 1109, 54.5 ), DOOR_UNBUYABLE, "Employees Only", 0, "MISC1" },
	{ Vector( -1055, 1391, 6 ), DOOR_BUYABLE, "Misc Store", 10, "MISC2" },
	{ Vector( -1192, 895.5, 64 ), DOOR_COMBINELOCK, "Industrial District" },
	{ Vector( -1294, 896, 64 ), DOOR_COMBINELOCK, "Industrial District" },
	{ Vector( -379, 1771, 38 ), DOOR_BUYABLE, "Misc Store", 10, "MISC3" },
	{ Vector( -281, 1500, 38.281299591064 ), DOOR_UNBUYABLE, "Employees Only", 0, "MISC3" },
	{ Vector( -358, 1420, 38.281299591064 ), DOOR_UNBUYABLE, "Backroom", 0, "MISC3" },
	{ Vector( -709, 548, 662 ), DOOR_COMBINELOCK, "CCH-D" },
	{ Vector( -434, 246, 462 ), DOOR_BUYABLE, "Apartment D-1", 5, "D1" },
	{ Vector( -715, 182, 326 ), DOOR_BUYABLE, "Apartment D-2", 5, "D2" },
	{ Vector( -750, 57, 317 ), DOOR_UNBUYABLE, "CCH-D" },
	{ Vector( -807, 57, 317 ), DOOR_UNBUYABLE, "CCH-D" },
	{ Vector( 797, -1160, 57.374698638916 ), DOOR_COMBINELOCK, "Sewer Access" },
	{ Vector( 242, -1558, 58.5 ), DOOR_COMBINELOCK, "Sewer Office" },
	{ Vector( 80, -1482, -203 ), DOOR_COMBINELOCK, "Sewer Access" },
	{ Vector( -251, -1860, -282 ), DOOR_COMBINELOCK, "Bridge Access" },
	{ Vector( -786, -3091, 82.281303405762 ), DOOR_BUYABLE, "XCCR", 20, "XCCR" },
	{ Vector( -124, -3025, -544 ), DOOR_UNBUYABLE, "Out of Order", 0, "XCCR" },
	--{ Vector( -316, -3098, -544 ), DOOR_UNBUYABLE, "Storage", 0, "XCCR" },
	{ Vector( -254, -2728, -282 ), DOOR_UNBUYABLE, "Bridge Access", 0, "XCCR" },
	{ Vector( -138, -3294, -280 ), DOOR_UNBUYABLE, "", 0, "XCCR" },
	{ Vector( -251, -2745, 86.268501281738 ), DOOR_UNBUYABLE, "Underground Access", 0, "XCCR" },
	{ Vector( -337, -2822, 82.25 ), DOOR_UNBUYABLE, "Backroom", 0, "XCCR" },
	{ Vector( -1843, 281, 66 ), DOOR_BUYABLE, "Warehouse 1", 10 },
	{ Vector( -3397, 1465.5, 694 ), DOOR_BUYABLE, "CMS", 10, "CMS" },
	{ Vector( -3389, 1116, 726 ), DOOR_UNBUYABLE, "CMS", 0, "CMS" },
	{ Vector( -4031, 1736, 534 ), DOOR_BUYABLE, "Misc Store", 10, "MISC4" },
	{ Vector( -4253, 1284, 534 ), DOOR_UNBUYABLE, "Backroom", 0, "MISC4" },
	{ Vector( -4003, 1424, 694.25 ), DOOR_COMBINELOCK, "CCH-B" },
	{ Vector( -4384, 1572, 694 ), DOOR_UNBUYABLE, "Washing Room" },
	{ Vector( -4256, 1340, 694 ), DOOR_BUYABLE, "Apartment B-1-1", 5, "B11" },
	{ Vector( -4351, 1581, 822 ), DOOR_BUYABLE, "Apartment B-2-1", 5, "B21" },
	{ Vector( -4177, 1821, 822 ), DOOR_UNBUYABLE, "Bathroom", 0, "B21" },
	{ Vector( -4351, 1317, 822 ), DOOR_BUYABLE, "Apartment B-2-2", 5, "B22" },
	{ Vector( -4208, 1296, 822 ), DOOR_UNBUYABLE, "Bathroom", 0, "B22" },
	{ Vector( -4351, 1581, 950 ), DOOR_BUYABLE, "Apartment B-3-1", 5, "B31" },
	{ Vector( -4177, 1821, 950 ), DOOR_UNBUYABLE, "Bathroom", 0, "B31" },
	{ Vector( -4351, 1317, 950 ), DOOR_BUYABLE, "Apartment B-3-2", 5, "B32" },
	{ Vector( -4208, 1296, 950 ), DOOR_UNBUYABLE, "Bathroom", 0, "B32" },
	{ Vector( -4351, 1581, 1078 ), DOOR_BUYABLE, "Apartment B-4-1", 5, "B41" },
	{ Vector( -4177, 1821, 1078 ), DOOR_UNBUYABLE, "Bathroom", 0, "B41" },
	{ Vector( -4075, 1574.5, 1080 ), DOOR_UNBUYABLE, "", 0, "B41" },
	{ Vector( 100, 100, 110.56199645996 ), DOOR_COMBINELOCK, "CCH-E" },
	{ Vector( 6, 100, 110.28099822998 ), DOOR_COMBINELOCK, "CCH-E" },
	{ Vector( 114, 367, 110.5 ), DOOR_UNBUYABLE, "CCH-E" },
	{ Vector( 170, 404, 110.5 ), DOOR_UNBUYABLE, "Closet" },
	{ Vector( 211, 268.08898925781, -22 ), DOOR_BUYABLE, "Storage Room", 5 },
	{ Vector( -16, 268.08898925781, -22 ), DOOR_BUYABLE, "Storage Room", 5 },
	{ Vector( 120, 299, 254 ), DOOR_BUYABLE, "Apartment E-1", 5, "E1" },
	{ Vector( -6, 344, 254 ), DOOR_BUYABLE, "Apartment E-2", 5, "E2" },
	{ Vector( -25, -3721, 82 ), DOOR_COMBINELOCK, "CCH-A" },
	{ Vector( 353, -3485, 82 ), DOOR_BUYABLE, "Apartment A-1-1", 5, "A11" },
	{ Vector( 769, -3485, 82 ), DOOR_BUYABLE, "Apartment A-1-2", 5, "A12" },
	{ Vector( 353, -3485, 338 ), DOOR_BUYABLE, "Apartment A-2-1", 5, "A21" },
	{ Vector( 769, -3485, 338 ), DOOR_BUYABLE, "Apartment A-2-2", 5, "A22" },
}

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")