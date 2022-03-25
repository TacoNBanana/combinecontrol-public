ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.Name 					= "Fur Lined Jacket"
ITEM.Description 			= "A rustic sailor outfit designed to beat out the freezing cold climates."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_balkan.mdl")

ITEM.Weight 				= 5
ITEM.ArmorValue 			= ARMOR.Light

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_balkan.mdl", ply:Gender()),
		}
	end
end
