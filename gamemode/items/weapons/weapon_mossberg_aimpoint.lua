ITEM = class.Create("base_weapon")

ITEM.Name 			= "Mossberg Tactical"
ITEM.Description 	= "Pump action shotgun."

ITEM.Model 			= Model("models/tnb/weapons/w_mossberg.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 600
ITEM.SellPrice 				= 200

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_mossberg_aimpoint"
ITEM.ScrapItem 		= "parts_shotgun"