ITEM = class.Create("base_weapon")

ITEM.Name 			= "HK MP5-GL"
ITEM.Description 	= "A NATO submachine gun that's been extensively modified."

ITEM.Model 			= Model("models/tnb/weapons/w_mp5.mdl")

ITEM.Bodygroups 	= {
	upgrades = 4
}
ITEM.Materials 		= {
	[17] = "null"
}

ITEM.Weight 		= 3.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mp5_m203"
ITEM.ScrapItem 		= "parts_smg"
