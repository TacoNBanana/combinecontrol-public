function GM:GetHL2CamPos()
	return {Vector(1820, 3180, 879), Angle(16, -143, 0)}
end

function GM:GetCombineCratePos()
	return {Vector(-3619, 2625, 318), Angle(-0, 180, -0)}
end

function GM:GetCombineRationPos()
	return {Vector(-3634, 2383, 364), Angle(0, 90, 0)}
end

GM.EnableAreaportals = true

GM.CurrentLocation	= LOCATION_CITY

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(1902, 2950, -400), LOCATION_CANAL, 64, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(4167, -361, -145), LOCATION_CANAL, 200, TRANSITPORT_CITY_SEWER)
	self:CreateLocationPoint(Vector(-2698, 3325, 743), LOCATION_CANAL, 128, TRANSITPORT_CITY_COMBINE)
end

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "The manhole cover is slightly ajar. Inside you can see a ladder leading down to a dimly lit shaft, leading who knows where."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "The grating under the gate looks loose, you could slip under it. It looks like it leads further away in the old sewer system."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "An elevator door here leads to a helicopter, which will bring you to Sector 12."

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(1966, 2872, -423),
	Vector(1996, 2872, -423),
	Vector(2029, 2872, -423),
	Vector(2069, 2872, -423),
	Vector(2071, 2913, -423),
	Vector(2034, 2915, -423),
}
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(4160, -80, -160),
	Vector(4202, -79, -159),
	Vector(4250, -78, -158),
	Vector(4249, -11, -158),
	Vector(4179, -12, -159),
	Vector(4139, -20, -160),
}
GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector(-2511, 3132, 686),
	Vector(-2511, 3075, 686),
	Vector(-2512, 3026, 686),
	Vector(-2457, 3025, 686),
	Vector(-2457, 3075, 686),
	Vector(-2457, 3132, 686),
}

GM.EntNamesToRemove = {
	"jw_button",
}

function GM:OnJWOn()
	ents.FindByName("jw_start")[1]:Fire("trigger")
end

function GM:OnJWOff()
	ents.FindByName("jw_end")[1]:Fire("trigger")
end

GM.Stoves = {
	-- CCH-A
	{Vector(894, 3443, 507), Angle(0, 0, 0), "A11"},
	{Vector(1462, 3460, 508), Angle(0, -90, 0), "A12"},
	{Vector(893, 3442, 664), Angle(0, 0, 0), "A21"},
	{Vector(1462, 3459, 665), Angle(0, -90, 0), "A22"},
	{Vector(935, 3415, 821), Angle(0, 31, 0), "A31"},
	{Vector(1461, 3460, 821), Angle(0, -90, 0), "A32"},

	-- CCH-B
	{Vector(363, 438, 97), Angle(0, 0, 0), "B11"},
	{Vector(364, 254, 98), Angle(0, 0, 0), "B12"},
	{Vector(365, 66, 98), Angle(0, 0, 0), "B13"},
	{Vector(364, 437, 254), Angle(0, 0, 0), "B21"},
	{Vector(365, 253, 256), Angle(0, 0, 0), "B22"},
	{Vector(365, 67, 255), Angle(0, 0, 0), "B23"},
	{Vector(366, 437, 412), Angle(0, 0, 0), "B31"},
	{Vector(367, 251, 411), Angle(0, 0, 0), "B32"},
	{Vector(364, 68, 411), Angle(0, 0, 0), "B33"},

	-- CCH-C
	{Vector(100, -189, 23), Angle(0, 90, 0), "C11"},
	{Vector(101, -189, 161), Angle(0, 90, 0), "C21"},

	-- Baltic
	{Vector(2120, 3277, 386), Angle(0, 1, 0), "BALTIC", true},

	-- Bar 1
	{Vector(-890, 1857, 65), Angle(0, 91, 0), "BAR1", true},
}

GM.VendingMachines = {
	{Vector(-533, 3462, 495), Angle(0, 180, 0)},
	{Vector(-533, 3409, 495), Angle(0, 180, 0)},
	{Vector(-97, 1378, 566), Angle(0, 90, 0)},
	{Vector(496, 3747, 532), Angle(0, -90, 0)},
	{Vector(549, 3747, 532), Angle(0, -90, 0)},
	{Vector(721, 932, 207), Angle(0, -89, 0)},
	{Vector(70, 43, 50), Angle(0, -0, 0)},
}

