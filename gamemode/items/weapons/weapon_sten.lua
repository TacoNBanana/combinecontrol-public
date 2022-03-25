ITEM = class.Create("base_weapon")

ITEM.Name 			= "Sten Gun"
ITEM.Description 	= "WW2 SMG"

ITEM.Model 			= Model("models/tnb/weapons/w_sten.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 80
ITEM.SellPrice 				= 40

ITEM.Bodygroups 	= {0}
ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_sten"
ITEM.ScrapItem 		= "parts_smg"