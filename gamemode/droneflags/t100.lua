FLAG.PrintName 					= "T-100"
FLAG.NameFormat 				= "T100.%s"

FLAG.Health 					= 400
FLAG.ArmorValue 				= 95

FLAG.Loadout 					= {"trp_t100"}

FLAG.Scale 						= 0.55

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t100.mdl"
		}
	}
end

function FLAG.SpeedOverride(ply)
	return 91, 160, 300, 91
end
