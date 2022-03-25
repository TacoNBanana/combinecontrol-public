ITEM = class.Create("base_clothing")
DEFINE_BASECLASS("base_clothing")

ITEM.Name 					= "Oxygen Tank"
ITEM.Description 			= "An aluminium gas tank that's been filled with a breathable air mixture. Mask not included."

ITEM.Model					= Model("models/tnb/items/shared/item_oxygen.mdl")

ITEM.Weight 				= 10
ITEM.CarryAdd 				= 0

ITEM.Slots 					= {EQUIPMENT_BACK}

if SERVER then
	function ITEM:GetModelData(ply, data)
		data.back = {
			model = "models/tnb/clothing/shared/pack_oxygen.mdl"
		}
	end
end

function ITEM:GetGasImmunity()
	local mask = self.Player:GetEquipment(EQUIPMENT_MASK)

	if mask and mask:GetClass() == "gasmask_advanced" then
		return true
	end

	local hazmat = self.Player:GetEquipment(EQUIPMENT_BODY)

	if hazmat and hazmat:GetClass() == "clothing_hazmat" and hazmat:GetProperty("mask") then
		return true
	end

	return 0
end
