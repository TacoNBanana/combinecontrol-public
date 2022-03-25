ITEM = class.Create("base_weapon")

ITEM.Name 			= "Thermal Imaging Device"
ITEM.Description 	= "Aiming this device allows you to scan for heat signatures."

ITEM.Model 			= Model("models/tnb/trpweapons/w_scanner.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 200
ITEM.SellPrice 				= 100

ITEM.Bodygroups 	= {0}

ITEM.Weight 		= 0.5

ITEM.Slots 			= {EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_scanner_thermal"