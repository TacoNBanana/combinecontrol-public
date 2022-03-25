ITEM = class.Create("base_weapon")

ITEM.Name 			= "Pattern 19 CMP"
ITEM.Description 	= "A compact machine pistol issued to AOF personnel."

ITEM.Model 			= Model("models/weapons/arccw/w_bo2_chicom.mdl")

ITEM.Bodygroups 	= {
	["3"] = 2
}

ITEM.Weight 		= 1.4

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_aof_chicom"
ITEM.ScrapItem 		= true
