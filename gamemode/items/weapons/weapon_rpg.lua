ITEM = class.Create("base_weapon")

ITEM.Name 			= "RPG-7"
ITEM.Description 	= "Vintage Russian Anti-tank launcher."

ITEM.Model 			= Model("models/tnb/weapons/w_rpg7.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 800
ITEM.SellPrice 				= 200

ITEM.Weight 		= 7

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_rpg"
ITEM.ScrapItem 		= "parts_explosive"