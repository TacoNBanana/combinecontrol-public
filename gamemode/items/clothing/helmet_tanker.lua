ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Tanker Helmet"
ITEM.Description 			= "A soviet helmet designed to protect against impacts, provides no ballistic protection whatsoever."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat7.mdl")

ITEM.Weight 				= 1

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 7
			}
		})
	end
end
