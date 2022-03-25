ITEM = class.Create("base_weapon")

ITEM.Name 			= "APS"
ITEM.Description 	= "Automatic pistol chambered in 9x18mm"

ITEM.Model 			= Model("models/tnb/weapons/w_aps.mdl")

ITEM.Weight 		= 1
ITEM.Bodygroups 	= {0}

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_aps"
ITEM.ScrapItem 		= "parts_pistol"