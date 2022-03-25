FLAG.PrintName 					= "SkyNet"
FLAG.Flag 						= "S"

FLAG.IsSkyNET 					= true

FLAG.Team						= TEAM_SKYNET

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.InfiniteAmmo 				= true
FLAG.NoWeaponDegradation 		= true
FLAG.GasImmune 					= true

FLAG.BloodColor 				= BLOOD_COLOR_MECH

local function DroneFlag(ply, var, fallback)
	local flag = GAMEMODE:GetDroneFlag(ply:ActiveDroneFlag())

	if not flag or flag[var] == nil then
		return fallback
	end

	if isfunction(flag[var]) then
		return flag[var](ply)
	end

	return flag[var]
end

function FLAG.Health(ply)
	return DroneFlag(ply, "Health", 100)
end

function FLAG.ArmorValue(ply)
	return DroneFlag(ply, "ArmorValue", 0)
end

function FLAG.VisibleRPName(ply)
	return string.format(DroneFlag(ply, "NameFormat", "%s"), ply:RPName())
end

function FLAG.Scale(ply)
	return DroneFlag(ply, "Scale", false)
end

function FLAG.Loadout(ply)
	return DroneFlag(ply, "Loadout", {})
end

function FLAG.ModelFunc(ply)
	return DroneFlag(ply, "ModelFunc", {
		head = {
			model = "models/player/skeleton.mdl",
			skin = 3
		}
	})
end

function FLAG.SpeedOverride(ply)
	return DroneFlag(ply, "SpeedOverride")
end

function FLAG.QuietSteps(ply)
	return DroneFlag(ply, "QuietSteps")
end

function FLAG.PostDrawTranslucentRenderables(ply, depth, skybox)
	local flag = GAMEMODE:GetDroneFlag(ply:ActiveDroneFlag())

	if not flag then
		return
	end

	if flag.PostDrawTranslucentRenderables then
		flag.PostDrawTranslucentRenderables(ply, depth, skybox)
	end
end
