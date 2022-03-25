ITEM = class.Create("armor_tc")
DEFINE_BASECLASS("armor_tc")

ITEM.__Internal 			= false

ITEM.Name 					= "Tech-Com Recon Uniform"
ITEM.Description 			= "A light Tech-Com uniform made with mobility and concealment in mind. Designed for reconnaissance missions."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_tc_recon.mdl")

ITEM.Weight 				= 5
ITEM.ArmorValue 			= ARMOR.Light

ITEM.Gear 					= 0
ITEM.Pouch 					= false
ITEM.Holster 				= false
ITEM.Strap 					= false
ITEM.Hood 					= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		local mdl = self:GetProperty("Casual") and "models/tnb/clothing/trp/body/%s_tc_offduty.mdl" or "models/tnb/clothing/trp/body/%s_tc_recon.mdl"

		data.body = {
			model = string.format(mdl, ply:Gender()),
			skin = self:GetProperty("ModelSkin"),
			bodygroups = {
				chestrig = self:GetProperty("Gear"),
				pouch = not self:GetProperty("Pouch"),
				gunholster = not self:GetProperty("Holster"),
				hood = self:GetProperty("Hood"),
				boots = self:GetProperty("Shoes")
			}
		}
	end

	function ITEM:PostGetModelData(ply, data)
		BaseClass.PostGetModelData(self, ply, data)

		if not self:GetProperty("Casual") then
			local hood = self:GetProperty("Hood")
			local mask = self:GetProperty("Mask")

			table.Merge(data, {
				head = {
					bodygroups = {
						hat = hood and 0 or nil
					},
					materials = (hood and mask) and {
						["models/tnb/techcom/addons1"] = "null",
						["models/tnb/techcom/vest_a1"] = "null"
					} or nil
				}
			})
		end
	end
end

function ITEM:GetSecondaryOptions(ply, tab)
	local casual = self:GetProperty("Casual")

	if not casual then
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
