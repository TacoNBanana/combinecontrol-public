GM.CurrentLocation	= LOCATION_CITY
GM.LogLocation		= LOCATION_NEXUS

function GM:GetHL2CamPos()
	return {Vector(-180.185, -1350.627, 210.833), Angle(13.100, 42.462, 0)}
end

function GM:GetCombineCratePos()
	return {Vector(-879.563, 644.250, 80.344), Angle(0, 0, 0)}
end

function GM:GetCombineRationPos()
	return {Vector(1417.914, -1005.596, 118.639), Angle(0, 90, 0)}
end

if SERVER then
	resource.AddFile("rp_tnb_central18nexus_v2.lua")
end

hook.Remove("SetupWorldFog", "SW.SetupWorldFog")
hook.Remove("SetupSkyboxFog", "SW.SetupSkyboxFog")
hook.Remove("Think", "SW.Think")
hook.Remove("HUDPaint", "SW.HUDPaint")
hook.Remove("RenderScreenspaceEffects", "SW.RenderScreenspaceEffects")
hook.Remove("InitPostEntity", "SW.InitPostEntity")
hook.Remove("PlayerInitialSpawn", "SW.PlayerInitialSpawn")
hook.Remove("Initialize", "SW.Initialize")
