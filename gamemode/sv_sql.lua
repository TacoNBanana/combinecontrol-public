require("mysqloo")

local meta = FindMetaTable("Player")

function GM:InitSQL()
	if not self.SQL then
		self.SQLQueue = {}
	end

	hook.Run("CC.SV.InitSQL")

	self.SQL = dbal.new(self.MySQLType,
		self.MySQLHost,
		self.MySQLUser,
		self.MySQLPass,
		self.MySQLDB,
		self.MySQLPort,
		self.MySQLAliases)
end

hook.Add("DbalConnected", "sql.DbalConnected", function(db)
	if db.Name != GAMEMODE.MySQLDB then
		return
	end

	GAMEMODE.NoMySQL = false

	timer.Simple(0, function() GAMEMODE:InitSQLTables() end)

	for k, v in pairs(GAMEMODE.SQLQueue) do

		timer.Simple(0.01 * (k - 1), function()

			GAMEMODE:RawQuery(v[1], v[2], unpack(v[3]))

		end)

	end

	GAMEMODE.SQLQueue = {}
end)

hook.Add("DbalConnectionFailed", "sql.DbalConnectionFailed", function(db, err)
	if db != GAMEMODE.SQL then
		return
	end

	GAMEMODE:LogBug("ERROR: MySQL connection failed (\"" .. err .. "\").")
	GAMEMODE.NoMySQL = true

	if string.find(err, "Unknown MySQL server host") then return end

	GAMEMODE:InitSQL()
end)

function GM:DbalCreateQueryFailed(db, query, cb, ...)
	self:LogBug("ERROR: MySQL query \"" .. query .. "\" could not be created. Reconnecting SQL.")

	table.insert(self.SQLQueue, {query, cb, {...}})
	self.SQL:abortAllQueries()
	self.SQL:connect()
end

function GM:DbalQueryFailed(db, query, err, trace)
	self:LogBug("ERROR: MySQL query \"" .. query .. "\" failed (\"" .. err .. "\").")
end

function GM:DbalQueryAborted(db, query)
	self:LogBug("ERROR: MySQL query \"" .. query .. "\" aborted.")
end

function GM:DbalTransactionFailed(db, err, trace)
	self:LogBug("ERROR: MySQL transaction failed (\"" .. err .. "\").")
end

function GM:AddSQLColumn(tabname, column, type, default)
	local tab = self.SQLTables[tabname]

	assertf(tab, "SQL table '%s' does not exist", tabname)
	assertf(not tab[column], "SQL column '%s.%s' already exists", tabname, column)

	local data = {Type = type}

	if default then
		data.Default = tostring(default)
	end

	tab[column] = data
end

GM.SQLTables = {}

GM.SQLTables.chars = {
	["SteamID"] 			= {Type = "VARCHAR(30)"},
	["RPName"] 				= {Type = "VARCHAR(64)"},
	["Model"] 				= {Type = "VARCHAR(64)"},
	["Skin"] 				= {Type = "TINYINT(11)", 	Default = "0"},
	["Title"] 				= {Type = "VARCHAR(2048)", 	Default = ""},
	["Inventory"] 			= {Type = "VARCHAR(2048)", 	Default = ""},
	["Money"] 				= {Type = "MEDIUMINT(11)", 	Default = "0"},
	["Trait"] 				= {Type = "MEDIUMINT(11)", 	Default = TRAIT_NONE},
	["Lang"] 				= {Type = "MEDIUMINT(11)", 	Default = LANG_ENGLISH},
	["CharFlags"] 			= {Type = "VARCHAR(10)", 	Default = ""},
	["BusinessLicenses"] 	= {Type = "FLOAT", 			Default = "0"},
	["CriminalRecord"] 		= {Type = "VARCHAR(2048)", 	Default = ""},
	["Date"] 				= {Type = "VARCHAR(20)", 	Default = ""},
	["LastOnline"] 			= {Type = "VARCHAR(20)", 	Default = ""},
	["Location"] 			= {Type = "TINYINT(3)", 	Default = "1"},
	["EntryPort"] 			= {Type = "TINYINT(3)", 	Default = "1"},
	["EntryTime"] 			= {Type = "VARCHAR(20)", 	Default = ""},
	["CharacterScale"] 		= {Type = "FLOAT", 			Default = "1"},
	["Deleted"] 			= {Type = "BIT(1)", 		Default = ""}
}

