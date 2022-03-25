function GM:GetHL2CamPos()

	return {Vector(4202, 1315, 13787), Angle(5, -32, 0)}
end

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(3795, 6714, 13761), LOCATION_CITY, 100, TRANSITPORT_CITY_GATE)
	self:CreateLocationPoint(Vector(3815, 3972, 13745), LOCATION_CITY, 60, TRANSITPORT_CITY_SEWER)
	self:CreateLocationPoint(Vector(9229, -1050, 4160), LOCATION_CITY, 200, TRANSITPORT_CITY_COMBINE)
	self:CreateLocationPoint(Vector(-10229, 12763, 9520), LOCATION_OUTLANDS, 256, TRANSITPORT_CAVES_ENTRY)
end

GM.EnableAreaportals = true

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "This maintenance shaft leads back into the city."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "This maintenance shaft leads into the city's sewers."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "You can summon the helicopter to take you back to the City 18 Nexus here."
GM.ConnectMessages[TRANSITPORT_CAVES_ENTRY] = "You come across what looks like the entrance to a mine."
GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "You come across a tunnel that leads towards the coast."

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(3719, 6659, 13697),
	Vector(3718, 6620, 13697),
	Vector(3666, 6621, 13697),
	Vector(3666, 6663, 13697),
	Vector(3611, 6663, 13697),
	Vector(3611, 6614, 13697),
	Vector(3555, 6614, 13713),
	Vector(3556, 6659, 13713),

}
GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
	Vector(-10280, 12403, 9457),
	Vector(-10222, 12407, 9478),
	Vector(-10172, 12410, 9480),
	Vector(-10189, 12338, 9465),
	Vector(-10239, 12323, 9457),
	Vector(-10299, 12346, 9457),
}
GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(3819, 4125, 13745),
	Vector(3821, 4070, 13745),
}
GM.EntryPortSpawns[TRANSITPORT_COAST_ENTRY] = {
	Vector(-8621.874023, -12516.361328, 3146.371338),
	Vector(-8619.418945, -12344.905273, 3142.916504),
	Vector(-8617.740234, -12227.692383, 3139.704590),
	Vector(-8616.061523, -12110.479492, 3144.290039),
	Vector(-8614.218750, -11981.817383, 3159.222412),
	Vector(-8501.891602, -12115.143555, 3147.928467),
	Vector(-8439.027344, -12300.929688, 3136.031250),
	Vector(-8364.438477, -12474.690430, 3139.439209),
}

GM.CombineSpawnpoints = {
	Vector(10160, 2002, 3841),
	Vector(10218, 2002, 3841),
	Vector(10282, 2002, 3841),
	Vector(10277, 1938, 3841),
	Vector(10224, 1938, 3841),
	Vector(10169, 1938, 3841),
	Vector(10169, 1869, 3841),
	Vector(10227, 1869, 3841),
	Vector(10288, 1869, 3841),
	Vector(10288, 1814, 3841),
	Vector(10231, 1813, 3841),
	Vector(10168, 1813, 3841),
}

GM.CurrentLocation = LOCATION_CANAL

GM.DoorData = {
	{Vector(10308, 1920, 3888), DOOR_COMBINEOPEN, ""},
}