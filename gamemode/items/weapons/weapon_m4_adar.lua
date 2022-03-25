ITEM = class.Create("base_weapon")

ITEM.Name 			= "ADAR 2-15"
ITEM.Description 	= "A civilian version of the M4 that's been limited to semi-auto only and features wooden furniture."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["1"] = 1,
	["3"] = 3,
	["4"] = 1,
	["5"] = 8,
	["6"] = 4,
	["7"] = 11,
	["8"] = 4,
	["12"] = 1
}

ITEM.Weight 		= 3.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m4_adar"
ITEM.ScrapItem 		= "parts_rifle"