GM.SQLTables.players = {
	["LastName"] 			= {Type = "VARCHAR(128)", 	Default = ""},
	["ToolTrust"] 			= {Type = "INT", 			Default = "0"},
	["PhysTrust"] 			= {Type = "INT", 			Default = "1"},
	["PropTrust"] 			= {Type = "INT", 			Default = "1"},
	["NewbieStatus"] 		= {Type = "INT", 			Default = NEWBIE_STATUS_NEW},
	["PlayerFlags"] 		= {Type = "VARCHAR(128)", 	Default = ""},
	["ScoreboardTitle"] 	= {Type = "VARCHAR(100)", 	Default = ""},
	["ScoreboardTitleC"] 	= {Type = "VARCHAR(100)", 	Default = "200 200 200"},
	["ScoreboardBadges"] 	= {Type = "INT", 			Default = "0"},
	["LastNotesUpdate"] 	= {Type = "INT", 			Default = "0"},
	["IsOOCMuted"] 			= {Type = "INT", 			Default = "0"},
	["IsTravelBanned"] 		= {Type = "INT", 			Default = "0"},
	["Donations"] 			= {Type = "TEXT"},
	["PhysgunMode"] 		= {Type = "INT", 			Default = "0"},
	["DroneFlags"] 			= {Type = "TEXT"},
	["ActiveDroneFlag"] 	= {Type = "VARCHAR(128)",    Default = ""},
	["DonatorActive"] 		= {Type = "INT", 			Default = "0"},
	["CustomModelAuths"] 	= {Type = "INT", 			Default = "0"},
}

GM.SQLTables.bans = {
	["UserSteamID"] 		= {Type = "VARCHAR(30)"},
	["AdminSteamID"]		= {Type = "VARCHAR(30)"},
	["Date"] 				= {Type = "INT"},
	["Length"] 				= {Type = "INT"},
	["Reason"] 				= {Type = "VARCHAR(512)", 	Default = ""},
	["LifterSteamID"]		= {Type = "VARCHAR(30)",	Default = ""},
	["Lifted"]				= {Type = "BIT(1)",			Default = ""}
}

GM.SQLTables.notes = {
	["SteamID"] 			= {Type = "VARCHAR(30)"},
	["Title"] 				= {Type = "VARCHAR(100)"},
	["Content"] 			= {Type = "VARCHAR(2048)"},
	["Date"] 				= {Type = "VARCHAR(20)"},
	["Admin"] 				= {Type = "VARCHAR(32)"},
	["Removed"] 			= {Type = "BIT(1)", 		Default = ""},
	["LastEdit"] 			= {Type = "VARCHAR(20)", 	Default = ""},
	["LastEditor"] 			= {Type = "VARCHAR(32)", 	Default = ""}
}

GM.SQLTables.items = {
	["ItemClass"] 			= {Type = "VARCHAR(256)", 	Default = ""},
	["CustomData"] 			= {Type = "VARCHAR(2048)", 	Default = "[]"},
	["StorageType"] 		= {Type = "INT", 			Default = "0"},
	["CharacterID"] 		= {Type = "INT", 			Default = "0"},
	--["ContainerID"] 		= {Type = "INT",			Default = "0"},
	["WorldX"] 				= {Type = "FLOAT", 			Default = "0"},
	["WorldY"] 				= {Type = "FLOAT", 			Default = "0"},
	["WorldZ"] 				= {Type = "FLOAT", 			Default = "0"},
	["WorldAP"] 			= {Type = "FLOAT", 			Default = "0"},
	["WorldAY"] 			= {Type = "FLOAT", 			Default = "0"},
	["WorldAR"] 			= {Type = "FLOAT", 			Default = "0"},
	["WorldFrozen"] 		= {Type = "BIT(1)", 		Default = ""},
	["WorldMap"] 			= {Type = "VARCHAR(256)", 	Default = ""},
	["Deleted"] 			= {Type = "BIT(1)", 		Default = ""}
}

