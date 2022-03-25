FLAG.PrintName 					= "T-500 Reaver"
FLAG.Flag 						= "R"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"trp_skynet_reaver", "trp_skynet_t500_canons"}

FLAG.BodyArmor					= 1000
FLAG.DamageReduction			= 20

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 100
FLAG.SpeedOverride.r 			= 400
FLAG.SpeedOverride.c 			= 100
FLAG.SpeedOverride.j 			= 500

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t500_reaver.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end