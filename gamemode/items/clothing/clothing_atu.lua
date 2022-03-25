ITEM = class.Create("base_clothing")

ITEM.Name 					= "44th ATU Kit"
ITEM.Description 			= "Specialist infantry loadout incorporating combat vest, kevlar and rigging."

ITEM.Model					= Model("models/tnb/trpitems/vest.mdl")

ITEM.ArmorAdd				= 150
ITEM.DamageReduction		= 20

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 3000
ITEM.SellPrice 				= 500

ITEM.Weight 				= 2
ITEM.CarryAdd				= 15

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_desert.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_desert.mdl")