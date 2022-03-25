FLAG.PrintName 					= "Reprogrammed T-600"
FLAG.Flag 						= "a"

FLAG.Team						= TEAM_REPROG
FLAG.Loadout					= {"weapon_cc_hands", "trp_minigun_t600"}

FLAG.BodyArmor					= 3500
FLAG.DamageReduction			= 40

FLAG.NoFallDamage 				= true

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t600_repro.mdl"), 1
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end