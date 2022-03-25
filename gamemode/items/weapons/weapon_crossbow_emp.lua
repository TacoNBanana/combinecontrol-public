ITEM = class.Create("base_weapon")

ITEM.Name 			= "Crossbow with EMP Darts"
ITEM.Description 	= "Loaded with experimental bolts specifically designed to destroy Drones."

ITEM.Model 			= Model("models/tnb/weapons/w_crossbow.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= -1
ITEM.SellPrice 				= 500

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_crossbow_emp"
ITEM.ScrapItem 		= "parts_sniper"