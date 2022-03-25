function GM:GetHL2CamPos()
	return {Vector(-2888, -2316, 483), Angle(15, 56, 0)}
end

function GM:GetCombineCratePos()
	return {Vector(-327, 665, 408), Angle(0, 90, 0)}
end

function GM:GetCombineRationPos()
	return {Vector(-21, 1059, 191), Angle(0, 180, 0)}
end

GM.EnableAreaportals = true
GM.CurrentLocation = LOCATION_CITY

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(-930, 5817, -158), LOCATION_CANAL, 128, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(-528, 907, 567), LOCATION_CANAL, 78, TRANSITPORT_CITY_COMBINE)

	for _, ent in pairs(ents.FindByClass("prop_door_rotating")) do
		ent:SetKeyValue("opendir", "0")
	end
end

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "This fence is low enough to be scaled. If the coast is clear, you can escape the cordon and sneak beyond city limits."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "A helicopter can be chartered here to take you into Sector 12."

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(-70, 5664, -222),
	Vector(-68, 5617, -222),
	Vector(-69, 5562, -222),
	Vector(-70, 5514, -222),
	Vector(-41, 5516, -222),
	Vector(-42, 5561, -222),
	Vector(-42, 5618, -222),
	Vector(-42, 5668, -222),
}
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = GM.EntryPortSpawns[TRANSITPORT_CITY_GATE]

GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector(-242, 1000, 649),
	Vector(-279, 999, 649),
	Vector(-308, 999, 649),
	Vector(-342, 999, 649),
	Vector(-342, 954, 649),
	Vector(-308, 954, 649),
	Vector(-279, 954, 649),
	Vector(-242, 955, 649),
}

GM.CombineSpawnpoints = {
	Vector(-365, 1015, 137),
	Vector(-365, 1049, 137),
	Vector(-365, 1077, 137),
	Vector(-365, 1112, 137),
	Vector(-400, 1112, 137),
	Vector(-400, 1075, 137),
	Vector(-400, 1049, 137),
	Vector(-400, 1011, 137),
}

GM.Stoves = {
	--Nexus
	{Vector(-119, 1056, 157), Angle(0, -0, 0), "", true},

	--CCH-A communal
	{Vector(-288, -527, 188), Angle(0, 90, 0), "", false},
	{Vector(-288, -527, 318), Angle(0, 90, 0), "", false},
	{Vector(-288, -527, 448), Angle(0, 90, 0), "", false},
	{Vector(-288, -527, 578), Angle(0, 90, 0), "", false},

	--CCH-B communal
	{Vector(-2027, 5293, -186), Angle(0, 90, 0), "", false, "models/props_wasteland/kitchen_stove001a.mdl"},
	{Vector(-1880, 5293, -186), Angle(0, 90, 0), "", false, "models/props_wasteland/kitchen_stove001a.mdl"},

	--Chestnut
	{Vector(-129, -1350, 130), Angle(0, 180, 0), "Chestnut", false, "models/props_wasteland/kitchen_stove001a.mdl"},
	{Vector(-106, -1402, 285), Angle(0, 180, 0), "Chestnut Apartment", false},
}

GM.VendingMachines = {
	--Bus station
	{Vector(-2247, -647, 120), Angle(0, 180, 0)},
	{Vector(-2254, -490, 120), Angle(0, -170, 0)},

	--Civic Center
	{Vector(-3441, -1642, 120), Angle(0, 90, 0)},

	--Transcontinental
	{Vector(-3236, 671, 137), Angle(0, -83, 0)},

	--CCH-A
	{Vector(-605, -995, 217), Angle(0, -0, 0)},

	--CCH-B
	{Vector(-157, 5491, -142), Angle(0, 180, 0)},
}

GM.CameraData = {
	{Vector(-3495.25, -429.125, 221.969), Angle(0, -42.8906, 0), "CIVIC-CENTER"},
	{Vector(-3611.09, -990.719, 333.969), Angle(0, -54.624, 0), "RDC"},
	{Vector(1664.84, -1633.03, 509.969), Angle(0, 74.0479, 0), "AUXILIARY", true},
	{Vector(-4135.25, -764.188, 349.969), Angle(0, 40.3418, 0), "ATRIUM"},
	{Vector(-4256.53, -1259.91, 677.969), Angle(0, 148.579, 0), "ATRIUM-OFFICES"},
	{Vector(271.469, 743.688, 61.9375), Angle(0, -19.248, 0), "NEXUS-MAINT", true},
}

