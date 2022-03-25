ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Baseball Cap"
ITEM.Description 			= "A baseball cap with a pair of goggles on top."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat2.mdl")

ITEM.Weight 				= 0.2

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 2
			}
		})
	end
end
