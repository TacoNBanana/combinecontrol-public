function GM:GetHL2CamPos()
	return {Vector(2274, 3201, 856), Angle(34, 131, 0)}
end

function GM:GetCACamPos()
	return Vector(2722,4068,3416)
end

function GM:TurnOnCamera()
	ents.GetMapCreatedEntity(1297):Fire("use")
	ents.GetMapCreatedEntity(3889):Fire("use")
end

function GM:TurnOffCamera()
	ents.GetMapCreatedEntity(1297):Fire("use", nil, 15)
	ents.GetMapCreatedEntity(3889):Fire("use")
end

if (SERVER) then
	local BreenExists = false
	local function broinz()
		if not BreenExists then
			GAMEMODE:CreateBreen("camera_tv_breen", GAMEMODE:GetCACamPos(), Angle(0, -90, 0.000000))
			BreenExists = true
		end
	end
	concommand.AddAdmin("rpa_createbreen", broinz)
end

function GM:GetCombineCratePos()
	return {Vector(2813,3383, 544), Angle(0, -90, 0)}
end

function GM:GetCombineRationPos()
	return {Vector(3385,3976,444), Angle(3.771, 163.594, -0.139)}
end

GM.EnableAreaportals = true
GM.IntroCamData = {}

GM.IntroCamData[1] = {{Vector(2274, 3201, 856), Vector(2271, 4209, 725)}, {Angle(32, 133, 0), Angle(11, -123, 0)}}
GM.IntroCamData[2] = {{Vector(2390, 1991, 469), Vector(1248, 2188, 195)}, {Angle(22, 135, 0), Angle(0, 179, 0)}}
GM.IntroCamData[3] = {{Vector(-654, 1941, 266), Vector(-741, 3180, 202)}, {Angle(15, 110, 0), Angle(0, 85, 0)}}
GM.IntroCamData[4] = {{Vector(269, 2785, 257), Vector(196, 3113, 397)}, {Angle(30, 43, 0), Angle(-12, 90, 0)}}
GM.IntroCamData[5] = {{Vector(5561, 3006, 865), Vector(6411, 2346, 902)}, {Angle(47, -39, 0), Angle(26, -163, 0)}}
GM.IntroCamData[6] = {{Vector(-4191, 2886, 598), Vector(-2204, 2885, 573)}, {Angle(-32, 0, 0), Angle(0, 0, 0)}}

GM.CurrentLocation = LOCATION_CITY

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(6271, 1840, 531), LOCATION_CANAL, 128, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(4116, 1861, -78), LOCATION_CANAL, 128, TRANSITPORT_CITY_SEWER)
	self:CreateLocationPoint(Vector(2626, 4392, 1408), LOCATION_CANAL, 128, TRANSITPORT_CITY_COMBINE)

	ents.FindByName("nexus_judactivate")[1]:SetPos(Vector(0,0,0)) -- Let's avoid those being +use'd
	ents.FindByName("nexus_judeactivate")[1]:SetPos(Vector(0,0,0))

	if SW then
		SW.MaxLightness = "f"
		SW.MaxDarkness	= "b"
	end
end

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "Behind the trains, you can see what looks like a maintenance door. It looks like you can crawl under the railcars to reach it."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "The grating under the gate looks loose, you could slip under it. It looks like it leads further away in the old sewer system."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "An elevator door here leads to a helicopter, which will bring you to Sector 12"

