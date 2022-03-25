ITEM = class.Create("base_weapon")

ITEM.Name 			= "Uzi SD"
ITEM.Description 	= "Classic Israeli SMG. For some reason, infiltrators love using it."

ITEM.Model 			= Model("models/tnb/weapons/w_uzi.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 200
ITEM.SellPrice 				= 80

ITEM.Bodygroups 	= {1}
ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_uzi_sd"
ITEM.ScrapItem 		= "parts_smg"