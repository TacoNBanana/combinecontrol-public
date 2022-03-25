ITEM = class.Create("base_weapon")

ITEM.Name 			= "M4 Carbine"
ITEM.Description 	= "A carbine version of the M16 family of rifles."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["4"] = 1,
	["5"] = 4,
	["6"] = 2,
	["7"] = 8
}

ITEM.Weight 		= 3.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m4_carbine"
ITEM.ScrapItem 		= "parts_rifle"
