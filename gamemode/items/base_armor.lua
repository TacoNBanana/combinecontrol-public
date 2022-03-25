ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 	= "base_armor"

ITEM.Slots 	= {EQUIPMENT_ARMOR}

if SERVER then
	function ITEM:OnWorn(ply)
		local equip = ply:GetEquipment(EQUIPMENT_BODY)

		if equip then
			equip:Unwear(ply)
		end

		ply:RecalculatePlayerModel()
	end
end
