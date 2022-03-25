FLAG.PrintName 					= "T-250"
FLAG.Flag 						= "j"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t831_canon", "trp_skynet_t450_railgun" }

FLAG.Health						= 500
FLAG.BodyArmor					= 5000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 0.8

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
	return Model("models/tnb/skynet/t200.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end