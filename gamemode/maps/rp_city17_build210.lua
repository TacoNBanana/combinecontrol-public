function GM:GetHL2CamPos()

	return { Vector( -1008, 965, 560 ), Angle( 16, -23, 0 ) };

end

function GM:GetCombineCratePos()

	return { Vector( 4876, 172, 93 ), Angle( 0, 180, 0 ) };

end

function GM:GetCombineRationPos()

	return { Vector( 4889, 89, 123 ), Angle( 0, 180, 0 ) };

end

GM.EnableAreaportals = true;

GM.IntroCamData = { };
GM.IntroCamData[1] = { { Vector( -912, -1262, 628 ), Vector( -700, -510, 456 ) }, { Angle( 13, 75, 0 ), Angle( 13, 75, 0 ) } };
GM.IntroCamData[2] = { { Vector( -2859, -2001, 284 ), Vector( -3397, -2452, 608 ) }, { Angle( 25, 40, 0 ), Angle( 25, 40, 0 ) } };
GM.IntroCamData[3] = { { Vector( 824, -8, 675 ), Vector( 1354, -2, 276 ) }, { Angle( 44, 1, 0 ), Angle( 17, 1, 0 ) } };
GM.IntroCamData[4] = { { Vector( 261, 4909, -324 ), Vector( 1142, 4916, -347 ) }, { Angle( 2, 1, 0 ), Angle( 2, 1, 0 ) } };
GM.IntroCamData[5] = { { Vector( 4002, -1753, 254 ), Vector( 4065, -1187, 190 ) }, { Angle( 9, 81, 0 ), Angle( 4, 89, 0 ) } };
GM.IntroCamData[6] = { { Vector( -5036, -262, 420 ), Vector( -4484, -258, 363 ) }, { Angle( 6, 1, 0 ), Angle( 6, 1, 0 ) } };


function GM:MapInitPostEntity()

	--for k, v in pairs( ents.GetAll() ) do

	--	MsgC( v:GetName() .. "\n" );

	--end

	for _, v in pairs( ents.FindByName( "razor_train_gate_2" ) ) do

		v:Fire( "Lock" );

	end

	for _, v in pairs( ents.FindByName( "trainstation_nova_doors" ) ) do

		v:Fire( "Lock" );

	end

	for _, v in pairs( ents.FindByName( "barney_door_1" ) ) do

		v:Fire( "Lock" );

	end

	for _, v in pairs( ents.FindByName( "change_door" ) ) do

		v:Fire( "Lock" );

	end

	for _, v in pairs( ents.FindByName( "petrol_entrance" ) ) do

		v:Fire( "Lock" );

	end

	self:CreateLocationPoint( Vector( 2094.525879, -3851.621826, 142.667206 ), LOCATION_CANAL, 128, TRANSITPORT_CITY_GATE );
	self:CreateLocationPoint( Vector( -673.025452, 7720.555176, -433.968750 ), LOCATION_CANAL, 128, TRANSITPORT_CITY_SEWER );
	self:CreateLocationPoint( Vector( 3815.592773, -1970.662354, -91.040276 ), LOCATION_CANAL, 128, TRANSITPORT_CITY_COMBINE );

end

GM.CurrentLocation = LOCATION_CITY;

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "Through the thick of the mud is a pipe by the wall. It may smell like shit but it just might be your chance out of the city.";
GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector( 1693, -4547, 81 ),
	Vector( 1647, -4547, 81 ),
	Vector( 1607, -4547, 81 ),
	Vector( 1600, -4616, 81 ),
	Vector( 1647, -4620, 81 ),
	Vector( 1693, -4625, 81 ),
};

GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "The sewage pipe looks like you can climb through it. Down a ways, you see a light - it looks like it leads into a concrete maintenance area.";
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector( -761, 6893, -465 ),
	Vector( -760, 6960, -465 ),
	Vector( -763, 7019, -465 ),
	Vector( -763, 7076, -465 ),
	Vector( -758, 7131, -465 ),
	Vector( -754, 7185, -463 ),
};

GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "A helicopter is here, ready to take you to patrol Sector 12.";
GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector( 3820, -1579, -179 ),
	Vector( 3822, -1541, -179 ),
	Vector( 3823, -1492, -179 ),
	Vector( 3825, -1437, -179 ),
	Vector( 3827, -1374, -179 ),
};

GM.EntNamesToRemove = {
	"nexus_door1",
	"spawn_message_3",
	"spawn_message_2",
	"spawn_message_1",
	"spawn_message_4",
	"button_range1_2",
	"cannon_button_trigger",
	"cannon_button",
	--"button_alarm_autonomous",
	--"button_alarm_streetfight_model",
	--"button_alarm_judge_model",
	--"button_alarm_judge",
	"game_text_autonomous",
	"game_text_judgement",
	"pipe_steam",
	"pipe_steam",
	"pipe_steam",
	"pipe_steam_sound",
	"pipe_damage",
	"nexus_door4",
	"secretdoor_apartment_down1",
	"secretdoor_apartment_down2",
	"underground_plinkohall_chaindoor",
	"pod_player",
	"podtrain_player",
	"button_pod_open_close",
	"button_pod_open_close_model",
	"button_pod_back_model",
	"button_pod_return",
	"button_pod_go_model",
	"button_fire_pod",
};

GM.CombineSpawnpoints = {
	Vector( 4664, 340, 77 ),
	Vector( 4733, 340, 77 ),
	Vector( 4795, 340, 77 ),
	Vector( 4858, 340, 77 ),
	Vector( 4856, 278, 77 ),
	Vector( 4797, 278, 77 ),
	Vector( 4735, 278, 77 ),
	Vector( 4672, 278, 77 ),
};

GM.Stoves = {
	{ Vector( 141, -1763, 101 ), Angle( 0, 90, 0 ), "SOUV", true },
	{ Vector( -114, -1389, 230 ), Angle( 0, 90, 0 ), "A11" },
	{ Vector( -418, -1338, 230 ), Angle( 0, 0, 0 ), "A12" },
	{ Vector( -115, -1389, 361 ), Angle( 0, 90, 0 ), "A21" },
	{ Vector( -418, -1339, 357 ), Angle( 0, 0, 0 ), "A22" },
	{ Vector( -115, -1390, 485 ), Angle( 0, 90, 0 ), "A31" },
	{ Vector( -417, -1338, 487 ), Angle( 0, 0, 0 ), "A32" },
	{ Vector( -115, -1390, 613 ), Angle( 0, 90, 0 ), "A41" },
	{ Vector( -418, -1339, 614 ), Angle( 0, 0, 0 ), "A42" },
	{ Vector( 633, 2647, 239 ), Angle( 0, 180, 0 ), "B11" },
	{ Vector( 634, 1980, 239 ), Angle( 0, 180, 0 ), "B12" },
	{ Vector( 634, 2646, 374 ), Angle( 0, 180, 0 ), "B21" },
	{ Vector( 633, 1980, 375 ), Angle( 0, 180, 0 ), "B22" },
	{ Vector( 634, 2647, 509 ), Angle( 0, 180, 0 ), "B31" },
	{ Vector( 587, 2234, 510 ), Angle( 0, 180, 0 ), "B32" },
	{ Vector( 634, 1979, 511 ), Angle( 0, 180, 0 ), "B33" },
	{ Vector( -2911, -3027, 357 ), Angle( 0, -90, 0 ), "C11" },
	{ Vector( -2455, -2606, 358 ), Angle( 0, 90, 0 ), "C13" },
	{ Vector( -2942, -3028, 486 ), Angle( 0, -90, 0 ), "C21" },
	{ Vector( -2471, -2613, 487 ), Angle( 0, 90, 0 ), "C22" },
	{ Vector( -2301, -2581, 486 ), Angle( 0, -90, 0 ), "C23" },
};

