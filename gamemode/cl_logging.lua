net.Receive("nSendLogs", function(len)
	if not IsValid(CCP.AdminMenu.LogsPanel) then
		return
	end

	local identifier = net.ReadString()
	local timestamp = net.ReadInt(32)
	local data = net.ReadString()

	CCP.AdminMenu.LogsPanel:AddLog(identifier, timestamp, data)
end)

function GM:OutputLogData(data)
	for k, v in pairs(data) do
		local val

		if istable(v) then
			if not v._meta then
				continue
			end

			if v._meta == META_CHAR then
				val = GAMEMODE:FormatCharacter(v)
			elseif v._meta == META_ITEM then
				val = GAMEMODE:FormatItem(v)
			elseif v._meta == META_PLY then
				val = GAMEMODE:FormatPlayer(v)
			end
		else
			val = v
		end

		print(k .. "\t=\t" .. string.FirstToUpper(val))
	end
end