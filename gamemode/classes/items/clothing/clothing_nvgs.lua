ITEM = class.Create("base_clothing")

ITEM.Name 						= "Nightvision Goggles"
ITEM.Description 				= "Allows you to see in the dark, though you're going to need something to turn them on"

ITEM.Model						= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd					= 20
ITEM.DamageReduction			= 20

ITEM.FOV 						= 20
ITEM.CamPos 					= Vector(50, 50, 50)
ITEM.LookAt 					= Vector(0, 0, -10)

ITEM.Weight 					= 0.5

ITEM.Slots 						= {EQUIPMENT_HEAD}

ITEM.ModelData 					= {}
ITEM.ModelData.bg_headgear		= 5