GM.SQLTables.logs = {
	["Category"] 			= {Type = "INT", 			Default = "0"},
	["Data"] 				= {Type = "VARCHAR(4096)", 	Default = "[]"},
	["Identifier"] 			= {Type = "VARCHAR(64)", 	Default = ""},
	["Timestamp"] 			= {Type = "INT", 			Default = "0"}
}

GM.SQLTables.worldents = {
	["MapPos"] 				= {Type = "TEXT"},
	["CustomData"] 			= {Type = "TEXT"},
	["Class"] 				= {Type = "VARCHAR(256)", 	Default = ""},
	["MapName"] 			= {Type = "VARCHAR(256)", 	Default = ""}
}

function GM:InitSQLTable(tab, data)
	if not data then
		return
	end

	local fields = {}

	for _, col in pairs(self.SQL:RawQuery("SHOW COLUMNS FROM " .. tab)) do
		fields[col.Field] = true
	end

	for field, v in pairs(data) do
		if fields[field] then
			continue
		end

		self:LogSQL("Column \"" .. field .. "\" does not exist in table " .. tab .. ", creating...")

		self.SQL:RawQuery(([[
			ALTER TABLE %s
				ADD COLUMN %s %s NOT NULL%s
			]]):format(tab, field, v.Type, v.Default and (" DEFAULT '%s'"):format(v.Default) or ""), stub)
	end
end

function GM:InitSQLTables()
	self.SQL:Query("CREATE TABLE IF NOT EXISTS $chars (id INT NOT NULL auto_increment, PRIMARY KEY (id))")
	self.SQL:Query("CREATE TABLE IF NOT EXISTS $players (SteamID VARCHAR(30) NOT NULL, PRIMARY KEY (SteamID))")
	self.SQL:Query("CREATE TABLE IF NOT EXISTS $bans (id INT NOT NULL auto_increment, PRIMARY KEY (id))")
	self.SQL:Query("CREATE TABLE IF NOT EXISTS $notes (id INT NOT NULL auto_increment, PRIMARY KEY (id))")
	self.SQL:Query("CREATE TABLE IF NOT EXISTS $items (id INT NOT NULL auto_increment, PRIMARY KEY (id))")
	self.SQL:Query("CREATE TABLE IF NOT EXISTS $logs (id INT NOT NULL auto_increment, PRIMARY KEY (id))")
	self.SQL:Query("CREATE TABLE IF NOT EXISTS $worldents (id INT NOT NULL auto_increment, PRIMARY KEY (id))")

	self.SQL:Query([[
		CREATE TABLE IF NOT EXISTS $logcharacters (
			logid INT NOT NULL,
			charid INT NOT NULL,
		PRIMARY KEY (logid, charid),
		FOREIGN KEY (logid)
			REFERENCES $logs(id)
			ON UPDATE RESTRICT
			ON DELETE CASCADE
		)]])

	self.SQL:Query([[
		CREATE TABLE IF NOT EXISTS $logitems (
			logid INT NOT NULL,
			itemid INT NOT NULL,
		PRIMARY KEY(logid, itemid),
		FOREIGN KEY (logid)
			REFERENCES $logs(id)
			ON UPDATE RESTRICT
			ON DELETE CASCADE
		)]])

	self.SQL:Query([[
		CREATE TABLE IF NOT EXISTS $logplayers (
			logid INT NOT NULL,
			steamid VARCHAR(30) NOT NULL,
		PRIMARY KEY(logid, steamid),
		FOREIGN KEY (logid)
			REFERENCES $logs(id)
			ON UPDATE RESTRICT
			ON DELETE CASCADE
		)]])

	for k, v in pairs(self.MySQLAliases) do
		self:InitSQLTable(v, self.SQLTables[k])
	end
