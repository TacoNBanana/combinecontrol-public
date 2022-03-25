FLAG.PrintName 					= "T-800"
FLAG.Flag 						= "D"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_40watt_drone", "trp_skynet_30watt_dual"}

FLAG.BodyArmor					= 4000
FLAG.DamageReduction			= 45

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t800.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end