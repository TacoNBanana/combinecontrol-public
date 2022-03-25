ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.Name 					= "SWAT Uniform"
ITEM.Description 			= "An oversized protective vest, fairly aged."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_fear.mdl")

ITEM.Weight 				= 7
ITEM.ArmorValue 			= ARMOR.Medium

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_fear.mdl", ply:Gender()),
		}
	end
end
