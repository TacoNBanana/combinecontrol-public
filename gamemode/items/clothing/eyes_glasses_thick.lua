ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Thick-rimmed Glasses"
ITEM.Description 			= "A pair of thick-rimmed glasses."

ITEM.Model					= Model("models/tnb/items/trp/headgear/eyewear4.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_EYES}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				eyewear = 4
			}
		})
	end
end
