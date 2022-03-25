ITEM = class.Create("base_weapon")

ITEM.Name 			= "HK G36C M203"
ITEM.Description 	= "A common NATO assault rifle that's been modified with an underslung grenade launcher."

ITEM.Model 			= Model("models/tnb/weapons/w_g36c.mdl")

ITEM.Bodygroups 	= {
	upgrades = 2
}
ITEM.Materials 		= {
	["models/tnb/weapons/acog"] = "null",
	["models/tnb/weapons/glock/dot_red"] = "null"
}

ITEM.Weight 		= 3.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_g36c_m203"
ITEM.ScrapItem 		= "parts_rifle"
