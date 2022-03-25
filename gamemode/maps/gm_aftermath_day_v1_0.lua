function GM:GetHL2CamPos()
	
	return { Vector( 5058, 9469, 549 ), Angle( 49, -13, 0 ) };
	
end

function GM:MapInitPostEntity()
	
	self:CreateLocationPoint( Vector( 7971.848633, 1789.684814, 112.031250 ), LOCATION_CITY, 100, TRANSITPORT_CITY_GATE );
	self:CreateLocationPoint( Vector( -773.197937, 13444.789063, 734.853394 ), LOCATION_CITY, 100, TRANSITPORT_CITY_SEWER );
	self:CreateLocationPoint( Vector( 7768, 13780, 86 ), LOCATION_CITY, 200, TRANSITPORT_CITY_COMBINE );

end

GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "You can summon the helicopter to take you back to the City 17 Nexus here.";
GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "You can take this path back to the city.";
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "You can take this path back to the city.";

GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = {
	Vector( 7024, 13345, 95 ),
	Vector( 7025, 13392, 87 ),
	Vector( 7025, 13437, 79 ),
	Vector( 7023, 13495, 69 ),
	Vector( 7023, 13554, 56 )
};

GM.CurrentLocation = LOCATION_CANAL;
GM.EnableAreaportals = true;

GM.EntNamesToRemove = {
	"Train 1",
	"rocketlaunch button",
	"rocketlaunch button prop",
	"failrocket button prop",
	"failrocket steam",
	"path rocket 1",
	"failrocket ignite",
	"failrocket sound",
	"failrocket lights",
	"failrocket explosion",
	"failrocket ignite",
	"failrocket sound",
	"failrocket lights",
	"failrocket alarm 1",
	"failrocket lights",
	"failrocket alarm 2",
	"failrocket electric",
	"failrocket display",
	"failrocket display",
	"failrocket shake",
	"failrocket lights"
};

GM.CombineSpawnpoints = {
	Vector( 8048, 13157, 315 ),
	Vector( 8046, 13105, 309 ),
	Vector( 8044, 13050, 308 ),
	Vector( 8046, 12974, 329 ),
	Vector( 8080, 12974, 345 ),
	Vector( 8084, 13158, 331 ),
	Vector( 8084, 13075, 323 ),
};