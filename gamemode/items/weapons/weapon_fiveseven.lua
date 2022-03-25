ITEM = class.Create("base_weapon")

ITEM.Name 			= "FN Five-Seven"
ITEM.Description 	= "Modern sidearm."

ITEM.Model 			= Model("models/weapons/w_pist_fiveseven.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 80
ITEM.SellPrice 				= 30

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_fiveseven"
ITEM.ScrapItem 		= "parts_pistol"