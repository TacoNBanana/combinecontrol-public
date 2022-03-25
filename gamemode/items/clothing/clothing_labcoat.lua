ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "Labcoat"
ITEM.Description 			= "A labcoat worn over some casual clothing."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_labcoat.mdl")
ITEM.Skin 					= 1

ITEM.Weight 				= 2
ITEM.ArmorValue 			= 0

ITEM.Dirty 					= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_labcoat.mdl", ply:Gender()),
			skin = self:GetProperty("Dirty") and 0 or 1
		}
	end
end

function ITEM:SetItemAppearance(ent)
	BaseClass.SetItemAppearance(self, ent)

	if self:GetProperty("Dirty") then
		ent:SetSkin(0)
	end
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
		table.insert(tab, {
			Name = "Toggle dirty",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Dirty", not self:GetProperty("Dirty"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
