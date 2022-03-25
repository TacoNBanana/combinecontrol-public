ITEM = class.Create("armor_tc")
DEFINE_BASECLASS("armor_tc")

ITEM.__Internal 			= false

ITEM.Name 					= "Tech-Com Support Uniform"
ITEM.Description 			= "A Tech-Com uniform fitted with additional carrying capacity for tools and other supplies."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_tc_support.mdl")

ITEM.Weight 				= 7
ITEM.ArmorValue 			= ARMOR.Medium

ITEM.Gear 					= 0
ITEM.Pouch 					= false
ITEM.Holster 				= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		local mdl = self:GetProperty("Casual") and "models/tnb/clothing/trp/body/%s_tc_offduty.mdl" or "models/tnb/clothing/trp/body/%s_tc_support.mdl"

		data.body = {
			model = string.format(mdl, ply:Gender()),
			skin = self:GetProperty("ModelSkin"),
			bodygroups = {
				chestrig = self:GetProperty("Gear"),
				pouch = not self:GetProperty("Pouch"),
				gunholster = not self:GetProperty("Holster"),
				boots = self:GetProperty("Shoes")
			}
		}
	end
end

function ITEM:GetSecondaryOptions(ply, tab)
	local casual = self:GetProperty("Casual")

	if not casual then
		for k, v in pairs({"Variant 1", "Variant 2", "Variant 3", "Variant 4", "Variant 5", "Blank"}) do
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

		table.insert(tab, {
			Name = "Toggle pouch",
			Func = function(item, user)
				if SERVER then
					self:SetProperty("Pouch", not self:GetProperty("Pouch"))

					ply:RecalculatePlayerModel()
				end
			end
		})
	end

	table.insert(tab, {
		Name = "Toggle holster",
		Func = function(item, user)
			if SERVER then
				self:SetProperty("Holster", not self:GetProperty("Holster"))

				ply:RecalculatePlayerModel()
			end
		end
	})
end
