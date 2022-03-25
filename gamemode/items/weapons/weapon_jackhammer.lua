ITEM = class.Create("base_weapon")

ITEM.Name 			= "Jackhammer"
ITEM.Description 	= "Assault shotgun"

ITEM.Model 			= Model("models/tnb/weapons/w_jackhammer.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 3000
ITEM.SellPrice 				= 1000

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_jackhammer"
ITEM.ScrapItem 		= "parts_shotgun"