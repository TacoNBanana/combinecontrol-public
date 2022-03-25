ITEM = class.Create("base_weapon")

ITEM.Name 			= "M72 LAW"
ITEM.Description 	= "Vintage American Anti-tank launcher."

ITEM.Model 			= Model("models/tnb/trpweapons/w_law.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 800
ITEM.SellPrice 				= 200

ITEM.Weight 		= 2

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_law"
ITEM.ScrapItem 		= "parts_explosive"