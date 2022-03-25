ITEM = class.Create("base_consumable")

ITEM.Name 			= "MRE"
ITEM.Description 	= "A self-contained field ration that's outlasted the military that produced it."

ITEM.Model			= "models/illusion/eftcontainers/mre.mdl"

ITEM.Weight 		= 0.6

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Eat"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Eat")
	end
end
