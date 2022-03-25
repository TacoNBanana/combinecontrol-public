ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Shemagh"
ITEM.Description 			= "A dark green pattern shemagh to cover your face with."

ITEM.Model					= Model("models/tnb/items/trp/headgear/mask2.mdl")

ITEM.Weight 				= 0.2

ITEM.Slots 					= {EQUIPMENT_MASK}

ITEM.Lowered 				= false
ITEM.LowProfile 			= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		local lowered = self:GetProperty("Lowered")
		local lowProfile = self:GetProperty("LowProfile")

		table.Merge(data.head, {
			bodygroups = {
				mask = lowered and 0 or 2,
				scarf = (lowered and lowProfile) and 2 or 0
			}
		})
	end

	function ITEM:PostGetModelData(ply, data)
		if not self:GetProperty("LowProfile") then
			table.Merge(data.body, {
				bodygroups = {
					shemagh = 1
				},
				materials = {
					["models/ninja/cod4r/chr/marines/marine_keffiyeh_col"] = "models/tnb/techcom/shemagh1"
				}
			})
		end
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
			Context = true,
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Lowered", not self:GetProperty("Lowered"))

					ply:RecalculatePlayerModel()
				end
			end
		})

		table.insert(tab, {
			Name = "Toggle low-profile",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("LowProfile", not self:GetProperty("LowProfile"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
