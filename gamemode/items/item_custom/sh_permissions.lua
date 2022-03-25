function ITEM:IsLocked()
	return self:GetProperty("Locked")
end

function ITEM:CanLock(ply)
	return ply:IsAdmin()
end

function ITEM:CanEdit(ply, silent)
	if self:IsLocked() then
		if SERVER and not silent then
			ply:SendChat(nil, "WARNING", "Unlock the item to customise!")
		end

		return false
	end

	return ply:IsAdmin()
end