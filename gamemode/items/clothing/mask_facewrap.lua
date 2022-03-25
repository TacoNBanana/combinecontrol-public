ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Facewrap"
ITEM.Description 			= "A bandana to be worn over the mouth."

ITEM.Model					= Model("models/tnb/items/trp/headgear/scarf1.mdl")
ITEM.Materials 				= {
	["models/tnb/techcom/facewrap1"] = "models/tnb/techcom/bandana_1",
	["models/tnb/citizens/facewrap3"] = "models/tnb/techcom/bandana_1"
}

ITEM.Weight 				= 0.1

ITEM.Slots 					= {EQUIPMENT_MASK}

ITEM.Lowered 				= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		local lowered = self:GetProperty("Lowered")

		table.Merge(data.head, {
			bodygroups = {
				mask = lowered and 0 or 1,
				scarf = lowered and 1 or 0
			},
			materials = self.Materials
		})
	end
end

function ITEM:GetGasImmunity()
	return self:GetProperty("Lowered") and false or 60
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		table.insert(tab, {
			Name = "Toggle mask",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Lowered", not self:GetProperty("Lowered"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
