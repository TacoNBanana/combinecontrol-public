ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Long-range Radio Receiver"
ITEM.Description 			= "A radio pack worn on the user's back, able to send and receive signals over long distances."

ITEM.Model					= Model("models/tnb/items/shared/item_radio.mdl")

-- Effective CarryAdd: 6
ITEM.Weight 				= 4
ITEM.CarryAdd 				= 8

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_radio.mdl"
		}
	end
end
