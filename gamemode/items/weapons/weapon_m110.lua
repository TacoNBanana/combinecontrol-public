ITEM = class.Create("base_weapon")

ITEM.Name 			= "M110 SASS"
ITEM.Description 	= "A NATO semi-auto precision rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_m16.mdl")

ITEM.Bodygroups 	= {
	upgrades = 4
}

ITEM.Weight 		= 3.6

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m110"
ITEM.ScrapItem 		= "parts_sniper"
