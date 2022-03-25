ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Desert Combat Uniform"
ITEM.Description 			= "A standard military uniform with desert camouflage."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_survivor_desert.mdl")

ITEM.Weight 				= 3
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_survivor_desert.mdl", ply:Gender()),
		}
	end
end
