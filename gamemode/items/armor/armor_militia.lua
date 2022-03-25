ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.Name 					= "Scavengers Vest"
ITEM.Description 			= "A random assortment of gear commonly worn by scavengers."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_survivor_militia.mdl")

ITEM.Weight 				= 4
ITEM.ArmorValue 			= ARMOR.Light

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_survivor_militia.mdl", ply:Gender()),
		}
	end
end
