FLAG.PrintName 					= "T-70"
FLAG.Flag 						= "O"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t70_canons", "trp_skynet_t500_canons"}

FLAG.BodyArmor					= 3000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 3

--for walk sounds check sh_player line 624

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 80
FLAG.SpeedOverride.r 			= 250
FLAG.SpeedOverride.c 			= 80
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t70.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end