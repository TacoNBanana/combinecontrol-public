ITEM = class.Create("base_weapon")

ITEM.Name 			= "S&W Model 629"
ITEM.Description 	= "A classic double-action magnum revolver."

ITEM.Model 			= Model("models/tnb/weapons/w_magnum.mdl")

ITEM.Bodygroups 	= {
	upgrades = 1
}

ITEM.Weight 		= 1.2

ITEM.Slots 			= {EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_44"
ITEM.ScrapItem 		= "parts_revolver"
