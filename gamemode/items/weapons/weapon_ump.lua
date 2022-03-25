ITEM = class.Create("base_weapon")

ITEM.Name 			= "HK UMP45"
ITEM.Description 	= "A common NATO submachine gun."

ITEM.Model 			= Model("models/tnb/weapons/w_ump.mdl")

ITEM.Bodygroups 	= {
	upgrades = 1
}
ITEM.Materials 		= {
	["models/tnb/weapons/frontgrip"] = "null",
	["models/tnb/weapons/glock/dot_red"] = "null"
}

ITEM.Weight 		= 2.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_ump"
ITEM.ScrapItem 		= "parts_smg"
