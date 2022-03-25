ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tech-Com Jury-Rigged SCAR"
ITEM.Description 	= "Special forces issue plasma rifle, with full auto capacity."

ITEM.Model 			= Model("models/tnb/trpweapons/w_scar.mdl")

ITEM.FOV 			= 20
ITEM.CamPos 		= Vector(50, 50, 50)
ITEM.LookAt 		= Vector(0, 0, 0)

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_scar"
ITEM.ScrapItem 		= "parts_plasma"