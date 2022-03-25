ITEM = class.Create("base_weapon")

ITEM.Name 			= "MP7"
ITEM.Description 	= "HK SMG"

ITEM.Model 			= Model("models/tnb/weapons/w_mp7.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 1000
ITEM.SellPrice 				= 300

ITEM.Bodygroups 	= {3}
ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mp7"
ITEM.ScrapItem 		= "parts_smg"