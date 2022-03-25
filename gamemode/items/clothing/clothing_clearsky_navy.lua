ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Blue Jacket"
ITEM.Description 			= "A bundled up navy hoodie and jeans."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_clearsky.mdl")

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_clearsky.mdl", ply:Gender()),
		}
	end
end
