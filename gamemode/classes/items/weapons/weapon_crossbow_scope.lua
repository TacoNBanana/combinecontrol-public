ITEM = class.Create("base_weapon")

ITEM.Name 			= "Crossbow with Scope"
ITEM.Description 	= "Modernised and silent."

ITEM.Model 			= Model("models/tnb/weapons/w_crossbow.mdl")

ITEM.Weight 		= 2

ITEM.Bodygroups 	= {1}

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_crossbow_scope"
ITEM.ScrapItem 		= "parts_pistol"