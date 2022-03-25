ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Basic Gas Mask"
ITEM.Description 			= "An older model of gas mask, still more than usable."

ITEM.Model					= Model("models/tnb/items/trp/headgear/mask5.mdl")

ITEM.Weight 				= 1

ITEM.Slots 					= {EQUIPMENT_MASK}

ITEM.GasImmunity 			= 600 -- 10 minutes

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				mask = 5
			}
		})
	end
end
