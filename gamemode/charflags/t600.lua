FLAG.PrintName 					= "T-600"
FLAG.Flag 						= "A"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_minigun_t600", "trp_skynet_35watt_drone", "trp_skynet_30watt"}

FLAG.BodyArmor					= 3500
FLAG.DamageReduction			= 30

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t600.mdl"), math.random(1, 3) == 3 and 2 or 0
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end