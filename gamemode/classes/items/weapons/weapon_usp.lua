ITEM = class.Create("base_weapon")

ITEM.Name 			= "USP"
ITEM.Description 	= "Semi-automatic pistol chambered in .45 ACP"

ITEM.Model 			= Model("models/tnb/weapons/w_usp.mdl")

ITEM.Weight 		= 1

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_usp"
ITEM.ScrapItem 		= "parts_pistol"