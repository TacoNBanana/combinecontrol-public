ITEM = class.Create("base_weapon")

ITEM.Name 			= "SMK-1 35MW"
ITEM.Description 	= "A Sentinel designed plasma rifle based on a DMR role."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_carabine.mdl")

ITEM.Materials 		= {
	["models/tnb/trpweapons/readout2_blu"] = "null",
	["models/tnb/trpweapons/tc_50watt_holo_1"] = "null"
}

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_sentinel_35watt"
