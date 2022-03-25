FLAG.PrintName 					= "T-500"
FLAG.NameFormat 				= "T500.%s"

FLAG.Health 					= 200
FLAG.ArmorValue 				= 50

FLAG.Scale 						= 1.2

function FLAG.Loadout(ply)
	local tab = {"trp_t500"}

	if GAMEMODE:AprilFools() then
		table.insert(tab, "trp_t500_antlion")
	end

	return tab
end

function FLAG.ModelFunc(ply)
	return {
		head = {
			model = "models/tnb/player/trp/t400.mdl",
			skin = 1
		}
	}
end

function FLAG.SpeedOverride(ply)
	return 95, 300, 300, 95
end