GM.CombineSpawnpoints = {
	Vector(-3788, 2620, 302),
	Vector(-3789, 2579, 302),
	Vector(-3788, 2530, 302),
	Vector(-3787, 2481, 302),
	Vector(-3787, 2442, 302),
	Vector(-3786, 2400, 302),
}

GM.MapChairs = {
	{Vector(1080, 2517, 234), Angle(0, 88, 0)},
	{Vector(1079, 2491, 234), Angle(0, 88, 0)},
	{Vector(1078, 2463, 234), Angle(0, 88, 0)},
	{Vector(1087, 2432, 234), Angle(0, 94, 0)},
	{Vector(1089, 2403, 234), Angle(0, 94, 0)},
	{Vector(1090, 2375, 234), Angle(0, 94, 0)},
	{Vector(1082, 2339, 234), Angle(0, 63, 0)},
	{Vector(1070, 2317, 234), Angle(0, 64, 0)},
	{Vector(1057, 2291, 234), Angle(0, 63, 0)},
	{Vector(757, 2290, 234), Angle(0, -2, 0)},
	{Vector(726, 2291, 234), Angle(0, -0, 0)},
	{Vector(697, 2292, 234), Angle(0, -1, 0)},
	{Vector(630, 2296, 234), Angle(0, 2, 0)},
	{Vector(569, 2294, 234), Angle(0, 2, 0)},
	{Vector(597, 2294, 234), Angle(0, 2, 0)},
	{Vector(123, 2274, 234), Angle(0, -2, 0)},
	{Vector(152, 2273, 234), Angle(0, -2, 0)},
	{Vector(183, 2272, 234), Angle(0, -2, 0)},
	{Vector(160, 2505, 233), Angle(0, -132, 0)},
	{Vector(140, 2484, 234), Angle(0, -132, 0)},
	{Vector(118, 2461, 233), Angle(0, -132, 0)},
	{Vector(437, 2558, 234), Angle(0, -179, 0)},
	{Vector(464, 2558, 234), Angle(0, -179, 0)},
	{Vector(491, 2558, 234), Angle(0, -179, 0)},
	{Vector(526, 2556, 234), Angle(0, -179, 0)},
	{Vector(553, 2556, 234), Angle(0, -179, 0)},
	{Vector(583, 2556, 234), Angle(0, -179, 0)},
	{Vector(707, 2557, 234), Angle(0, -179, 0)},
	{Vector(737, 2557, 234), Angle(0, -179, 0)},
	{Vector(762, 2557, 234), Angle(0, -179, 0)},
	{Vector(-126, 3151, 59), Angle(0, 73, 0)},
	{Vector(-119, 3174, 59), Angle(0, 73, 0)},
	{Vector(-110, 3202, 59), Angle(0, 72, 0)},
	{Vector(-122, 3336, 56), Angle(0, 109, 0)},
	{Vector(-112, 3307, 56), Angle(0, 108, 0)},
	{Vector(-105, 3282, 56), Angle(0, 108, 0)},
}

