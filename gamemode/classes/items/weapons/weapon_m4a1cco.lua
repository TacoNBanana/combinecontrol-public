ITEM = class.Create("base_weapon")

ITEM.Name 			= "M4A1 Scoped"
ITEM.Description 	= "Automatic rifle chambered in 5.56x45mm"

ITEM.Model 			= Model("models/tnb/weapons/w_m4.mdl")

ITEM.Weight 		= 5
ITEM.Bodygroups 	= {4}

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_m4a1cco"
ITEM.ScrapItem 		= "parts_assault"