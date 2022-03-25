ITEM = class.Create("base_weapon")

ITEM.Name 			= "AEK SD Kobra"
ITEM.Description 	= "Modern Russian assault carbine."

ITEM.Model 			= Model("models/tnb/weapons/w_aek.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 700
ITEM.SellPrice 				= 300

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_aek_sd"
ITEM.ScrapItem 		= "parts_assault"