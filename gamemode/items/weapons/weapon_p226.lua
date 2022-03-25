ITEM = class.Create("base_weapon")

ITEM.Name 			= "Sig P226"
ITEM.Description 	= "Compact pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_p220.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 50
ITEM.SellPrice 				= 30

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_p226"
ITEM.ScrapItem 		= "parts_pistol"