ITEM = class.Create("base_weapon")

ITEM.Name 			= "PTRS-41 Anti Tank Rifle"
ITEM.Description 	= "Vintage Russian AT weapon."

ITEM.Model 			= Model("models/tnb/weapons/w_ptrs41.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 2000
ITEM.SellPrice 				= 800

ITEM.Weight 		= 10

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ptrs41"
ITEM.ScrapItem 		= "parts_sniper"