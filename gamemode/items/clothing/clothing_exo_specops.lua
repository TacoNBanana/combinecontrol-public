ITEM = class.Create("base_clothing")

ITEM.Name 				= "Exoskeleton - 4th Gen Special Ops Chasis"
ITEM.Description 		= "Experimental infantry suit designed to allow soldiers to compete with drones in close combat."

ITEM.Model				= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd			= 375
ITEM.DamageReduction	= 18

ITEM.Weight 			= 4

ITEM.Slots 				= {EQUIPMENT_EXO}

ITEM.ModelData 			= {}
ITEM.ModelData.model 	= Model("models/tnb/techcom/exoskeleton_specops.mdl")

function ITEM:GetSpeeds(ply, w, r, j, c)
	return w * 0.9, r * 0.9, j, c
end

ITEM.NoFallDamage 	= true