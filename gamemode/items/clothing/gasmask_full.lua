ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Gas Mask"
ITEM.Description 			= "A heavy-duty gas mask, covering everything but two portholes to look through."

ITEM.Model					= Model("models/tnb/items/trp/headgear/mask6.mdl")

ITEM.Weight 				= 1.5

ITEM.Slots 					= {EQUIPMENT_MASK}

ITEM.GasImmunity 			= 1200 -- 20 minutes

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				mask = 6
			}
		})
	end
end
