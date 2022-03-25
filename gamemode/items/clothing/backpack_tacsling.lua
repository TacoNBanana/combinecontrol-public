ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Tan Sling Bag"
ITEM.Description 			= "A small sling bag meant for light loads."

ITEM.Model					= Model("models/tnb/items/shared/item_max_fuchs.mdl")

-- Effective CarryAdd: 9
ITEM.Weight 				= 2
ITEM.CarryAdd 				= 10

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_max_fuchs_body_lod0.mdl"
		}
	end
end
