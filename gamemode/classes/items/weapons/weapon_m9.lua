ITEM = class.Create("base_weapon")

ITEM.Name 			= "M9"
ITEM.Description 	= "Semi-automatic pistol chambered in 9x19mm"

ITEM.Model 			= Model("models/tnb/weapons/w_m9.mdl")

ITEM.Weight 		= 1

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_m9"
ITEM.ScrapItem 		= "parts_pistol"