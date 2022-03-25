ITEM = class.Create("base_weapon")

ITEM.Name 			= "M4A1 Tactical"
ITEM.Description 	= "An M4A1 that's been upgraded with aftermarket furniture and internals."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["1"] = 1,
	["3"] = 3,
	["4"] = 4,
	["5"] = 7,
	["6"] = 5,
	["7"] = 12,
	["12"] = 2
}

ITEM.Weight 		= 3.7

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m4_tactical"
ITEM.ScrapItem 		= "parts_rifle"
