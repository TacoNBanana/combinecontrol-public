function GM:GetHL2CamPos()
	return {Vector(-333, 4110, 2371), Angle(32, 33, 0)}
end

function GM:MapInitPostEntity()
	self:CreateLocationPoint(Vector(-4048, 5057, 1572), LOCATION_CITY, 64, TRANSITPORT_CITY_GATE) -- Spawn tunnel door
	self:CreateLocationPoint(Vector(9005, -12081, 2048), LOCATION_CITY, 64, TRANSITPORT_CITY_COMBINE) -- Far-end tunnel
end

GM.ConnectMessages[TRANSITPORT_CITY_GATE] = "This door seems to lead to a series of tunnels, leading back into City 17."
GM.ConnectMessages[TRANSITPORT_CITY_COMBINE] = "There is an APC standing by, ready to take you back to City 17."

GM.CombineSpawnpoints = {
	Vector(9406, -12182, 2049),
	Vector(9405, -12108, 2049),
	Vector(9402, -12034, 2049),
	Vector(9404, -11957, 2049),
	Vector(9333, -12183, 2049),
	Vector(9332, -12108, 2049),
	Vector(9331, -12034, 2049),
	Vector(9330, -11957, 2049)
}

GM.CurrentLocation = LOCATION_CANAL

function GM:GetCombineCratePos()
	return {Vector(9456, -11811, 2065), Angle(0, 180, 0)}
end

GM.CameraData = {
	{Vector(9141.69, -11582.7, 2237.97), Angle(0, 49.7461, 0), "HARDPOINT", true}
}