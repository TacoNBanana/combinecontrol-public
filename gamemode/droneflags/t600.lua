FLAG.PrintName 					= "T-600"
FLAG.NameFormat 				= "T600.%s"

FLAG.Health 					= 400
FLAG.ArmorValue 				= 50

FLAG.Loadout 					= {"trp_t600_minigun"}

FLAG.Scale 						= 1.10

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t600.mdl"
		}
	}
end
