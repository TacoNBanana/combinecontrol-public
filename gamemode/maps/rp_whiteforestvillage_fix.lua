function GM:GetHL2CamPos()
  return {Vector(526, -3564, 742), Angle(0, 31, 0)}
end

function GM:MapInitPostEntity()
  self:CreateLocationPoint(Vector(4726, -11705, -975), LOCATION_CITY, 500, TRANSITPORT_CITY_SEWER)
end

GM.ConnectMessages[TRANSITPORT_CITY_SEWER] = "You've been here before. Further down the tunnel is a pipe leading to the Canals system."

GM.EntryPortSpawns[TRANSITPORT_CITY_SEWER] = {
  Vector(4733, -10425, -1000),
  Vector(4833, -10425, -1000),
  Vector(4633, -10425, -1000)
}

GM.CurrentLocation = LOCATION_CANAL