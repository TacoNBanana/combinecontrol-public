DEFINE_BASECLASS("base_item")

function ITEM:CanWear(ply, slot, silent)
	if self:IsWorn() then
		return false
	end

	if self:IsBroken() and not self.AllowBroken then
		if SERVER and not silent then
			ply:SendChat(nil, "WARNING", "This item is broken!")
		end

		return false
	end

	for _, v in pairs(ply.Inventory) do
		if not class.IsTypeOf(v, "base_equipment") then
			continue
		end

		if v:IsWorn() and v:GetClass() == self:GetClass() then
			if SERVER and not silent then
				ply:SendChat(nil, "WARNING", "You cannot equip the same item twice!")
			end

			return false
		end
	end

	return true
end

function ITEM:CanDrop(ply)
	if self:IsWorn() and ply == self.Player then
		return false
	end

	return BaseClass.CanDrop(self, ply)
end

function ITEM:CanDestroy(ply)
	if self:IsWorn() and ply == self.Player then
		return false
	end

	return BaseClass.CanDestroy(self, ply)
end

function ITEM:CanSell(ply, amt)
	if self:IsWorn() and ply == self.Player then
		return false
	end

	return BaseClass.CanSell(self, ply, amt)
end
