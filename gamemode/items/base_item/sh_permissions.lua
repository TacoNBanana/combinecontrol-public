function ITEM:IsInPlayerInventory(ply)
	return self.StoreType == ITEM_PLAYER and ply:CharID() == self.CharacterID
end

function ITEM:CanPickup(ply, silent)
	if self:IsInPlayerInventory(ply) then
		if not silent then
			ply:SendChat(nil, "ERROR", "You're already carrying this.")
		end

		return false
	end

	local weight = self:GetWeight()

	if weight < 0 then
		return true
	end

	if (ply:InventoryWeight() + weight) > ply:InventoryMaxWeight() then
		if not silent then
			ply:SendChat(nil, "ERROR", "That's too heavy for you to carry.")
		end

		return false
	end

	return true
end

function ITEM:CanDrop(ply)
	if ply == self.Player then
		return self:IsInPlayerInventory(ply)
	end

	return ply:IsAdmin()
end

function ITEM:CanDestroy(ply)
	if ply == self.Player then
		return self:IsInPlayerInventory(ply)
	end

	return ply:IsAdmin()
end

function ITEM:CanInteract(ply)
	return self:IsInPlayerInventory(ply)
end

function ITEM:CanSell(ply, amt)
	if self.SellMult == -1 or (isnumber(self.BusinessLicense) and self.BusinessLicense == BUSINESS_NONE) then
		return false
	end

	if not ply:HasLicense(self.BusinessLicense) then
		return false
	end

	if not amt or amt <= 0 then
		amt = 1
	end

	if amt > self:GetAmount() then
		return false
	end

	if ply == self.Player then
		return self:IsInPlayerInventory(ply)
	end

	return ply:IsAdmin()
end
