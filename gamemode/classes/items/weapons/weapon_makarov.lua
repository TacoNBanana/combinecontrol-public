ITEM = class.Create("base_weapon")

ITEM.Name 			= "Makarov"
ITEM.Description 	= "Compact pistol chambered in 9x18mm"

ITEM.Model 			= Model("models/tnb/weapons/w_makarov.mdl")

ITEM.Weight 		= 0.4

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_makarov"
ITEM.ScrapItem 		= "parts_pistol"