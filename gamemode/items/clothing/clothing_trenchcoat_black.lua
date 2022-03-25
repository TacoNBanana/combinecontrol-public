ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Trenchcoat"
ITEM.Description 			= "A heavy black trenchcoat."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_marcus.mdl")

ITEM.Weight 				= 3
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_marcus.mdl", ply:Gender())
		}
	end
end
