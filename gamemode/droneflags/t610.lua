FLAG.PrintName 					= "T-610"
FLAG.NameFormat 				= "T610.%s"

FLAG.Health 					= 400
FLAG.ArmorValue 				= 50

FLAG.Loadout 					= {"trp_t600_flamethrower"}

FLAG.Scale 						= 1.10

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t600.mdl",
			skin = 1
		}
	}
end
