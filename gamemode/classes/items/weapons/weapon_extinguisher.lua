ITEM = class.Create("base_weapon")

ITEM.Name 			= "Fire extinguisher"
ITEM.Description 	= "Pretty useful at putting out fires."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/weapons/w_fire_extinguisher.mdl")

ITEM.Weight 		= 4

ITEM.AngOffset		= Angle(0.00, 180.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "weapon_extinguisher"