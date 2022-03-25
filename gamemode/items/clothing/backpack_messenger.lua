ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Messenger Bag"
ITEM.Description 			= "An old postman's messenger bag, slung around the back."

ITEM.Model					= Model("models/tnb/items/shared/item_bp_rebel2.mdl")

-- Effective CarryAdd: 7.5
ITEM.Weight 				= 1
ITEM.CarryAdd 				= 8

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_rebel2.mdl"
		}
	end
end
