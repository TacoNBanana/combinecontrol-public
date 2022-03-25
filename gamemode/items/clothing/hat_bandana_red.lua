ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Bandana"
ITEM.Description 			= "A cloth bandana."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat8.mdl")

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 8
			}
		})
	end
end
