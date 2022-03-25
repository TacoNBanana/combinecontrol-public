ITEM = class.Create("base_weapon")

ITEM.Name 			= "SKS with PU Scope"
ITEM.Description 	= "Cold war era Russian rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_sks.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 150
ITEM.SellPrice 				= 50

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_sks_scope"
ITEM.ScrapItem 		= "parts_assault"