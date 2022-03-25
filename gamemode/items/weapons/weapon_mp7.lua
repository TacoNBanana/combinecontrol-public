ITEM = class.Create("base_weapon")

ITEM.Name 			= "HK MP7A1"
ITEM.Description 	= "A common NATO personal defense weapon."

ITEM.Model 			= Model("models/weapons/arccw/c_bo2_mp7.mdl")

ITEM.Bodygroups 	= {
	["3"] = 2
}
ITEM.Weight 		= 2.1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mp7"
ITEM.ScrapItem 		= "parts_smg"
