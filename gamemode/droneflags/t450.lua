FLAG.PrintName 					= "T-450"
FLAG.NameFormat 				= "T450.%s"

FLAG.Health 					= 1500
FLAG.ArmorValue 				= 80

FLAG.Loadout 					= {"trp_t450", "trp_t450_howitzer"}

FLAG.Scale 						= 2

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
