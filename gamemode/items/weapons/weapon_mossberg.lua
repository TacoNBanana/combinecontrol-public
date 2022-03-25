ITEM = class.Create("base_weapon")

ITEM.Name 			= "Mossberg"
ITEM.Description 	= "Pump action shotgun."

ITEM.Model 			= Model("models/tnb/weapons/w_mossberg.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 500
ITEM.SellPrice 				= 200

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mossberg"
ITEM.ScrapItem 		= "parts_shotgun"