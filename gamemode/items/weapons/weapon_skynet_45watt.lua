ITEM = class.Create("base_weapon")

ITEM.Name 			= "V-45DC"
ITEM.Description 	= "A dual-function plasma carbine designed by SkyNET featuring a magazine-fed integrated 20mm grenade launcher.\n\nIt features some kind of electronic lockout mechanism, preventing unauthorized users from firing it."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_skynet_45watt.mdl")

ITEM.Materials 		= {
	["models/tnb/weapons/lens1"] = "null"
}

ITEM.Weight 		= 3.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_skynet_45watt"
