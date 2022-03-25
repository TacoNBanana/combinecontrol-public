ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Beret"
ITEM.Description 			= "A soft green ceremonial-style cap."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat6.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 6
			}
		})
	end
end
