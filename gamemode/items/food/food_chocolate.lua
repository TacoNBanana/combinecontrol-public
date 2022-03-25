ITEM = class.Create("base_consumable")

ITEM.Name 			= "Chocolate bar"
ITEM.Description 	= "An old wrapped chocolate bar. For when you really need a pick-me-up."

ITEM.Model			= "models/illusion/eftcontainers/slickers.mdl"

ITEM.Weight 		= 0.1

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Eat"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Snack")
	end
end
