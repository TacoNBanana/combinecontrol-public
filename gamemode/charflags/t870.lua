FLAG.PrintName 					= "T-870"
FLAG.Flag 						= "u"

FLAG.Team						= TEAM_SKYNET
FLAG.Loadout					= {"weapon_cc_hands", "trp_skynet_t870_blade", "trp_skynet_50watt", "trp_skynet_55watt", "trp_skynet_55watt_stealth", "trp_skynet_50watt_stealth"}

FLAG.BodyArmor					= 4500
FLAG.DamageReduction			= 60

FLAG.IgnoreTravelRestriction	= true
FLAG.NoFallDamage 				= true
FLAG.UseCombineSpawns 			= true
FLAG.CanAccessCombineMenu 		= true
FLAG.NoWeaponDrop 				= true
FLAG.InfiniteAmmo 				= true

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t870.mdl"), 0
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end