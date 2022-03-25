ITEM = class.Create("base_weapon")

ITEM.Name 			= "TC-P02"
ITEM.Description 	= "Prototype 2 - A plasma conversion of an M4 Carbine that's been modified to draw a lot more power per shot.\n\nThe lack of sights is intentional, as putting your face anywhere near the body of the weapon is guaranteed to result in a nasty burn."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_m4.mdl")

ITEM.Materials 		= {
	[10] = "null",
	[11] = "null"
}

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_jury_m4"
