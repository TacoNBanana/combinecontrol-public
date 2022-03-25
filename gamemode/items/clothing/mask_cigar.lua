ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Cigar"
ITEM.Description 			= "A cigar of unknown origin, incredibly rare but looks cool."

ITEM.Model					= Model("models/tnb/items/trp/headgear/mask3.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_MASK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				mask = 3
			}
		})
	end
end
