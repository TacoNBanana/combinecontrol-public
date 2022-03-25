ITEM = class.Create("base_weapon")

ITEM.Name 			= "V-50R"
ITEM.Description 	= "A long-range plasma rifle designed by SkyNET.\n\nIt features some kind of electronic lockout mechanism, preventing unauthorized users from firing it."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_skynet_45watt.mdl")

ITEM.Materials 		= {
	["models/tnb/trpweapons/aim_red"] = "models/tnb/trpweapons/aim_red_trans"
}

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_skynet_50watt"
