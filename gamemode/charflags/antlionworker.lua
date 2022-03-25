FLAG.PrintName 					= "Antlion worker"
FLAG.Flag 						= "B"

FLAG.Team						= TEAM_XEN
FLAG.Loadout					= {"weapon_cc_antlion_worker"}

FLAG.Health						= 150

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 95
FLAG.SpeedOverride.r 			= 300
FLAG.SpeedOverride.c 			= 95
FLAG.SpeedOverride.j 			= 210

FLAG.CameraDispatch 			= "ALERT. [%s] reports local exogen breach"

function FLAG.ModelFunc(ply)
	return "models/antlion_worker.mdl"
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_YELLOW)

	ply:SetViewOffset(Vector(0, 0, 30))
	ply:SetViewOffsetDucked(Vector(0, 0, 30))
end

function FLAG.OnDeath(ply)
	ply:StopSound("antlion_flight_loop")
	ply:StopSound("antlion_flight_land")

	ply:SetBodygroup(1, 0)
end