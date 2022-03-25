ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Drifter Clothes"
ITEM.Description 			= "A thick and durable black leather jacket and pants combo."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_drifter.mdl")
ITEM.Materials 				= {
	["models/tnb/techcom/body_connor1"] = "models/tnb/techcom/body_connor2"
}

ITEM.Weight 				= 2.5
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_drifter.mdl", ply:Gender()),
			skin = 1
		}
	end
end
