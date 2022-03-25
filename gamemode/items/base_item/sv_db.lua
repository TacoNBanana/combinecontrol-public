function ITEM:DeleteItem()
	if self:IsTempItem() then
		return
	end

	local id = self.ID

	assertf(id > 0, "Attempt to delete item with invalid ID: %s", id)

	if table.Count(self.Overrides) < 1 then
		GAMEMODE.SQL:Query("DELETE FROM $items WHERE id = ?", id, stub)
	else
		GAMEMODE.SQL:Update("$items", {Deleted = 1}, "id = ?", id, stub)
	end
end

function ITEM:SaveItem()
	if self:IsTempItem() then
		return
	end

	local id = self.ID
	local data = util.TableToJSON(self.Overrides)
	assertf(id > 0, "Attempt to save item with invalid ID: %s", id)

	GAMEMODE.SQL:Update("$items", {CustomData = data}, "id = ?", id, stub)
end

function ITEM:SaveLocation()
	if self:IsTempItem() then
		return
	end

	local id = self.ID
	local store = self.StoreType

	local data = {
		StorageType = store
	}

	assertf(id > 0, "Attempt to save item with invalid ID: %s", id)

	if store == ITEM_PLAYER then
		assertf(self.CharacterID, "ERROR: Attempt to save item with missing character ID: %s", self.CharacterID)

		data.CharacterID = self.CharacterID
	elseif store == ITEM_WORLD then
		local ent = self.PhysicalEntity

		assert(IsValid(ent), "Attempt to save world item with invalid entity")

		if not ent.SavedPos then
			ent:SaveMoved() -- Construct ent.SavedPos/Ang
		end

		local pos = ent.SavedPos
		local ang = ent.SavedAng

		local frozen = false
		local phys = ent:GetPhysicsObject()

		if IsValid(phys) then
			frozen = not phys:IsMotionEnabled()
		end

		data.WorldX, data.WorldY, data.WorldZ = pos.x, pos.y, pos.z
		data.WorldAP, data.WorldAY, data.WorldAR = ang.p, ang.y, ang.r
		data.WorldFrozen = frozen
		data.WorldMap = game.GetMap()
	else
		return
	end

	GAMEMODE.SQL:Update("$items", data, "id = ?", id, stub)
end
