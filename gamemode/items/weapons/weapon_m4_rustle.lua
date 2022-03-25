ITEM = class.Create("base_weapon")

ITEM.Name 			= "M4A1 'Rustle'"
ITEM.Description 	= "A supressed version of the M4A1 with it's gas system removed and chambered in .300 Blackout. Quiet but requires manual cycling of the action."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["1"] = 1,
	["2"] = 1,
	["3"] = 3,
	["4"] = 3,
	["5"] = 9,
	["6"] = 5,
	["7"] = 5,
	["12"] = 2
}

ITEM.Weight 		= 3.7

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m4_rustle"
ITEM.ScrapItem 		= "parts_rifle"
