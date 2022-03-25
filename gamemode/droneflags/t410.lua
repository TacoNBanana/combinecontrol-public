FLAG.PrintName 					= "T-410"
FLAG.NameFormat 				= "T410.%s"

FLAG.Health 					= 500
FLAG.ArmorValue 				= 80

FLAG.Loadout 					= {"trp_t410"}

FLAG.Scale 						= 1.5

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t400.mdl",
			skin = 1,
			bodygroups = {
				arms = 1
			}
		}
	}
end

function FLAG.SpeedOverride(ply)
	return 95, 210, 210, 95
end
