ITEM = class.Create("base_consumable")

ITEM.Name 			= "Beer"
ITEM.Description 	= "A bottle of skunky piss water."

ITEM.Model			= "models/props_junk/garbage_glassbottle003a.mdl"

ITEM.Weight 		= 0.3

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Drink"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Drink")
	end
end
