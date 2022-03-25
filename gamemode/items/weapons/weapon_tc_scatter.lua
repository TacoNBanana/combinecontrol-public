ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tech-Com Scattergun"
ITEM.Description 	= "Heavy Plasma Shotgun."

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_turok.mdl")

ITEM.FOV 			= 20
ITEM.CamPos 		= Vector(50, 50, 50)
ITEM.LookAt 		= Vector(0, 0, 0)

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_scatter"
ITEM.ScrapItem 		= "parts_plasma"