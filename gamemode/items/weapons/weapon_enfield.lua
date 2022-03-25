ITEM = class.Create("base_weapon")

ITEM.Name 			= "Enfield"
ITEM.Description 	= "British WW2 Rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_enfield.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 500
ITEM.SellPrice 				= 200

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_enfield"
ITEM.ScrapItem 		= "parts_sniper"