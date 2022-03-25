ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Hiking Backpack"
ITEM.Description 			= "An oversized purple backpack that's ideal for camping or carrying around a lot of weight."

ITEM.Model					= Model("models/tnb/items/shared/item_pilgrim.mdl")

-- Effective CarryAdd: 20
ITEM.Weight 				= 10
ITEM.CarryAdd 				= 25

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_piligrimm_body_lod0.mdl"
		}
	end
end
