FLAG.PrintName 					= "Techcom T100 APU"
FLAG.Flag 						= "h"

FLAG.Team						= TEAM_REPROG
FLAG.Loadout					= {"weapon_cc_hands", "trp_mech_dualplasma", "trp_mech_artillary", "trp_mech_defender", }

FLAG.Health						= 500
FLAG.BodyArmor					= 9000
FLAG.DamageReduction			= 30

FLAG.Scale 						= 1
FLAG.NoFallDamage 				= true

FLAG.SpeedOverride 				= {}
FLAG.SpeedOverride.w 			= 80
FLAG.SpeedOverride.r 			= 260
FLAG.SpeedOverride.c 			= 80
FLAG.SpeedOverride.j 			= 210

FLAG.CanUseNightvision 			= true

function FLAG.ModelFunc(ply)
	return Model("models/tnb/skynet/t100_mech.mdl"), 0
end

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end