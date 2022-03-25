function GM:GetHL2CamPos()
	return {Vector(-11711, 7027, 583), Angle(3, 50, 0)}
end

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(-14439.423828, 13938.960938, 576.031250), LOCATION_CITY, 500, TRANSITPORT_CITY_GATE)
end

GM.ConnectMessages[TRANSITPORT_COAST_ENTRY] = "You've been here before. Further down the tunnel is a pipe leading to the Canals system."

GM.EntryPortSpawns[TRANSITPORT_CAVES_ENTRY] = {
Vector(-14210.609375, 12555.635742, 576.031250),
Vector(-14065.749023, 12439.214844, 576.031250),
Vector(-13959.743164, 12540.760742, 576.031250),
Vector(-13906.170898, 12664.815430, 576.031250),
Vector(-13984.706055, 12803.922852, 576.031250),
Vector(-14076.840820, 12933.494141, 576.031250),
Vector(-14175.039063, 13069.447266, 576.031250),
Vector(-13992.605469, 13172.310547, 576.031250),
}

GM.DoorData = {
	{Vector(567, -6586, -682), DOOR_BUYABLE, "Shack", 5},
	{Vector(-694, 5823, -710), DOOR_BUYABLE, "House", 5, "House"},
	{Vector(-942, 5679, -710), DOOR_BUYABLE, "Back Entrance", 5, "House"},
	{Vector(10864, 8531, -134), DOOR_BUYABLE, "Cabin", 5, "Cabin"},
	{Vector(11113, 8384, -134), DOOR_BUYABLE, "Side Entrance", 5, "Cabin"},
	{Vector(-11489, 7161.91015625, 566), DOOR_UNBUYABLE, ""},
}

GM.Stoves = {
	{Vector(-915, 5786, -742), Angle(0, 3, 0), "", true},
	{Vector(10886, 8710, -167), Angle(0, 0, 0), "", true},
}

GM.CurrentLocation = LOCATION_CANAL