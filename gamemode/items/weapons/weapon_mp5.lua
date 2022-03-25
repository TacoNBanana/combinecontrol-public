ITEM = class.Create("base_weapon")

ITEM.Name 			= "HK MP5A2"
ITEM.Description 	= "A common NATO submachine gun."

ITEM.Model 			= Model("models/tnb/weapons/w_mp5.mdl")

ITEM.Bodygroups 	= {
	upgrades = 1
}

ITEM.Weight 		= 3.1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mp5"
ITEM.ScrapItem 		= "parts_smg"
