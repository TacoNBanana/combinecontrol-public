ITEM = class.Create("base_weapon")

ITEM.Name 			= "TC-P40"
ITEM.Description 	= "A standard infantry plasma rifle designed for human use, features a steady and controllable rate of fire."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_35watt.mdl")

ITEM.Materials 		= {
	[0] = "models/tnb/trpweapons/aim_red_trans"
}

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_40watt"
