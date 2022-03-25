ITEM = class.Create("armor_tc")
DEFINE_BASECLASS("armor_tc")

ITEM.__Internal 			= false

ITEM.Name 					= "Tech-Com Heavy Infantry Uniform"
ITEM.Description 			= "A specialized Tech-Com uniform outfitted with high grade protective gear."

ITEM.Model					= Model("models/tnb/items/trp/clothes/item_tc_heavyinfantry.mdl")

ITEM.Weight 				= 8
ITEM.ArmorValue 			= ARMOR.Heavy

ITEM.Gear 					= 0
ITEM.Holster 				= false

if SERVER then
	function ITEM:GetModelData(ply, data)
		local mdl = self:GetProperty("Casual") and "models/tnb/clothing/trp/body/%s_tc_offduty.mdl" or "models/tnb/clothing/trp/body/%s_tc_heavyinfantry.mdl"

		data.body = {
			model = string.format(mdl, ply:Gender()),
			skin = self:GetProperty("ModelSkin"),
			bodygroups = {
				chestrig = self:GetProperty("Gear"),
				gunholster = not self:GetProperty("Holster"),
				boots = self:GetProperty("Shoes")
			}
		}
	end
end

function ITEM:GetSecondaryOptions(ply, tab)
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
		Name = "Toggle holster",
		Func = function(item, user)
			if SERVER then
				self:SetProperty("Holster", not self:GetProperty("Holster"))

				ply:RecalculatePlayerModel()
			end
		end
	})
end
