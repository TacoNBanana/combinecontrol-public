GM.CurrentLocation = LOCATION_CITY;

function GM:GetHL2CamPos()
	
	return { Vector( 3240, -2038, 712 ), Angle( 25, -171, 0 ) };
	
end

function GM:GetCombineRationPos()
	
	return { Vector( 221, 1, 271 ), Angle( 0, 180, 0 ) };
	
end

function GM:GetCombineCratePos()
	
	return { Vector( 161, -207, 241 ), Angle( -0, 90, 0 ) };
	
end

GM.EnableAreaportals = true;

GM.IntroCamData = { };
GM.IntroCamData[1] = { { Vector( -870, -275, 812 ), Vector( -2257, -269, 730 ) }, { Angle( 8, 180, 0 ), Angle( 8, 180, 0 ) } };
GM.IntroCamData[2] = { { Vector( -554, -1236, 625 ), Vector( 67, -1405, 526 ) }, { Angle( 11, 13, 0 ), Angle( 11, 14, 0 ) } };
GM.IntroCamData[3] = { { Vector( -742, -1932, 675 ), Vector( -742, -1932, 1063 ) }, { Angle( 18, -89, 0 ), Angle( 18, -89, 0 ) } };
GM.IntroCamData[4] = { { Vector( 2399, 150, 276 ), Vector( 2507, -367, 244 ) }, { Angle( 4, -78, 0 ), Angle( 4, -78, 0 ) } };
GM.IntroCamData[5] = { { Vector( -1289, -84, 598 ), Vector( -1873, -84, 598 ) }, { Angle( 7, -91, 0 ), Angle( 7, -91, 0 ) } };
GM.IntroCamData[6] = { { Vector( -2249, -1611, 265 ), Vector( -1433, -1615, 171 ) }, { Angle( 11, -0, 0 ), Angle( 11, -0, 0 ) } };


function GM:MapInitPostEntity()

	for _, v in pairs( ents.FindByName( "main_alarm" ) ) do
		
		v:SetPos( Vector(-1260.843140, -3250.799805, 185.815826) );
		
	end
	
	self:CreateLocationPoint( Vector( 3880.769531, -2571.363770, 47.642864 ), LOCATION_CANAL, 200, TRANSITPORT_CITY_GATE );
	self:CreateLocationPoint( Vector( -1436.837036, 145.166824, 143.641068 ), LOCATION_CANAL, 128, TRANSITPORT_CITY_SEWER );
	self:CreateLocationPoint( Vector( -176.708740, -2306.455566, 855.271729 ), LOCATION_CANAL, 128, TRANSITPORT_CITY_COMBINE );
	
end

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "A small tunnel up the wall leads into darkness, further down the tunnel you see light - it seems to lead into an open area, free of Combine rule.";
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "There is a sewage pipe here that looks like you can climb through it. Down a ways, you see a light - it looks like it leads into a concrete maintenance area.";
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "A helicopter is here, ready to take you to patrol Sector 12.";

GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector( -1252, -2587, 385 ),
	Vector( -1250, -2525, 385 ),
	Vector( -1183, -2524, 385 ),
	Vector( -1181, -2588, 385 ),
};

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector( -1667, -104, 1 ),
	Vector( -1632, -106, 1 ),
	Vector( -1596, -108, 1 ),
	Vector( -1563, -110, 1 ),
	Vector( -1530, -112, 1 ),
	Vector( -1496, -114, 1 ),
	Vector( -1462, -116, 1 ),
};

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector( 3291, -2622, -23 ),
	Vector( 3344, -2622, -23 ),
	Vector( 3400, -2622, -23 ), 
	Vector( 3470, -2622, -23 ),
	Vector( 3289, -2563, -23 ),
	Vector( 3341, -2560, -23 ),
	Vector( 3400, -2567, -23 ),
	Vector( 3468, -2569, -23 ),
};

GM.EntPositionsToRemove = {
	Vector( -203, -2701, 814 )
}

function GM:OnJWOn()
	
	for _, v in pairs( ents.FindByName( "siren_button" ) ) do
		
		v:Fire( "use" );
		
	end
	
