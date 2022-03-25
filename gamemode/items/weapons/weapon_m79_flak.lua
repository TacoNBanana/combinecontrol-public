ITEM = class.Create("base_weapon")

ITEM.Name 			= "M79 Flak Canon"
ITEM.Description 	= "Kind of like an AA gun, but much much smaller and kinda silly."

ITEM.Model 			= Model("models/tnb/weapons/w_m79.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 1000
ITEM.SellPrice 				= 400

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 2

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_m79_flak"
ITEM.ScrapItem 		= "parts_explosive"