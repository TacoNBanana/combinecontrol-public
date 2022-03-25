ITEM = class.Create("base_weapon")

ITEM.Name 			= "MP5"
ITEM.Description 	= "HK SMG"

ITEM.Model 			= Model("models/tnb/weapons/w_mp5.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 100
ITEM.SellPrice 				= 50

ITEM.Bodygroups 	= {1}
ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mp5"
ITEM.ScrapItem 		= "parts_smg"