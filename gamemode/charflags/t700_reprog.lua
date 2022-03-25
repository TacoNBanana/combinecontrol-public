FLAG.PrintName 					= "Reprogrammed T-700"
FLAG.Flag 						= "c"

FLAG.Team						= TEAM_REPROG
FLAG.Loadout					= {"weapon_cc_hands", "trp_minigun_t700", "trp_skynet_30watt", "trp_skynet_35watt_drone"}

FLAG.BodyArmor					= 3000
FLAG.DamageReduction			= 30

FLAG.NoFallDamage 				= true

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t700_repro.mdl"), 0
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end