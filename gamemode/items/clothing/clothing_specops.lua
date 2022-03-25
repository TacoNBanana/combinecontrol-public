ITEM = class.Create("base_clothing")

ITEM.Name 					= "Specops Uniform"
ITEM.Description 			= "Upgraded combat gear with advanced kevlar plating and rigging."

ITEM.Model					= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd				= 250
ITEM.DamageReduction		= 50

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= -1
ITEM.SellPrice 				= 1000

ITEM.Weight 				= 1
ITEM.CarryAdd				= 30

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_specops.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_specops.mdl")
