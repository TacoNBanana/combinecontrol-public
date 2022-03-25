FLAG.PrintName 					= "T-400"
FLAG.NameFormat 				= "T400.%s"

FLAG.Health 					= 500
FLAG.ArmorValue 				= 80

FLAG.Loadout 					= {"trp_t400", "trp_t400_rocket"}

FLAG.Scale 						= 1.5

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t400.mdl",
			skin = 1,
			bodygroups = {
				arms = 2
			}
		}
	}
end

function FLAG.SpeedOverride(ply)
	return 95, 210, 210, 95
end
