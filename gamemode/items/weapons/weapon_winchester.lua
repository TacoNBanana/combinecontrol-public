ITEM = class.Create("base_weapon")

ITEM.Name 			= "Winchester 1886"
ITEM.Description 	= "lever action rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_winchester.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 500
ITEM.SellPrice 				= 200

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_winchester"
ITEM.ScrapItem 		= "parts_sniper"