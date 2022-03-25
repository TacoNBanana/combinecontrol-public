ITEM = class.Create("base_weapon")

ITEM.Name 			= "Colt .45 Longslide"
ITEM.Description 	= "Classic American pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_45.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= -1
ITEM.SellPrice 				= 1000

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_45"
ITEM.ScrapItem 		= "parts_pistol"