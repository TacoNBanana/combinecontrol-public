ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Work Shirt"
ITEM.Description 			= "A blue shirt paired with grey cargo pants."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_workshirt.mdl")

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_workshirt.mdl", ply:Gender())
		}
	end
end
