ITEM = class.Create("base_weapon")

ITEM.Name 			= "Glock17"
ITEM.Description 	= "Semi-automatic pistol chambered in 9x19mm"

ITEM.Model 			= Model("models/tnb/weapons/w_glock.mdl")

ITEM.Weight 		= 0.5

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_glock17"
ITEM.ScrapItem 		= "parts_pistol"