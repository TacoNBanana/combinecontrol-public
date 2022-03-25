ITEM = class.Create("base_clothing")

ITEM.Name 					= "Pilot Uniform"
ITEM.Description 			= "Air crew outfit with chest rig."

ITEM.Model					= Model("models/tnb/trpitems/rebelkit.mdl")

ITEM.ArmorAdd				= 150
ITEM.DamageReduction		= 30

ITEM.Weight 				= 2
ITEM.CarryAdd				= 15

ITEM.BusinessLicense 		= BUSINESS_QUARTERMASTER
ITEM.BuyPrice 				= 0
ITEM.SellPrice 				= 0

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_pilot.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_tc_recon.mdl")
