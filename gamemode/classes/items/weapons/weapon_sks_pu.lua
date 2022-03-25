ITEM = class.Create("base_weapon")

ITEM.Name 			= "SKS with PU Scope"
ITEM.Description 	= "Semi Automatic rifle chambered in 7.62x39mm"

ITEM.Model 			= Model("models/tnb/weapons/w_sks.mdl")

ITEM.Weight 		= 6
ITEM.Bodygroups 	= {1}

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_sks_pu"
ITEM.ScrapItem 		= "parts_assault"