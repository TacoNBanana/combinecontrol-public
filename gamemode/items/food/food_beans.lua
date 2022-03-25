ITEM = class.Create("base_consumable")

ITEM.Name 			= "Canned Baked Beans"
ITEM.Description 	= "A dinged-up yet perfectly sealed can of baked beans."

ITEM.Model			= "models/props_junk/garbage_beancan01a.mdl"

ITEM.Weight 		= 0.8

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Eat"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Eat")
	end
end
