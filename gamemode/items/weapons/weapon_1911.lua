ITEM = class.Create("base_weapon")

ITEM.Name 			= "Colt 1911"
ITEM.Description 	= "Classic American pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_1911.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 300
ITEM.SellPrice 				= 100

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_1911"
ITEM.ScrapItem 		= "parts_pistol"