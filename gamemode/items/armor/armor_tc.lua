ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.__Internal 			= true

ITEM.Casual 				= false
ITEM.Mask 					= false
ITEM.Shoes 					= false
ITEM.ModelSkin 				= 0

local helmets = {
	["helmet_tc"] = 0,
	["helmet_tc_medic"] = 1
}

local marpat = {
	["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons_marpat",
	["models/tnb/techcom/body_a1"] = "models/tnb/techcom/body_a_marpat",
	["models/tnb/techcom/body_b1"] = "models/tnb/techcom/body_b_marpat",
	["models/tnb/techcom/body_c1"] = "models/tnb/techcom/body_c_marpat",
	["models/tnb/techcom/legs_a1"] = "models/tnb/techcom/legs_a_marpat",
	["models/tnb/techcom/legs_b1"] = "models/tnb/techcom/legs_b_marpat",
	["models/tnb/techcom/snip_1"] = "models/tnb/techcom/snip_marpat",
	["models/tnb/techcom/vest_a1"] = "models/tnb/techcom/vest_a_marpat",
	["models/tnb/techcom/vest_b1"] = "models/tnb/techcom/vest_b_marpat"
}

local woodland = {
	["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons_woodland",
	["models/tnb/techcom/body_a1"] = "models/tnb/techcom/body_a_woodland",
	["models/tnb/techcom/body_b1"] = "models/tnb/techcom/body_b_woodland",
	["models/tnb/techcom/body_c1"] = "models/tnb/techcom/body_c_woodland",
	["models/tnb/techcom/legs_a1"] = "models/tnb/techcom/legs_a_woodland",
	["models/tnb/techcom/legs_b1"] = "models/tnb/techcom/legs_b_woodland",
	["models/tnb/techcom/snip_1"] = "models/tnb/techcom/snip_woodland",
	["models/tnb/techcom/vest_b1"] = "models/tnb/techcom/vest_b_woodland"
}

local urban = {
	["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons_urban",
	["models/tnb/techcom/body_a1"] = "models/tnb/techcom/body_a_urban",
	["models/tnb/techcom/body_b1"] = "models/tnb/techcom/body_b_urban",
	["models/tnb/techcom/body_c1"] = "models/tnb/techcom/body_c_urban",
	["models/tnb/techcom/legs_a1"] = "models/tnb/techcom/legs_a_urban",
	["models/tnb/techcom/legs_b1"] = "models/tnb/techcom/legs_b_urban",
	["models/tnb/techcom/snip_1"] = "models/tnb/techcom/snip_urban",
	["models/tnb/techcom/vest_a1"] = "models/tnb/techcom/vest_a_urban",
	["models/tnb/techcom/vest_b1"] = "models/tnb/techcom/vest_b_urban"
}

local twotone = {
	["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons_twotone",
	["models/tnb/techcom/body_a1"] = "models/tnb/techcom/body_a_twotone",
	["models/tnb/techcom/body_b1"] = "models/tnb/techcom/body_b_twotone",
	["models/tnb/techcom/body_c1"] = "models/tnb/techcom/body_c_twotone",
	["models/tnb/techcom/legs_a1"] = "models/tnb/techcom/legs_a_twotone",
	["models/tnb/techcom/legs_b1"] = "models/tnb/techcom/legs_b_twotone",
	["models/tnb/techcom/snip_1"] = "models/tnb/techcom/snip_twotone",
	["models/tnb/techcom/vest_a1"] = "models/tnb/techcom/vest_a_twotone",
	["models/tnb/techcom/vest_b1"] = "models/tnb/techcom/vest_b_twotone"
}

function ITEM:SetItemAppearance(ent)
	BaseClass.SetItemAppearance(self, ent)

	local skin = self:GetProperty("ModelSkin")

	if skin == 2 then
		skin = 0
		model.SetSubMaterials(ent, marpat)
	elseif skin == 5 then
		skin = 0
		model.SetSubMaterials(ent, woodland)
	elseif skin == 6 then
		skin = 0
		model.SetSubMaterials(ent, urban)
	elseif skin == 7 then
		skin = 0
		model.SetSubMaterials(ent, twotone)
	end

	ent:SetSkin(skin)
end

if SERVER then
	function ITEM:PostGetModelData(ply, data)
		local head = ply:GetEquipment(EQUIPMENT_HEAD)
		local helmet = head and helmets[head:GetClass()]
		local mask = helmet and self:GetProperty("Mask")

		local skin = data.body.skin

		if skin == 2 then
			data.body.skin = 0
			data.body.materials = table.Merge(data.body.materials or {}, marpat)
		elseif skin == 5 then
			data.body.skin = 0
			data.body.materials = table.Merge(data.body.materials or {}, woodland)
		elseif skin == 6 then
			data.body.skin = 0
			data.body.materials = table.Merge(data.body.materials or {}, urban)
		elseif skin == 7 then
			data.body.skin = 0
			data.body.materials = table.Merge(data.body.materials or {}, twotone)
		end

		if mask then
			table.Merge(data.head, {
				model = string.format("models/tnb/heads/trp/%s_tc.mdl", ply:Gender(data.head.model)),
				bodygroups = {
					hat = helmet
				}
			})
		end
	end
end

function ITEM:GetSecondaryOptions(ply, tab)
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		for k, v in pairs({"Navy", "Night", "MARPAT", "Arctic", "Arid", "Woodland", "Urban", "Two-tone"}) do
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
			Name = "Toggle armor",
			Context = true,
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Casual", not self:GetProperty("Casual"))

					ply:RecalculatePlayerModel()
				end
			end
		})

		local head = ply:GetEquipment(EQUIPMENT_HEAD)

		if head and helmets[head:GetClass()] then
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

		self:GetSecondaryOptions(ply, tab)

		table.insert(tab, {
			Name = "Toggle boots",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Shoes", not self:GetProperty("Shoes"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
