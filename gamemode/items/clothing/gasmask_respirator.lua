ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Respirator"
ITEM.Description 			= "A compact respirator, not recommended for heavy use."

ITEM.Model					= Model("models/tnb/items/trp/headgear/mask4.mdl")

ITEM.Weight 				= 0.8

ITEM.Slots 					= {EQUIPMENT_MASK}

ITEM.GasImmunity 			= 300 -- 5 minutes

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				mask = 4
			}
		})
	end
end
