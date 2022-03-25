FLAG.PrintName 					= "Reprogrammed T-500"
FLAG.Flag 						= "f"

FLAG.Team						= TEAM_REPROG
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t500_canons"}

FLAG.BodyArmor					= 2000
FLAG.DamageReduction			= 20

FLAG.NoFallDamage 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 95
FLAG.SpeedOverride.r 			= 300
FLAG.SpeedOverride.c 			= 95
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t400_repro.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end