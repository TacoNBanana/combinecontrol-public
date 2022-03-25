ITEM = class.Create("base_weapon")

ITEM.Name 			= "Automag"
ITEM.Description 	= "Heavy pistol."

ITEM.Model 			= Model("models/tnb/weapons/w_automag.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= -1
ITEM.SellPrice 				= 30

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_automag"
ITEM.ScrapItem 		= "parts_pistol"