GM.DoorData = {
	-- CCH-A
	{Vector(743, 3606, 539), DOOR_COMBINELOCK, "Apartment Block A"},
	{Vector(836, 3606, 539), DOOR_COMBINELOCK, "Apartment Block A"},
	-- Floor 1
	{Vector(1102, 3602, 540), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-1", 2, "A11"},
	{Vector(951, 3528, 540.33099365234), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 2, "A11"},
	{Vector(906.33001708984, 3380.9599609375, 514.16998291016), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 2, "A11"},
	{Vector(1222, 3602, 540), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-2", 2, "A12"},
	{Vector(1410, 3549, 540.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 2, "A12"},
	{Vector(1400.0799560547, 3446.5500488281, 514.16998291016), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 2, "A12"},
	-- Floor 2
	{Vector(1102, 3602, 697), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-1", 2, "A21"},
	{Vector(951, 3528, 697.33099365234), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 2, "A21"},
	{Vector(906.33001708984, 3380.9599609375, 671.16998291016), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 2, "A21"},
	{Vector(1222, 3602, 697), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-2", 2, "A22"},
	{Vector(1410, 3549, 697.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 2, "A22"},
	{Vector(1400.0799560547, 3446.5500488281, 671.16998291016), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 2, "A22"},
	-- Floor 3
	{Vector(1102, 3602, 854), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-1", 2, "A31"},
	{Vector(951, 3528, 854.33099365234), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 2, "A31"},
	{Vector(1222, 3602, 854), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-2", 2, "A32"},
	{Vector(1410, 3549, 854.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 2, "A32"},
	{Vector(1400.0799560547, 3446.5600585938, 828.16998291016), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 2, "A32"},

	-- CCH-B
	{Vector(706, 750, 212), DOOR_COMBINELOCK, "Apartment Block B"},
	{Vector(613, 750, 212), DOOR_COMBINELOCK, "Apartment Block B"},
	{Vector(614, -54, 129), DOOR_COMBINELOCK, "Apartment Block B"},
	{Vector(707, -54, 129), DOOR_COMBINELOCK, "Apartment Block B"},
	-- Floor 1
	{Vector(579, 477, 130), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-1-1", 4, "B11"},
	{Vector(340, 478, 130.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B11"},
	{Vector(473, 381, 130), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B11"},
	{Vector(416.95999145508, 405.20999145508, 104.16999816895), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B11"},
	{Vector(579, 292, 130), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-1-2", 4, "B12"},
	{Vector(340, 293, 130.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B12"},
	{Vector(473, 196, 130), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B12"},
	{Vector(416.95999145508, 220.21000671387, 104.16999816895), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B12"},
	{Vector(579, 107, 130), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-1-3", 4, "B13"},
	{Vector(340, 108, 130.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B13"},
	{Vector(473, 11, 130), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B13"},
	{Vector(416.95999145508, 35.209999084473, 104.16999816895), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B13"},
	-- Floor 2
	{Vector(579, 477, 287), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-2-1", 4, "B21"},
	{Vector(340, 478, 287.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B21"},
	{Vector(473, 381, 287), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B21"},
	{Vector(416.95999145508, 405.20999145508, 261.17001342773), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B21"},
	{Vector(579, 292, 287), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-2-2", 4, "B22"},
	{Vector(340, 293, 287.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B22"},
	{Vector(473, 196, 287), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B22"},
	{Vector(416.95999145508, 220.21000671387, 261.17001342773), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B22"},
	{Vector(579, 107, 287), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-2-3", 4, "B23"},
	{Vector(340, 108, 287.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B23"},
	{Vector(473, 11, 287), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B23"},
	{Vector(416.95999145508, 35.209999084473, 261.17001342773), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B23"},
	-- Floor 3
	{Vector(579, 477, 444), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-3-1", 4, "B31"},
	{Vector(340, 478, 444.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B31"},
	{Vector(473, 381, 444), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B31"},
	{Vector(416.95999145508, 405.20999145508, 418.17001342773), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B31"},
	{Vector(579, 292, 444), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-3-2", 4, "B32"},
	{Vector(340, 293, 444.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B32"},
	{Vector(473, 196, 444), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B32"},
	{Vector(416.95999145508, 220.21000671387, 418.17001342773), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B32"},
	{Vector(579, 107, 444), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-3-3", 4, "B33"},
	{Vector(340, 108, 444.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Balcony", 4, "B33"},
	{Vector(473, 11, 444), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 4, "B33"},
	{Vector(416.95999145508, 35.209999084473, 418.17001342773), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 4, "B33"},

	-- CCH-C
	{Vector(-72, 92, 55.281299591064), DOOR_COMBINELOCK, "Apartment Block C"},
	-- Floor 1
	{Vector(-12, -28, 56.281299591064), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-1-1", 3, "C11"},
	{Vector(-29, -129, 56.28099822998), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 3, "C11"},
	{Vector(70.120002746582, -174.91999816895, 30.170000076294), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 3, "C11"},
	-- Floor 2
	{Vector(-12, -20, 195.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-2-1", 3, "C21"},
	{Vector(-29, -129, 195.28100585938), DOOR_BUYABLE_ASSIGNABLE, "Bathroom", 3, "C21"},
	{Vector(69.959999084473, -174.91999816895, 169.16999816895), DOOR_BUYABLE_ASSIGNABLE, "Fridge", 3, "C21"},

	-- Misc Living
	{Vector(1836, 906, 419.28100585938), DOOR_UNBUYABLE, "Apartment Complex"},
	{Vector(1836, 813, 419.28100585938), DOOR_UNBUYABLE, "Apartment Complex"},
	{Vector(2149, 835, 419.28100585938), DOOR_BUYABLE, "Old Apartment", 2},
	{Vector(2057, 968, 222.28100585938), DOOR_BUYABLE, "Old Apartment", 2},
	{Vector(4018, 443, 15.281299591064), DOOR_BUYABLE, "Shack", 5},
	{Vector(4390, -118, -90.718803405762), DOOR_BUYABLE, "Shack", 5},

	-- Warehouses
	-- Warehouse 1
	{Vector(2011, 1897, 420), DOOR_BUYABLE, "Backroom", 10, "WARE1"},
	{Vector(2158, 2289, 487), DOOR_BUYABLE, "Warehouse", 10, "WARE1"},
	{Vector(1845, 2041, 419.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE1"},
	{Vector(1845, 2134, 419.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE1"},
	-- Warehouse 2
	{Vector(1832, 1494, 427), DOOR_BUYABLE, "Warehouse", 10, "WARE2"},
	{Vector(2066, 1307, 354.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE2"},
	-- Warehouse 3
	{Vector(197, 1403, 354.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE3"},
	{Vector(900.63000488281, 1652.5500488281, 428.01000976563), DOOR_BUYABLE, "Warehouse", 10, "WARE3"},
	-- Warehouse 4
	{Vector(-209, 1572, 571), DOOR_BUYABLE, "Warehouse", 10, "WARE4"},
	{Vector(-209, 1479, 571), DOOR_BUYABLE, "Warehouse", 10, "WARE4"},
	-- Warehouse 5
	{Vector(-309, 935, 226.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE5"},
	{Vector(-254, 1240, 226.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE5"},
	-- Warehouse 6
	{Vector(-574.25, 312, 226.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE6"},
	{Vector(-790, 594.93902587891, 226.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE6"},
	-- Warehouse 7
	{Vector(5030, 885, 309.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE7"},
	{Vector(4883, 1411, 439.28100585938), DOOR_BUYABLE, "Backroom", 10, "WARE7"},
	-- Warehouse 8
	{Vector(4838, 430, 309.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE8"},
	{Vector(5245, 8.1999998092651, 309.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE8"},
	-- Warehouse 9
	{Vector(4712.2001953125, -663, 309.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE9"},
	{Vector(5098, -193.23100280762, 309.28100585938), DOOR_BUYABLE, "Warehouse", 10, "WARE9"},
	-- Misc warehouses
	{Vector(957, 629, 111.28099822998), DOOR_BUYABLE, "Warehouse", 10},
	{Vector(3388, 674, 309.28100585938), DOOR_BUYABLE, "Warehouse", 10},
	{Vector(3277.9499511719, -87, 309.28100585938), DOOR_BUYABLE, "Warehouse", 10},
	{Vector(-242, 347, 118.28099822998), DOOR_BUYABLE, "Warehouse", 10},

	-- Stores
	-- Baltic
	{Vector(1882, 3202, 420), DOOR_BUYABLE, "Store", 10, "BALTIC"},
	{Vector(2244, 3239, 419.28100585938), DOOR_BUYABLE, "Store", 10, "BALTIC"},
	{Vector(2096, 3585, 419.28100585938), DOOR_BUYABLE, "Backroom", 10, "BALTIC"},
	-- FOTO
	{Vector(-1021, 2647, 501.28100585938), DOOR_BUYABLE, "Store", 5, "FOTO"},
	{Vector(-1248, 2704, 501.28100585938), DOOR_BUYABLE, "Backroom", 5, "FOTO"},
	-- Cyber Cafe
	{Vector(-1021, 2828, 501.28100585938), DOOR_BUYABLE, "Store", 5, "CYBERCAFE"},
	{Vector(-1247, 2948, 501.28100585938), DOOR_BUYABLE, "Backroom", 5, "CYBERCAFE"},
	-- Souvenir
	{Vector(-1021, 3219, 501.28100585938), DOOR_BUYABLE, "Store", 5, "SOUVENIR"},
	{Vector(-1365, 3494, 501), DOOR_BUYABLE, "Backroom", 5, "SOUVENIR"},
	-- Store 1
	{Vector(-957, 3494, 501), DOOR_BUYABLE, "Store", 5, "STORE1"},
	{Vector(-988, 3618, 501.28100585938), DOOR_BUYABLE, "Backroom", 5, "STORE1"},
	-- Store 2
	{Vector(522, -409, -22.718799591064), DOOR_BUYABLE, "Store", 5, "STORE2"},
	{Vector(748, -411, -22.718799591064), DOOR_BUYABLE, "Backroom", 5, "STORE2"},
	-- Misc stores
	{Vector(-729, 3494, 501), DOOR_BUYABLE, "Store", 5},
	{Vector(-107, 692, 184.28100585938), DOOR_BUYABLE, "Store", 5},

	-- Bars
	-- Bar 1
	{Vector(-1074, 1467, 98.281303405762), DOOR_BUYABLE, "Bar", 10, "BAR1"},
	{Vector(-1074, 1828, 99), DOOR_BUYABLE, "Backroom", 10, "BAR1"},
	-- Bar 2
	{Vector(659, 280, -128.71899414063), DOOR_BUYABLE, "Bar", 10, "BAR2"},
	{Vector(385, 736, -128.71899414063), DOOR_BUYABLE, "Bathroom", 10, "BAR2"},
	-- Misc bars
	{Vector(-1016.1099853516, 316, 290.5), DOOR_BUYABLE, "Bar", 10},

	-- Nexus doors
	{Vector(-1303, 2123, 547), DOOR_COMBINELOCK, "Nexus"},
	{Vector(-1303, 2216, 547), DOOR_COMBINELOCK, "Nexus"},
	{Vector(-1636, 2094, 547.28100585938), DOOR_COMBINELOCK, "Nexus"},
	{Vector(-1636, 2187, 547.28100585938), DOOR_COMBINELOCK, "Nexus"},
	{Vector(-1536, 2000, 547.28100585938), DOOR_COMBINELOCK, "Liason Room"},
	{Vector(-1443, 2000, 547.28100585938), DOOR_COMBINELOCK, "Liason Room"},
	{Vector(-1356.0400390625, 2268, 549), DOOR_COMBINEOPEN, "Distribution"},
	{Vector(-2008.0100097656, 2140.0100097656, 549), DOOR_COMBINEOPEN, "Nexus"},
	{Vector(-3270, 1550, 355.25), DOOR_COMBINELOCK, "Cell 1"},
	{Vector(-3270, 1437, 355.25), DOOR_COMBINELOCK, "Cell 2"},
	{Vector(-3270, 1324, 355.25), DOOR_COMBINELOCK, "Cell 3"},
	{Vector(-3270, 1211, 355.25), DOOR_COMBINELOCK, "Cell 4"},
	{Vector(-3270, 1098, 355.25), DOOR_COMBINELOCK, "Cell 5"},
	{Vector(-3270, 992, 355.25), DOOR_COMBINELOCK, "Cell 6"},
	{Vector(-3797, 1527.5, 362.5), DOOR_COMBINEOPEN, "Room 103"},
	{Vector(-3793, 1304.5, 362.5), DOOR_COMBINEOPEN, "Room 102"},
	{Vector(-3796, 1102.5, 362.5), DOOR_COMBINEOPEN, "Room 101"},
	{Vector(-2393, 1650.5, 1124.5), DOOR_COMBINEOPEN, "Control Room"},
	{Vector(-1626, 1445.5, 1116.5), DOOR_COMBINEOPEN, "Rooftop Access"},
	{Vector(-3596.1398925781, 2534, 355.28100585938), DOOR_UNBUYABLE, "Locker Room"},
	-- Misc Combine lockable
	{Vector(-33, 3660, 99.281196594238), DOOR_COMBINELOCK, "Maintenance Access"},
	{Vector(574, 3660, -115.71900177002), DOOR_COMBINELOCK, "Maintenance Access"},
	{Vector(1411, 1654.5600585938, 439.28100585938), DOOR_COMBINELOCK, "Pump Station"},
	{Vector(1454, 2788.5600585938, -56.718799591064), DOOR_COMBINELOCK, "Maintenance Access"},

	-- Misc doors
	{Vector(3337.7199707031, 1180.5899658203, -437.71899414063), DOOR_UNBUYABLE, "Meeting Room"},
	{Vector(3430.7199707031, 1180.5899658203, -437.71899414063), DOOR_UNBUYABLE, "Meeting Room"},
}

GM.OldDoorData = {
	{Vector(-72, 92, 55.281299591064), DOOR_COMBINELOCK, "Luxury Condos"},
	{Vector(-12, -28, 56.281299591064), DOOR_BUYABLE_ASSIGNABLE, "CCH-B 1-1", 3, "CCH-B 1-1"},
	{Vector(-12, -20, 195.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-B 2-1", 3, "CCH-B 2-1"},
	{Vector(-29, -129, 195.28100585938), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-B 2-1"},
	{Vector(-242, 347, 118.28099822998), DOOR_COMBINELOCK, "Boiler Room"},
	{Vector(340, 108, 130.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 1-1", 5, "CCH-C 1-1"},
	{Vector(-29, -129, 56.28099822998), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-B 1-1"},
	{Vector(473, 11, 130), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 1-1"},
	{Vector(579, 107, 130), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 1-1", 5, "CCH-C 1-1"},
	{Vector(340, 293, 130.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 1-2", 5, "CCH-C 1-2"},
	{Vector(473, 196, 130), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 1-2"},
	{Vector(579, 292, 130), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 1-2", 5, "CCH-C 1-2"},
	{Vector(340, 478, 130.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 1-3", 5, "CCH-C 1-3"},
	{Vector(473, 381, 130), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 1-3"},
	{Vector(579, 477, 130), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 1-3", 5, "CCH-C 1-3"},
	{Vector(340, 108, 287.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 2-1", 5, "CCH-C 2-1"},
	{Vector(473, 11, 287), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 2-1"},
	{Vector(579, 107, 287), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 2-1", 5, "CCH-C 2-1"},
	{Vector(340, 293, 287.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 2-2", 5, "CCH-C 2-2"},
	{Vector(473, 196, 287), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 2-2"},
	{Vector(579, 292, 287), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 2-2", 5, "CCH-C 2-2"},
	{Vector(340, 478, 287.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 2-3", 5, "CCH-C 2-3"},
	{Vector(473, 381, 287), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 2-3"},
	{Vector(579, 477, 287), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 2-3", 5, "CCH-C 2-3"},
	{Vector(340, 108, 444.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 3-1", 5, "CCH-C 3-1"},
	{Vector(473, 11, 444), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 3-1"},
	{Vector(579, 107, 444), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 3-1", 5, "CCH-C 3-1"},
	{Vector(340, 293, 444.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 3-2", 5, "CCH-C 3-2"},
	{Vector(473, 196, 444), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 3-2"},
	{Vector(579, 292, 444), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 3-2", 5, "CCH-C 3-2"},
	{Vector(340, 478, 444.28100585938), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 3-3", 5, "CCH-C 3-3"},
	{Vector(473, 381, 444), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-C 3-3"},
	{Vector(579, 477, 444), DOOR_BUYABLE_ASSIGNABLE, "CCH-C 3-3", 5, "CCH-C 3-3"},
	{Vector(-107, 692, 184.28100585938), DOOR_BUYABLE, "Kiosk", 3},
	{Vector(-309, 935, 226.28100585938), DOOR_BUYABLE, "Room", 5, "Meeting Room"},
	{Vector(-254, 1240, 226.28100585938), DOOR_BUYABLE, "Room", 5, "Meeting Room"},
	{Vector(197, 1403, 354.28100585938), DOOR_BUYABLE, "Generator Room", 10, "Generatorplace"},
	{Vector(900.63000488281, 1652.5500488281, 428.01000976563), DOOR_BUYABLE, "Deliveries", 10, "Generatorplace"},
	{Vector(957, 629, 111.28099822998), DOOR_BUYABLE, "Workshop", 5},
	{Vector(2057, 968, 222.28100585938), DOOR_BUYABLE, "Old Apartment", 2},
	{Vector(2149, 835, 419.28100585938), DOOR_BUYABLE, "Old Apartment", 2},
	{Vector(2066, 1307, 354.28100585938), DOOR_BUYABLE, "Garage", 8, "Garage12"},
	{Vector(2011, 1897, 420), DOOR_UNBUYABLE, "Staff Only", 0, "Storefront12"},
	{Vector(1832, 1494, 427), DOOR_BUYABLE, "Garage", 8, "Garage12"},
	{Vector(2158, 2289, 487), DOOR_UNBUYABLE, "Deliveries", 0, "Storefront12"},
	{Vector(2096, 3585, 419.28100585938), DOOR_BUYABLE, "Staff Only", 6, "CafeBaltic12"},
	{Vector(2244, 3239, 419.28100585938), DOOR_BUYABLE, "Rear Access", 6, "CafeBaltic12"},
	{Vector(1882, 3202, 420), DOOR_BUYABLE, "Cafe Baltic", 6, "CafeBaltic12"},
	{Vector(659, 280, -128.71899414063), DOOR_BUYABLE_ASSIGNABLE, "The Honeybadger's Snare", 5, "rexleeroom"},
	{Vector(951, 3528, 540.33099365234), DOOR_UNBUYABLE, "Bathroom", 0, "A-1-1"},
	{Vector(1410, 3549, 540.28100585938), DOOR_UNBUYABLE, "Bathroom", 0, "A-1-2"},
	{Vector(1222, 3602, 540), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-2", 3, "A-1-2"},
	{Vector(1102, 3602, 540), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-1", 3, "A-1-1"},
	{Vector(951, 3528, 697.33099365234), DOOR_UNBUYABLE, "Bathroom", 0, "A-2-2"},
	{Vector(1102, 3602, 697), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-2", 3, "A-2-2"},
	{Vector(1410, 3549, 697.28100585938), DOOR_UNBUYABLE, "Bathroom", 0, "A-2-1"},
	{Vector(1222, 3602, 697), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-1", 3, "A-2-1"},
	{Vector(1410, 3549, 854.28100585938), DOOR_UNBUYABLE, "Bathroom", 0, "A-3-1"},
	{Vector(1222, 3602, 854), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-1", 3, "A-3-1"},
	{Vector(951, 3528, 854.33099365234), DOOR_UNBUYABLE, "Bathroom", 0, "A-3-2"},
	{Vector(1102, 3602, 854), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-2", 3, "A-3-2"},
	{Vector(385, 736, -128.71899414063), DOOR_UNBUYABLE, "Bathroom", 0, "rexleeroom"},
	{Vector(-33, 3660, 99.281196594238), DOOR_COMBINELOCK, "Sewer Access"},
	{Vector(-1021, 2647, 501.28100585938), DOOR_BUYABLE, "Store", 4, "Store47"},
	{Vector(-1021, 2828, 501.28100585938), DOOR_BUYABLE, "Store", 4, "Store46"},
	{Vector(-1021, 3219, 501.28100585938), DOOR_BUYABLE, "Store", 4, "Store45"},
	{Vector(-957, 3494, 501), DOOR_BUYABLE, "Store", 4, "Store42"},
	{Vector(-729, 3494, 501), DOOR_BUYABLE, "Store", 2},
	{Vector(-1248, 2704, 501.28100585938), DOOR_BUYABLE, "Store", 4, "Store47"},
	{Vector(-1247, 2948, 501.28100585938), DOOR_BUYABLE, "Store", 4, "Store46"},
	{Vector(-1365, 3494, 501), DOOR_BUYABLE, "Store", 4, "Store45"},
	{Vector(-988, 3618, 501.28100585938), DOOR_BUYABLE, "Store", 4, "Store42"},
	{Vector(-2393, 1650.5, 1124.5), DOOR_COMBINEOPEN, "<::High Command Resistricted Access::>"},
	{Vector(-1819.5, 2128.5, 1258.5), DOOR_COMBINEOPEN, "Administration Hub"},
	{Vector(-3270, 992, 355.25), DOOR_COMBINELOCK, "Cell 6"},
	{Vector(-3270, 1098, 355.25), DOOR_COMBINELOCK, "Cell 5"},
	{Vector(-3270, 1211, 355.25), DOOR_COMBINELOCK, "Cell 4"},
	{Vector(-3270, 1324, 355.25), DOOR_COMBINELOCK, "Cell 3"},
	{Vector(-3270, 1437, 355.25), DOOR_COMBINELOCK, "Cell 2"},
	{Vector(-3270, 1550, 355.25), DOOR_COMBINELOCK, "Cell 1"},
	{Vector(-3797, 1527.5, 362.5), DOOR_COMBINEOPEN, "Room 100"},
	{Vector(-3793, 1304.5, 362.5), DOOR_COMBINEOPEN, "Room 101"},
	{Vector(-3796, 1102.5, 362.5), DOOR_COMBINEOPEN, "Interrogation"},
	{Vector(-3596.1398925781, 2534, 355.28100585938), DOOR_COMBINEOPEN, "Nexus Storage"},
	{Vector(-1074, 1467, 98.281303405762), DOOR_BUYABLE, "The Gentlemen's Lounge", 7, "Bar50"},
	{Vector(-1074, 1828, 99), DOOR_BUYABLE, "Staff Only", 7, "Bar50"},
	{Vector(-574.25, 312, 226.28100585938), DOOR_BUYABLE, "Warehouse", 6, "SlumWarehouse1"},
	{Vector(-790, 594.93902587891, 226.28100585938), DOOR_BUYABLE, "Warehouse", 6, "SlumWarehouse1"},
	{Vector(522, -409, -22.718799591064), DOOR_BUYABLE, "Kiosk", 3, "Kiosk"},
	{Vector(748, -411, -22.718799591064), DOOR_BUYABLE, "Staff Only", 3, "Kiosk"},
	{Vector(1411, 1654.5600585938, 439.28100585938), DOOR_UNBUYABLE, "SMU Sewer Hub"},
	{Vector(4390, -118, -90.718803405762), DOOR_BUYABLE, "Container Room", 3},
	{Vector(5030, 885, 309.28100585938), DOOR_BUYABLE, "Warehouse", 6, "Warehouse25"},
	{Vector(4883, 1411, 439.28100585938), DOOR_BUYABLE, "Warehouse", 6, "Warehouse25"},
	{Vector(4838, 430, 309.28100585938), DOOR_BUYABLE, "Warehouse", 6, "Warehouse24"},
	{Vector(5245, 8.1999998092651, 309.28100585938), DOOR_BUYABLE, "Warehouse", 6, "Warehouse24"},
	{Vector(4712.2001953125, -663, 309.28100585938), DOOR_BUYABLE, "Warehouse", 6, "Warehouse23"},
	{Vector(5098, -193.23100280762, 309.28100585938), DOOR_BUYABLE, "Warehouse", 6, "Warehouse23"},
	{Vector(3518.9499511719, 327, 309.28100585938), DOOR_BUYABLE, "Warehouse", 5},
	{Vector(3277.9499511719, -87, 309.28100585938), DOOR_BUYABLE, "Warehouse", 5},
	{Vector(4018, 443, 15.281299591064), DOOR_BUYABLE, "Shack", 3},
	{Vector(3337.7199707031, 1180.5899658203, -437.71899414063), DOOR_UNBUYABLE, "Meeting Room"},
	{Vector(3430.7199707031, 1180.5899658203, -437.71899414063), DOOR_UNBUYABLE, "Meeting Room"},
	{Vector(836, 3606, 539), DOOR_COMBINELOCK, "CCH-A"},
	{Vector(743, 3606, 539), DOOR_COMBINELOCK, "CCH-A"},
	{Vector(3388, 674, 309.28100585938), DOOR_BUYABLE, "Warehouse", 5},
	{Vector(613, 750, 212), DOOR_COMBINELOCK, "CCH-C"},
	{Vector(706, 750, 212), DOOR_COMBINELOCK, "CCH-C"},
	{Vector(614, -54, 129), DOOR_COMBINELOCK, "CCH-C"},
	{Vector(707, -54, 129), DOOR_COMBINELOCK, "CCH-C"},
	{Vector(1836, 813, 419.28100585938), DOOR_UNBUYABLE, "Old Apartment Complex"},
	{Vector(1836, 906, 419.28100585938), DOOR_UNBUYABLE, "Old Apartment Complex"},
	{Vector(-1303, 2123, 547), DOOR_COMBINELOCK, "District 23 Nexus"},
	{Vector(-1303, 2216, 547), DOOR_COMBINELOCK, "District 23 Nexus"},
	{Vector(-1636, 2094, 547.28100585938), DOOR_COMBINELOCK, "District 23 Nexus"},
	{Vector(-1636, 2187, 547.28100585938), DOOR_COMBINELOCK, "District 23 Nexus"},
	{Vector(-1536, 2000, 547.28100585938), DOOR_COMBINELOCK, "Civil Liaison Room"},
	{Vector(-1443, 2000, 547.28100585938), DOOR_COMBINELOCK, "Civil Liaison Room"},
	{Vector(-209, 1572, 571), DOOR_COMBINELOCK, "Generator Room"},
	{Vector(-209, 1479, 571), DOOR_COMBINELOCK, "Generator Room"},
	{Vector(1845, 2134, 419.28100585938), DOOR_BUYABLE, "Store", 6, "Storefront12"},
	{Vector(1845, 2041, 419.28100585938), DOOR_BUYABLE, "Store", 6, "Storefront12"},
	{Vector(-1016.1099853516, 316, 290.5), DOOR_BUYABLE, "Le Club De La Fraise", 10, "Bar51"},
	{Vector(-2008.0100097656, 2140.0100097656, 549), DOOR_COMBINEOPEN, "RESTRICTED ACCESS"},
	{Vector(-1356.0400390625, 2268, 549), DOOR_COMBINEOPEN, "Distribution"},
	{Vector(-1626, 1445.5, 1116.5), DOOR_COMBINEOPEN, "District 23 Nexus"},
}

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")