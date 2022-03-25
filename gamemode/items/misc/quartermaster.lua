ITEM = class.Create("base_item")
DEFINE_BASECLASS("base_item")

ITEM.Name 			= "Quartermaster's box"
ITEM.Description 	= "Holds a nearly endless amount of items."

ITEM.Model			= Model("models/illusion/eftcontainers/magbox.mdl")

ITEM.Weight 		= 0
ITEM.CarryAdd 		= 200

ITEM.Slots 			= {EQUIPMENT_EQUIP1, EQUIPMENT_EQUIP2}

function ITEM:GetCarryAdd()
	if self.Player:ArmoryAccess() == "" then
		return 0
	end

	return BaseClass.GetCarryAdd(self)
end
