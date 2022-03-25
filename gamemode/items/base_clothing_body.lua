ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 	= "base_clothing_body"

ITEM.Slots 	= {EQUIPMENT_BODY}

if SERVER then
	function ITEM:OnWorn(ply)
		local equip = ply:GetEquipment(EQUIPMENT_ARMOR)

		if equip and class.IsTypeOf(equip, "base_armor") then
			equip:Unwear(ply)
		end

		ply:RecalculatePlayerModel()
	end
end
