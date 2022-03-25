ITEM = class.Create("base_weapon")

ITEM.Name 			= "Skynet Plasma Blaster"
ITEM.Description 	= "Heavy Plasma Shotgun."

ITEM.Model 			= Model("models/tnb/trpweapons/w_skynet_shotgun.mdl")

ITEM.FOV 			= 20
ITEM.CamPos 		= Vector(50, 50, 50)
ITEM.LookAt 		= Vector(0, 0, 0)

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_skynet_shotgun"
ITEM.ScrapItem 		= "parts_plasma"