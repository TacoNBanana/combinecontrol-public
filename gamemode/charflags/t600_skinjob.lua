FLAG.PrintName 					= "T-600 (Skinjob)"
FLAG.Flag 						= "B"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_minigun_t600", "trp_skynet_m60", "trp_skynet_35watt_drone"}

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
	return Model("models/tnb/skynet/t600_skinjob.mdl"), math.random(0, 3)
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end