ITEM = class.Create("base_weapon")

ITEM.Name 			= "Pattern 35 CAR"
ITEM.Description 	= "A compact assault rifle issued to AOF personnel."

ITEM.Model 			= Model("models/weapons/arccw/w_bo2_mtar.mdl")

ITEM.Bodygroups 	= {
	["4"] = 1
}

ITEM.Weight 		= 3.2

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_aof_mtar"
ITEM.ScrapItem 		= true
