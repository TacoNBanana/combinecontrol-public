ITEM = class.Create("base_weapon")

ITEM.Name 			= "Lee Enfield"
ITEM.Description 	= "Bolt action rifle chambered in 7.62x39mm"

ITEM.Model 			= Model("models/tnb/weapons/w_enfield.mdl")

ITEM.Weight 		= 5
ITEM.Bodygroups 	= {0}

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_enfield"
ITEM.ScrapItem 		= "parts_sniper"