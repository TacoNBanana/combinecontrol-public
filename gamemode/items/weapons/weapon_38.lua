ITEM = class.Create("base_weapon")

ITEM.Name 			= ".38 Revolver"
ITEM.Description 	= "A Smith & Wesson revolver"

ITEM.Model 			= Model("models/tnb/weapons/w_38.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 300
ITEM.SellPrice 				= 100

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_38"
ITEM.ScrapItem 		= "parts_pistol"

ITEM.SellConditionMult         = {
    [CONDITION_GOOD] = 1,
    [CONDITION_DAMAGED] = 0.75,
    [CONDITION_HEAVILYDAMAGED] = 0.5,
    [CONDITION_BROKEN] = 0.25
}