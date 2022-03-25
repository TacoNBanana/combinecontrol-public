ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Shades"
ITEM.Description 			= "A pair of dark shades."

ITEM.Model					= Model("models/tnb/items/trp/headgear/eyewear1.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_EYES}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				eyewear = 1
			}
		})
	end
end
