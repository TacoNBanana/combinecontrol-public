ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Glasses"
ITEM.Description 			= "A pair of reading glasses."

ITEM.Model					= Model("models/tnb/items/trp/headgear/eyewear5.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_EYES}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				eyewear = 5
			}
		})
	end
end
