ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Combat Helmet"
ITEM.Description 			= "A round ballistic kevlar helmet."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat14.mdl")

ITEM.Weight 				= 1.4

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 13
			}
		})
	end
end
