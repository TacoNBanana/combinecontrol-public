ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Leather Jacket"
ITEM.Description 			= "A black leather jacket."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_survivor_leatherjacket.mdl")

ITEM.Materials 				= {
	["models/tnb/techcom/torso_jackets1"] = "models/tnb/techcom/torso_jackets2"
}

ITEM.Weight 				= 2.5
ITEM.ArmorValue 			= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_survivor_leatherjacket.mdl", ply:Gender()),
			skin = 1
		}
	end
end
