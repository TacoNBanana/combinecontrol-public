ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Tactical Visor"
ITEM.Description 			= "An advanced heads up display, providing essential information directly into the user's field of view."

ITEM.Model					= Model("models/tnb/items/trp/headgear/eyewear6.mdl")

ITEM.Weight 				= 0.2

ITEM.Slots 					= {EQUIPMENT_EYES}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				eyewear = 6
			}
		})
	end
end
