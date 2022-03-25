ITEM = class.Create("base_armor")
DEFINE_BASECLASS("base_armor")

ITEM.Name 					= "Specops Command Uniform"
ITEM.Description 			= "A heavy-duty command uniform designed for elite units."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_specops.mdl")

ITEM.Weight 				= 8
ITEM.ArmorValue 			= ARMOR.Heavy

ITEM.AltSkin 				= false
ITEM.Patch 					= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = "models/tnb/clothing/trp/body/male_specops_command.mdl"
		}

		if self:GetProperty("AltSkin") then
			data.body.materials = {
				["models/tnb/techcom/body_a6"] = "models/tnb/aof/body_a",
				["models/tnb/techcom/torso_specops_vest1"] = "models/tnb/aof/torso_specops_vest",
				["models/tnb/techcom/vest_a1"] = "models/tnb/aof/vest_a",
				["models/tnb/techcom/goons"] = self:GetProperty("Patch") and "models/tnb/techcom/collaborator" or "null"
			}
		else
			data.body.materials = {
				["models/tnb/techcom/goons"] = self:GetProperty("Patch") and "models/tnb/techcom/collaborator" or "null"
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

		table.insert(tab, {
			Name = "Toggle patch",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Patch", not self:GetProperty("Patch"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
