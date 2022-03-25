ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Leather Jacket"
ITEM.Description 			= "A brown leather jacket."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_survivor_leatherjacket.mdl")

ITEM.Weight 				= 2.5
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_survivor_leatherjacket.mdl", ply:Gender())
		}
	end
end
