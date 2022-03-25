ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Medic Bag"
ITEM.Description 			= "A low-profile messenger bag specifically designed for carrying first-aid supplies. Marked with a red cross."

ITEM.Model					= Model("models/tnb/items/shared/item_medic.mdl")

-- Effective CarryAdd: 7.5
ITEM.Weight 				= 1
ITEM.CarryAdd 				= 8

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_medic.mdl"
		}
	end
end
