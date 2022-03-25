function GM:GetHL2CamPos()
	return {Vector(-3278, 3986, 8690), Angle(14, -39, 0)}
end

function GM:GetCombineCratePos()
	return {Vector(-2334, -1561, 8337), Angle(-0, 180, 0)}
end

GM.CombineSpawnpoints = {
	Vector(-3419, -776, 8577),
	Vector(-3420, -815, 8577),
	Vector(-3420, -851, 8577),
	Vector(-3392, -852, 8577),
	Vector(-3392, -808, 8577),
	Vector(-3391, -771, 8577),
	Vector(-3426, -891, 8577),
	Vector(-3398, -891, 8577),
}

GM.Stoves = {
	{Vector(-2335, -1625, 8341), Angle(0, 180, 0), "", true},
}

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(5744, 6705, 8321), LOCATION_CITY, 512, TRANSITPORT_CITY_GATE) --done
	self:CreateLocationPoint(Vector(1323, 116, 8417), LOCATION_CITY, 128, TRANSITPORT_CITY_SEWER) --done
	self:CreateLocationPoint(Vector(-3545, -600, 8577), LOCATION_CITY, 128, TRANSITPORT_CITY_COMBINE) --done
end

GM.EnableAreaportals = true

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "If you continue along through the dank sewage tunnels, you might be able to find your way back to the city..."
GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "There's a grate between these two generators. It leads to the sewage maintenance tunnels, and it's unlocked. You could get to the city from here."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "Beyond this door is the razor train to the City 17 nexus. If you leave now, you might just make it on board."

GM.EntryPortSpawns[TRANSITPORT_CITY_GATE] = {
	Vector(4703, 6298, 8321),
	Vector(4646, 6308, 8321),
	Vector(4572, 6309, 8321),
	Vector(4506, 6310, 8321),
	Vector(4432, 6311, 8321),
	Vector(4371, 6311, 8321),
	Vector(4702, 6363, 8321),
	Vector(4647, 6369, 8321),
	Vector(4576, 6377, 8321),
	Vector(4507, 6384, 8321),
	Vector(4431, 6392, 8321),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
	Vector(1544, 169, 8417),
	Vector(1544, 128, 8417),
	Vector(1544, 92, 8417),
	Vector(1544, 47, 8417),
	Vector(1579, 47, 8417),
	Vector(1580, 95, 8417),
	Vector(1583, 135, 8417),
	Vector(1584, 182, 8417),
}

GM.EntryPortSpawns[TRANSITPORT_CITY_COMBINE] = GM.CombineSpawnpoints

GM.CurrentLocation = LOCATION_CANAL