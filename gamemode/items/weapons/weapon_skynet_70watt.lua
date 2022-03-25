ITEM = class.Create("base_weapon")

ITEM.Name 			= "V-60H"
ITEM.Description 	= "A heavy plasma rifle designed by SkyNET.\n\nIt features some kind of electronic lockout mechanism, preventing unauthorized users from firing it."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_skynet_70watt.mdl")

ITEM.Materials 		= {
	["models/tnb/trpweapons/skynet_40watt_1"] = "null",
}

ITEM.Weight 		= 5.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_skynet_70watt"