GM.EntryPortSpawns[1] = {
	Vector(-4403, 2772, 465),
	Vector(-4402, 2845, 465),
	Vector(-4402, 2914, 465),
	Vector(-4402, 2984, 465),
	Vector(-4462, 2986, 465),
	Vector(-4462, 2914, 465),
	Vector(-4462, 2845, 465),
	Vector(-4462, 2773, 465),
	Vector(-4526, 2774, 465),
	Vector(-4526, 2847, 465),
	Vector(-4527, 2913, 465),
	Vector(-4527, 2988, 465),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(6462, 1858, 484),
	Vector(6464, 1995, 484),
	Vector(6269, 1891, 484),
	Vector(6269, 1995, 484),
	Vector(6074, 1876, 249),
	Vector(6074, 1995, 251)
}
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(4145, 1937, -134),
	Vector(4145, 1850, -134),
	Vector(3900, 1937, -134),
	Vector(3900, 1937, -134),
	Vector(3800, 1754, -133),
	Vector(4145, 1754, -133)
}
GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector(2597, 4510, 1350),
	Vector(2697, 4410, 1350),
	Vector(2597, 4620, 1350),
	Vector(2813, 4397, 1350)
}

GM.EntNamesToRemove = {
"vendingmachines"
}

GM.EntPositionsToRemove = {
}

function GM:OnJWOn()
	ents.FindByName("nexus_judactivate")[1]:Fire("use")
end

function GM:OnJWOff()
	ents.FindByName("nexus_judeactivate")[1]:Fire("use", nil, 2)
end

GM.Microphones = {
	{Vector(2720, 883, 218), MICROPHONE_BIG},-- TODO!
}

GM.Stoves = {
	{Vector(583,3988,613), Angle(0,135,0), "A11"},
	{Vector(-244,3929,613), Angle(0,90,0), "A14"},
	{Vector(583,3988,749), Angle(0,135,0), "A21"},
	{Vector(-244,3929,749), Angle(0,90,0), "A24"},
	{Vector(583,3988,885), Angle(0,135,0), "A31"},
	{Vector(-244,3929,885), Angle(0,90,0), "A34"},
	{Vector(583,3988,1021), Angle(0,135,0),"A41"},
	{Vector(-244,3929,1021),Angle(0,90,0), "A44"},

	{Vector(3886,1698.5,396), Angle(0, 180, 0), "B1", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(3886,1698.5,596), Angle(0, 180, 0), "B2", true, "models/props_c17/furnitureStove001a.mdl"},
	{Vector(3886,1698.5,796), Angle(0, 180, 0), "B3", true, "models/props_c17/furnitureStove001a.mdl"},

	{Vector(6156,4735,352.5),Angle(0,90,0), "21221"},
	{Vector(6276,4599,352.5),Angle(0,-90,0), "21222"},
	{Vector(6039.5,4056,352.5),Angle(0,180,0), "21223"},

	{Vector(4158.5,5190,548.5), Angle(0,180,0), "D11"},
	{Vector(4575,5182,548.5), Angle(0,180,0), "D12"},
	{Vector(4158.5,5190,693), Angle(0,180,0), "D21"},
	{Vector(4575,5182,693), Angle(0,180,0), "D22"},

	{Vector(1424.5,4384,384.5), Angle(0,0,0), "CAFE", nil, "models/props_wasteland/kitchen_stove001a.mdl"},
	{Vector(5171,4929,328.5), Angle(0,0,0), "GG", nil, "models/props_wasteland/kitchen_stove001a.mdl"}
}

GM.VendingMachines = {
	{Vector(2807,5098,376), Angle(0,270,0)},
	{Vector(2742,5098,376), Angle(0,255,0)},
	{Vector(1628,3016,184), Angle(0,101,0)},
	{Vector(1560,3024,184), Angle(0,81,0)},
	{Vector(-865,3807.34375,184), Angle(0,277,0)},
	{Vector(-932,3802,184), Angle(0,300.5,0)},
	{Vector(96,4624,216), Angle(0,270,0)},
	{Vector(2296,4068,184), Angle(0,267.5,0)},
	{Vector(568,2614,184), Angle(0,87,0)},
	{Vector(502,2612,184), Angle(0,91,0)},
	{Vector(3968,3368,880), Angle(0,172.5,0)},
	{Vector(-927,988,184), Angle(0,72,0)},
	{Vector(-864,982,184), Angle(0,91,0)},
	{Vector(6218,2091,272), Angle(0,359.5,0)}
}

