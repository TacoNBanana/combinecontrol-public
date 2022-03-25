function ITEM:AddNetworkedPlayer(ply)
	if not IsValid(ply) then
		return
	end

	self.NetworkedPlayers[ply:EntIndex()] = ply
	self:UpdateClients(self:GetUpdateTargets())
end

function ITEM:RemoveNetworkedPlayer(ply)
	if not IsValid(ply) then
		return
	end

	self.NetworkedPlayers[ply:EntIndex()] = nil
	self:UnloadClients(self:GetUnloadTargets())
end

function ITEM:ClearNetworkedPlayers()
	self.NetworkedPlayers = {}
end

function ITEM:GetUpdateTargets()
	local location = self.StoreType
	local tab = {}

	if location == ITEM_PLAYER then
		local ply = self.Player

		if IsValid(ply) then
			table.insert(tab, ply)
		end

		for _, v in pairs(self.NetworkedPlayers) do
			if IsValid(v) and v != ply then
				table.insert(tab, v)
			end
		end
	elseif location == ITEM_WORLD or location == ITEM_AUGMENT then
		tab = player.GetAll()
	end

	return tab
end

function ITEM:GetUnloadTargets()
	local tab = player.GetAll()

	for _, v in pairs(self:GetUpdateTargets()) do
		table.RemoveByValue(tab, v)
	end

	return tab
end

function ITEM:UpdateClients(targets)
	local location = self.StoreType

	if self.Unloaded then
		return
	end

	net.Start("nSendItem")
		net.WriteInt(self.ID, 32)
		net.WriteString(self:GetClass())
		net.WriteTable(self.Overrides)
		net.WriteInt(location, 8)

		if location == ITEM_PLAYER then
			net.WriteInt(self.CharacterID, 32)
		elseif location == ITEM_WORLD then
			net.WriteInt(self.PhysicalEntityIndex, 32)
		end

	if not targets or #targets <= 0 then
		net.Broadcast()
	else
		net.Send(targets)
	end
end

function ITEM:UnloadClients(targets)
	net.Start("nUnloadItem")
		net.WriteInt(self.ID, 32)
	if not targets or #targets <= 0 then
		net.Broadcast()
	else
		net.Send(targets)
	end
end