end

function GM:OnJWOff()
	
	for _, v in pairs( ents.FindByName( "siren_button" ) ) do
		
		v:Fire( "use" );
		
	end

end

GM.EntNamesToRemove = {
	"message01",
	"message02",
	"Pod_message",
	"lift_txt_top",
	"lift_txt_control",
	"lift_txt_prisoncontrol",
	"lift_txt_groundlevel",
	"lift_txt_trainyard",
	"alarm_txt",
	"item_ammo_crate",
	"item_ammo_crate",
	"item_ammo_crate",
};

GM.CombineSpawnpoints = {
	Vector( 191, 191, 225 ),
	Vector( 131, 191, 225 ),
	Vector( 71, 191, 225 ),
	Vector( 11, 191, 225 ),
	Vector( -49, 191, 225 ),
	Vector( -109, 191, 225 ),
	Vector( -169, 191, 225 ),
};

GM.Stoves = {
	{ Vector( -1438, -749, 541 ), Angle( 0, 91, 0 ), "B11", true },
	{ Vector( -1241, -714, 541 ), Angle( 0, 90, 0 ), "B12", true },
	{ Vector( -1250, -1116, 541 ), Angle( 0, 1, 0 ), "B13", true },
	{ Vector( -1634, -1054, 669 ), Angle( 0, -0, 0 ), "B21", true },
	{ Vector( -1388, -1054, 669 ), Angle( 0, -0, 0 ), "B22", true },
	{ Vector( -4756, -1946, 925 ), Angle( 0, 0, 0 ), "A21", true },
	{ Vector( -4746, -2323, 925 ), Angle( 0, -90, 0 ), "A22", true },
	{ Vector( -4746, -2323, 797 ), Angle( 0, -90, 0 ), "A12", true },
	{ Vector( -4756, -1946, 797 ), Angle( 0, -0, 0 ), "A11", true },
	{ Vector( 1309, 1298, 629 ), Angle( 0, 90, 0 ), "D21", true },

};

