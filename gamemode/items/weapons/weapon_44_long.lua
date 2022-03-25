ITEM = class.Create("base_weapon")

ITEM.Name 			= ".44 Magnum Long"
ITEM.Description 	= "A Smith & Wesson revolver chambered for .44 magnum rounds. Long barreled. You could probably take somebodies eye out with the barrel."

ITEM.Model 			= Model("models/tnb/weapons/w_magnum.mdl")
ITEM.Bodygroups 	= {1}

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 1000
ITEM.SellPrice 				= 400

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_44_long"
ITEM.ScrapItem 		= "parts_pistol"