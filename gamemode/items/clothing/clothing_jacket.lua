ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Survivor Jacket"
ITEM.Description 			= "A thin jacket, insulated against the cold."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_survivor_jacket.mdl")

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

ITEM.AltSkin 				= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_survivor_jacket.mdl", ply:Gender()),
			skin = self:GetProperty("AltSkin") and 1 or 0
		}
	end
end

function ITEM:SetItemAppearance(ent)
	BaseClass.SetItemAppearance(self, ent)

	if self:GetProperty("AltSkin") then
		model.SetSubMaterials(ent, {
			["models/tnb/techcom/torso_misc1"] = "models/tnb/techcom/torso_misc2"
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
