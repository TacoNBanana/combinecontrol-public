ITEM = class.Create("base_weapon")

ITEM.Name 			= "TC-P30C"
ITEM.Description 	= "Tech-Com's first mass-produced plasma design, featuring burst and full-auto capabilities in a compact carbine package.\n\nA sticker on the side warns you to keep your hands clear of the emergency exhaust ports. Probably for a good reason."
ITEM.UseCondition 	= false

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_30watt.mdl")

ITEM.Materials 		= {
	["models/tnb/trpweapons/readout2_blu"] = "null",
	["models/tnb/trpweapons/tc_rocketlauncher_1"] = "null",
	["models/tnb/skynet/t600_eye_glow2"] = "null"
}

ITEM.Weight 		= 3.6

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_30watt"
