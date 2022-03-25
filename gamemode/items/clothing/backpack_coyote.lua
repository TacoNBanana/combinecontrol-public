ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Coyote Backpack"
ITEM.Description 			= "A medium-sized backpack with a pair of side pouches."

ITEM.Model					= Model("models/tnb/items/shared/item_coyote.mdl")

-- Effective CarryAdd: 13
ITEM.Weight 				= 4
ITEM.CarryAdd 				= 15

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_coyote.mdl"
		}
	end
end
