ITEM = class.Create("base_weapon")

ITEM.Name 			= "AKsuN Kobra"
ITEM.Description 	= "Cold war era Russian assault carbine."

ITEM.Model 			= Model("models/tnb/weapons/w_ak74u.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 300
ITEM.SellPrice 				= 150

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ak74un"
ITEM.ScrapItem 		= "parts_assault"