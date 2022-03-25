ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 				= "base_armband"

ITEM.Slots 				= {EQUIPMENT_ARM_L, EQUIPMENT_ARM_R}

ITEM.Model 				= "models/tnb/items/trp/bodygear/armband.mdl"
ITEM.Materials 			= "models/tnb/techcom/bloodband_blank"

ITEM.Weight 			= 0.1

function ITEM:GetArmorValue()
	return self:GetProperty("ArmorValue")
end

if SERVER then
	function ITEM:OnWorn(ply)
		ply:RecalculatePlayerModel()
	end

	function ITEM:OnUnworn(ply)
		ply:RecalculatePlayerModel()
	end

	function ITEM:PostGetModelData(ply, data)
		local left = self:IsWorn() == EQUIPMENT_ARM_L

		local bodygroup = left and "armband_left" or "armband_right"
		local mat = left and "models/tnb/techcom/bloodband2" or "models/tnb/techcom/bloodband"

		local merge = data.body or data.head

		table.Merge(merge, {
			bodygroups = {
				[bodygroup] = 1
			},
			materials = {
				[mat] = self:GetProperty("Materials")
			}
		})
	end
end
