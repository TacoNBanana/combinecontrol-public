ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tokarev"
ITEM.Description 	= "Classic Russian pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_tokarev.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 200
ITEM.SellPrice 				= 50

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_tokarev"
ITEM.ScrapItem 		= "parts_pistol"