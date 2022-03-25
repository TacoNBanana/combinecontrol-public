ITEM = class.Create("base_weapon")

ITEM.Name 			= "Mosin with PSO Scope"
ITEM.Description 	= "Russian WW2 Rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_mosin.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 700
ITEM.SellPrice 				= 300

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_mosin_pso"
ITEM.ScrapItem 		= "parts_sniper"