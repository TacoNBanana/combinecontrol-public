ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 	= "base_vest"

ITEM.Slots 	= {EQUIPMENT_ARMOR}

ITEM.Index 	= 0

if SERVER then
	function ITEM:OnWorn(ply)
		ply:RecalculatePlayerModel()
	end

	function ITEM:PostGetModelData(ply, data)
		local merge = data.body or data.head
		local materials = self:GetProperty("Materials")

		local mat = istable(materials) and materials or {}

		table.Merge(merge, {
			bodygroups = {
				armor = self.Index
			},
			materials = mat
		})
	end
end
