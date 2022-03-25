ITEM = class.Create("base_weapon")

ITEM.Name 			= "Uzi 9mm"
ITEM.Description 	= "Classic Israeli SMG. For some reason, infiltrators love using it."

ITEM.Model 			= Model("models/tnb/weapons/w_uzi.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 200
ITEM.SellPrice 				= 80

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_uzi"
ITEM.ScrapItem 		= "parts_smg"