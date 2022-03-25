ITEM = class.Create("base_clothing")

ITEM.Name 				= "Ghillie Suit (Dusty)"
ITEM.Description 		= "Worn by snipers."

ITEM.Model				= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd			= 0
ITEM.DamageReduction	= 0

ITEM.Weight 			= 1
ITEM.CarryAdd			= 0

ITEM.Slots 				= {EQUIPMENT_EXO}

ITEM.ModelData 			= {}
ITEM.ModelData.model 	= Model("models/tnb/techcom/pack_ghillie.mdl")
ITEM.ModelData.skin 	= 1

if SERVER then
	function ITEM:OnWorn(ply)
		ply:RecalculatePlayerModel()

		if self.ArmorAdd > 0 then
			ply:SetBodyArmor(ply:BodyArmor() + self.ArmorAdd)
			ply:SetMaxBodyArmor(ply:BodyArmor())
		end

		ply:SetThermalHidden(true)
	end

	function ITEM:OnUnworn(ply)
		ply:RecalculatePlayerModel()

		if self.ArmorAdd > 0 then
			ply:SetBodyArmor(math.max(0, ply:BodyArmor() - self.ArmorAdd))
			ply:SetMaxBodyArmor(ply:BodyArmor())
		end

		ply:SetThermalHidden(false)
	end
end