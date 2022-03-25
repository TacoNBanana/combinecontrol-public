ITEM = class.Create("base_clothing")

ITEM.Name 					= "Combat Kit with Liberator Rig"
ITEM.Description 			= "Combination of millitary BDUs, shell jacket and a modern desert rig with kevlar."

ITEM.Model					= Model("models/tnb/trpitems/vest.mdl")

ITEM.ArmorAdd				= 200
ITEM.DamageReduction		= 40

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 1000
ITEM.SellPrice 				= 300

ITEM.Weight 				= 2
ITEM.CarryAdd				= 15

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_jacketkevlar.mdl")


ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_jacketkevlar.mdl")
