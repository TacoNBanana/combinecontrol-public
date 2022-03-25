ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tech-Com Jury-Rigged STEN-BLASTER"
ITEM.Description 	= "Also known as the 'Plumbers pipe gun'."

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_sten.mdl")

ITEM.FOV 			= 20
ITEM.CamPos 		= Vector(50, 50, 50)
ITEM.LookAt 		= Vector(0, 0, 0)

ITEM.Weight 		= 2

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_sten"
ITEM.ScrapItem 		= "parts_plasma"