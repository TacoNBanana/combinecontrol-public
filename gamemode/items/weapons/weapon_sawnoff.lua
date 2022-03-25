ITEM = class.Create("base_weapon")

ITEM.Name 			= "Sawnoff Shotgun"
ITEM.Description 	= "Double barrel sawnoff"

ITEM.Model 			= Model("models/tnb/weapons/w_sawnoff.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 400
ITEM.SellPrice 				= 100

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 2

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_sawnoff"
ITEM.ScrapItem 		= "parts_shotgun"