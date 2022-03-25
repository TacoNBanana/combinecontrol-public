FLAG.PrintName 					= "T-70 Driller"
FLAG.Flag 						= "Q"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t100_canons", "trp_skynet_t400_canons", "trp_skynet_t400_minigun", "trp_skynet_t400_rocketlauncher" }

FLAG.BodyArmor					= 20000
FLAG.DamageReduction			= 20

FLAG.Scale 						= 10

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true
FLAG.QuietSteps 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 150
FLAG.SpeedOverride.r 			= 300
FLAG.SpeedOverride.c 			= 150
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t70_scorpion.mdl")
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end