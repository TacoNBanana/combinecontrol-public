ITEM = class.Create("base_weapon")

ITEM.Name 			= "AK74u"
ITEM.Description 	= "Cold war era Russian assault carbine."

ITEM.Model 			= Model("models/tnb/weapons/w_ak74u.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 150
ITEM.SellPrice 				= 100

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ak74u"
ITEM.ScrapItem 		= "parts_assault"