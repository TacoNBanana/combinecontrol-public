ITEM = class.Create("base_weapon")

ITEM.Name 			= "Ruger Mk.II"
ITEM.Description 	= "Classic large calibre pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_ruger.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 200
ITEM.SellPrice 				= 100

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ruger"
ITEM.ScrapItem 		= "parts_pistol"