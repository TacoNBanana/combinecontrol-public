ITEM = class.Create("base_equipment")
DEFINE_BASECLASS("base_equipment")

ITEM.Name 				= "base_clothing"

ITEM.Slots 				= {EQUIPMENT_BODY}

ITEM.CoversFace 		= false
ITEM.GasFilter 			= false

ITEM.ArmorValue 		= 0

function ITEM:CanWear(ply, slot, silent)
	local flag = ply:GetCharFlag()

	if flag and flag.ModelFunc and flag.Flag != "Z" then
		if SERVER and not silent then
			ply:SendChat(nil, "WARNING", "This character cannot wear clothing!")
		end

		return false
	end

	return BaseClass.CanWear(self, ply, slot, silent)
end

function ITEM:GetArmorValue()
	return self:GetProperty("ArmorValue")
end

function ITEM:GetWeight()
	local weight = BaseClass.GetWeight(self)

	if self:IsWorn() then
		return weight * 0.5
	end

	return weight
end

if SERVER then
	function ITEM:OnWorn(ply)
		ply:RecalculatePlayerModel()
	end

	function ITEM:OnUnworn(ply)
		ply:RecalculatePlayerModel()
	end
end
