ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Navy BDU"
ITEM.Description 			= "An old combat uniform worn by a disbanded resistance cell. Navy pattern."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_bdu1.mdl")

ITEM.Weight 				= 3
ITEM.ArmorValue 			= 0

ITEM.Rig 					= true

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_bdu1.mdl", ply:Gender()),
		}
	end
end
