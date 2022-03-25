local meta = FindMetaTable("Player")

function GM:PlayerNotes(viewer, ply)
	net.Start("nPlayerNotes")
		net.WriteEntity(ply)
		net.WriteTable(ply.PlayerNotes or {})
	net.Send(viewer)
end

net.Receive("nAddNote", function(len, ply)
	local targ = net.ReadEntity()
	local title = net.ReadString()
	local content = net.ReadString()

	if not ply:IsAdmin() then
		GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:Nick(), "Tried to access player notes as a player!")

		return
	end

	if IsValid(targ) then
		targ:AddPlayerNote(title, content, ply)
	end
end)

net.Receive("nEditNote", function(len, ply)
	local targ = net.ReadEntity()
	local id = net.ReadInt(32)
	local content = net.ReadString()

	if not ply:IsAdmin() then
		GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:Nick(), "Tried to access player notes as a player!")

		return
	end

	if IsValid(targ) then
		targ:EditPlayerNote(id, content, ply)
	end
end)

net.Receive("nRemoveNote", function(len, ply)
	local targ = net.ReadEntity()
	local id = net.ReadInt(32)

	if not ply:IsAdmin() then
		GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:Nick(), "Tried to access player notes as a player!")

		return
	end

	if IsValid(targ) then
		targ:RemovePlayerNote(id, ply)
	end
end)

net.Receive("nRefreshNotes", function(len, ply)
	local targ = net.ReadEntity()

	if not ply:IsAdmin() then
		GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:Nick(), "Tried to access player notes as a player!")

		return
	end

	GAMEMODE:PlayerNotes(ply, targ)
end)

util.AddNetworkString("nPlayerNotes")
util.AddNetworkString("nAddNote")
util.AddNetworkString("nEditNote")
util.AddNetworkString("nRemoveNote")
util.AddNetworkString("nRefreshNotes")

function meta:LoadPlayerNotes()
	local function cb(res)
		self.PlayerNotes = {}

		for _, v in pairs(res) do
			self.PlayerNotes[v["id"]] = v
		end
	end

	GAMEMODE.SQL:Query([[
		SELECT * FROM $notes
			WHERE steamid = ? AND Removed = 0
		]], self:SteamID(), cb)
end

function meta:AddPlayerNote(title, content, author)
	local timestamp = os.date("!%m/%d/%y %H:%M:%S")
	local steamid = self:SteamID()
	local name = author:Nick()
	local data = {
		SteamID = steamid,
		Title = title,
		Content = content,
		Date = timestamp,
		Admin = name
	}

	self:SetLastNotesUpdate(os.time(), true)
	self:UpdatePlayerField("LastNotesUpdate", self:LastNotesUpdate())

	local function cb(res)
		GAMEMODE:LogSQL(name .. " (" .. author:SteamID() .. ") added a player note for " .. steamid .. " with title '" .. title .. "'.")
		GAMEMODE:LogAdmin("[Notes] " .. name .. " added a player note for " .. steamid .. " with title '" .. title .. "'.", author)

		local tab = {}
		tab["id"] = res[1].id
		tab["Title"] = title
		tab["Content"] = content
		tab["Admin"] = name
		tab["Date"] = timestamp
		tab["SteamID"] = steamid

		self.PlayerNotes[tab.id] = tab

		GAMEMODE:PlayerNotes(author, self)
	end

	GAMEMODE.SQL:Insert("$notes", data, cb)
end

function meta:AddAutomatedPlayerNote(title, content, author)
	local timestamp = os.date("!%m/%d/%y %H:%M:%S")
	local data = {
		SteamID = self:SteamID(),
		Title = title,
		Content = content,
		Date = timestamp,
		Admin = author
	}

	self:SetLastNotesUpdate(os.time(), true)
	self:UpdatePlayerField("LastNotesUpdate", self:LastNotesUpdate())

	local function cb(res)
		local tab = {}
		tab["id"] = res[1].id
		tab["Title"] = title
		tab["Content"] = content
		tab["Admin"] = "Server"
		tab["Date"] = timestamp
		tab["SteamID"] = steamid

		if IsValid(self) then
			self.PlayerNotes[tab.id] = tab
		end
	end

	GAMEMODE.SQL:Insert("$notes", data, cb)
end

function meta:EditPlayerNote(id, content, author)
	local name = author:Nick()
	local data = {
		Content = content,
		LastEdit = os.date("!%m/%d/%y %H:%M:%S"),
		LastEditor = name
	}

	self:SetLastNotesUpdate(os.time(), true)
	self:UpdatePlayerField("LastNotesUpdate", self:LastNotesUpdate())

	local function cb(res)
		local tab = self.PlayerNotes[id]
		tab["Content"] = content
		tab["LastEditor"] = name
		tab["LastEdit"] = timestamp

		GAMEMODE:LogSQL(name .. " (" .. author:SteamID() .. ") edited player note '" .. tab["Title"] .. "' belonging to " .. tab["SteamID"] .. ".")
		GAMEMODE:LogAdmin("[Notes] " .. name .. " edited player note '" .. tab["Title"] .. "' belonging to " .. tab["SteamID"] .. ".", author)

		GAMEMODE:PlayerNotes(author, self)
	end

	GAMEMODE.SQL:Update("$notes", data, "id = ?", id, cb)
end

function meta:RemovePlayerNote(id, remover)
	local function cb(res)
		local tab = self.PlayerNotes[id]
		local name = remover:Nick()

		GAMEMODE:LogSQL(name .. " (" .. remover:SteamID() .. ") removed player note '" .. tab["Title"] .. "' belonging to " .. tab["SteamID"] .. ".")
		GAMEMODE:LogAdmin("[Notes] " .. name .. " removed player note '" .. tab["Title"] .. "' belonging to " .. tab["SteamID"] .. ".", remover)

		self.PlayerNotes[id] = nil

		GAMEMODE:PlayerNotes(remover, self)
	end

	GAMEMODE.SQL:Update("$notes", {Removed = 1}, "id = ?", id, cb)
end