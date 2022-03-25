ITEM = class.Create("base_weapon")

ITEM.Name 			= "AKS"
ITEM.Description 	= "Cold war era Russian assault rifle."

ITEM.Model 			= Model("models/tnb/weapons/w_akm_classic.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 300
ITEM.SellPrice 				= 100

ITEM.Bodygroups 	= {1}

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_akm_aks"
ITEM.ScrapItem 		= "parts_assault"