ITEM = class.Create("base_weapon")

ITEM.Name 			= "Makarov PB"
ITEM.Description 	= "Compact silent pistol chambered in 9x18mm"

ITEM.Model 			= Model("models/tnb/weapons/w_makarov_pb.mdl")

ITEM.Weight 		= 0.4

ITEM.IconFOV 		= 2.00
ITEM.CamOffset 		= Vector(2.50, -1.00, 0.00)

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_makarov_pb"
ITEM.ScrapItem 		= "parts_pistol"