FLAG.PrintName 					= "T-20"
FLAG.Flag 						= "P"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t20"}

FLAG.BodyArmor					= 1000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 0.2

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true
FLAG.QuietSteps 				= true
FLAG.NoRagdoll 					= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 38
FLAG.SpeedOverride.r 			= 210
FLAG.SpeedOverride.c 			= 38
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t200.mdl")
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end