ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tokarev TT"
ITEM.Description 	= "Semi-automatic pistol chambered in 7.62x25mm"

ITEM.Model 			= Model("models/tnb/weapons/w_tokarev.mdl")

ITEM.Weight 		= 1

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_tokarev"
ITEM.ScrapItem 		= "parts_pistol"