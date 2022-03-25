ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Pilot Helmet"
ITEM.Description 			= "A large and padded helmet originally used by helicopter pilots."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_head_pilot.mdl")

ITEM.Weight 				= 2

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.helmet = {
			model = string.format("models/tnb/clothing/trp/body/pack_%spilot.mdl", ply:Gender())
		}
	end
end
