FLAG.PrintName 					= "T-70 Widow"
FLAG.Flag 						= "N"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_widow"}

FLAG.BodyArmor					= 500
FLAG.DamageReduction			= 30

FLAG.Scale 						= 1

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true
FLAG.QuietSteps 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 38
FLAG.SpeedOverride.r 			= 210
FLAG.SpeedOverride.c 			= 38
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t70_widow.mdl")
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end