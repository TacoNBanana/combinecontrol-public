ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Beret"
ITEM.Description 			= "A soft red ceremonial-style cap."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat6.mdl")
ITEM.Materials 				= {
	["models/tnb/techcom/trenchcoat1"] = "models/tnb/techcom/trenchcoat2"
}

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 6
			},
			materials = {
				["models/tnb/techcom/trenchcoat1"] = "models/tnb/techcom/trenchcoat2"
			}
		})
	end
end
