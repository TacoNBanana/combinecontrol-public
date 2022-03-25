FLAG.PrintName 					= "T-450"
FLAG.Flag 						= "M"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t450", "trp_skynet_t450_railgun", "trp_skynet_t450_autocannon"}

FLAG.Health						= 500
FLAG.BodyArmor					= 5000
FLAG.DamageReduction			= 50

FLAG.Scale 						= 2

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 95
FLAG.SpeedOverride.r 			= 210
FLAG.SpeedOverride.c 			= 95
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t400.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end