-- rp_salvation_night_redemption

function GM:GetHL2CamPos()
	return {Vector(-213, -11094, 390), Angle(3, 123, 0)}
end

function GM:GetCombineCratePos()
	return {Vector(-276, 5350, -78), Angle(7, -90, 0)}
end

GM.CombineSpawnpoints = {
	Vector(-316, 5159, -94),
	Vector(-327, 5069, -94),
	Vector(-323, 4968, -94),
}

function GM:MapInitPostEntity()
	local garagedoor = ents.GetMapCreatedEntity(1453)
	if IsValid(garagedoor) then
		garagedoor:Fire("lock", "", 0)
	end
end

GM.EnableAreaportals = true

-- fuckin shit!
GM.EntryPortSpawns[0] = {
	Vector(-153.752289, -10386.176758, -71.968750),
	Vector(-154.091660, -10487.564453, -71.968750),
	Vector(-154.060654, -10575.576172, -71.968750),
	Vector(-139.435104, -10651.161133, -71.968750),
}

GM.EntryPortSpawns[1] = GM.EntryPortSpawns[0]

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")