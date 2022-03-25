ITEM = class.Create("base_equipment")
DEFINE_BASECLASS("base_equipment")

ITEM.Name 				= "base_clothing"

ITEM.Slots 				= {EQUIPMENT_EXO}

ITEM.ModelData 			= {}
ITEM.ModelDataFemale 	= {}

ITEM.CoversFace 		= false
ITEM.GasFilter 			= false

ITEM.ArmorAdd 			= 0
ITEM.DamageReduction	= 0

function ITEM:CanWear(ply, slot, silent)
	local flag = ply:GetCharFlag()

	if flag and flag.ModelFunc and flag.Flag ~= "Z" then
		if SERVER and not silent then
			ply:SendChat(nil, "WARNING", "This character cannot wear clothing!")
		end

		return false
	end

	return BaseClass.CanWear(self, ply, slot, silent)
end

if SERVER then
	function ITEM:OnWorn(ply)
		ply:RecalculatePlayerModel()

		if self.ArmorAdd > 0 then
			ply:SetBodyArmor(ply:BodyArmor() + self.ArmorAdd)
			ply:SetMaxBodyArmor(ply:BodyArmor())
		end
	end

	function ITEM:OnUnworn(ply)
		ply:RecalculatePlayerModel()

		if self.ArmorAdd > 0 then
			ply:SetBodyArmor(math.max(0, ply:BodyArmor() - self.ArmorAdd))
			ply:SetMaxBodyArmor(ply:BodyArmor())
		end
	end

	function ITEM:OnPlayerSpawn(ply)
		if self:IsWorn() and self.ArmorAdd > 0 then
			ply:SetBodyArmor(ply:BodyArmor() + self.ArmorAdd)
			ply:SetMaxBodyArmor(ply:BodyArmor())
		end
	end

	function ITEM:GetModelData(ply)
		local tab = self:GetProperty("ModelDataFemale")

		return (ply:IsFemale() and tab.model) and tab or self:GetProperty("ModelData")
	end
end
