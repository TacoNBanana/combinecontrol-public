ITEM = class.Create("base_consumable")

ITEM.Name 			= "Water bottle (Filled)"
ITEM.Description 	= "A plastic bottle filled with drinkable water."

ITEM.Model			= "models/illusion/eftcontainers/waterbottle.mdl"

ITEM.Weight 		= 0.5

ITEM.CanUseSelf 	= true
ITEM.UseSelfName 	= "Drink"

if SERVER then
	function ITEM:OnUse(ply)
		ply:EmitSound("Food.Drink")

		ply:GiveItem("junk_waterbottle", 1)
	end
end
