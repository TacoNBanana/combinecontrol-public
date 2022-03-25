ITEM = class.Create("base_weapon")

ITEM.Name 			= "M202 Rocket Launcher"
ITEM.Description 	= "American AT launcher with 4 tubes."

ITEM.Model 			= Model("models/tnb/weapons/w_m202.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 5000
ITEM.SellPrice 				= 1000

ITEM.Weight 		= 10

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_rocketlauncher"
ITEM.ScrapItem 		= "parts_explosive"