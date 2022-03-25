ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "SWAT Helmet"
ITEM.Description 			= "An old style of kevlar helmet, commonly used by police forces."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat16.mdl")

ITEM.Weight 				= 1.4

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 15
			}
		})
	end
end