GM.DoorData = {

	{Vector(-792, -841, 222), DOOR_COMBINELOCK, "Precinct 6 Apartment Block A", 0, "CCH-A"},
	{Vector(-400, -1019, 222), DOOR_COMBINELOCK, "Basement", 0, "CCH-A"},
	{Vector(-145, -1053, 94), DOOR_COMBINELOCK, "Basement", 0, "CCH-A"},

	{Vector(-555, -756, 222), DOOR_UNBUYABLE, "1", 0, "CCH-A"},
	{Vector(-431, -652, 222), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},
	{Vector(-201, -652, 222), DOOR_BUYABLE_ASSIGNABLE, "1-A", 10, "CCH-A 1-A"},
	{Vector(-201, -756, 222), DOOR_BUYABLE_ASSIGNABLE, "1-B", 10, "CCH-A 1-B"},

	{Vector(-555, -756, 350), DOOR_UNBUYABLE, "2", 0, "CCH-A"},
	{Vector(-201, -652, 350), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},
	{Vector(-431, -652, 350), DOOR_UNBUYABLE, "Storage", 0, "CCH-A"},
	{Vector(-783, -796, 350), DOOR_BUYABLE_ASSIGNABLE, "2-A", 10, "CCH-A 2-A"},
	{Vector(-201, -756, 350), DOOR_BUYABLE_ASSIGNABLE, "2-B", 10, "CCH-A 2-B"},
	{Vector(-376, -379, 350), DOOR_BUYABLE_ASSIGNABLE, "2-C", 10, "CCH-A 2-C"},
	{Vector(-231, -420, 350), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A 2-C"},

	{Vector(-555, -756, 479), DOOR_UNBUYABLE, "3", 0, "CCH-A"},
	{Vector(-431, -652, 478), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},
	{Vector(-783, -796, 478), DOOR_BUYABLE_ASSIGNABLE, "3-A", 10, "CCH-A 3-A"},
	{Vector(-201, -652, 478), DOOR_BUYABLE_ASSIGNABLE, "3-B", 10, "CCH-A 3-B"},
	{Vector(-232, -422, 478), DOOR_UNBUYABLE, "", 0, "CCH-A 3-B"},
	{Vector(-201, -756, 478), DOOR_BUYABLE_ASSIGNABLE, "3-C", 10, "CCH-A 3-C"},

	{Vector(-555, -756, 606), DOOR_UNBUYABLE, "4", 0, "CCH-A"},
	{Vector(-431, -652, 606), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},
	{Vector(-543, -417, 606), DOOR_UNBUYABLE, "Roof Access", 0, "CCH-A"},
	{Vector(-783, -796, 606), DOOR_BUYABLE_ASSIGNABLE, "4-A", 8, "CCH-A 4-A"},
	{Vector(-201, -652, 606), DOOR_BUYABLE_ASSIGNABLE, "4-B", 8, "CCH-A 4-B"},
	{Vector(-201, -756, 606), DOOR_BUYABLE_ASSIGNABLE, "4-C", 8, "CCH-A 4-C"},


	{Vector(-499, 5292, -137), DOOR_COMBINELOCK, "Precinct 6 Apartment Block B", 0, "CCH-B"},
	{Vector(-2253, 5684, -137), DOOR_COMBINELOCK, "Precinct 6 Apartment Block B", 0, "CCH-B"},
	{Vector(-382, 5707, -137), DOOR_COMBINELOCK, "Office", 0, "CCH-B"},
	{Vector(-2167, 5501, -137), DOOR_COMBINELOCK, "Storage", 0, "CCH-B"},

	{Vector(-799, 5508, -137), DOOR_BUYABLE_ASSIGNABLE, "1-A", 5, "CCH-B 1-A"},
	{Vector(-836, 5349, -137), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-B 1-A"},

	{Vector(-1093, 5524, -137), DOOR_BUYABLE_ASSIGNABLE, "1-B", 5, "CCH-B 1-B"},
	{Vector(-1068, 5349, -137), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-B 1-B"},

	{Vector(-1343, 5524, -137), DOOR_BUYABLE_ASSIGNABLE, "1-C", 5, "CCH-B 1-C"},
	{Vector(-1368, 5349, -137), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-B 1-C"},

	{Vector(-1621, 5508, -137), DOOR_BUYABLE_ASSIGNABLE, "1-D", 5, "CCH-B 1-D"},
	{Vector(-1658, 5349, -137), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-B 1-D"},

	{Vector(-405, -1577, 158), DOOR_BUYABLE, "Chestnut Tree Cafe", 25, "Chestnut"},
	{Vector(-195, -1560, 158), DOOR_UNBUYABLE, "", 0, "Chestnut"},

	{Vector(-84, -1568, 318), DOOR_BUYABLE, "Chestnut Tree Suite", 20, "Chestnut Apartment"},
	{Vector(-105, -1284, 318), DOOR_UNBUYABLE, "Bathroom", 0, "Chestnut Apartment"},
	{Vector(-228, -1351, 318), DOOR_UNBUYABLE, "Bedroom", 0, "Chestnut Apartment"},

	{Vector(-3576, -643, 150), DOOR_COMBINELOCK, "Civic Center", 0, "Civic Center"},
	{Vector(-3576, -549, 150), DOOR_COMBINELOCK, "Civic Center", 0, "Civic Center"},
	{Vector(-3565, -1672, 126), DOOR_COMBINELOCK, "Civic Center", 0, "Civic Center"},
	{Vector(-3995, -1180, 150), DOOR_COMBINELOCK, "Ration Distribution", 0, "Civic Center"},
	{Vector(-3995, -988, 150), DOOR_COMBINELOCK, "Bathroom", 0, "Civic Center"},
	{Vector(-4015, -205, 150), DOOR_COMBINELOCK, "Workroom A", 0, "Civic Center"},
	{Vector(-3603, -205, 150), DOOR_COMBINELOCK, "Workroom B", 0, "Civic Center"},
	{Vector(-4161, -665, 246), DOOR_COMBINELOCK, "Atrium", 0, "Civic Center"},
	{Vector(-4540, -1243, 478), DOOR_COMBINELOCK, "Offices", 0, "Civic Center"},
	{Vector(-4348, -1091, 478), DOOR_COMBINELOCK, "Office A", 0, "Civic Center"},
	{Vector(-4348, -779, 478), DOOR_COMBINELOCK, "Office B", 0, "Civic Center"},
	{Vector(-4348, -531, 478), DOOR_COMBINELOCK, "Office C", 0, "Civic Center"},
	{Vector(-4348, -315, 478), DOOR_COMBINELOCK, "Office D", 0, "Civic Center"},
	{Vector(-3794, -981, -10), DOOR_COMBINELOCK, "Lecture Hall", 0, "Civic Center"},
	{Vector(-3794, -587, -10), DOOR_COMBINELOCK, "Classroom", 0, "Civic Center"},

	{Vector(-1844, 644, 142), DOOR_BUYABLE, "Clinic", 20, "Clinic"},
	{Vector(-2207, 1108, 142), DOOR_BUYABLE, "Clinic", 20, "Clinic"},
	{Vector(-1781, 908, 142), DOOR_UNBUYABLE, "Storage", 0, "Clinic"},

	{Vector(467, -906, 178), DOOR_COMBINELOCK, "Abandoned Condos", 0, "Condos"},
	{Vector(373, -906, 178), DOOR_COMBINELOCK, "Abandoned Condos", 0, "Condos"},

	{Vector(327, -590, 178), DOOR_BUYABLE_ASSIGNABLE, "2", 2, "Condos 2"},

	{Vector(-409, -164, 158), DOOR_BUYABLE, "Corner Shop", 10, "Corner Shop"},
	{Vector(-376, -371, 158), DOOR_UNBUYABLE, "Storage", 0, "Corner Shop"},

	{Vector(-330, 644, 191.5), DOOR_COMBINEOPEN, "Precinct 6 Nexus", 0, "Nexus"},
	{Vector(172, 772, -130), DOOR_COMBINEOPEN, "Precinct 6 Nexus", 0, "Nexus"},
	{Vector(362, 792, 190), DOOR_COMBINEOPEN, "Precinct 6 Nexus", 0, "Nexus"},
	{Vector(-398, 644, 447.5), DOOR_COMBINEOPEN, "Roof Access", 0, "Nexus"},
	{Vector(131, 964, 190), DOOR_COMBINELOCK, "Bathroom", 0, "Nexus"},
	{Vector(113, 964, 190), DOOR_COMBINELOCK, "Bathroom", 0, "Nexus"},

	{Vector(-409, 828, 446), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(823, 897, -130), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(219, 1759, -258), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(651, 1759, -258), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(219, 1665, -258), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(907, 1671, -258), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(651, 1665, -258), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(325, 860, 318), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(-363, 828, 190), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(-213, 964, 446), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(-295, 964, 446), DOOR_COMBINELOCK, "", 0, "Nexus"},
	{Vector(147, 964, 318), DOOR_COMBINELOCK, "", 0, "Nexus"},

	{Vector(-462, 919, -66), DOOR_COMBINELOCK, "Cells", 0, "Nexus"},
	{Vector(-302, 1010, -66), DOOR_COMBINELOCK, "Cell 1", 0, "Nexus"},
	{Vector(-114, 1010, -66), DOOR_COMBINELOCK, "Cell 2", 0, "Nexus"},
	{Vector(39, 1010, -66), DOOR_COMBINELOCK, "Interrogation", 0, "Nexus"},

	{Vector(1857, -894, 437), DOOR_UNBUYABLE, "CELL", 0, "Nexus"},
	{Vector(1765, -1340, 438), DOOR_COMBINELOCK, "RESTRICTED ACCESS", 0, "Nexus"},
	{Vector(1611, -1340, 438), DOOR_COMBINELOCK, "RESTRICTED ACCESS", 0, "Nexus"},
	{Vector(1611, -1236, 438), DOOR_COMBINELOCK, "RESTRICTED ACCESS", 0, "Nexus"},
	{Vector(1711, -1236, 438), DOOR_COMBINELOCK, "RESTRICTED ACCESS", 0, "Nexus"},

	{Vector(958, 3642, 155), DOOR_BUYABLE, "Overpass Suite", 5, "Overpass Suite"},
	{Vector(954, 4018, 155), DOOR_BUYABLE, "Overpass Suite", 5, "Overpass Suite"},

	{Vector(195, 636, -130), DOOR_UNBUYABLE, "Maintenance Access", 0, "Sewer"},

	{Vector(-719, -2879, 134), DOOR_BUYABLE, "Shack", 8, "Shack"},
	{Vector(-928, -2930, 134), DOOR_UNBUYABLE, "", 0, "Shack"},

	{Vector(-3575, 2525, -11), DOOR_BUYABLE, "Shed", 8, "Shed"},

	{Vector(-2294, 6254, -168), DOOR_UNBUYABLE, "Back Room", 0, "Storehouse"},
	{Vector(-2371, 5940, -168), DOOR_BUYABLE, "Storehouse", 10, "Storehouse"},

	{Vector(-2743, 704, 158), DOOR_BUYABLE, "The Transcontinental", 30, "TPAHC"},
	{Vector(-2649, 704, 158), DOOR_BUYABLE, "The Transcontinental", 30, "TPAHC"},
	{Vector(-3003, 1027, 346), DOOR_UNBUYABLE, "Bathroom", 0, "TPAHC"},
	{Vector(-2912, 1120, 341), DOOR_UNBUYABLE, "", 0, "TPAHC"},

	{Vector(1364, 2091, 118), DOOR_UNBUYABLE, "Derelict Train Shed"},
	{Vector(-2311, 4, 126), DOOR_COMBINELOCK, "Delousing Station"},
	{Vector(-1908, 5143, -157), DOOR_BUYABLE, "Ticket Booth", 8},
}
