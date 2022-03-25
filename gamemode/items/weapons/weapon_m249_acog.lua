ITEM = class.Create("base_weapon")

ITEM.Name 			= "M249 ACOG"
ITEM.Description 	= "American military Light Machinegun."

ITEM.Model 			= Model("models/tnb/weapons/w_m249.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 900
ITEM.SellPrice 				= 300

ITEM.Bodygroups 	= {2}

ITEM.Weight 		= 6

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m249_acog"
ITEM.ScrapItem 		= "parts_lmg"