local citymap = true -- change this to true if you wanna use it on the city isntead of canals

if citymap then
	GM.CurrentLocation = LOCATION_CITY
	function GM:MapInitPostEntity()
		-- self:CreateLocationPoint(Vector(-1840,5290,-535), LOCATION_CANAL, 128, TRANSITPORT_CITY_GATE)
		self:CreateLocationPoint(Vector(-781, 1086, 648), LOCATION_CITY, 128, TRANSITPORT_CITY_COMBINE)
		self:CreateLocationPoint(Vector(-2050, -2990, 64), LOCATION_CITY, 128, TRANSITPORT_CITY_GATE)
	end

	-- GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "The bars here are bent out of shape, it looks like you'd be able to slip through. If the coast is clear, you might be able to sneak out beyond city limits to the drainage canal system."
	GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "A helicopter can be chartered here to take you back to District 17 much faster than any APC would."
	GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "You can board a bus here back to the comfort of District 17."
else
	GM.CurrentLocation = LOCATION_CANAL
	
	function GM:MapInitPostEntity()
		self:CreateLocationPoint(Vector(-2068, -3063, 128), LOCATION_CITY, 256, TRANSITPORT_CITY_GATE)
		self:CreateLocationPoint(Vector(946, 75, -119), LOCATION_CITY, 128, TRANSITPORT_CITY_SEWER)
		self:CreateLocationPoint(Vector(-533, 909, 610), LOCATION_CITY, 128, TRANSITPORT_CITY_COMBINE)
	end

	GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "Beyond this gate lies the city, all you need to do is wait until it opens... then just slide through. Easy enough, right?"
	GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "This door leads to the sewage maintenance tunnels, and it's unlocked. You could get to the city from here."
	GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "Beyond this door is the helicopter to the City 17 nexus. If you leave now, you might just make it on board."
	GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "This pipe - yes, this one in particular - seems to be broken. Theres a hole just in view that leads into subterranean caverns. Hm.."
	GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "The metal bars blocking this route could be removed. Past it, combine patrols are significantly reduced. This is your chance at freedom."
	
	GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
		Vector(1256, -17, -119),
		Vector(1194, -19, -119),
		Vector(1191, 60, -119),
	}
	
	GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
		Vector(-180, 666, 457),
		Vector(-254, 670, 457),
	}
	
	GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
		Vector(-1913, 4780, -400),
		Vector(-1793, 4787, -400),
		Vector(-1779, 4561, -390),
		Vector(-1892, 4555, -390),
	}
	GM.EntryPortSpawns[TRANSITPORT_COAST_ENTRY] = GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY]
end

function GM:GetHL2CamPos()
	return {Vector(-1302, 109, 273), Angle(0, 89, 0)}
end

