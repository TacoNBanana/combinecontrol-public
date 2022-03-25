ITEM = class.Create("base_weapon")

ITEM.Name 			= "M16 'Patriot'"
ITEM.Description 	= "A conversion of the M16 assault rifle originally designed for firing out of mounted APC's."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["2"] = 4,
	["4"] = 1,
	["5"] = 6,
	["6"] = 5,
	["7"] = 2
}

ITEM.Weight 		= 5.2

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m16_patriot"
ITEM.ScrapItem 		= "parts_rifle"
