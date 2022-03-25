FLAG.PrintName 					= "Reprogrammed T-500 Reaver"
FLAG.Flag 						= "r"

FLAG.Team						= TEAM_REPROG
FLAG.Loadout					= {"trp_skynet_reaver", "trp_skynet_t500_canons"}

FLAG.BodyArmor					= 1000
FLAG.DamageReduction			= 20

FLAG.NoFallDamage 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 100
FLAG.SpeedOverride.r 			= 400
FLAG.SpeedOverride.c 			= 100
FLAG.SpeedOverride.j 			= 500

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t500_reaver.mdl"), 3
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end