ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Scavenger Backpack"
ITEM.Description 			= "A common backpack that's been fitted with various extra straps, pouches and essentials."

ITEM.Model					= Model("models/tnb/items/shared/item_load_baselard.mdl")

-- Effective CarryAdd: 13.5
ITEM.Weight 				= 3
ITEM.CarryAdd 				= 15

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_load_baselard_body_lod0.mdl"
		}
	end
end
