ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tech-Com Jury-Rigged M60"
ITEM.Description 	= "Special forces issue plasma rifle, with full auto capacity."

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_m60.mdl")

ITEM.FOV 			= 20
ITEM.CamPos 		= Vector(50, 50, 50)
ITEM.LookAt 		= Vector(0, 0, 0)

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_m60"
ITEM.ScrapItem 		= "parts_plasma"