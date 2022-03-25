ITEM = class.Create("base_weapon")

ITEM.Name 			= "TC-P01"
ITEM.Description 	= "Prototype 1 - A crude amalgamation of an old WW2 submachine gun and the internals of one of SkyNET's plasma rifles.\n\nThere's a warning sticker applied to the exposed fuel cell, it reads:\n\nDO NOT OVERHEAT\nFUEL CELL RUPTURE CAN BE FATAL"
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_sten.mdl")

ITEM.Weight 		= 3.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_jury_sten"
