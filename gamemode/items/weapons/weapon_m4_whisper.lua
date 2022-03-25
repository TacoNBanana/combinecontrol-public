ITEM = class.Create("base_weapon")

ITEM.Name 			= "M4A1 'Whisper'"
ITEM.Description 	= "A supressed version of the M4A1. Quiet but only has a 3-round burst."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["1"] = 1,
	["3"] = 3,
	["4"] = 3,
	["5"] = 9,
	["6"] = 5,
	["7"] = 5,
	["12"] = 2
}

ITEM.Weight 		= 3.7

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m4_whisper"
ITEM.ScrapItem 		= "parts_rifle"
