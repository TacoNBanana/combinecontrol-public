ITEM = class.Create("base_weapon")

ITEM.Name 			= "AK74"
ITEM.Description 	= "Cold war era Russian assault rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_ak74.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 200
ITEM.SellPrice 				= 100

ITEM.Bodygroups 	= {5}

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_ak74"
ITEM.ScrapItem 		= "parts_assault"