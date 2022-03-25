ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Tactical Bag"
ITEM.Description 			= "A small bag that slings around the hip, designed for easy access to tools or other supplies."

ITEM.Model					= Model("models/tnb/items/shared/item_tactical.mdl")

-- Effective CarryAdd: 9
ITEM.Weight 				= 2
ITEM.CarryAdd 				= 10

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_tactical_backpack_d.mdl"
		}
	end
end
