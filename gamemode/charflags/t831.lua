FLAG.PrintName 					= "T-850"
FLAG.Flag 						= "e"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t831_guns", "trp_skynet_t831_plasma", "trp_skynet_t831_canon", "trp_skynet_45watt"}

FLAG.BodyArmor					= 5000
FLAG.DamageReduction			= 50

FLAG.Scale 						= 1

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t831.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end