ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Cowboy Hat"
ITEM.Description 			= "A rugged old cowboy hat."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat10.mdl")

ITEM.Weight 				= 0.2

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 10
			}
		})
	end
end
