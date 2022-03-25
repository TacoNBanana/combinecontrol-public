ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Sling Bag"
ITEM.Description 			= "A small bag that goes over the shoulder."

ITEM.Model					= Model("models/tnb/items/shared/item_bp_rebel.mdl")

-- Effective CarryAdd: 5.5
ITEM.Weight 				= 1
ITEM.CarryAdd 				= 6

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_rebel.mdl"
		}
	end
end
