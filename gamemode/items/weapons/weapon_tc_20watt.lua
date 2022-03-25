ITEM = class.Create("base_weapon")

ITEM.Name 			= "TC-P20S"
ITEM.Description 	= "A small plasma submachine gun designed by Tech-Com.\n\nThe small size comes at a cost of it's power output, resulting in a plasma weapon that is only effective against the smallest of bots, or humans."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_20watt.mdl")

ITEM.Materials 		= {
	["models/tnb/trpweapons/readout_blu"] = "null",
	["models/tnb/trpweapons/readout2_blu"] = "null",
	["models/tnb/weapons/lens1"] = "null"
}

ITEM.Weight 		= 2.6

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_20watt"
