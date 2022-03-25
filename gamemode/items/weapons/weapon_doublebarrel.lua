ITEM = class.Create("base_weapon")

ITEM.Name 			= "Double Barrel Shotgun"
ITEM.Description 	= "Double barrel sawnoff"

ITEM.Model 			= Model("models/tnb/weapons/w_sawnoff.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 800
ITEM.SellPrice 				= 300

ITEM.Bodygroups 	= {0}

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_doublebarrel"
ITEM.ScrapItem 		= "parts_shotgun"