FLAG.PrintName 					= "T-400"
FLAG.Flag 						= "G"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t400_canons", "trp_skynet_t400_long", "trp_skynet_t400_minigun", "trp_skynet_t400_guns", "trp_skynet_t400_rocketlauncher" }

FLAG.Health						= 500
FLAG.BodyArmor					= 4000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 1.5

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
	return Model("models/tnb/skynet/t400.mdl")
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end