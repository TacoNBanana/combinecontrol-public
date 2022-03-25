FLAG.PrintName 					= "T-700"
FLAG.NameFormat 				= "T700.%s"

FLAG.Health 					= 1200
FLAG.ArmorValue 				= 80

FLAG.Loadout 					= {"trp_skynet_30watt", "trp_skynet_40watt"}

FLAG.Scale 						= 1

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t700.mdl"
		}
	}
end
