ITEM = class.Create("base_weapon")

ITEM.Name 			= "Enfield with Scope"
ITEM.Description 	= "British WW2 Rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_enfield.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 800
ITEM.SellPrice 				= 300

ITEM.Bodygroups 	= {1}
ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_enfield_scope"
ITEM.ScrapItem 		= "parts_sniper"