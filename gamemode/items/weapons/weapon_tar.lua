ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tavor TAR-21"
ITEM.Description 	= "A compact NATO assault rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_tar.mdl")

ITEM.Bodygroups 	= {
	upgrades = 1
}
ITEM.Materials 		= {
	["models/tnb/weapons/m16/m16_silencer"] = "null",
	["models/tnb/weapons/mp7/mp7_lens_red"] = "null"
}

ITEM.Weight 		= 3.3

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tar"
ITEM.ScrapItem 		= "parts_rifle"
