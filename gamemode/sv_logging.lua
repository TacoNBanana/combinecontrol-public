function GM:WriteLog(identifier, data)
	local logtype = self.LogTypes[identifier]

	assertf(logtype, "Invalid log identifier: %s", identifier)

	local json = util.TableToJSON(data)
	local time = os.time()
	local dbdata = {
		Category = logtype.Category,
		Data = json,
		Identifier = identifier,
		Timestamp = time
	}

	self.SQL:Insert("$logs", dbdata, function(res)
		local id = res[1].id

		local cache = {
			[META_CHAR] = {},
			[META_ITEM] = {},
			[META_PLY] = {}
		}

		for _, v in pairs(data) do
			if not istable(v) or not v._meta then
				continue
			end

			if v._meta == META_CHAR and not cache[META_CHAR][v.CharID] then
				cache[META_CHAR][v.CharID] = true

				self.SQL:Insert("$logcharacters", {logid = id, charid = v.CharID}, stub)
			elseif v._meta == META_ITEM and not cache[META_ITEM][v.ItemID] then
				cache[META_ITEM][v.ItemID] = true

				self.SQL:Insert("$logitems", {logid = id, itemid = v.ItemID}, stub)
			elseif v._meta == META_PLY and not cache[META_PLY][v.SteamID] then
				cache[META_PLY][v.SteamID] = true

				self.SQL:Insert("$logplayers", {logid = id, steamid = v.SteamID}, stub)
			end
		end

		MsgC(Color(200, 200, 200, 255), string.format("[%s] [%s] - %s", os.date("%Y-%m-%d %H:%M:%S", time), identifier, GAMEMODE:ParseLog(identifier, data)), "\n")
	end)
end

function GM:WriteChatLog(ply, class, lang, text, custom)
	if lang then
		lang = (lang != self.Languages.eng) and lang.Alias or nil
	end

	local tab = {
		Ply = self:LogPlayer(ply),
		Char = self:LogCharacter(ply),
		Class = string.lower(class.Name),
		Lang = lang,
		Text = text,
	}

	if custom then
		for k, v in pairs(custom) do
			tab[k] = v
		end
	end

	local name = class.LogName and string.lower(class.LogName) or string.lower(class.Name)

	self:WriteLog("chat_" .. name, tab)
end

function GM:LogCharacter(ply)
	return {
		_meta = META_CHAR,
		CharID = ply:CharID(),
		CharName = ply:VisibleRPName(),
		TrueName = ply:RPName()
	}
end

function GM:LogItem(item, amount)
	local tab = {
		_meta = META_ITEM,
		ItemClass = item:GetClass(),
		ItemID = item.ID,
		Stacking = class.IsTypeOf(item, "base_stacking"),
		Custom = class.IsTypeOf(item, "item_custom"),
	}

	if tab.Stacking then
		tab.Amount = amount or item:GetAmount()
	end

	if tab.Custom then
		tab.Name = item:GetProperty("Name")
	end

	return tab
end

function GM:LogPlayer(ply)
	local tab = {
		_meta = META_PLY,
	}

	if isstring(ply) then
		tab.Nick = "Unknown"
		tab.SteamID = ply
	else
		tab.Nick = ply:Nick()
		tab.SteamID = ply:SteamID()
	end

	return tab
end

function GM:ReadLogs(filters, callback)
	local join = ""
	local where = ""
	local args = {}

	local filtertypes = {
		category = {" AND $logs.Category = ?"},
		identifier = {" AND $logs.Identifier = ?"},
		charid = {" AND $logcharacters.charid = ?", "JOIN $logcharacters ON $logs.id = $logcharacters.logid"},
		itemid = {" AND $logitems.itemid = ?", "JOIN $logitems ON $logs.id = $logitems.logid"},
		steamid = {" AND $logplayers.steamid = ?", "JOIN $logplayers ON $logs.id = $logplayers.logid"},
		timestamp = {" AND $logs.Timestamp < ?"}
	}

	for k, v in pairs(filters) do
		local tab = filtertypes[k]
		if tab then
			where = where .. tab[1]

			table.insert(args, v)

			if tab[2] then
				join = string.format("%s\n%s", join, tab[2])
			end
		end
	end

	local limit = math.Clamp(filters.limit or GAMEMODE.DefaultLogLines, 1, GAMEMODE.MaxLogLines)
	local query = string.format([[
	SELECT
		$logs.Identifier,
		$logs.Timestamp,
		$logs.Data
	FROM $logs%s
	WHERE
		1=1%s
	ORDER BY $logs.id DESC
	LIMIT ?]], join, where)

	table.insert(args, limit)
	table.insert(args, callback)

	GAMEMODE.SQL:Query(query, unpack(args))
end

net.Receive("nRequestLogs", function(len, ply)
	if not IsValid(ply) or not ply:IsAdmin() then
		return
	end

	local tab = {
		category = net.ReadInt(8),
		identifier = net.ReadString(),
		charid = net.ReadInt(32),
		itemid = net.ReadInt(32),
		steamid = net.ReadString(),
		limit = net.ReadInt(32),
		timestamp = net.ReadInt(32)
	}

	for k, v in pairs(tab) do
		if k == "identifier" and v == "Any" then
			tab[k] = nil
		elseif k == "steamid" then
			tab[k] = IsValidSteamID(v) and v or nil
		elseif isnumber(v) then
			tab[k] = v > 0 and tab[k] or nil
		end
	end

	local callback = function(data)
		for _, v in pairs(data) do
			net.Start("nSendLogs")
				net.WriteString(v.Identifier)
				net.WriteInt(v.Timestamp, 32)
				net.WriteString(v.Data)
			net.Send(ply)
		end
	end

	GAMEMODE:ReadLogs(tab, callback)
end)
