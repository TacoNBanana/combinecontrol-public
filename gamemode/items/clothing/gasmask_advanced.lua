ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Tactical Gas Mask"
ITEM.Description 			= "A black gas mask designed for combat situations. Can be attached to an external oxygen tank."

ITEM.Model					= Model("models/tnb/items/trp/headgear/mask7.mdl")

ITEM.Weight 				= 1

ITEM.Slots 					= {EQUIPMENT_MASK}

ITEM.GasImmunity 			= 1800 -- 30 minutes

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				mask = 7
			}
		})
	end
end
