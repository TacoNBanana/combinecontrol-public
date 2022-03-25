ITEM = class.Create("base_clothing")

ITEM.Name 				= "Exoskeleton - 4th Gen Mid Chasis"
ITEM.Description 		= "Experimental infantry suit designed to allow soldiers to compete with drones in close combat."

ITEM.Model				= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd			= 350
ITEM.DamageReduction	= 15

ITEM.Weight 			= 5

ITEM.Slots 				= {EQUIPMENT_EXO}

ITEM.ModelData 			= {}
ITEM.ModelData.model 	= Model("models/tnb/techcom/exoskeleton_mid.mdl")

function ITEM:GetSpeeds(ply, w, r, j, c)
	return w * 0.8, r * 0.8, j, c
end