GM.CombineSpawnpoints = {
	Vector(2624,2998,569),
	Vector(2608,2934,569),
	Vector(2608,2896,569),
	Vector(2708,2896,569),
	Vector(2609,2703,569),
	Vector(2858,2704,569),
	Vector(2858,2804,569),
	Vector(2758,2804,569),
	Vector(2857,2988,569)
}

GM.MapChairs = { -- Just a few done
	{Vector(1820, 4079, 136), Angle(0, 180, 0)},
	{Vector(1845, 4079, 136), Angle(0, 180, 0)},
	{Vector(1870, 4079, 136), Angle(0, 180, 0)},
	{Vector(1950, 4079, 136), Angle(0, 180, 0)},
	{Vector(1975, 4079, 136), Angle(0, 180, 0)},
	{Vector(2000, 4079, 136), Angle(0, 180, 0)},
	{Vector(2200, 4079, 136), Angle(0, 180, 0)},
	{Vector(2225, 4079, 136), Angle(0, 180, 0)},
	{Vector(2250, 4079, 136), Angle(0, 180, 0)},
	{Vector(1500,3023,136), Angle(0, 0, 0)},
	{Vector(1475,3023,136), Angle(0, 0, 0)},
	{Vector(1450,3023,136), Angle(0, 0, 0)},
	{Vector(1187, 3184, 136), Angle(0, 0, 0)},
	{Vector(1162, 3184, 136), Angle(0, 0, 0)},
	{Vector(1137, 3184, 136), Angle(0, 0, 0)},
	{Vector(1101, 3211, 136), Angle(0, -90, 0)},
	{Vector(1101, 3236, 136), Angle(0, -90, 0)},
	{Vector(1101, 3261, 136), Angle(0, -90, 0)},
	{Vector(1030, 3855, 136), Angle(0, 180, 0)},
	{Vector(1055, 3855, 136), Angle(0, 180, 0)},
	{Vector(1080, 3855, 136), Angle(0, 180, 0)},
}

