ITEM = class.Create("base_consumable")

ITEM.Name 			= "Powdered milk"
ITEM.Description 	= "A resealable container containing shelf-stable powdered milk. To use mix 1 part water with 1/4th part powdered milk."

ITEM.Model			= "models/props_lab/jar01b.mdl"

ITEM.Weight 		= 0.4

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Eat"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Eat")
	end
end
