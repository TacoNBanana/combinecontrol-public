ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tech-Com 30-Watt rifle"
ITEM.Description 	= "Lite-plasma Carbine with burst capacity."

ITEM.Model 			= Model("models/tnb/trpweapons/w_tc_30watt.mdl")

ITEM.BusinessLicense 		= {BUSINESS_WEAPONRY, BUSINESS_QUARTERMASTER}
ITEM.BuyPrice 				= 1200
ITEM.SellPrice 				= 500

ITEM.Weight 		= 4

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_tc_30watt"
ITEM.ScrapItem 		= "parts_plasma"