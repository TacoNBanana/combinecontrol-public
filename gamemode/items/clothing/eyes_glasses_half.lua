ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Half-rimmed Glasses"
ITEM.Description 			= "A pair of half-rimmed prescription glasses."

ITEM.Model					= Model("models/tnb/items/trp/headgear/eyewear8.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_EYES}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				eyewear = 8
			}
		})
	end
end
