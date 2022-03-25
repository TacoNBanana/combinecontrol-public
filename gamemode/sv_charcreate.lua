net.Receive("nCreateCharacter", function(len, ply)
	local mul = ply:IsSuperAdmin() and 3 or ply:IsAdmin() and 2 or 1
	if ply:SQLGetNumChars() >= GAMEMODE.MaxCharacters*mul then return end
	if not ply:IsAdmin() and GAMEMODE.CurrentLocation != LOCATION_CITY then return end

	local name = net.ReadString()
	local desc = net.ReadString()
	local model = net.ReadString()
	local skin = net.ReadUInt(5)
	local trait = net.ReadFloat()

	local r, err = GAMEMODE:CheckCharacterValidity(name, desc, model, skin, trait)

	if r then

		ply:SaveNewCharacter(name, desc, model, skin, trait)

	end
end)

net.Receive("nSelectCharacter", function(len, ply)
	local id = net.ReadFloat()

	if ply:SQLCharExists(id) then

		if ply:CharID() == id then return end

		if GAMEMODE.CurrentLocation and ply:GetCharFromID(id).Location != GAMEMODE.CurrentLocation and not ply:CanIgnoreTravelRestrictions(ply:GetCharFromID(id)) then return end

		ply:LoadCharacter(ply:GetCharFromID(id))

	end
end)

net.Receive("nDeleteCharacter", function(len, ply)
	local id = net.ReadFloat()

	if ply:SQLCharExists(id) then

		if ply:CharID() == id then return end

		local char = ply:GetCharFromID(id)

		ply:DeleteCharacter(id, char.RPName)

	end
end)

net.Receive("nChangeRPName", function(len, ply)
	local name = net.ReadString()

	name = string.Trim(name)

	if #name <= GAMEMODE.MaxNameLength and #name >= GAMEMODE.MinNameLength then

		if GAMEMODE:CheckNameValidity(name) then
			GAMEMODE:WriteLog("character_setname", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), Name = name})

			ply:SetRPName(name)
			ply:UpdateCharacterField("RPName", name)

			GAMEMODE:PlayerUpdateName(ply)
		end

	end
end)

net.Receive("nChangeTitle", function(len, ply)
	local desc = net.ReadString()

	desc = string.Trim(desc)

	if #desc <= GAMEMODE.MaxDescLength then
		GAMEMODE:WriteLog("character_setdesc", {Char = GAMEMODE:LogCharacter(ply), Ply = GAMEMODE:LogPlayer(ply), New = desc})

		ply:SetDescription(desc)
		ply:UpdateCharacterField("Title", desc)
	end
end)

net.Receive("nSetNewbieStatus", function(len, ply)
	local status = 1 - net.ReadBit()

	ply:SetNewbieStatus(status)
	ply:UpdatePlayerField("NewbieStatus", status)
end)
