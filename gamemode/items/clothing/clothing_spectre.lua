ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Reconnaissance Kit"
ITEM.Description 			= "A set of lightweight clothes chosen for easy maneuvering."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_spectre.mdl")

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_spectre.mdl", ply:Gender())
		}
	end
end
