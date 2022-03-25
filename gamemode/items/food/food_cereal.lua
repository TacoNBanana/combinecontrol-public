ITEM = class.Create("base_consumable")

ITEM.Name 			= "Cerceal"
ITEM.Description 	= "A cardboard box containing breakfast cereal. All that's missing is the milk."

ITEM.Model			= "models/illusion/eftcontainers/oatmeal.mdl"

ITEM.Weight 		= 1

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Eat"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Eat")
	end
end
