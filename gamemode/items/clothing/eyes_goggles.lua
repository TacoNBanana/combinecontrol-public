ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Ballistic Goggles"
ITEM.Description 			= "A pair of clear ballistic goggles."

ITEM.Model					= Model("models/tnb/items/trp/headgear/eyewear7.mdl")

ITEM.Weight 				= 0.2

ITEM.Slots 					= {EQUIPMENT_EYES}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				eyewear = 7
			}
		})
	end
end
