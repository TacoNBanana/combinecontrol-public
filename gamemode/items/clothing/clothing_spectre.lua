ITEM = class.Create("base_clothing")

ITEM.Name 					= "Sentinel Combat Rig"
ITEM.Description 			= "Specialist infantry loadout incorporating combat vest, kevlar and rigging."

ITEM.Model					= Model("models/tnb/trpitems/techcom_bravo.mdl")

ITEM.ArmorAdd				= 200
ITEM.DamageReduction		= 20

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= -1
ITEM.SellPrice 				= 200

ITEM.Weight 				= 1
ITEM.CarryAdd				= 20

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_spectre.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_spectre.mdl")