end

function GM:LoadBans()
	local function cb(res)
		self:LogSQL("Banlist successfully retrieved. " .. #res .. " entries loaded.")
		self.BanTable = self.BanTable or {}

		for _, data in pairs(res) do
			self.BanTable[data.id] = data
		end

		for id, data in pairs(self.BanTable) do
			if data.Length > 0 and ((data.Date + data.Length) < os.time()) then
				self:RemoveBan(id, data.UserSteamID, "time's up")
			end
		end
	end

	self.SQL:Query("SELECT * FROM $bans WHERE Lifted = 0", cb)
end

function GM:AddBan(userSteam, len, reason, adminSteam)
	local data = {
		UserSteamID = userSteam,
		AdminSteamID = adminSteam or "SERVER",
		Length = math.Round(len) * 60,
		Reason = reason,
		Date = os.time(),
		Lifted = 0
	}

	self.SQL:Insert("$bans", data, function(res)
		self:LogSQL("Banned SteamID " .. userSteam .. " for " .. math.Round(len) .. " minutes (" .. ("%s"):format(reason) .. ").")
		self.BanTable[res[1].id] = data
	end)
end

function GM:RemoveBan(id, userSteam, r, lifterSteam)
	local function cb(res)
		self:LogSQL("Unbanned SteamID " .. userSteam .. ": " .. r .. ".")
		self.BanTable[id] = nil
	end

	self.SQL:Update("$bans", {Lifted = 1, LifterSteamID = lifterSteam or "SERVER"}, "id = ?", id, cb)
end

function GM:LookupBans(userSteam)
	local t = {}

	for id, data in pairs(self.BanTable) do
		if data.UserSteamID == userSteam and data.Lifted == 0 then
			t[id] = data
		end
	end

	return t
end

function meta:SQLSaveNewPlayer()
	local function cb(res)
		GAMEMODE:LogSQL("Created new player record for user " .. self:Nick() .. ".")

		local tab = {}
		tab["SteamID"] = self:SteamID()

		for field, v in pairs(GAMEMODE.SQLTables.players) do
			if v.Default then
				tab[field] = v.Default
			end
		end

		self.SQLPlayerData = tab
		self:LoadPlayer(self.SQLPlayerData)
		self:LoadCharsInfo()
	end

	GAMEMODE:LogSQL("Creating new player record for user " .. self:Nick() .. "...")

	GAMEMODE.SQL:Insert("$players", {SteamID = self:SteamID()}, cb)
end

function meta:PostLoadCharsInfo()
	if self:SQLGetNumChars() > 0 then

		net.Start("nCharacterList")
			net.WriteTable(self.SQLCharData)
		net.Send(self)

		net.Start("nOpenCharCreate")

			if not self:IsAdmin() and GAMEMODE.CurrentLocation != LOCATION_CITY then
				net.WriteFloat(CC_SELECT)
			else
				local mul = self:IsSuperAdmin() and 3 or self:IsAdmin() and 2 or 1
				if self:SQLGetNumChars() < GAMEMODE.MaxCharacters*mul then
					net.WriteFloat(CC_CREATESELECT)
				else
					net.WriteFloat(CC_SELECT)
				end
			end
		net.Send(self)

	else

		if GAMEMODE.CurrentLocation and GAMEMODE.CurrentLocation != LOCATION_CITY then

			net.Start("nConnect")
				net.WriteString(IP_GENERAL .. ":" .. PORT_CITY)
			net.Send(self)
			return

		end

		net.Start("nOpenCharCreate")
			net.WriteFloat(CC_CREATE)
		net.Send(self)

	end
end

function meta:PostLoadPlayerInfo()
	net.Start("nIntroStart")
		net.WriteFloat(0)
	net.Send(self)

	if not self:SQLHasPlayer() then

		self:SQLSaveNewPlayer()

	else

		self:LoadPlayer(self.SQLPlayerData)
		self:LoadCharsInfo()

	end

	self:UpdateCharacterField("LastName", self:Nick())
end

function meta:LoadCharsInfo()
	GAMEMODE.SQL:Query("SELECT * FROM $chars WHERE SteamID = ? AND Deleted = 0", self:SteamID(), function(res)
		self.SQLCharData = res
		self:PostLoadCharsInfo()
	end)
end

function meta:LoadPlayerInfo()
	GAMEMODE.SQL:Query("SELECT * FROM $players WHERE SteamID = ?", self:SteamID(), function(res)
		self.SQLPlayerData = res[1]
		self:PostLoadPlayerInfo()
	end)
end

function meta:SQLCharExists(id)
	for _, v in pairs(self.SQLCharData) do

		if tonumber(v.id) == id then

			return true

		end

	end

	return false
end

function meta:SQLHasPlayer()
	return self.SQLPlayerData and table.Count(self.SQLPlayerData) > 0
end

function meta:SQLGetNumChars()
	if not self.SQLCharData then return 0 end

	return #self.SQLCharData
end

function meta:GetCharFromID(id)
	for _, v in pairs(self.SQLCharData) do

		if tonumber(v.id) == id then

			return v

		end

	end
end

function meta:GetCharIndexFromID(id)
	for k, v in pairs(self.SQLCharData) do

		if tonumber(v.id) == id then

			return k

		end

	end
end

function meta:SaveNewCharacter(name, title, model, skin, trait)
	local d = os.date("!%m/%d/%y %H:%M:%S")

	local data = {
		SteamID = self:SteamID(),
		RPName = name,
		Title = title,
		Model = model,
		Skin = skin,
		Trait = trait,
		Lang = LANG_ENGLISH,
		Date = d
	}

	local function cb(res)
		GAMEMODE:LogSQL("Player " .. self:Nick() .. " created character " .. name .. ".")

		data.id = res[1].id
		for field, v in pairs(GAMEMODE.SQLTables.chars) do
			if not data[field] and v.Default then
				data[field] = v.Default
			end
		end

		table.insert(self.SQLCharData, data)

		net.Start("nCharacterList")
			net.WriteTable(self.SQLCharData)
		net.Send(self)

		self:LoadCharacter(data)
	end

	GAMEMODE.SQL:Insert("$chars", data, cb)
end

function GM:DeleteCharacter(id, deleter, name)
	self.SQL:Update("$chars", {Deleted = 1}, "id = ?", id, function(res)
		self:LogSQL("Player " .. deleter .. " deleted character " .. name .. ".")
	end)
end

function meta:DeleteCharacter(id, name)
	for k, v in pairs(self.SQLCharData) do
		if v.id == id then
			table.remove(self.SQLCharData, k)
		end
	end

	GAMEMODE.SQL:Update("$chars", {Deleted = 1}, "id = ?", id, function(res)
		GAMEMODE:LogSQL("Player " .. self:Nick() .. " deleted character " .. name .. ".")
	end)
end

function meta:UpdateCharacterField(field, value, nolog)
	if self:IsBot() then return end
	if self:CharID() == -1 then return end
	if self.SQLCharData[self:GetCharIndexFromID(self:CharID())][field] == tostring(value) then return end

	GAMEMODE.SQL:Update("$chars", {[field] = value}, "id = ?", self:CharID(), function(res)
		if not nolog then
			GAMEMODE:LogSQL("Player " .. self:Nick() .. " (" .. self:RPName() .. ") updated character field " .. field .. " to " .. tostring(value) .. ".")
		end

		self.SQLCharData[self:GetCharIndexFromID(self:CharID())][field] = tostring(value)
	end)
end

function GM:UpdateCharacterFieldOffline(id, field, value, nolog)
	self.SQL:Update("$chars", {[field] = value}, "id = ?", id, function(res)
		if not nolog then
			GAMEMODE:LogSQL("Character " .. id .. " updated character field " .. field .. " to " .. tostring(value) .. ".")
		end
	end)

	for _, v in pairs(player.GetAll()) do
		for _, char in pairs(v.SQLCharData) do
			if char.id == id then
				char[field] = value
			end
		end
	end
end

function GM:AddCharacterFieldOffline(id, field, value, min, max)
	local function cb(cur)
		local new = math.Clamp(tonumber(cur[1][field]) + tonumber(value), min or -math.huge, max or math.huge)

		self.SQL:Update("$chars", {[field] = new}, "id = ?", id, function(res)
			self:LogSQL("Character " .. id .. " updated character field " .. field .. " to " .. tostring(new) .. ".")
		end)
	end

	self.SQL:Query(("SELECT %s FROM $chars WHERE id = ?"):format(field), id, cb)
end

function meta:UpdatePlayerField(field, value)
	GAMEMODE.SQL:Update("$players", {[field] = value}, "SteamID = ?", self:SteamID(), function(res)
		GAMEMODE:LogSQL("Player " .. self:Nick() .. " (" .. self:RPName() .. ") updated player field " .. field .. " to " .. tostring(value) .. ".")
		self.SQLPlayerData[field] = tostring(value)
	end)
end

function GM:UpdatePlayerFieldOffline(steamid, field, value)
	self.SQL:Update("$players", {[field] = value}, "SteamID = ?", SteamID(), function(res)
		GAMEMODE:LogSQL("Player " .. steamid .. " updated player field " .. field .. " to " .. tostring(value) .. ".")
	end)
end

function GM:AddPlayerFieldOffline(steamid, field, value)
	local function cb(cur)
		local new = math.Clamp(tonumber(cur[1][field]) + tonumber(value), min or -math.huge, max or math.huge)

		self.SQL:Update("$players", {[field] = new}, "SteamID = ?", steamid, function(res)
			self:LogSQL("Player " .. steamid .. " updated player field " .. field .. " to " .. tostring(new) .. ".")
		end)
	end

	self.SQL:Query(("SELECT %s FROM $players WHERE SteamID = ?"):format(field), steamid, cb)
end

function GM:GetCharacterList(steamID, requester)
	local function cb(res)
		net.Start("nAListCharacters")
			net.WriteString(steamID)
			net.WriteTable(res)
		net.Send(requester)
	end

	self.SQL:Query([[
		SELECT id, RPName, CharFlags FROM $chars
			WHERE SteamID = ? AND Deleted = 0
		]], steamID, cb)
end

function GM:GetCharacterData(charid, requester)
	local fields = {
		"SteamID", "RPName", "Model", "Money"
	}

	local function cb(res)
		net.Start("nACharacterData")
			net.WriteInt(charid, 32)
			net.WriteTable(res)
		net.Send(requester)
	end

	self.SQL:Query([[
		SELECT ]] .. table.concat(fields, ", ") .. [[ FROM $chars
			WHERE id = ? AND Deleted = 0
		]], charid, cb)
end

function GM:GetCharacterInventory(charid, requester)
	local function cb(res)
		net.Start("nACharacterInventory")
			net.WriteInt(charid, 32)
			net.WriteTable(res)
		net.Send(requester)
	end

	self.SQL:Query([[
		SELECT RPName, Inventory FROM $chars
			WHERE id = ? AND Deleted = 0
		]], charid, cb)
end

function GM:CharacterLookup(name, requester)
	local function cb(res)
		net.Start("nACharacterLookup")
			net.WriteString(name)
			net.WriteTable(res)
		net.Send(requester)
	end

	self.SQL:Query([[
		SELECT id, RPName, SteamID, CharFlags FROM $chars
			WHERE RPName LIKE ? AND Deleted = 0
		LIMIT 500
		]], name, cb)
end
