ITEM = class.Create("base_weapon")

ITEM.Name 			= "M4 Beowulf"
ITEM.Description 	= "A modified version of the M4 chambered in .50 Beowulf. More effective against terminators than you think."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["1"] = 1,
	["2"] = 10,
	["3"] = 3,
	["4"] = 2,
	["5"] = 5,
	["6"] = 2,
	["7"] = 5,
	["12"] = 1
}

ITEM.Weight 		= 3.7

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m4_beowulf"
ITEM.ScrapItem 		= "parts_rifle"
