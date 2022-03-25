ITEM = class.Create("base_weapon")

ITEM.Name 			= "TC-P45C"
ITEM.Description 	= "A 45-watt plasma carbine designed for human use. Implements a 5-round burst firing system for a balance between firepower and heat dissipation."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_prototype.mdl")

ITEM.Materials 		= {
	[1] = "models/tnb/trpweapons/aim_red_trans"
}

ITEM.Weight 		= 3.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_45watt"
