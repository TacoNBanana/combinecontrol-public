ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Tri-zip Army Bag"
ITEM.Description 			= "A spaceous backpack with a triple zipper design. Meant for easy packing of large and heavy items."

ITEM.Model					= Model("models/tnb/items/shared/item_trizip_exo.mdl")

-- Effective CarryAdd: 17.5
ITEM.Weight 				= 5
ITEM.CarryAdd 				= 20

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_trizip.mdl"
		}
	end
end
