ITEM = class.Create("base_weapon")

ITEM.Name 			= "USP .45"
ITEM.Description 	= "Classic American pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_usp.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 60
ITEM.SellPrice 				= 30

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_usp"
ITEM.ScrapItem 		= "parts_pistol"