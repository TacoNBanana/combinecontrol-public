ITEM = class.Create("base_weapon")

ITEM.Name 			= ".44 Magnum"
ITEM.Description 	= "A Smith & Wesson revolver chambered for .44 magnum rounds."

ITEM.Model 			= Model("models/tnb/weapons/w_magnum.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 800
ITEM.SellPrice 				= 300

ITEM.Weight 		= 2

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_44"
ITEM.ScrapItem 		= "parts_pistol"