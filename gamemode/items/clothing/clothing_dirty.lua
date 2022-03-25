ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Dirty Clothes"
ITEM.Description 			= "An old set of dirty rags."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_dirtyshirt.mdl")

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

ITEM.Alternate 				= false
ITEM.ModelSkin 				= 0

if SERVER then
	function ITEM:GetModelData(ply, data)
		local mdl = self:GetProperty("Alternate") and "models/tnb/clothing/trp/body/%s_dirtyvest.mdl" or "models/tnb/clothing/trp/body/%s_dirtyshirt.mdl"

		data.body = {
			model = string.format(mdl, ply:Gender()),
			skin = self:GetProperty("ModelSkin")
		}
	end
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		for k, v in pairs({"Variant 1", "Variant 2"}) do
			table.insert(tab, {
				Name = v,
				Group = "Customize gear",
				Func = function(item, user)
					if SERVER then
						self:SetProperty("Alternate", false)
						self:SetProperty("ModelSkin", k - 1)

						ply:RecalculatePlayerModel()
					end
				end
			})
		end

		for k, v in pairs({"Variant 3", "Variant 4"}) do
			table.insert(tab, {
				Name = v,
				Group = "Customize gear",
				Func = function(item, user)
					if SERVER then
						self:SetProperty("Alternate", true)
						self:SetProperty("ModelSkin", k - 1)

						ply:RecalculatePlayerModel()
					end
				end
			})
		end
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
