ITEM = class.Create("base_clothing")

ITEM.Name 					= "Tech-Com Charlie Squad Uniform"
ITEM.Description 			= "Favoured by engineers and other support roles, includes a combination of custom rigging and kevlar."

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
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_tc_support.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_tc_support.mdl")
