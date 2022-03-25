FLAG.PrintName 					= "T-600 Skinjob"
FLAG.NameFormat 				= "T600.%s"

FLAG.Health 					= 400
FLAG.ArmorValue 				= 50

FLAG.Loadout 					= {"trp_t600_minigun", "trp_m60"}

FLAG.Scale 						= 1.10

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t600_skinjob2.mdl"
		}
	}
end
