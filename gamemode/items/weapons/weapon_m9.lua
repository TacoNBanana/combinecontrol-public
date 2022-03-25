ITEM = class.Create("base_weapon")

ITEM.Name 			= "M9"
ITEM.Description 	= "American military pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_m9.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 50
ITEM.SellPrice 				= 30

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_m9"
ITEM.ScrapItem 		= "parts_pistol"