GM.DoorData = {
	{Vector(-409, -164, 158), DOOR_BUYABLE, "Corner Shop", 5, "FOTO"},
	{Vector(-376, -371, 158), DOOR_UNBUYABLE, "Corner Shop", 5, "FOTO"},

	{Vector(-405, -1577, 158), DOOR_BUYABLE, "Chestnut Tree Cafe", 5, "Chesnut"},
	{Vector(-195, -1560, 158), DOOR_UNBUYABLE, "", 0, "Chesnut"},

	{Vector(-84, -1614, 318), DOOR_BUYABLE, "Chestnut Tree Suite", 3, "Chesnut Apartment"},
	{Vector(-105, -1284, 318), DOOR_UNBUYABLE, "Bathroom", 0, "Chesnut Apartment"},

	{Vector(-2743, 704, 158), DOOR_BUYABLE, "The Transcontinental", 10, "TPAHC"},
	{Vector(-2649, 704, 158), DOOR_BUYABLE, "The Transcontinental", 10, "TPAHC"},
	{Vector(-2912, 1120, 341), DOOR_UNBUYABLE, "", 0, "TPAHC"},

	{Vector(-792, -841, 222), DOOR_COMBINELOCK, "Precinct 6 Apartment Block A", 0, "CCH-A"},
	{Vector(-400, -1019, 222), DOOR_COMBINELOCK, "Basement", 0, "CCH-A"},
	{Vector(-191, -1053, 94), DOOR_COMBINELOCK, "Basement", 0, "CCH-A"},

	{Vector(-555, -756, 222), DOOR_UNBUYABLE, "1", 0, "CCH-A"},
	{Vector(-431, -652, 222), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},
	{Vector(-201, -652, 222), DOOR_BUYABLE_ASSIGNABLE, "1-A", 1, "CCH-A 1-A"},
	{Vector(-201, -756, 222), DOOR_BUYABLE_ASSIGNABLE, "1-B", 1, "CCH-A 1-B"},

	{Vector(-555, -756, 350), DOOR_UNBUYABLE, "2", 0, "CCH-A"},
	{Vector(-201, -652, 350), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},
	{Vector(-185, -420, 350), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},
	{Vector(-431, -652, 350), DOOR_UNBUYABLE, "Storage", 0, "CCH-A"},
	{Vector(-783, -796, 350), DOOR_BUYABLE_ASSIGNABLE, "2-A", 1, "CCH-A 2-A"},
	{Vector(-201, -756, 350), DOOR_BUYABLE_ASSIGNABLE, "2-B", 1, "CCH-A 2-B"},
	{Vector(-376, -379, 350), DOOR_BUYABLE_ASSIGNABLE, "2-C", 1, "CCH-A 2-C"},

	{Vector(-555, -756, 479), DOOR_UNBUYABLE, "3", 0, "CCH-A"},
	{Vector(-431, -652, 478), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},
	{Vector(-783, -796, 478), DOOR_BUYABLE_ASSIGNABLE, "3-A", 1, "CCH-A 3-A"},
	{Vector(-201, -652, 478), DOOR_BUYABLE_ASSIGNABLE, "3-B", 1, "CCH-A 3-B"},
	{Vector(-201, -756, 478), DOOR_BUYABLE_ASSIGNABLE, "3-C", 1, "CCH-A 3-C"},

	{Vector(-555, -756, 606), DOOR_UNBUYABLE, "4", 0, "CCH-A"},
	{Vector(-783, -796, 606), DOOR_BUYABLE_ASSIGNABLE, "4-A", 1, "CCH-A 4-A"},
	{Vector(-201, -652, 606), DOOR_BUYABLE_ASSIGNABLE, "4-B", 1, "CCH-A 4-B"},
	{Vector(-201, -756, 606), DOOR_BUYABLE_ASSIGNABLE, "4-C", 1, "CCH-A 4-C"},
	{Vector(-431, -652, 606), DOOR_UNBUYABLE, "Bathroom", 0, "CCH-A"},

	{Vector(-3576, -549, 150), DOOR_COMBINELOCK, "Civic Center", 0, "Civic Center"},
	{Vector(-3576, -643, 150), DOOR_COMBINELOCK, "Civic Center", 0, "Civic Center"},
	{Vector(-3565, -1672, 126), DOOR_COMBINELOCK, "Civic Center", 0, "Civic Center"},
	{Vector(-3995, -1180, 150), DOOR_COMBINELOCK, "Ration distribution", 0, "Civic Center"},

	{Vector(467, -906, 178), DOOR_COMBINELOCK, "Abandoned Condos", 0, "Condos"},
	{Vector(373, -906, 178), DOOR_COMBINELOCK, "Abandoned Condos", 0, "Condos"},
	{Vector(327, -590, 178), DOOR_BUYABLE_ASSIGNABLE, "2", 2, "Condos 2"},

	{Vector(-719, -2879, 134), DOOR_BUYABLE, "Shed", 1, "Shed"},
	{Vector(-928, -2930, 134), DOOR_UNBUYABLE, "", 1, "Shed"},

	{Vector(1711, -1236, 438), DOOR_COMBINEOPEN, "RESTRICTED ACCESS", 0, "Nexus"},
	{Vector(1611, -1236, 438), DOOR_COMBINEOPEN, "RESTRICTED ACCESS", 0, "Nexus"},
	{Vector(1611, -1340, 438), DOOR_COMBINEOPEN, "RESTRICTED ACCESS", 0, "Nexus"},
	{Vector(1765, -1340, 438), DOOR_COMBINEOPEN, "RESTRICTED ACCESS", 0, "Nexus"},
	{Vector(1857, -894, 437), DOOR_COMBINEOPEN, "CELL", 0, "Nexus"},

	{Vector(172, 772, -130), DOOR_COMBINEOPEN, "Precinct 6 Nexus", 0, "Nexus"},
	{Vector(172, 772, -130), DOOR_COMBINEOPEN, "Precinct 6 Nexus", 0, "Nexus"},
	{Vector(362, 792, 190), DOOR_COMBINEOPEN, "Precinct 6 Nexus", 0, "Nexus"},
	{Vector(-398, 644, 447.5), DOOR_COMBINEOPEN, "Roof Access", 0, "Nexus"},
	{Vector(-302, 1010, -66), DOOR_COMBINELOCK, "Cell 1", 0, "Nexus"},
	{Vector(-114, 1010, -66), DOOR_COMBINELOCK, "Cell 2", 0, "Nexus"},
	{Vector(39, 1010, -66), DOOR_COMBINELOCK, "Interrogation", 0, "Nexus"},

	{Vector(195, 636, -130), DOOR_UNBUYABLE, "Maintenance Access", 0, "Sewer"}
}

GM.Stoves = {
	{Vector(-288, -527, 188), Angle(0, 90, 0), "", false},
	{Vector(-288, -527, 318), Angle(0, 90, 0), "", false},
	{Vector(-288, -527, 448), Angle(0, 90, 0), "", false},
	{Vector(-288, -527, 578), Angle(0, 90, 0), "", false},
	{Vector(-129, -1350, 130), Angle(0, 180, 0), "Chesnut", false, "models/props_wasteland/kitchen_stove001a.mdl"}
}

GM.VendingMachines = {
	{Vector(-2247, -647, 120), Angle(0, 180, 0)},
	{Vector(-2254, -490, 120), Angle(0, -170, 0)},
	{Vector(-3441, -1642, 120), Angle(0, 90, 0)},
	{Vector(-732, -1024, 216), Angle(0, 90, 0)},
}

function GM:GetCombineCratePos()
	return {Vector(-327, 665, 408), Angle(0, -90, 0)}
end

function GM:GetCombineRationPos()
	return {Vector(179.3, 799.1, 189.9), Angle(-0.096, -1.955, 0.030)}
end

GM.CombineSpawnpoints = {
	Vector(-562, 900, 521),
}

if SW then
	hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
	hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
	hook.Remove("Think", "SW.Think")
	hook.Remove("HUDPaint", "SW.HUDPaint")
	hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
	hook.Remove("InitPostEntity", "SW.InitPostEntity")
	hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
	hook.Remove("Initialize", "SW.Initialize")
end