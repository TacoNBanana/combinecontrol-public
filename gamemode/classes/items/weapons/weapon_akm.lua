ITEM = class.Create("base_weapon")

ITEM.Name 			= "AKM"
ITEM.Description 	= "Automatic rifle chambered in 7.62x39mm"

ITEM.Model 			= Model("models/tnb/weapons/w_akm.mdl")

ITEM.Weight 		= 5
ITEM.Bodygroups 	= {0}

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_akm"
ITEM.ScrapItem 		= "parts_assault"