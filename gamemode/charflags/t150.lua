FLAG.PrintName 					= "T-150"
FLAG.Flag 						= "k"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t70_canons", "trp_skynet_t400_canons", "trp_skynet_t400_minigun", "trp_skynet_t400_guns" }

FLAG.Health						= 500
FLAG.BodyArmor					= 3000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 0.6

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 120
FLAG.SpeedOverride.r 			= 250
FLAG.SpeedOverride.c 			= 100
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t100.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end