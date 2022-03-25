ITEM = class.Create("base_consumable")

ITEM.Name 			= "Crackers"
ITEM.Description 	= "A wrapper containing salted crackers."

ITEM.Model			= "models/illusion/eftcontainers/galette.mdl"

ITEM.Weight 		= 0.1

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Eat"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Snack")
	end
end
