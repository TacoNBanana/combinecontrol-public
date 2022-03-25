ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Advanced Combat Helmet"
ITEM.Description 			= "The latest generation pre-war ballistic helmet."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat15.mdl")
ITEM.Materials 				= {
	["models/tnb/techcom/body_crysis_helmet1"] = "models/tnb/techcom/body_crysis_helmet2"
}

ITEM.Weight 				= 1.5

ITEM.Slots 					= {EQUIPMENT_HEAD}

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 14
			},
			materials = {
				["models/tnb/techcom/body_crysis_helmet1"] = "models/tnb/techcom/body_crysis_helmet2"
			}
		})
	end
end
