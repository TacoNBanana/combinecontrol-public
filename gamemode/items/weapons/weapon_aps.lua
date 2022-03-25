ITEM = class.Create("base_weapon")

ITEM.Name 			= "APS"
ITEM.Description 	= "Russian pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_aps.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 500
ITEM.SellPrice 				= 30

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_aps"
ITEM.ScrapItem 		= "parts_pistol"