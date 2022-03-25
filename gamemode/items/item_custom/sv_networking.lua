net.Receive("nSaveCustomItemData", function(len, ply)
	local id = net.ReadInt(32)
	local data = net.ReadTable()

	local item = GAMEMODE.Items[id]

	if not item or not item:CanEdit(ply) then
		return
	end

	local updated = false
	for _, property in pairs(item.EditableProperties) do
		local new = data[property]
		local cur = item:GetProperty(property)
		if new and new != cur then
			item:SetProperty(property, new)
			updated = true
		end
	end

	if updated then
		net.Start("nRefreshEditUI")
			net.WriteInt(item.ID, 32)
		net.Send(ply)
	end
end)

net.Receive("nImportCustomItemData", function(len, ply)
	local id = net.ReadInt(32)
	local data = net.ReadString()

	local item = GAMEMODE.Items[id]

	if not item or not item:CanEdit(ply) then
		return
	end

	local func = function()
		local tab = pon.decode(base64.Decode(data))

		if ply:IsDeveloper() then
			return tab
		end

		for k, v in pairs(tab) do
			if not table.HasValue(item.EditableProperties, k) then
				GAMEMODE:WriteLog("dev_itemimport_whitelistviolation", {
					Ply = GAMEMODE:LogPlayer(ply),
					Item = GAMEMODE:LogItem(item),
					Property = k
				})

				ply:Kick("Item import violation")

				error()
			end

			local expected = type(item:GetProperty(k))
			local received = type(v)

			if expected != received then
				GAMEMODE:WriteLog("dev_itemimport_typeviolation", {
					Ply = GAMEMODE:LogPlayer(ply),
					Item = GAMEMODE:LogItem(item),
					Property = k,
					Expected = expected,
					Received = received
				})

				ply:Kick("Item import violation")

				error()
			end
		end

		return tab
	end

	local ok, val = pcall(func)

	if not ok then
		return
	end

	for k, v in pairs(val) do
		item:SetProperty(k, v)
	end
end)