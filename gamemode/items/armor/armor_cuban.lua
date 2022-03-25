ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.Name 					= "Advanced Reconnaissance Suit"
ITEM.Description 			= "A highly advanced combat uniform, armored and outfitted with thermal insulation."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_cubanmerc.mdl")

ITEM.Weight 				= 8
ITEM.ArmorValue 			= ARMOR.Medium

ITEM.ModelSkin 				= 0

ITEM.Hood 					= false
ITEM.Mask 					= false
ITEM.Gear 					= 4
ITEM.Shoulders 				= false

local skins = {
	{
		["models/ninja/cubanmerc/c_cub_pmc_torso_c"] = "models/ninja/cubanmerc/c_cub_pmc_torso_c1",
		["models/ninja/cubanmerc/c_cub_pmc_torso2_c"] = "models/ninja/cubanmerc/c_cub_pmc_torso2_c1"
	}, {
		["models/ninja/cubanmerc/c_cub_pmc_torso_c"] = "models/ninja/cubanmerc/c_cub_pmc_torso_c2",
		["models/ninja/cubanmerc/c_cub_pmc_torso2_c"] = "models/ninja/cubanmerc/c_cub_pmc_torso2_c2"
	}, {
		["models/ninja/cubanmerc/c_cub_pmc_torso_c"] = "models/ninja/cubanmerc/c_cub_pmc_torso_c3",
		["models/ninja/cubanmerc/c_cub_pmc_torso2_c"] = "models/ninja/cubanmerc/c_cub_pmc_torso2_c3"
	}, {
		["models/ninja/cubanmerc/c_cub_pmc_torso_c"] = "models/ninja/cubanmerc/c_cub_pmc_torso_c4",
		["models/ninja/cubanmerc/c_cub_pmc_torso2_c"] = "models/ninja/cubanmerc/c_cub_pmc_torso2_c4"
	}
}

function ITEM:SetItemAppearance(ent)
	BaseClass.SetItemAppearance(self, ent)

	model.SetSubMaterials(ent, skins[self:GetProperty("ModelSkin")] or {})
end

if SERVER then
	function ITEM:GetModelData(ply, data)
		local hood = self:GetProperty("Hood")
		local mask = self:GetProperty("Mask")

		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_cubanmerc.mdl", ply:Gender()),
			skin = self:GetProperty("ModelSkin"),
			bodygroups = {
				holster = 2,
				hood = hood,
				mask = hood and mask,
				gear = self:GetProperty("Gear"),
				altgear = self:GetProperty("Shoulders") and 1 or 2
			}
		}
	end

	function ITEM:PostGetModelData(ply, data)
		local hood = self:GetProperty("Hood")
		local mask = self:GetProperty("Mask")

		if hood then
			data.head.bodygroups = data.head.bodygroups or {}
			data.head.bodygroups.hat = 0
		end

		if hood and mask then
			data.head = data.body
			data.head.replaced = true
			data.body = nil
		end
	end
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		for k, v in pairs({"Original", "Arctic", "Arid", "Woodland", "Autumn"}) do
			table.insert(tab, {
				Name = v,
				Group = "Set camouflage",
				Func = function(item, user)
					if SERVER then
						self:SetProperty("ModelSkin", k - 1)

						ply:RecalculatePlayerModel()
					end
				end
			})
		end

		table.insert(tab, {
			Name = "Toggle hood",
			Context = true,
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Hood", not self:GetProperty("Hood"))

					ply:RecalculatePlayerModel()
				end
			end
		})

		if self:GetProperty("Hood") then
			table.insert(tab, {
				Name = "Toggle mask",
				Context = true,
				Func = function(item, user)
					if SERVER then
						self:SetProperty("Mask", not self:GetProperty("Mask"))

						ply:RecalculatePlayerModel()
					end
				end
			})
		end

		table.insert(tab, {
			Name = "Toggle shoulder pads",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Shoulders", not self:GetProperty("Shoulders"))

					ply:RecalculatePlayerModel()
				end
			end
		})

		for k, v in pairs({"Variant 1", "Variant 2", "Variant 3", "Variant 4", "Blank"}) do
			table.insert(tab, {
				Name = v,
				Group = "Customize gear",
				Func = function(item, user)
					if SERVER then
						self:SetProperty("Gear", k - 1)

						ply:RecalculatePlayerModel()
					end
				end
			})
		end
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
