ITEM = class.Create("base_weapon")

ITEM.Name 			= "PPSH41"
ITEM.Description 	= "WW2 SMG"

ITEM.Model 			= Model("models/tnb/weapons/w_ppsh.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 120
ITEM.SellPrice 				= 50

ITEM.Bodygroups 	= {0}
ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ppsh"
ITEM.ScrapItem 		= "parts_smg"