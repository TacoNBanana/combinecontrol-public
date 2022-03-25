ITEM = class.Create("base_weapon")

ITEM.Name 			= "M60E4"
ITEM.Description 	= "A modernized vietnam-era light machine gun."

ITEM.Model 			= Model("models/tnb/weapons/w_m60.mdl")

ITEM.Bodygroups 	= {
	upgrades = 1
}

ITEM.Weight 		= 10

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m60"
ITEM.ScrapItem 		= "parts_lmg"
