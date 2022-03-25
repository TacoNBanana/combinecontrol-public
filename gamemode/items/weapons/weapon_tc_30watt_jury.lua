ITEM = class.Create("base_weapon")

ITEM.Name 			= "Tech-Com 30-Watt Jury-Rigged Plasma Rifle"
ITEM.Description 	= "Experimental Tech-Com plasma rifle, uses plasma cells as ammunition"

ITEM.Model 			= Model("models/tnb/weapons/w_airgun.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 1000
ITEM.SellPrice 				= 400

ITEM.Weight 		= 5

ITEM.Slots 			= {EQUIPMENT_PRIMARY}

ITEM.Weapon 		= "trp_tc_30watt_jury"
ITEM.ScrapItem 		= "parts_plasma"