ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.Name 					= "Specops Uniform"
ITEM.Description 			= "A heavy-duty combat uniform designed for elite units."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_specops.mdl")

ITEM.Weight 				= 8
ITEM.ArmorValue 			= ARMOR.Heavy

ITEM.AltSkin 				= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_specops.mdl", ply:Gender())
		}

		if self:GetProperty("AltSkin") then
			data.body.materials = {
				["models/tnb/techcom/body_a6"] = "models/tnb/aof/body_a",
				["models/tnb/techcom/torso_specops_kevlar1"] = "models/tnb/aof/torso_specops_kevlar",
				["models/tnb/techcom/torso_specops_vest1"] = "models/tnb/aof/torso_specops_vest"
			}
		end
	end
end

function ITEM:SetItemAppearance(ent)
	BaseClass.SetItemAppearance(self, ent)

	if self:GetProperty("AltSkin") then
		model.SetSubMaterials(ent, {
			["models/tnb/techcom/body_a6"] = "models/tnb/aof/body_a",
			["models/tnb/techcom/torso_specops_kevlar1"] = "models/tnb/aof/torso_specops_kevlar",
			["models/tnb/techcom/torso_specops_vest1"] = "models/tnb/aof/torso_specops_vest"
		})
	end
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		table.insert(tab, {
			Name = "Toggle style",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("AltSkin", not self:GetProperty("AltSkin"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
