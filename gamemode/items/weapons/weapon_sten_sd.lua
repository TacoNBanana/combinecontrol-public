ITEM = class.Create("base_weapon")

ITEM.Name 			= "Sten Gun SD"
ITEM.Description 	= "WW2 SMG"
ITEM.Bodygroups 	= {1}
ITEM.Model 			= Model("models/tnb/weapons/w_sten.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 120
ITEM.SellPrice 				= 40

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_sten_sd"
ITEM.ScrapItem 		= "parts_smg"