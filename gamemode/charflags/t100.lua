FLAG.PrintName 					= "T-100"
FLAG.Flag 						= "H"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t100_canons", "trp_skynet_t400_canons", "trp_skynet_t400_minigun", "trp_skynet_t400_rocketlauncher" }

FLAG.Health						= 500
FLAG.BodyArmor					= 9000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 1

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 80
FLAG.SpeedOverride.r 			= 260
FLAG.SpeedOverride.c 			= 80
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t100.mdl")
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end