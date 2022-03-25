ITEM = class.Create("base_weapon")

ITEM.Name 			= "V-30S"
ITEM.Description 	= "A compact plasma rifle designed by SkyNET.\n\nIt features some kind of electronic lockout mechanism, preventing unauthorized users from firing it."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_skynet_30watt.mdl")

ITEM.Materials 		= {
	["models/tnb/weapons/lens1"] = "null",
	["models/tnb/trpweapons/readout2_blu"] = "null",
	["models/tnb/trpweapons/readout_blu"] = "null"
}

ITEM.Weight 		= 3

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_skynet_30watt"
