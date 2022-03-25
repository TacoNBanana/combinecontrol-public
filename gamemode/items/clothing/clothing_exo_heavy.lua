ITEM = class.Create("base_clothing")

ITEM.Name 				= "Exoskeleton - 3rd Gen Combat Chasis"
ITEM.Description 		= "Experimental infantry suit designed to allow soldiers to compete with drones in close combat."

ITEM.Model				= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd			= 400
ITEM.DamageReduction	= 20

ITEM.Weight 			= 8

ITEM.Slots 				= {EQUIPMENT_EXO}

ITEM.ModelData 			= {}
ITEM.ModelData.model 	= Model("models/tnb/techcom/exoskeleton_heavy.mdl")

function ITEM:GetSpeeds(ply, w, r, j, c)
	return w * 0.75, r * 0.75, j, c
end