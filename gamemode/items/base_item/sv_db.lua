function ITEM:DeleteItem()
	local id = self.ID
	assertf(id > 0, "Attempt to delete item with invalid ID: %s", id)

	if table.Count(self.Overrides) < 1 then
		GAMEMODE.SQL:Query("DELETE FROM $items WHERE id = ?", id, stub)
	else
		GAMEMODE.SQL:Update("$items", {Deleted = 1}, "id = ?", id, stub)
	end
end

function ITEM:SaveItem()
	local id = self.ID
	local data = util.TableToJSON(self.Overrides)
	assertf(id > 0, "Attempt to save item with invalid ID: %s", id)

	GAMEMODE.SQL:Update("$items", {CustomData = data}, "id = ?", id, stub)
end

function ITEM:SaveLocation()
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

		local pos = ent:GetPos()

		data.WorldX, data.WorldY, data.WorldZ = pos.x, pos.y, pos.z
		data.WorldMap = game.GetMap()
	else
		return
	end

	GAMEMODE.SQL:Update("$items", data, "id = ?", id, stub)
end