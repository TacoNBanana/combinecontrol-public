ITEM = class.Create("base_weapon")

ITEM.Name 			= "V-40"
ITEM.Description 	= "A phased plasma rifle designed by SkyNET.\n\nDesigned to only be usable by terminators the weapon doesn't feature any type of external controls, trigger or otherwise."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_skynet_40watt.mdl")

ITEM.Materials 		= {
	["models/tnb/weapons/lens1"] = "null"
}

ITEM.Weight 		= 4.5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_skynet_40watt"
