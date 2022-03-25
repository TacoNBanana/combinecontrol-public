ITEM = class.Create("base_weapon")

ITEM.Name 			= "PPK"
ITEM.Description 	= "Semi-automatic pistol chambered in 9x19mm"

ITEM.Model 			= Model("models/tnb/weapons/w_ppk.mdl")

ITEM.Weight 		= 0.2

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_ppk"
ITEM.ScrapItem 		= "parts_pistol"