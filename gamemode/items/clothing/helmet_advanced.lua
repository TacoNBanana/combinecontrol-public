ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Advanced Combat Helmet"
ITEM.Description 			= "The latest generation pre-war ballistic helmet."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat15.mdl")

ITEM.Weight 				= 1.5

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 14
			}
		})
	end
end
