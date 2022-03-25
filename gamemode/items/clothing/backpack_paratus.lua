ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Paratus Tactical Backpack"
ITEM.Description 			= "A large backpack capable of carrying a fair amount of weight."

ITEM.Model					= Model("models/tnb/items/shared/item_paratus.mdl")

-- Effective CarryAdd: 17.5
ITEM.Weight 				= 5
ITEM.CarryAdd 				= 20

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_paratus_3_day_body_lod0.mdl"
		}
	end
end
