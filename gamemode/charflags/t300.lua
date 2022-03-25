FLAG.PrintName 					= "T-300"
FLAG.Flag 						= "p"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= { "trp_skynet_t300_guns"}

FLAG.Health						= 500
FLAG.BodyArmor					= 5000
FLAG.DamageReduction			= 50

FLAG.Scale 						= 1

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 110
FLAG.SpeedOverride.r 			= 210
FLAG.SpeedOverride.c 			= 95
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t300_new.mdl"), 0
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end