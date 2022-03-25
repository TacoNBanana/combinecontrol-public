ITEM = class.Create("base_weapon")

ITEM.Name 			= "M4 Beowulf"
ITEM.Description 	= "American special forces assault rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_m4.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 1200
ITEM.SellPrice 				= 500

ITEM.Bodygroups 	= {5}

ITEM.Weight 		= 2

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_m4_beowulf"
ITEM.ScrapItem 		= "parts_assault"