GM.DoorData = {
	--COMBINE MISC--
	{ Vector( -3514, -1528, 112 ), DOOR_COMBINEOPEN, "Security" },
	{ Vector( 32, -2915, 112 ), DOOR_COMBINEOPEN, "Checkpoint" },
	{ Vector( 80, -2915, 112 ), DOOR_COMBINEOPEN, "Checkpoint" },
	{ Vector( 11, -1728, 118 ), DOOR_COMBINEOPEN, "Checkpoint" },
	{ Vector( -506.9700012207, -1726.5699462891, 118 ), DOOR_COMBINEOPEN, "Trainyard" },
	{ Vector( -1334, -2632, 572 ), DOOR_COMBINEOPEN, "" },
	--TRAINSTATION--
	{ Vector( -1724, -1910.5, 118 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( -2277, -1639, 118 ), DOOR_UNBUYABLE, "Trainstation" },
	{ Vector( -2343.4699707031, -1572.5300292969, 118 ), DOOR_UNBUYABLE, "Trainstation" },
	{ Vector( 906, -1478, 118 ), DOOR_UNBUYABLE, "Trainyard" },
	--SEWER MAINTAINANCE UNIT--
	{ Vector( 1281, -1533, 118 ), DOOR_BUYABLE, "SMU Station", 15, "SMU1" },
	{ Vector( 1418, -1297, 118 ), DOOR_UNBUYABLE, "", 0, "SMU1" },
	{ Vector( 1672, -1519, 118 ), DOOR_UNBUYABLE, "", 0, "SMU1" },
	{ Vector( 1672, -1297, 246 ), DOOR_UNBUYABLE, "", 0, "SMU1" },
	--SEWER ACCESS--
	{ Vector( 4233, -1404, 70 ), DOOR_COMBINELOCK, "Sewer Access" },
	{ Vector( 3428, 359, 246 ), DOOR_UNBUYABLE, "SMU Control" },
	{ Vector( 4057, 220, 246 ), DOOR_UNBUYABLE, "SMU Control" },
	{ Vector( 3481, -98, 118 ), DOOR_UNBUYABLE, "SMU Station" },
	{ Vector( 4057, -99, 506 ), DOOR_UNBUYABLE, "SMU Station" },
	{ Vector( 3236, -393, 714 ), DOOR_COMBINELOCK, "Sewer Access" },
	{ Vector( 4050, -385, 506 ), DOOR_COMBINELOCK, "Rooftop Access" },
	{ Vector( 785, 1278, 534 ), DOOR_UNBUYABLE, "Maintainance Access" },
	{ Vector( 906, -1338, 118 ), DOOR_UNBUYABLE, "Sub-Level A" },
	{ Vector( 1161, -828, 118 ), DOOR_UNBUYABLE, "Maintainance Access" },
	{ Vector( 1289, -564, 118 ), DOOR_COMBINELOCK, "Sewer Access" },
	{ Vector( -1276, -439, 118 ), DOOR_UNBUYABLE, "Sewer Access" },
	{ Vector( -1467, -1020, 574 ), DOOR_COMBINELOCK, "Sewer Access" },
	--COMBINE NEXUS--
	{ Vector( -712, -1707.5, 448 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -728, -1706, 448 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -744, -1708, 448 ), DOOR_COMBINEOPEN, "Combine Nexus" },
	{ Vector( -760, -1706, 448 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -824, -1708, 448 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -808, -1707, 448 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -792, -1707, 448 ), DOOR_COMBINEOPEN, "Combine Nexus" },
	{ Vector( -776, -1708, 448 ), DOOR_COMBINEOPEN, "" },
	{ Vector( -638, -2560, 448 ), DOOR_COMBINEOPEN, "Detainment" },
	{ Vector( -610.5, -2016, 578 ), DOOR_COMBINEOPEN, "Detainment" },
	{ Vector( -610.5, -1952, 578 ), DOOR_COMBINEOPEN, "Detainment" },
	{ Vector( -866, -2560, 448 ), DOOR_COMBINEOPEN, "Detainment" },
	{ Vector( -639, -2690, 708 ), DOOR_COMBINEOPEN, "Detainment Control" },
	{ Vector( -224, -2392.5, 836 ), DOOR_COMBINEOPEN, "Storage" },
	{ Vector( -484, -1924, 1346 ), DOOR_COMBINEOPEN, "Administration" },
	{ Vector( 64, -2242, 1352 ), DOOR_COMBINEOPEN, "Administration" },
	--CIVIL PROTECTION NEXUS--
	{ Vector( -236, 0, 284 ), DOOR_COMBINEOPEN, "Civil Protection Nexus" },
	{ Vector( -376.5, 88, 696 ), DOOR_COMBINEOPEN, "Civil Protection Nexus" },
	{ Vector( -276, 312, 702 ), DOOR_COMBINEOPEN, "Civil Protection Nexus" },
	{ Vector( -220, 312, 702 ), DOOR_COMBINEOPEN, "Civil Protection Nexus" },
	{ Vector( -128, -251, 272 ), DOOR_COMBINEOPEN, "" },
	{ Vector( 0, -1400, 120 ), DOOR_COMBINEOPEN, "Civil Protection Nexus" },
	--COMBINE OUTPOST--
	{ Vector( -1536, -896, 712 ), DOOR_COMBINEOPEN, "Combine Outpost" },
	{ Vector( -1030, -752, 726 ), DOOR_COMBINEOPEN, "Combine Outpost" },
	--CIVVIE DOORS--
	{ Vector( -2763, -988, 438 ), DOOR_BUYABLE, "Storage", 5, "STORAGE1" },
	{ Vector( -3331, -913, 438 ), DOOR_BUYABLE, "Northern Petrol Warehouse", 20, "NPW" },
	{ Vector( -3331, -1007, 438 ), DOOR_BUYABLE, "Northern Petrol Warehouse", 20, "NPW" },
	{ Vector( -3721, -964, 698 ), DOOR_UNBUYABLE, "Northern Petrol Roof" },
	{ Vector( -1593, 2, 438 ), DOOR_BUYABLE, "Corner Store", 15, "CS" },
	{ Vector( -1814, 262, 438 ), DOOR_BUYABLE, "", 15, "CS" },
	{ Vector( -1575, 2, 438 ), DOOR_BUYABLE, "Market", 15, "CM" },
	{ Vector( -1319, 380, 439 ), DOOR_BUYABLE, "", 15, "CM" },
	{ Vector( -1801, -516, 438 ), DOOR_BUYABLE, "Warehouse", 30, "SMUW" },
	{ Vector( -2076, -943, 710 ), DOOR_BUYABLE, "", 30, "SMUW" },
	{ Vector( -535, -552, 438 ), DOOR_BUYABLE, "Mini-Shop", 10, "MiniS" },
	{ Vector( 1544, -89, 438 ), DOOR_BUYABLE, "Storage", 10, "CCHCS" },
	{ Vector( 1544, 115, 438 ), DOOR_BUYABLE, "Store", 10, "CCHCSTORE" },
	{ Vector( 932, -1284, 440 ), DOOR_BUYABLE, "Store", 15, "NEXUSMARKET" },
	{ Vector( 1026, -1522, 574 ), DOOR_BUYABLE, "", 15, "NEXUSMARKET" },
	{ Vector( 1252, -1284, 440 ), DOOR_BUYABLE, "Store", 15, "NEXUSMARKET2" },
	{ Vector( 1234, -1522, 574 ), DOOR_BUYABLE, "", 15, "NEXUSMARKET2" },
	{ Vector( 1929, -572, 438 ), DOOR_BUYABLE, "Superstore", 30, "NEXUSMARKET3" },
	{ Vector( 2345, -761, 438 ), DOOR_BUYABLE, "Cafe Baltic", 20, "BALTIC" },
	{ Vector( 2688, -760, 432 ), DOOR_BUYABLE, "CMS", 40, "CMS" },
	{ Vector( 2656, -760, 432 ), DOOR_BUYABLE, "CMS", 40, "CMS" },
	{ Vector( 2792, 15, 438 ), DOOR_BUYABLE, "", 40, "CMS" },
	{ Vector( 2792, -337, 438 ), DOOR_BUYABLE, "", 40, "CMS" },
	{ Vector( 2951, -264, 438 ), DOOR_BUYABLE, "", 40, "CMS" },
	{ Vector( 2792, -337, 566 ), DOOR_BUYABLE, "", 40, "CMS" },
	{ Vector( 2696, -120, 566 ), DOOR_BUYABLE, "", 40, "CMS" },
	{ Vector( 1961, -204, 694 ), DOOR_BUYABLE, "Storage", 5, "ROOFSTORAGE" },
	--CCH A--
	{ Vector( -4516, -2345, 710 ), DOOR_UNBUYABLE, "Housing Block A" },
	{ Vector( -4871, -2304, 702 ), DOOR_UNBUYABLE, "Laundromat" },
	{ Vector( -4776, -2177, 830 ), DOOR_BUYABLE, "A-1-1", 30, "A11" },
	{ Vector( -4776, -2393, 830 ), DOOR_BUYABLE, "A-1-2", 30, "A12" },
	{ Vector( -4776, -2177, 958 ), DOOR_BUYABLE, "A-2-1", 30, "A21" },
	{ Vector( -4776, -2393, 958 ), DOOR_BUYABLE, "A-2-2", 30, "A22" },
	--CCH B--
	{ Vector( -1495, -518, 438 ), DOOR_UNBUYABLE, "Housing Block B" },
	{ Vector( -1627, -624, 439 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( -1623, -772, 574 ), DOOR_BUYABLE, "B-1-1", 15, "B11" },
	{ Vector( -1272, -553, 574 ), DOOR_BUYABLE, "B-1-2", 15, "B12" },
	{ Vector( -1272, -809, 574 ), DOOR_BUYABLE, "B-1-3", 15, "B13" },
	{ Vector( -1123, -1293, 574 ), DOOR_UNBUYABLE, "Housing Block B" },
	{ Vector( -1123, -1293, 702 ), DOOR_UNBUYABLE, "Housing Block B" },
	{ Vector( -1479, -1024, 702 ), DOOR_BUYABLE, "B-2-1", 15, "B21" },
	{ Vector( -1235, -1024, 702 ), DOOR_BUYABLE, "B-2-2", 15, "B22" },
	--CCH C--
	{ Vector( 641, -766, 438 ), DOOR_UNBUYABLE, "Housing Block C" },
	{ Vector( 735, -766, 438 ), DOOR_UNBUYABLE, "Housing Block C" },
	{ Vector( 735, 638, 438 ), DOOR_UNBUYABLE, "Housing Block C" },
	{ Vector( 641, 638, 438 ), DOOR_UNBUYABLE, "Housing Block C" },
	{ Vector( 772, -465, 438 ), DOOR_BUYABLE, "C-1-1", 15, "C11" },
	{ Vector( 1041, -480, 438 ), DOOR_BUYABLE, "", 15, "C11" },
	{ Vector( 903, -349, 438 ), DOOR_BUYABLE, "", 15, "C11" },
	{ Vector( 772, -145, 438 ), DOOR_BUYABLE, "C-1-2", 15, "C12" },
	{ Vector( 903, -29, 438 ), DOOR_BUYABLE, "", 15, "C12" },
	{ Vector( 1041, -160, 438 ), DOOR_BUYABLE, "", 15, "C12" },
	{ Vector( 772, 175, 438 ), DOOR_BUYABLE, "C-1-3", 15, "C13" },
	{ Vector( 903, 291, 438 ), DOOR_BUYABLE, "", 15, "C13" },
	{ Vector( 1041, 160, 438 ), DOOR_BUYABLE, "", 15, "C13" },
	{ Vector( 772, 495, 438 ), DOOR_BUYABLE, "C-1-4", 15, "C14" },
	{ Vector( 903, 611, 438 ), DOOR_BUYABLE, "", 15, "C14" },
	{ Vector( 1041, 480, 438 ), DOOR_BUYABLE, "", 15, "C14" },
	--CCH D--
	{ Vector( 827, 1076, 402 ), DOOR_UNBUYABLE, "Housing Block D" },
	{ Vector( 809, 1278, 662 ), DOOR_BUYABLE, "D-2-1", 10, "D21" },
	--CCH E--
	{ Vector( 2815, -1239, 438 ), DOOR_UNBUYABLE, "Housing Block E" },
	{ Vector( 1865, -898, 694 ), DOOR_UNBUYABLE, "Housing Block E" },
	{ Vector( 2481, -1153, 694 ), DOOR_BUYABLE, "E-1-1", 15, "E11" },
	{ Vector( 2333, -1240, 694 ), DOOR_BUYABLE, "", 15, "E11" },
	{ Vector( 2379, -1455, 694 ), DOOR_BUYABLE, "", 15, "E11" },
	{ Vector( 2305, -1519, 694 ), DOOR_BUYABLE, "", 15, "E11" },
	{ Vector( 2129, -1153, 694 ), DOOR_BUYABLE, "E-1-2", 15, "E12" },
	{ Vector( 1981, -1240, 694 ), DOOR_BUYABLE, "", 15, "E12" },
	{ Vector( 1953, -1519, 694 ), DOOR_BUYABLE, "", 15, "E12" },
	{ Vector( 2027, -1455, 694 ), DOOR_BUYABLE, "", 15, "E12" },
	{ Vector( 1855, -1111, 694 ), DOOR_BUYABLE, "E-1-3", 15, "E13" },
	{ Vector( 1647, -1111, 694 ), DOOR_BUYABLE, "", 15, "E13" },
	{ Vector( 1679, -1311, 694 ), DOOR_BUYABLE, "", 15, "E13" },
	{ Vector( 1601, -1519, 694 ), DOOR_BUYABLE, "", 15, "E13" },
	{ Vector( 1605, -639, 694 ), DOOR_BUYABLE, "E-1-4", 15, "E14" },
	{ Vector( 1519, -353, 694 ), DOOR_BUYABLE, "", 15, "E14" },
	{ Vector( 1585, -353, 694 ), DOOR_BUYABLE, "", 15, "E14" },
};