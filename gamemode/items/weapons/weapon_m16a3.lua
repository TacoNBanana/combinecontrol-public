ITEM = class.Create("base_weapon")

ITEM.Name 			= "M16A3"
ITEM.Description 	= "A widely used assault rifle chambered in 5.56x45mm. The A3 version features both semi and full-auto firing modes."

ITEM.Model 			= Model("models/weapons/arccw/c_ud_m16.mdl")

ITEM.Bodygroups 	= {
	["1"] = 1,
	["3"] = 3,
	["5"] = 2,
	["12"] = 1
}

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m16a3"
ITEM.ScrapItem 		= "parts_rifle"
