FLAG.PrintName 					= "Techcom T300 APU"
FLAG.Flag 						= "s"

FLAG.Team						= TEAM_REPROG
FLAG.Loadout					= {"weapon_cc_hands", "trp_mech_dualplasma", "trp_mech_railgun", "trp_mech_minigun" }

FLAG.Health						= 500
FLAG.BodyArmor					= 8000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 1
FLAG.NoFallDamage 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 95
FLAG.SpeedOverride.r 			= 120
FLAG.SpeedOverride.c 			= 95
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t300_mech.mdl"), 0
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end