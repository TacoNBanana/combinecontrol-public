ITEM = class.Create("base_clothing")

ITEM.Name 					= "Tech-Com Bravo Squad Uniform"
ITEM.Description 			= "Standard infantry loadout incorporating combat vest, kevlar and rigging."

ITEM.Model					= Model("models/tnb/trpitems/techcom_bravo.mdl")

ITEM.ArmorAdd				= 200
ITEM.DamageReduction		= 30

ITEM.Weight 				= 2
ITEM.CarryAdd				= 15

ITEM.BusinessLicense 		= BUSINESS_QUARTERMASTER
ITEM.BuyPrice 				= 0
ITEM.SellPrice 				= 0

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_tc_infantry.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_tc_infantry.mdl")
