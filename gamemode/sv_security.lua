function GM:SteamIDIsBanned(sid)
	local bans = self:LookupBans(sid)

	for id, data in pairs(bans) do
		if data.Length > 0 and ((data.Date + data.Length) < os.time()) then
			self:RemoveBan(id, data.UserSteamID, "time's up")
			bans[id] = nil
		end
	end

	if table.Count(bans) < 1 then return end

	local ban = bans[table.maxn(bans)]
	return math.ceil((ban.Date + ban.Length - os.time()) / 60), ban.Reason, ban.Length == 0
end

function GM:CheckPassword(steamid, networkid, svpass, pass, name)
	steamid = util.SteamIDFrom64(steamid)

	if self.AutoMapOverride then
		game.ConsoleCommand("changelevel " .. self.AutoMapOverride .. "\n")
		self.AutoMapOverride = false -- just in case...
	end

	if self.NoMySQL and not table.HasValue(GAMEMODE.Developers, steamid) then
		return false, "The server's MySQL is down for some reason - we're working on it! Check back later."
	end

	local t, r, p = self:SteamIDIsBanned(steamid)

	if t then
		if p then
			self:WriteLog("security_banned", {SteamID = steamid, Nick = name, IP = networkid, Perma = p})

			local reason = "."

			if r and #r > 0 then
				reason = " (" .. r .. ")."
			end

			return false, "You're permabanned" .. reason .. " Apply for an unban at " .. self.WebsiteURL .. "."
		else
			self:WriteLog("security_banned", {Duration = t, SteamID = steamid, Nick = name, IP = networkid})

			local reason = "."

			if r and #r > 0 then
				reason = " (" .. r .. ")."
			end

			return false, "You're banned for " .. t .. " more minutes" .. reason .. " Apply for an unban at " .. self.WebsiteURL .. "."
		end
	end

	if self.PrivateMode and not table.HasValue(self.PrivateSteamIDs, steamid) then
		self:WriteLog("security_privatemode", {SteamID = steamid, Nick = name, IP = networkid})

		return false, self.TestingClosedMessage
	end

	if svpass != "" and pass != svpass then
		self:WriteLog("security_badpassword", {SteamID = steamid, Nick = name, IP = networkid, Password = pass})

		return false, "#GameUI_ServerRejectBadPassword"
	end

	return true
end

net.Receive("nQuizBan", function(len, ply)
	local mode = net.ReadFloat()

	GAMEMODE:WriteLog("security_failedquiz", {Ply = GAMEMODE:LogPlayer(ply)})

	if mode == 1 then
		local nick = ply:Nick()

		GAMEMODE:AddBan(ply:SteamID(), GAMEMODE.QuizBanTime, "Failed quiz.")

		ply:Kick("Failed quiz")

		net.Start("nAQuizBan")
			net.WriteString(nick)
			net.WriteFloat(mode)
		net.Broadcast()
	else
		local nick = ply:Nick()

		GAMEMODE:AddBan(ply:SteamID(), GAMEMODE.QuizBanTime * 2, "Failed quiz.")

		ply:Kick("Failed quiz")

		net.Start("nAQuizBan")
			net.WriteString(nick)
			net.WriteFloat(mode)
		net.Broadcast()
	end
end)
