ITEM = class.Create("base_weapon")

ITEM.Name 			= "RPK"
ITEM.Description 	= "A russian light machine gun based on the AK pattern of rifles."

ITEM.Model 			= Model("models/tnb/weapons/w_akm.mdl")

ITEM.Bodygroups 	= {
	upgrades = 2
}

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_rpk"
ITEM.ScrapItem 		= "parts_lmg"
