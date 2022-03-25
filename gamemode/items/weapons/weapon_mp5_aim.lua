ITEM = class.Create("base_weapon")

ITEM.Name 			= "MP5 AIM"
ITEM.Description 	= "HK SMG"

ITEM.Model 			= Model("models/tnb/weapons/w_mp5.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 250
ITEM.SellPrice 				= 100

ITEM.Bodygroups 	= {3}
ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mp5_aim"
ITEM.ScrapItem 		= "parts_smg"