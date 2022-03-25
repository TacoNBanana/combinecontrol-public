ITEM = class.Create("base_clothing")

ITEM.Name 						= "Headset"
ITEM.Description 				= "ComTacs providing the user with radio communications. For walking and talking"

ITEM.Model						= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.FOV 						= 12
ITEM.CamPos 					= Vector(-50, -50, 50)
ITEM.LookAt 					= Vector(0, 0, 1.5)

ITEM.Weight 					= 1

ITEM.Slots 						= {EQUIPMENT_HEAD}

ITEM.ModelData 					= {}
ITEM.ModelData.bg_headgear 		= 2