GM.DoorData = {
	--Apartment Block A --
	{Vector(223, 3870, 230), DOOR_COMBINELOCK, "Apartment Block A"},
	{Vector(129, 3870, 230), DOOR_COMBINELOCK, "Apartment Block A"},
	{Vector(388, 4125, 254), DOOR_COMBINELOCK, "Common Room"},
	{Vector(388, 4067, 254), DOOR_COMBINELOCK, "Common Room"},
	{Vector(376,4555,918), DOOR_COMBINELOCK, ""},
	{Vector(376,4497,918), DOOR_COMBINELOCK, ""},
	{Vector(697,4292,886), DOOR_COMBINELOCK, "Apartment Block A - Floor 3"},
	-- Floor 1
	{Vector(380, 4219, 646), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-1", 2, "A11"},
	{Vector(528, 3952, 620), DOOR_UNBUYABLE, "Fridge", 0, "A11"},
	{Vector(643, 4292, 646), DOOR_UNBUYABLE, "Bathroom", 0, "A11"},
	{Vector(303, 4068, 646), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-2", 1, "A12"},
	{Vector(95, 4068, 646), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-3", 1, "A13"},
	{Vector(-28, 4173, 646), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-1-4", 2, "A14"},
	{Vector(-272, 3944, 620), DOOR_UNBUYABLE, "Fridge", 0, "A14"},
	{Vector(-61,4292,646), DOOR_UNBUYABLE, "Bathroom", 0, "A14"},
	--Floor 2
	{Vector(380,4219,782), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-1", 2, "A21"},
	{Vector(528,3952,756), DOOR_UNBUYABLE, "Fridge", 0, "A21"},
	{Vector(643,4292,782), DOOR_UNBUYABLE, "Bathroom", 0, "A21"},
	{Vector(303,4068,782), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-2", 1, "A22"},
	{Vector(95,4068,782), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-3", 1, "A23"},
	{Vector(-28,4173,782), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-2-4", 2, "A24"},
	{Vector(-272,3944,756), DOOR_UNBUYABLE, "Fridge", 0, "A24"},
	{Vector(-61,4292,782), DOOR_UNBUYABLE, "Bathroom", 0, "A24"},
	--Floor 3
	{Vector(380,4219,918), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-1", 2, "A31"},
	{Vector(528,3952,892), DOOR_UNBUYABLE, "Fridge", 0, "A31"},
	{Vector(643,4292,918), DOOR_UNBUYABLE, "Bathroom", 0, "A31"},
	{Vector(303,4068,918), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-2", 1, "A32"},
	{Vector(95,4068,918), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-3", 1, "A33"},
	{Vector(-28,4173,918), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-3-4", 2, "A34"},
	{Vector(-272,3944,892), DOOR_UNBUYABLE, "Fridge", 0, "A34"},
	{Vector(-61,4292,918), DOOR_UNBUYABLE, "Bathroom", 0, "A34"},
	--Floor 4
	{Vector(380,4219,1054), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-4-1", 2, "A41"},
	{Vector(528,3952,1028), DOOR_UNBUYABLE, "Fridge", 0, "A41"},
	{Vector(643,4292,1054), DOOR_UNBUYABLE, "Bathroom", 0, "A41"},
	{Vector(303,4068,1054), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-4-2", 1, "A42"},
	{Vector(95,4068,1054), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-4-3", 1, "A43"},
	{Vector(-28,4173,1054), DOOR_BUYABLE_ASSIGNABLE, "Apartment A-4-4", 2, "A44"},
	{Vector(-272,3944,1028), DOOR_UNBUYABLE, "Fridge", 0, "A44"},
	{Vector(-61,4292,1054), DOOR_UNBUYABLE, "Bathroom", 0, "A44"},

	-- Apartment Block B --
	{Vector(3732,2061,190), DOOR_COMBINELOCK, "Apartment Block B"},
	{Vector(3839,1988,190), DOOR_COMBINELOCK, "Basement"},
	{Vector(3900,2283,1110), DOOR_COMBINELOCK, "Apartment Block B Rooftop"},

	{Vector(3765,2316,430), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-1", 1, "B1"},
	{Vector(3633,2396,430), DOOR_UNBUYABLE, "Bathroom", 0, "B1"},
	{Vector(3765,2316,630), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-2", 1, "B2"},
	{Vector(3633,2396,629.75), DOOR_UNBUYABLE, "Bathroom", 0, "B2"},
	{Vector(3765,2316,830), DOOR_BUYABLE_ASSIGNABLE, "Apartment B-3", 1, "B3"},
	{Vector(3633,2396,829.75), DOOR_UNBUYABLE, "Bathroom", 0, "B3"},
	{Vector(3835,2148,1110), DOOR_BUYABLE, "Room", 1},
	--Misc Houses
	{Vector(1384,4275,886), DOOR_BUYABLE, "Loft", 1},


	--2122
	{Vector(5981,4508,386), DOOR_BUYABLE, "Apartment 2122-1", 2, "21221"},
	{Vector(6020,4413,386), DOOR_BUYABLE, "Apartment 2122-2", 2, "21222"},
	{Vector(5935,4364,386), DOOR_BUYABLE, "Apartment 2122-3", 2, "21223"},

	--Apartments C (Above Assembly Street)
	{Vector(4120,4203,886), DOOR_COMBINELOCK, "Apartments Block C", 0},
	{Vector(4220,3923,886), DOOR_COMBINELOCK, "Apartments Block C Rooftops", 0},
	{Vector(4173,4268,886), DOOR_BUYABLE, "Apartment C-1", 2, "C1"},
	{Vector(4284,4381,886), DOOR_UNBUYABLE, "Bathroom", 0, "C1"},

	{Vector(4685,4268,886), DOOR_BUYABLE, "Apartment C-2", 2, "C2"},
	{Vector(4796,4381,886.25), DOOR_UNBUYABLE, "Bathroom", 0, "C2"},

	{Vector(4099,3836,886), DOOR_BUYABLE, "Apartment C-3", 1},

	-- Apartments D
	{Vector(3976,5079,438), DOOR_COMBINELOCK, "Apartment Block D"},
	{Vector(4841,4932,438), DOOR_COMBINELOCK, "Apartment Block D"},
	{Vector(4489,4840,726), DOOR_COMBINELOCK, "Roof Access"},

	{Vector(4105,4984,582), DOOR_BUYABLE_ASSIGNABLE, "Apartment D-1-1", 2, "D11"},
	{Vector(4144,5138,556), DOOR_UNBUYABLE, "Fridge", 0, "D11"},
	{Vector(4013,5464,582), DOOR_UNBUYABLE, "", 0, "D11"},
	{Vector(4164,5611,582), DOOR_UNBUYABLE, "Bathroom", 0, "D11"},
	{Vector(4425,4984,582), DOOR_BUYABLE_ASSIGNABLE, "Apartment D-1-2", 2, "D12"},
	{Vector(4560,5130,556), DOOR_UNBUYABLE, "Fridge", 0, "D12"},
	{Vector(4563,5460,582), DOOR_UNBUYABLE, "", 0, "D12"},
	{Vector(4404,5603,582), DOOR_UNBUYABLE, "Bathroom", 0, "D12"},
	{Vector(4105,4984,726), DOOR_BUYABLE_ASSIGNABLE, "Apartment D-2-1", 2, "D21"},
	{Vector(4144,5138,700), DOOR_UNBUYABLE, "Fridge", 0, "D21"},
	{Vector(4013,5464,726), DOOR_UNBUYABLE, "", 0, "D21"},
	{Vector(4164,5611,726), DOOR_UNBUYABLE, "Bathroom", 0, "D21"},
	{Vector(4425,4984,726), DOOR_BUYABLE_ASSIGNABLE, "Apartment D-2-2", 2, "D22"},
	{Vector(4560,5130,700), DOOR_UNBUYABLE, "Fridge", 0, "D22"},
	{Vector(4563,5460,726), DOOR_UNBUYABLE, "", 0, "D22"},
	{Vector(4404,5603,726), DOOR_UNBUYABLE, "Bathroom", 0, "D22"},


	--Industrial Uncompleted Housing
	{Vector(4585,3046,390), DOOR_BUYABLE, "Room", 1},
	{Vector(4585,3046,526), DOOR_BUYABLE, "Room", 1},
	{Vector(5412,2487,662), DOOR_BUYABLE, "Room", 1},
	{Vector(5335,2674,662), DOOR_BUYABLE, "Room", 1},
	{Vector(5335,2674,526), DOOR_BUYABLE, "Room", 1},
	{Vector(5412,2487,526), DOOR_BUYABLE, "Room", 1},
	{Vector(5335,2627,390), DOOR_BUYABLE, "Room", 1},
	{Vector(5596,2487,254), DOOR_BUYABLE, "Room", 1},
	-- Shops
	{Vector(808,4016,186), DOOR_BUYABLE, "Foto Shop", 5, "FOTO"},
	{Vector(810,4088,190.25), DOOR_UNBUYABLE, "", 0, "FOTO"},
	{Vector(928,3883,190.25), DOOR_UNBUYABLE, "", 0, "FOTO"},
	{Vector(837,4188,190), DOOR_UNBUYABLE, "", 0, "FOTO"},
	{Vector(897,4292,190), DOOR_UNBUYABLE, "", 0, "FOTO"},
	{Vector(897,4540,190), DOOR_UNBUYABLE, "Foto Shop", 0, "FOTO"},

	{Vector(1128,3878,186), DOOR_BUYABLE, "Change Shop", 5, "CHANGE"},
	{Vector(1237,4000,190.25), DOOR_UNBUYABLE, "", 0, "CHANGE"},
	{Vector(1061,4124,190), DOOR_UNBUYABLE, "", 0, "CHANGE"},
	{Vector(1121,4292,190), DOOR_UNBUYABLE, "", 0, "CHANGE"},
	{Vector(1121,4540,190), DOOR_UNBUYABLE, "Change Shop", 0, "CHANGE"},

	{Vector(-376,2872,190), DOOR_BUYABLE, "Arrivals", 10, "ARRIVALS"},
	{Vector(-164,3136,190), DOOR_UNBUYABLE, "Arrivals", 0, "ARRIVALS"},
	{Vector(11,2836,190), DOOR_UNBUYABLE, "", 0, "ARRIVALS"},
	{Vector(108,2741,190), DOOR_UNBUYABLE, "Arrivals", 0, "ARRIVALS"},
	{Vector(-336,2827,390), DOOR_UNBUYABLE, "", 0, "ARRIVALS"},
	{Vector(-336,2901,390), DOOR_UNBUYABLE, "", 0, "ARRIVALS"},
	{Vector(-176,2931,390), DOOR_UNBUYABLE, "", 0, "ARRIVALS"},
	{Vector(-176,2837,390), DOOR_UNBUYABLE, "", 0, "ARRIVALS"},

	{Vector(-660,1847,186), DOOR_BUYABLE, "Laundry", 5, "LAUNDRY"},
	{Vector(-703,1268,190), DOOR_UNBUYABLE, "", 0, "LAUNDRY"},
	{Vector(-543,1124,190), DOOR_UNBUYABLE, "", 0, "LAUNDRY"},
	{Vector(-702,1850,198.281250), DOOR_UNBUYABLE, "", 0, "LAUNDRY"},
	{4802, DOOR_UNBUYABLE, "", 0, "LAUNDRY"},

	{Vector(-386,1849.5,186), DOOR_BUYABLE, "Souvenir Shop", 5, "SOUVENIR"},
	{Vector(-431,1612,190), DOOR_UNBUYABLE, "", 0, "SOUVENIR"},
	{Vector(-311,1388,190), DOOR_UNBUYABLE, "", 0, "SOUVENIR"},
	{Vector(-311,1124,190), DOOR_UNBUYABLE, "", 0, "SOUVENIR"},

	{Vector(780,3208,190), DOOR_BUYABLE, "Medical Center", 10, "MEDIC"},
	{Vector(387,2932.0100097656,190), DOOR_UNBUYABLE, "Medical Center", 0, "MEDIC"},
	{Vector(900,2617,190), DOOR_UNBUYABLE, "", 0, "MEDIC"},
	{Vector(900,3047,190), DOOR_UNBUYABLE, "", 0, "MEDIC"},
	{Vector(987,2972,190), DOOR_UNBUYABLE, "", 0, "MEDIC"},

	{Vector(1889,4616,438), DOOR_BUYABLE, "Shop", 5},

	{Vector(1784,4435,438), DOOR_BUYABLE, "Cafe", 5, "CAFE"},
	{Vector(1396,4229,438), DOOR_UNBUYABLE, "", 0, "CAFE"},
	{Vector(1276,4253,438), DOOR_UNBUYABLE, "", 0, "CAFE"},
	{Vector(1309,4600,438), DOOR_UNBUYABLE, "", 0, "CAFE"},

	{Vector(2544,5221,382.25), DOOR_BUYABLE, "Shop", 5},
	{Vector(4083,1372,254), DOOR_BUYABLE, "Corner Shop", 5},


	{Vector(5583,4776,382), DOOR_BUYABLE, "Grizzly Grotto", 10, "GG"},
	{Vector(5489,4776,382), DOOR_UNBUYABLE, "Grizzly Grotto", 0, "GG"},
	{Vector(5396,4885,382), DOOR_UNBUYABLE, "", 0, "GG"},
	{Vector(6291,4980,382), DOOR_UNBUYABLE, "Bathroom", 0, "GG"},

	{Vector(5808,3317,254), DOOR_BUYABLE, "Shop", 5, "ISHOP"},
	{Vector(6076,3389,254), DOOR_UNBUYABLE, "", 0, "ISHOP"},
	{Vector(5806,3400,256.26000976563), DOOR_UNBUYABLE, "", 0, "ISHOP"},
	{Vector(6024,4499,-330), DOOR_BUYABLE, "CyberCafe", 5, "CYBER"},
	{Vector(6780,4673,-330), DOOR_UNBUYABLE, "", 0, "CYBER"},

	{Vector(508,1221,246), DOOR_BUYABLE, "Warehouse 4/5", 10},

	-- Combine Doors
	{Vector(1784,2755.9899902344,224), DOOR_COMBINEOPEN, "Nexus"},
	{Vector(1736,4408,184), DOOR_COMBINEOPEN, "Garage"},
	{Vector(1507.9899902344,4424,-48), DOOR_COMBINEOPEN, "Sewers"},
	{Vector(1507.9899902344,4536,-48), DOOR_COMBINEOPEN, "Nexus"},
	{Vector(2942.9899902344,4446,362), DOOR_COMBINEOPEN, "Rations Booth"},
	{Vector(3124,5510,886), DOOR_COMBINEOPEN, "Warehouse 3 Office"},
	{Vector(2652,4855.990234375,1396), DOOR_COMBINEOPEN, "Nexus"},
	{Vector(2916,4792.009765625,1460), DOOR_COMBINEOPEN, "Nexus"},
	{Vector(2992,4106,1480), DOOR_COMBINEOPEN, ""},
	{Vector(2438,4192,888), DOOR_COMBINEOPEN, "Nexus"},
	{Vector(3450,4192,888), DOOR_COMBINEOPEN, "Nexus"},
	{Vector(2620,4104.009765625,884), DOOR_COMBINEOPEN, ""},
	{Vector(1852.0100097656,1984,-520), DOOR_COMBINEOPEN, "Armory"},
	{Vector(2117,3635,-243), DOOR_COMBINEOPEN, "Pod 2 Control"},
	{Vector(2304,4206,-241), DOOR_COMBINEOPEN, ""},
	{Vector(2232.0100097656,2968,152), DOOR_COMBINEOPEN, ""},
	{Vector(2448,3209.1398925781,244), DOOR_COMBINEOPEN, ""},
	{Vector(2640,2964,125), DOOR_COMBINEOPEN, "Holding Cell"},
	{Vector(3164,3320,344), DOOR_COMBINEOPEN, ""},
	{Vector(3080,3255.9899902344,344), DOOR_COMBINEOPEN, ""},
	{Vector(3032,4358,-216), DOOR_COMBINEOPEN, ""},
	{Vector(2612,4297.009765625,444), DOOR_COMBINEOPEN, ""},
	{Vector(3384,4384,416), DOOR_COMBINEOPEN, "Ration Distribution"},
	{Vector(2944,3848.0100097656,308), DOOR_COMBINEOPEN, ""},
	{Vector(2868,3799.9899902344,-216), DOOR_COMBINEOPEN, ""},
	{Vector(4164.009765625,4476,464), DOOR_COMBINEOPEN, ""},
	{2542, DOOR_COMBINEOPEN, "Nexus"},
	{Vector(2936,3320,311), DOOR_COMBINEOPEN, ""},
	{2145, DOOR_COMBINEOPEN, ""},
	{Vector(3100,3394,308), DOOR_COMBINEOPEN, ""},
	{Vector(1448,4114,288), DOOR_COMBINEOPEN, "Garage"},

	-- Combine Misc
	{Vector(1919,2956,181), DOOR_COMBINELOCK, ""},
	{Vector(2051,2958,181), DOOR_COMBINELOCK, ""},
	{Vector(2720,5275,382), DOOR_COMBINELOCK, "Warehouse 3"},
	{Vector(2696,5299,886.25), DOOR_COMBINELOCK, "Warehouse 3 Observation"},
	{Vector(2073,4626,886.25), DOOR_COMBINELOCK, ""},
	{Vector(1907,2488,-490), DOOR_COMBINELOCK, "Training"},
	{Vector(1813,2488,-490), DOOR_COMBINELOCK, "Training"},
	{Vector(1992,3175,-490), DOOR_COMBINELOCK, ""},
	{Vector(1976,2983,-490), DOOR_COMBINELOCK, ""},
	{Vector(1976,2745,-490), DOOR_COMBINELOCK, ""},
	{Vector(1744,2959,-490), DOOR_COMBINELOCK, ""},
	{Vector(1728,3175,-490), DOOR_UNBUYABLE, "Medical"},
	{Vector(1208,3183,-490), DOOR_COMBINELOCK, ""},
	{Vector(2249,2824,118), DOOR_COMBINELOCK, "Room 101"},
	{Vector(2471,2824,118), DOOR_COMBINELOCK, "Observation"},
	{Vector(2630,3537,310), DOOR_COMBINELOCK, ""},
	{Vector(2630,3631,310), DOOR_COMBINELOCK, ""},
	{Vector(2012,3867,-250), DOOR_COMBINELOCK, "Cell 1"},
	{Vector(2013,4059,-250), DOOR_COMBINELOCK, "Cell 2"},
	{Vector(2588,4115,-250), DOOR_COMBINELOCK, "Cell 3"},
	{Vector(2588,3923,-250), DOOR_COMBINELOCK, "Cell 4"},
	{Vector(2588,3731,-250), DOOR_COMBINELOCK, "Cell 5"},
	{5067, DOOR_COMBINELOCK, ""},
	{Vector(3176,4153,446), DOOR_COMBINELOCK, ""},
	{Vector(4220,3831,430), DOOR_COMBINELOCK, "Disposals"},
	{Vector(4631,4100,430), DOOR_COMBINELOCK, "Disposals"},

	{Vector(2236,3940,-252), DOOR_UNBUYABLE, "Isolation 1"},
	{Vector(2300,3876,-252), DOOR_UNBUYABLE, "Isolation 2"},
	{Vector(2364,3940,-252), DOOR_UNBUYABLE, "Isolation 3"},

	-- Other
	{Vector(3128,1820,190), DOOR_COMBINELOCK, "Theater"},
	{Vector(3128,1716,190), DOOR_COMBINELOCK, "Theater"},
	{Vector(3028,1687,190), DOOR_COMBINELOCK, "Tickets"},

	{Vector(937,4740,190), DOOR_COMBINELOCK, "Sewers Access"},
	{Vector(3976,5440,1408), DOOR_BUYABLE, "Upper Warehouse", 10, "UWH"},
	{Vector(4744,4869,1472), DOOR_UNBUYABLE, "", 0, "UWH"},
	{Vector(3469,5640,886), DOOR_BUYABLE, "Upper XCCR", 5}
}

GM.CameraData = {
	{Vector(-504, 3820, 320), Angle(0, -133.506, 0), "GATE-2"},
	{Vector(1984, 2532, 384), Angle(0, -90, 0), "GATE-3"},
	{Vector(2354.25, 3583.41, 448), Angle(0, 180, 0), "NEXUS", true},
	{Vector(3995.84, 4428.44, 573.969), Angle(0, -50, 0), "OUTPOST", true},
	{Vector(3487.22, 5472.78, 1597.97), Angle(0, -22, 0), "CAT-UPPER"},
	{Vector(84.6875, 4347.16, 381.969), Angle(0, 18, 0), "CCH-A"},
	{Vector(3690.16, 1998.34, 341.969), Angle(0, 140, 0), "CCH-B"},
	{Vector(2228.78, 4268.75, -130.031), Angle(0, 60, 0), "DETAINMENT", true}
}