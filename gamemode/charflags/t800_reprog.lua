FLAG.PrintName 					= "Reprogrammed T-800"
FLAG.Flag 						= "d"

FLAG.Team						= TEAM_REPROG

FLAG.BodyArmor					= 4000
FLAG.DamageReduction			= 30


FLAG.NoFallDamage 				= true

FLAG.CanUseNightvision 			= true

function FLAG.OnSpawn(ply)
	ply:SetBloodColor(BLOOD_COLOR_MECH)
end