GM.DoorData = {
	{ Vector( 2408, 4, 132 ), DOOR_COMBINEOPEN, "Nexus" },
	{ Vector( 3512, -417.98999023438, 120 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 3501.9899902344, -1344, 132 ), DOOR_COMBINEOPEN, "Detainment Control" },
	{ Vector( 4140, 136, 132 ), DOOR_COMBINEOPEN, "Medical Bay" },
	{ Vector( 4544, 116, 132 ), DOOR_COMBINEOPEN, "Mess Hall" },
	{ Vector( 4676, -1639, 132.02000427246 ), DOOR_COMBINEOPEN, "Room 101" },
	{ Vector( 4340, -1413, -124 ), DOOR_COMBINEOPEN, "C&C" },
	{ Vector( 4340, -1547, -124 ), DOOR_COMBINEOPEN, "Intel Command" },
	{ Vector( 4780, -1088, -124 ), DOOR_COMBINEOPEN, "Armory" },
	{ Vector( 4780, -1848, -124 ), DOOR_COMBINEOPEN, "Armory" },
	{ Vector( 3448, -3512, -392 ), DOOR_COMBINEOPEN, "Combine Overwatch Transhuman Arm" },
	{ Vector( 5022.009765625, -196, 132 ), DOOR_COMBINEOPEN, "Combine Administration" },
	{ Vector( 4140, -2302, -124 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 4244, -747, -125.71900177002 ), DOOR_COMBINELOCK, "" },
	{ Vector( 4244, -747, 2.2810099124908 ), DOOR_COMBINELOCK, "" },
	{ Vector( 4244, -379, 2.2810099124908 ), DOOR_COMBINELOCK, "" },
	{ Vector( 4244, -1403, 2.2810099124908 ), DOOR_COMBINELOCK, "" },
	{ Vector( 4244, -1771, 2.2810099124908 ), DOOR_COMBINELOCK, "" },
	{ Vector( 251, -1154, 136 ), DOOR_BUYABLE, "Souvenirs", 20, "SOUV" },
	{ Vector( 131, -1436, 134 ), DOOR_BUYABLE, "", 20, "SOUV" },
	{ Vector( -3917, 444.07000732422, 102 ), DOOR_COMBINELOCK, "Ticket Booth" },
	{ Vector( -4479, 809, 96 ), DOOR_BUYABLE, "Food Stand", 10, "TSFS" },
	{ Vector( -4384, 667.5, 143.5 ), DOOR_BUYABLE, "", 10, "TSFS" },
	{ Vector( -4384, 888.5, 143.5 ), DOOR_BUYABLE, "", 10, "TSFS" },
	{ Vector( -3228.0700683594, 1299, 102 ), DOOR_COMBINELOCK, "Security" },
	{ Vector( -2840.7199707031, 1329.9100341797, 102 ), DOOR_COMBINELOCK, "Room 001" },
	{ Vector( -2649, 1332, 102 ), DOOR_COMBINELOCK, "Room 002" },
	{ Vector( -2489, 1660, 102 ), DOOR_COMBINELOCK, "Storage" },
	{ Vector( -2868, 1835, 102 ), DOOR_COMBINELOCK, "Storage" },
	{ Vector( -2868, 1741, 102 ), DOOR_COMBINELOCK, "Storage" },
	{ Vector( -2339, 1123.9799804688, 198 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( -1195, -209, 198 ), DOOR_UNBUYABLE, "Trainstation" },
	{ Vector( -1195, -303, 198 ), DOOR_UNBUYABLE, "Trainstation" },
	{ Vector( -909, 1048.9100341797, 134 ), DOOR_BUYABLE, "CMS", 30, "CMSD1" },
	{ Vector( -851, 1049, 134 ), DOOR_BUYABLE, "CMS", 30, "CMSD1" },
	{ Vector( -283, -1154, 136 ), DOOR_UNBUYABLE, "Housing Block A" },
	{ Vector( -24.977899551392, -1411.9899902344, 262.28100585938 ), DOOR_BUYABLE, "A-1-1", 20, "A11" },
	{ Vector( -89, -1268, 262 ), DOOR_BUYABLE, "", 20, "A11" },
	{ Vector( -312.97399902344, -1411.9799804688, 262.28100585938 ), DOOR_BUYABLE, "A-1-2", 20, "A12" },
	{ Vector( -339, -1268, 262 ), DOOR_BUYABLE, "", 20, "A12" },
	{ Vector( -24.977899551392, -1411.9899902344, 390.28100585938 ), DOOR_BUYABLE, "A-2-1", 20, "A21" },
	{ Vector( -89, -1268, 390 ), DOOR_BUYABLE, "", 20, "A21" },
	{ Vector( -312.97399902344, -1411.9799804688, 390.28100585938 ), DOOR_BUYABLE, "A-2-2", 20, "A22" },
	{ Vector( -339, -1268, 390 ), DOOR_BUYABLE, "", 20, "A22" },
	{ Vector( -24.977899551392, -1411.9899902344, 518.28100585938 ), DOOR_BUYABLE, "A-3-1", 20, "A31" },
	{ Vector( -89, -1268, 518 ), DOOR_BUYABLE, "", 20, "A31" },
	{ Vector( -312.97399902344, -1411.9799804688, 518.28100585938 ), DOOR_BUYABLE, "A-3-2", 20, "A32" },
	{ Vector( -339, -1268, 518 ), DOOR_BUYABLE, "", 20, "A32" },
	{ Vector( -24.977899551392, -1411.9899902344, 646.28100585938 ), DOOR_BUYABLE, "A-4-1", 20, "A41" },
	{ Vector( -89, -1268, 646 ), DOOR_BUYABLE, "", 20, "A41" },
	{ Vector( -312.97399902344, -1411.9799804688, 646.28100585938 ), DOOR_BUYABLE, "A-4-2", 20, "A42" },
	{ Vector( -339, -1268, 646 ), DOOR_BUYABLE, "", 20, "A42" },
	{ Vector( 741, 3630, 136 ), DOOR_BUYABLE, "CMU Building", 30, "CMU" },
	{ Vector( 873, 3356, 134 ), DOOR_BUYABLE, "", 30, "CMU" },
	{ Vector( 701, 3260, 134 ), DOOR_BUYABLE, "", 30, "CMU" },
	{ Vector( 651, 3260, 134 ), DOOR_BUYABLE, "", 30, "CMU" },
	{ Vector( -107, 2607, 134 ), DOOR_BUYABLE, "Shop", 15, "D2SHOP1" },
	{ Vector( -110, 2219.5, 128 ), DOOR_BUYABLE, "Shop", 15, "D2SHOP2" },
	{ Vector( -110, 2156.5, 128 ), DOOR_BUYABLE, "Shop", 15, "D2SHOP2" },
	{ Vector( -471.4049987793, 1965, 134 ), DOOR_BUYABLE, "", 15, "D2SHOP2" },
	{ Vector( -618.541015625, 2157, 134 ), DOOR_BUYABLE, "Back Entrance", 15, "D2SHOP2" },
	{ Vector( 462, 1669, 136 ), DOOR_BUYABLE, "Market", 15, "D2SHOP3" },
	{ Vector( 462, 1787, 136 ), DOOR_BUYABLE, "Market", 15, "D2SHOP3" },
	{ Vector( 397, 2373, 134 ), DOOR_UNBUYABLE, "Housing Block B" },
	{ Vector( 397, 2279, 134 ), DOOR_UNBUYABLE, "Housing Block B" },
	{ Vector( 600, 2443, 134 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( 768, 2491, 270 ), DOOR_BUYABLE, "B-1-1", 15, "B11" },
	{ Vector( 655, 2565, 270.28100585938 ), DOOR_BUYABLE, "", 15, "B11" },
	{ Vector( 768, 2087, 270 ), DOOR_BUYABLE, "B-1-2", 15, "B12" },
	{ Vector( 656, 2060, 270.28100585938 ), DOOR_BUYABLE, "", 15, "B12" },
	{ Vector( 768, 2491, 406 ), DOOR_BUYABLE, "B-2-1", 15, "B21" },
	{ Vector( 655, 2565, 406.28100585938 ), DOOR_BUYABLE, "", 15, "B21" },
	{ Vector( 768, 2087, 406 ), DOOR_BUYABLE, "B-2-2", 15, "B22" },
	{ Vector( 656, 2060, 406 ), DOOR_BUYABLE, "", 15, "B22" },
	{ Vector( 768, 2491, 542 ), DOOR_BUYABLE, "B-3-1", 15, "B31" },
	{ Vector( 655, 2565, 542.28100585938 ), DOOR_BUYABLE, "", 15, "B31" },
	{ Vector( 768, 2289, 542 ), DOOR_BUYABLE, "B-3-2", 15, "B32" },
	{ Vector( 623, 2256, 542 ), DOOR_BUYABLE, "", 15, "B32" },
	{ Vector( 768, 2087, 542 ), DOOR_BUYABLE, "B-3-3", 15, "B33" },
	{ Vector( 656, 2060, 542 ), DOOR_BUYABLE, "", 15, "B33" },
	{ Vector( -673, -1673, 136 ), DOOR_BUYABLE, "Shop", 20, "CORNERSHOP1" },
	{ Vector( -673, -1783, 136 ), DOOR_BUYABLE, "Shop", 20, "CORNERSHOP1" },
	{ Vector( 295.90899658203, -3854.9899902344, 134 ), DOOR_COMBINELOCK, "Combine Garage" },
	{ Vector( -2233, -4153, 136 ), DOOR_BUYABLE, "Book Store", 10, "BOOKSTORE" },
	{ Vector( -2551, -4412, 134 ), DOOR_BUYABLE, "", 10, "BOOKSTORE" },
	{ Vector( -4153, -3436, 198 ), DOOR_BUYABLE, "Store", 15, "STORED3NUMBER1" },
	{ Vector( -4127, -3436, 198 ), DOOR_BUYABLE, "Store", 15, "STORED3NUMBER2" },
	{ Vector( -1895, -3196, 134.28100585938 ), DOOR_UNBUYABLE, "Housing Block C" },
	{ Vector( -3251, -3284, 134 ), DOOR_UNBUYABLE, "Housing Block C" },
	{ Vector( -3251, -2499.4599609375, 134 ), DOOR_UNBUYABLE, "Housing Block C" },
	{ Vector( -2823, -2997, 390 ), DOOR_BUYABLE, "C-1-1", 10, "C11" },
	{ Vector( -2694, -2995, 390 ), DOOR_BUYABLE, "C-1-1", 10, "C11" },
	{ Vector( -2752, -2995.0900878906, 390 ), DOOR_BUYABLE, "C-1-1", 10, "C11" },
	{ Vector( -2297, -2997, 390 ), DOOR_BUYABLE, "C-1-2", 10, "C12" },
	{ Vector( -2469, -2901, 390 ), DOOR_BUYABLE, "C-1-3", 10, "C13" },
	{ Vector( -2576, -2711, 390 ), DOOR_BUYABLE, "", 10, "C13" },
	{ Vector( -2633, -2780, 390.25 ), DOOR_BUYABLE, "", 10, "C13" },
	{ Vector( -3307, -3054.169921875, 518 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( -2817, -2996, 518 ), DOOR_BUYABLE, "C-2-1", 10, "C21" },
	{ Vector( -2576, -2711, 518 ), DOOR_BUYABLE, "C-2-2", 10, "C22" },
	{ Vector( -2633, -2780, 518 ), DOOR_BUYABLE, "", 10, "C22" },
	{ Vector( -2408, -2711, 518 ), DOOR_BUYABLE, "C-2-3", 10, "C23" },
	{ Vector( -2153, -2776, 518 ), DOOR_BUYABLE, "", 10, "C23" },
	{ Vector( -2253, -2776, 518 ), DOOR_BUYABLE, "", 10, "C23" },
	{ Vector( 1705, -2832.0900878906, 134 ), DOOR_BUYABLE, "Warehouse", 15, "ELECWH" },
	{ Vector( 2500.0900878906, -2787, 134 ), DOOR_BUYABLE, "Warehouse", 15, "NORMWH" },
	{ Vector( 2693, -2517, 134 ), DOOR_BUYABLE, "", 15, "NORMWH" },
	{ Vector( 2572, -5113, 134 ), DOOR_BUYABLE, "Warehouse", 15, "NORMWH2" },
	{ Vector( 1881, -608, -412 ), DOOR_UNBUYABLE, "Sewer Access" },
	{ Vector( 311.45901489258, 5841, -412 ), DOOR_UNBUYABLE, "SMU Station" },
};

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")
