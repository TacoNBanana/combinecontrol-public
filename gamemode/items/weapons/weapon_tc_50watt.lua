ITEM = class.Create("base_weapon")

ITEM.Name 			= "TC-P50R"
ITEM.Description 	= "An experimental conversion of a long-range SkyNET plasma rifle. Features a fixed medium-range scope and low rate of fire."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_skynet_50watt.mdl")

ITEM.Materials 		= {
	["models/tnb/trpweapons/aim_red"] = "models/tnb/trpweapons/aim_red_trans"
}

ITEM.Weight 		= 4.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_50watt"
