ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Aviators"
ITEM.Description 			= "A set of black aviator sunglasses."

ITEM.Model					= Model("models/tnb/items/trp/headgear/eyewear3.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_EYES}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				eyewear = 3
			}
		})
	end
end
