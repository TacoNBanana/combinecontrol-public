ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.Name 					= "Pilot Outfit"
ITEM.Description 			= "An old pilot outfit, fitted with a vest that contains various essentials."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_pilot.mdl")

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = "models/tnb/clothing/trp/body/male_pilot.mdl"
		}
	end
end
