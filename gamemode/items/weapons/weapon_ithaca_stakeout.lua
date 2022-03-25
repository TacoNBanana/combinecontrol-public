ITEM = class.Create("base_weapon")

ITEM.Name 			= "Ithaca 37 Stakeout"
ITEM.Description 	= "Sawnoff shotgun."

ITEM.Model 			= Model("models/tnb/weapons/w_ithaca.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 300
ITEM.SellPrice 				= 100

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 2

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ithaca_stakeout"
ITEM.ScrapItem 		= "parts_shotgun"