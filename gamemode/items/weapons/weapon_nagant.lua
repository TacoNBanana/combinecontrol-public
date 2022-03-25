ITEM = class.Create("base_weapon")

ITEM.Name 			= "Nagant Revolver"
ITEM.Description 	= "Russian revolver"

ITEM.Model 			= Model("models/tnb/weapons/w_nagant.mdl")

ITEM.BusinessLicense 		= BUSINESS_WEAPONRY
ITEM.BuyPrice 				= 200
ITEM.SellPrice 				= 40

ITEM.Weight 		= 1

ITEM.Slots 			= {EQUIPMENT_PRIMARY, EQUIPMENT_SECONDARY}

ITEM.Weapon 		= "trp_nagant"
ITEM.ScrapItem 		= "parts_pistol"

ITEM.SellConditionMult         = {
    [CONDITION_GOOD] = 1,
    [CONDITION_DAMAGED] = 0.75,
    [CONDITION_HEAVILYDAMAGED] = 0.5,
    [CONDITION_BROKEN] = 0.25
}