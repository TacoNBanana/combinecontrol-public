GM.CurrentLocation = LOCATION_CANAL;

function GM:GetHL2CamPos()

	return { Vector( 5801, 8423, 1576 ), Angle( 13, -103, 0 ) };

end

function GM:MapInitPostEntity()
	self:CreateLocationPoint( Vector( 11627.391602, -14671.546875, 112.279572 ), LOCATION_CITY, 100, TRANSITPORT_CITY_GATE );
	self:CreateLocationPoint( Vector( -11002.495117188, 7120.7260742188, -143.96875 ), LOCATION_CITY, 100, TRANSITPORT_CITY_SEWER );
	self:CreateLocationPoint( Vector( 15178.108398, -15627.213867, 1359.219604 ), LOCATION_CITY, 200, TRANSITPORT_CITY_COMBINE );
end

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "This long forgotten tunnel leads back into the city.";
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "You can summon the helicopter to take you back to the City 17 Nexus here.";
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "A pipe at the bottom of the pit leads into the city's sewers.";

GM.EnableAreaportals = true;

GM.CombineSpawnpoints = {
	Vector(10372, 14769, 1281),
	Vector(10345, 14726, 1281),
	Vector(10343, 14817, 1281),
	Vector(10307, 14723, 1281),
	Vector(10306, 14811, 1281),
	Vector(10270, 14769, 1281),
};

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector( 11926, -14020, 41 ),
	Vector( 11912, -13947, 42 ),
	Vector( 11910, -13871, 42 ),
	Vector( 11902, -13802, 43 ),
	Vector( 11859, -13805, 42 ),
	Vector( 11867, -13876, 42 ),
	Vector( 11874, -13950, 41 ),
	Vector( 11890, -14031, 40 ),
};

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector( 11926, -14020, 41 ),
	Vector( 11912, -13947, 42 ),
	Vector( 11910, -13871, 42 ),
	Vector( 11902, -13802, 43 ),
	Vector( 11859, -13805, 42 ),
	Vector( 11867, -13876, 42 ),
	Vector( 11874, -13950, 41 ),
	Vector( 11890, -14031, 40 ),
};

GM.Stoves = {
	{ Vector( 3350, 2033, 541 ), Angle( 0, -90, 0 ), "", true },
	{ Vector( -2374, 1696, 293 ), Angle( 0, 0, 0 ), "", true },
	{ Vector( -10344, -11608, 1061 ), Angle( 0, -90, 0 ), "", true },
	{ Vector( -10030, 7316, 1045 ), Angle( 0, 0, 0 ), "", true },
};
