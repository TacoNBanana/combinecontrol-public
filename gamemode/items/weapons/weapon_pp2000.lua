ITEM = class.Create("base_weapon")

ITEM.Name 			= "PP2000"
ITEM.Description 	= "Russian SMG"

ITEM.Model 			= Model("models/tnb/weapons/w_pp2000.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 300
ITEM.SellPrice 				= 100

ITEM.Bodygroups 	= {1}
ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_pp2000"
ITEM.ScrapItem 		= "parts_smg"