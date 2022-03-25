ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Grey Jacket"
ITEM.Description 			= "A bundled up grey hoodie and jeans."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_clearsky.mdl")
ITEM.Materials 				= {
	["models/tnb/techcom/torso_workshirt3"] = "models/tnb/techcom/torso_workshirt1"
}

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_clearsky.mdl", ply:Gender()),
			skin = 2
		}
	end
end
