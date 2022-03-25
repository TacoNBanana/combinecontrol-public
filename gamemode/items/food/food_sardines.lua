ITEM = class.Create("base_consumable")

ITEM.Name 			= "Canned Sardines"
ITEM.Description 	= "A small circular can that's packed with the salty fish."

ITEM.Model			= "models/illusion/eftcontainers/dogfood.mdl"

ITEM.Weight 		= 0.2

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Eat"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Eat")
	end
end
