ITEM = class.Create("base_clothing_body")
DEFINE_BASECLASS("base_clothing_body")

ITEM.Name 					= "HAZMAT Suit"
ITEM.Description 			= "A sealed HAZMAT suit designed to keep its user safe from dangerous materials. Comes with a fitted gas mask."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_chemsuit.mdl")

ITEM.Weight 				= 4
ITEM.ArmorValue 			= 0

ITEM.GasImmunity 			= 3600 -- 1 hour
ITEM.Mask 					= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.body = {
			model = string.format("models/tnb/clothing/trp/body/%s_chemsuit.mdl", ply:Gender()),
			bodygroups = {
				model = self:GetProperty("Mask")
			}
		}
	end

	function ITEM:PostGetModelData(ply, data)
		if self:GetProperty("Mask") then
			data.head = data.body
			data.head.replaced = true
			data.body = nil
		end
	end
end

function ITEM:GetGasImmunity()
	if self:GetProperty("Mask") then
		return BaseClass.GetGasImmunity(self)
	end

	return 0
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	if self:IsWorn() then
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

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end
