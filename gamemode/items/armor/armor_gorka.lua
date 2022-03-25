ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.Name 					= "Gorka Uniform"
ITEM.Description 			= "A very bulky combat uniform, almost entirely made up of armor."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_survivor_gorka.mdl")

ITEM.Weight 				= 9
ITEM.ArmorValue 			= ARMOR.Heavy

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_survivor_gorka.mdl", ply:Gender()),
		}
	end
end
