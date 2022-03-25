ITEM = class.Create("base_weapon")

ITEM.Name 			= "Desert Eagle"
ITEM.Description 	= ".50Cal Pistol"

ITEM.Model 			= Model("models/tnb/weapons/w_deserteagle.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= -1
ITEM.SellPrice 				= 1000

ITEM.Weight 		= 2

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_deserteagle"
ITEM.ScrapItem 		= "parts_pistol"