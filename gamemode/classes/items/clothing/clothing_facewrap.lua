ITEM = class.Create("base_clothing")

ITEM.Name 						= "Facewrap"
ITEM.Description 				= "Red cloth wrap worn across the nose and mouth to conceal identity and keep sand out."

ITEM.Model						= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.FOV 						= 20
ITEM.CamPos 					= Vector(50, 50, 50)
ITEM.LookAt 					= Vector(0, 0, -10)

ITEM.Weight 					= 0.1

ITEM.Slots 						= {EQUIPMENT_HEAD}

ITEM.ModelData 					= {}
ITEM.ModelData.bg_headgear 		= 6