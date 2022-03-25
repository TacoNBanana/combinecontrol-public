ITEM = class.Create("base_weapon")

ITEM.Name 			= "Crowbar"
ITEM.Description 	= "Good for opening crates and breaking into houses."

ITEM.Model 			= Model("models/weapons/w_crowbar.mdl")

ITEM.Weight 		= 1
ITEM.Bodygroups 	= {0}

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_crowbar"
