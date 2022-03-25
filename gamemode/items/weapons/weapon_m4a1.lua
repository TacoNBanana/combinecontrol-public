ITEM = class.Create("base_weapon")

ITEM.Name 			= "M4A1"
ITEM.Description 	= "An upgraded version of the M4 Carbine that features both semi and full-auto firing modes."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["1"] = 1,
	["3"] = 3,
	["4"] = 1,
	["5"] = 5,
	["6"] = 2,
	["7"] = 8,
	["12"] = 1
}

ITEM.Weight 		= 3.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m4a1"
ITEM.ScrapItem 		= "parts_rifle"
