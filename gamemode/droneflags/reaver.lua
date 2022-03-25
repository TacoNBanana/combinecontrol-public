FLAG.PrintName 					= "HK-REAVER"
FLAG.NameFormat 				= "REAVER.%s"

FLAG.Health 					= 200
FLAG.ArmorValue 				= 50

FLAG.Loadout 					= {"trp_reaver"}

FLAG.Scale 						= 1

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t500_reaver.mdl",
			skin = 0
		}
	}
end

function FLAG.SpeedOverride(ply)
	return 95, 300, 300, 95
end
