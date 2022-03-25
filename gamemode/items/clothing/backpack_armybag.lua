ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Army Bag"
ITEM.Description 			= "A large green rucksack."

ITEM.Model					= Model("models/tnb/items/shared/item_baul_vkbo.mdl")

-- Effective CarryAdd: 9
ITEM.Weight 				= 2
ITEM.CarryAdd 				= 10

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_baul_vkbo_body_lod0.mdl"
		}
	end
end
