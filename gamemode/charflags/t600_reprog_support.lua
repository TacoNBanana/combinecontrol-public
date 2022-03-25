FLAG.PrintName 					= "Reprogrammed T-600 Support Drone"
FLAG.Flag 						= "b"

FLAG.Team						= TEAM_REPROG
FLAG.Loadout					= {"weapon_cc_hands", "trp_minigun_t600", "trp_skynet_t600_cutter"}

FLAG.BodyArmor					= 3500
FLAG.DamageReduction			= 40

FLAG.NoFallDamage 				= true

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t600_repro_support.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end