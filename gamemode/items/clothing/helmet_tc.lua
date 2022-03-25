ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Tech-Com Helmet"
ITEM.Description 			= "Tech-Com's signature helmet. Comes standard with a number of accessories that can be mounted to the side."

ITEM.Model					= Model("models/tnb/items/trp/headgear/hat12.mdl")

ITEM.Weight 				= 1.8

ITEM.Slots 					= {EQUIPMENT_HEAD}

ITEM.ModelSkin 				= 0

local skins = {
	{ -- Night
		["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons3"
	}, { -- MARPAT
		["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons_marpat"
	}, { -- Arctic
		["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons2"
	}, { -- Arid
		["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons4"
	},
	{ -- Woodland
		["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons_woodland"
	},
	{ -- Urban
		["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons_urban"
	},
	{ -- Twotone
		["models/tnb/techcom/addons1"] = "models/tnb/techcom/addons_twotone"
	},
	[0] = {
		["models/tnb/techcom/addons1"] = ""
	}
}

function ITEM:SetItemAppearance(ent)
	BaseClass.SetItemAppearance(self, ent)

	model.SetSubMaterials(ent, skins[self:GetProperty("ModelSkin")] or {})
end

if SERVER then
	function ITEM:GetModelData(ply, data)
		table.Merge(data.head, {
			bodygroups = {
				hat = 11
			},
			materials = table.Copy(skins[self:GetProperty("ModelSkin")])
		})
	end
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
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
