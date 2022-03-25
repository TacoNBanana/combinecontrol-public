ITEM = class.Create("base_weapon")

ITEM.Name 			= "Ithaca 37"
ITEM.Description 	= "Pump action shotgun."

ITEM.Model 			= Model("models/tnb/weapons/w_ithaca.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 300
ITEM.SellPrice 				= 100

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ithaca"
ITEM.ScrapItem 		= "parts_shotgun"