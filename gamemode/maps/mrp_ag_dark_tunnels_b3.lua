function GM:GetHL2CamPos()
	
	return { Vector( 1666, 1957, 125 ), Angle( 17.16, -48.87, 0 ) };
	
end

function GM:GetCombineCratePos()
	
	return { Vector( -986, -6040, -1519 ), Angle( -0, -90, -0 ) };

end

function GM:GetCombineRationPos()
	
	return { Vector( -902, -6027, -1478 ), Angle( 0, -90, 0 ) };
	
end

GM.CurrentLocation = LOCATION_CANAL;

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector( 2397, 4396, 704 ), LOCATION_CITY, 100, TRANSITPORT_CITY_GATE );
	self:CreateLocationPoint( Vector( 8060, 4293, -703 ), LOCATION_CITY, 256, TRANSITPORT_CITY_SEWER );
	self:CreateLocationPoint( Vector( 250, -5055, -1467 ), LOCATION_CITY, 128, TRANSITPORT_CITY_COMBINE );
	
end

GM.Stoves = {
	{ Vector( -10910, -5147, 21 ), Angle( 0, 1, 0 ), "", true },
};

GM.EnableAreaportals = true;
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "You can hear the faint sound of running water through the grates. They seem to lead to the sewer system under City 17.";
GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "A blinding light shines through an old maintenance hatch above. You can hear the sounds of the City on the other side.";
GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "The tunnel ahead looks both dark and cold. A makeshift train has been built with it's destination set for the abandoned mines.";
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "A Razor Train has been stationed just behind the armored door, chances are that it leads back to the City.";
GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "A long, dark tunnel before you would lead to an abandoned town just outside of the City. Just outside of the Combine's grip, travelling further should lead to the Outlands.";

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector( 7888, 1241, 55 ),
	Vector( 8227, 1241, 55 ),
	Vector( 8010, 1100, 55 ),
	Vector( 8110, 1100, 55 ),
};

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector( 2153, 4324, 695 ),
	Vector( 2153, 4385, 695 ),
	Vector( 2153, 4450, 695 ),
	Vector( 2210, 4450, 695 ),
	Vector( 2210, 4386, 695 ),
	Vector( 2210, 4321, 695 ),
};

GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
	Vector( 7595, -10448, -630 ),
	Vector( 7595, -10378, -630 ),
};

GM.EntryPortSpawns[TRANSITPORT_COAST_ENTRY] = {
	Vector( -10027, -4940, 55 ),
	Vector( -10096, -4940, 55 ),
	Vector( -10172, -4940, 55 ),
	Vector( -10027, -4940, 55 ),
	Vector( -10243, -4940, 55 ),
};

GM.CombineSpawnpoints = {
	Vector( -590, -5084, -1517 ),
	Vector( -590, -5032, -1517 ),
	Vector( -529, -5084, -1517 ),
	Vector( -529, -5032, -1517 ),
};

GM.DoorData = {
	{ Vector( -10021, -5180, 54.25 ), DOOR_UNBUYABLE, "Ticket Office" },
	{ Vector( -9281, -4792, 182.25 ), DOOR_UNBUYABLE, "Employees Only" },
	{ Vector( -9224, -4179, 182.25 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( -3931, 908, -457.75 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( -3204, 2429, -393.75 ), DOOR_UNBUYABLE, "Ticket Office" },
	{ Vector( 2835, 1532, -393.75 ), DOOR_UNBUYABLE, "Mai---nan-- Ac-ess" },
	{ Vector( 2576, 1549, -9.75 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 2341, -760, 54.25 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 2828, -3117, 54.25 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 4860, -2597, 54.25 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 5453, -3072, 54.25 ), DOOR_UNBUYABLE, "Sub-Level C; Employees Only" },
	{ Vector( 4781, -1016, -73.75 ), DOOR_UNBUYABLE, "Sub-Level B" },
	{ Vector( 4744, -603, -73.75 ), DOOR_UNBUYABLE, "Sub-Level B" },
	{ Vector( 7445, -3716, 182.25 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 7556, -4005, 54.25 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 7643, -4612, 54.25 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( 8068, -8773, -713.75 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 1499, -7948, 54.25 ), DOOR_COMBINELOCK, "Maintenance Access" },
	{ Vector( 7077, -1032, 54.25 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( 7048, -537, 54.25 ), DOOR_UNBUYABLE, "Sub-Level B" },
	{ Vector( 5413, -3324, -457.75 ), DOOR_UNBUYABLE, "Sub-Level A" },
	{ Vector( 8621, 2052, 54.25 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( 7544, 581, 54.25 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 7688, -211, -201.75 ), DOOR_UNBUYABLE, "Storage" },
	{ Vector( 5112, -685, -201.75 ), DOOR_UNBUYABLE, "Sub-Level A" },
	{ Vector( 1668, 9469, 54.25 ), DOOR_UNBUYABLE, "Maintenance Access" },
	{ Vector( 923, 9084, 54.25 ), DOOR_UNBUYABLE, "Maintenance Access" },


};