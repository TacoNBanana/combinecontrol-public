ITEM = class.Create("base_weapon")

ITEM.Name 			= "Mini Uzi"
ITEM.Description 	= "Automatic chambered in 9x19mm"

ITEM.Model 			= Model("models/tnb/weapons/w_uzi.mdl")

ITEM.Weight 		= 2.5
ITEM.Bodygroups 	= {3}

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_uzi_mini"
ITEM.ScrapItem 		= "parts_smg"