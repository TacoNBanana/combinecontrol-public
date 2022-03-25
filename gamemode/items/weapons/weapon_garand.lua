ITEM = class.Create("base_weapon")

ITEM.Name 			= "M1 Garand"
ITEM.Description 	= "A vintage WW2 semi-automatic rifle."

ITEM.Model 			= Model("models/weapons/tfa_doi/w_m1garand_scoped.mdl")
ITEM.Materials 		= {
	[0] = "null",
	[2] = "null"
}

ITEM.Weight 		= 4.3

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_garand"
ITEM.ScrapItem 		= "parts_rifle"
