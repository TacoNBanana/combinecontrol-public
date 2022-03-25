ITEM = class.Create("base_weapon")

ITEM.Name 			= "HK MP5SD3"
ITEM.Description 	= "A suppressed version of the MP5A2 submachine gun."

ITEM.Model 			= Model("models/tnb/weapons/w_mp5.mdl")

ITEM.Bodygroups 	= {
	upgrades = 2
}

ITEM.Weight 		= 3.1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mp5_sd"
ITEM.ScrapItem 		= "parts_smg"
