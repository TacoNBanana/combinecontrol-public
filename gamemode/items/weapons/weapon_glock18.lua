ITEM = class.Create("base_weapon")

ITEM.Name 			= "Glock 18"
ITEM.Description 	= "Fully automatic sidearm."

ITEM.Model 			= Model("models/tnb/weapons/w_glock.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 100
ITEM.SellPrice 				= 50

ITEM.Bodygroups 	= {2}

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_glock18"
ITEM.ScrapItem 		= "parts_pistol"