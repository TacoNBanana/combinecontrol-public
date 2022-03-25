ITEM = class.Create("base_weapon")

ITEM.Name 			= "TC-P03"
ITEM.Description 	= "Prototype 3 - The closest thing to an actual plasma rifle featuring both burst and (limited) full-auto capabilities.\n\nThe amount of heatsinks needed to keep the fuel cell's temperature in check during use means the weapon is too heavy to be practical."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_m249.mdl")

ITEM.Materials 		= {
	["models/tnb/trpweapons/readout2_blu"] = "null"
}

ITEM.Weight 		= 9

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_jury_m249"
