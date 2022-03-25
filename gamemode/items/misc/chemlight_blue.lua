ITEM = class.Create("base_weapon")

ITEM.Name 			= "Chemlight"
ITEM.Description 	= "A single-use light source, crack and shake to activate."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/glowstick/stick.mdl")
ITEM.Color 			= Color(0, 161, 255)

ITEM.Weight 		= 0.2

ITEM.Slots 			= {EQUIPMENT_EQUIP1, EQUIPMENT_EQUIP2}

ITEM.Weapon 		= "trp_chemlight"
