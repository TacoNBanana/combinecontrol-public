ITEM = class.Create("base_weapon")

ITEM.Name 			= "P90"
ITEM.Description 	= "Belgian SMG"

ITEM.Model 			= Model("models/tnb/weapons/w_p90.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 300
ITEM.SellPrice 				= 100

ITEM.Bodygroups 	= {2}
ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_p90"
ITEM.ScrapItem 		= "parts_smg"