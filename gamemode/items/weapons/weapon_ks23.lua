ITEM = class.Create("base_weapon")

ITEM.Name 			= "KS23"
ITEM.Description 	= "Pump action shotgun."

ITEM.Model 			= Model("models/tnb/weapons/w_ks23.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 1000
ITEM.SellPrice 				= 500

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ks23"
ITEM.ScrapItem 		= "parts_shotgun"