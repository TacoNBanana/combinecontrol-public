FLAG.PrintName 					= "Reprogrammed T-400"
FLAG.Flag 						= "g"

FLAG.Team						= TEAM_REPROG
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t400_canons", "trp_skynet_t400_minigun", "trp_skynet_t400_dshkm", "trp_skynet_t400_rocketlauncher" }

FLAG.Health						= 500
FLAG.BodyArmor					= 4000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 1.5
FLAG.NoFallDamage 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 95
FLAG.SpeedOverride.r 			= 210
FLAG.SpeedOverride.c 			= 95
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t400_repro.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end