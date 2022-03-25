ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Casual Outfit"
ITEM.Description 			= "A light grey shirt, paired with jeans and elbow pads."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_casual.mdl")

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_casual.mdl", ply:Gender())
		}
	end
end
