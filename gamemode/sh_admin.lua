local function CheckAdmin(ply, sa)
	if not IsValid(ply) then
		return false
	end

	if not ply:IsAdmin() then
		ply:SendChat(nil, "ERROR", "You need to be an admin to do this")

		return false
	elseif sa and not ply:IsSuperAdmin() then
		ply:SendChat(nil, "ERROR", "You need to be a superadmin to do this")

		return false
	end

	return true
end

local GoodTraceVectors = {
	Vector(40, 0, 0),
	Vector(-40, 0, 0),
	Vector(0, 40, 0),
	Vector(0, -40, 0),
	Vector(0, 0, 40)
}

local function FindTeleportPos(ply)
	local trace = {}
	trace.start = ply:GetShootPos()
	trace.endpos = trace.start + ply:GetAimVector() * 50
	trace.mins = Vector(-16, -16, 0)
	trace.maxs = Vector(16, 16, 72)
	trace.filter = ply
	local tr = util.TraceHull(trace)

	if not tr.Hit then
		return tr.HitPos
	end

	local pos = ply:GetPos()

	for _, v in pairs(GoodTraceVectors) do
		local trace = {}
		trace.start = ply:GetPos()
		trace.endpos = trace.start + v
		trace.mins = Vector(-16, -16, 0)
		trace.maxs = Vector(16, 16, 72)
		trace.filter = ply
		local tr = util.TraceHull(trace)

		if tr.Fraction == 1.0 then
			pos = ply:GetPos() + v
			break
		end
	end

	return pos
end

function concommand.AddAdmin(cmd, func, sa, typeList)
	local function c(len, ply)
		local args = net.ReadTable()

		if not CheckAdmin(ply, sa) then
			return
		end

		if typeList and #typeList > 0 then
			for k, v in pairs(typeList) do
				local arg = args[k]

				if v == TYPE_BOOL then
					local val = tobool(arg)

					args[k] = val
				elseif v == TYPE_STRING then
					local val

					if k == #typeList then
						val = tostring(table.concat(args, " ", k))
					else
						val = tostring(arg)
					end

					val = string.Trim(val)

					if val == "nil" then
						val = ""
					end

					args[k] = val
				elseif v == TYPE_NUMBER then
					local val = tonumber(arg)

					if not val then
						val = 0
					end

					args[k] = val
				elseif v == TYPE_ENTITY then -- Players
					local val = GAMEMODE:FindPlayer(arg, ply)

					if not IsValid(val) then
						ply:SendChat(nil, "ERROR", "Error: No target found")

						return
					end

					args[k] = val
				end
			end

			func(ply, unpack(args))
		else
			func(ply)
		end
	end

	if CLIENT then
		concommand.Add(cmd, function(ply, cmd, args)
			net.Start("CC.CMD." .. cmd)
				net.WriteTable(args)
			net.SendToServer()
		end)
	else
		util.AddNetworkString("CC.CMD." .. cmd)
		net.Receive("CC.CMD." .. cmd, c)
	end
end

concommand.AddAdmin("rpa_restart", function(ply)
	net.Start("nARestart")
		net.WriteEntity(ply)
	net.Broadcast()

	GAMEMODE:WriteLog("admin_restart", {Admin = GAMEMODE:LogPlayer(ply)})

	timer.Simple(5, function() game.ConsoleCommand("changelevel " .. game.GetMap() .. "\n") end)
end, false)

concommand.AddAdmin("rpa_stopsound", function(ply)
	net.Start("nAStopSound")
	net.Broadcast()
end, false)


concommand.AddAdmin("rpa_aidisabled", function(ply, bool)
	RunConsoleCommand("ai_disabled", bool)
end, false, {TYPE_BOOL})

concommand.AddAdmin("rpa_changelevel", function(ply, map)
	if not table.HasValue(GAMEMODE:GetMaps(), map) then
		net.Start("nMapList")
			net.WriteTable(GAMEMODE:GetMaps())
		net.Send(ply)

		return
	end

	GAMEMODE:WriteLog("admin_changelevel", {Admin = GAMEMODE:LogPlayer(ply), Map = map})
	GAMEMODE:SendChat(nil, player.GetAll(), "ERRORBIG", ply:Nick() .. " is changing the map to " .. map .. " in 5 seconds")

	-- Write the map file so the server auto switches on startup
	file.Write("cc_maps/" .. game.GetPort() .. ".txt", map)

	timer.Simple(5, function() game.ConsoleCommand("changelevel " .. map .. "\n") end)
end, false, {TYPE_STRING})

concommand.AddAdmin("rpa_invisible", function(ply, targ, bool)
	GAMEMODE:WriteLog("admin_invisible", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ), Bool = bool})
	targ:SetNoDraw(bool)
end, false, {TYPE_ENTITY, TYPE_BOOL})

concommand.AddAdmin("rpa_namewarn", function(ply, targ)
	GAMEMODE:WriteLog("admin_namewarn", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ)})

	net.Start("nWarnName")
	net.Send(targ)
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_kill", function(ply, targ)
	targ:Kill()

	targ:SendChat(nil, "WARNING", ply:Nick() .. " killed you")

	GAMEMODE:WriteLog("admin_kill", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ)})
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_slap", function(ply, targ)
	targ:SetVelocity(Vector(math.random(-400, 400), math.random(-400, 400), math.random(400, 600)))

	targ:SendChat(nil, "WARNING", ply:Nick() .. " slapped you")

	GAMEMODE:WriteLog("admin_slap", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ)})
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_ko", function(ply, targ)
	targ:SetConsciousness(0)
	targ:PassOut()

	targ:SendChat(nil, "WARNING", ply:Nick() .. " knocked you out")

	GAMEMODE:WriteLog("admin_ko", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ)})
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_wakeup", function(ply, targ)
	targ:SetConsciousness(100)
	targ:WakeUp()

	targ:SendChat(nil, "WARNING", ply:Nick() .. " woke you up")

	GAMEMODE:WriteLog("admin_wake", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ)})
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_kick", function(ply, targ, arg)
	local targNick = targ:Nick()
	local reason = "Kicked by " .. ply:Nick()

	if #arg > 0 then
		reason = reason .. " (" .. arg .. ")"
	end

	GAMEMODE:WriteLog("admin_kick", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ), Reason = arg})

	targ:Kick(reason)

	if #arg > 0 then
		GAMEMODE:SendChat(nil, player.GetAll(), "WARNING", ply:Nick() .. " kicked " .. targNick .. " (" .. arg .. ")")
	else
		GAMEMODE:SendChat(nil, player.GetAll(), "WARNING", ply:Nick() .. " kicked " .. targNick)
	end
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_ban", function(ply, targ, duration, reason)
	if duration < 0 then
		ply:SendChat(nil, "ERROR", "Error: Invalid duration")

		return
	end

	if #reason <= 0 then
		ply:SendChat(nil, "ERROR", "Error: Missing reason")

		return
	end

	if GAMEMODE:SteamIDIsBanned(targ:SteamID()) then
		ply:SendChat(nil, "ERROR", "Error: Player is already banned")

		return
	end

	duration = math.Round(duration)
	local targNick = targ:VisibleRPName()
	local perma = duration == 0
	local message = (perma and "Permabanned by " or "Banned by ") .. ply:Nick() .. (perma and "" or " for " .. duration .. " minutes") .. " (" .. reason .. ")"

	if not targ:IsBot() then
		targ:AddAutomatedPlayerNote("Ban log", reason, ply:Nick())

		GAMEMODE:AddBan(targ:SteamID(), duration, reason, ply:SteamID())
	end

	GAMEMODE:WriteLog("admin_ban", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ), Reason = reason, Duration = duration})

	targ:Kick(message)

	GAMEMODE:SendChat(nil, player.GetAll(), "WARNING", ply:Nick() .. (perma and " Permabanned " or " Banned ") .. targNick .. (perma and "" or " for " .. string.NiceTime(duration * 60)) .. " (" .. reason .. ")")
end, false, {TYPE_ENTITY, TYPE_NUMBER, TYPE_STRING})

concommand.AddAdmin("rpa_banoffline", function(ply, steamid, duration, reason)
	if not IsValidSteamID(steamid) then
		ply:SendChat(nil, "ERROR", "Error: SteamID is invalid")

		return
	end

	if duration < 0 then
		ply:SendChat(nil, "ERROR", "Error: Duration is invalid")

		return
	end

	if #reason <= 0 then
		ply:SendChat(nil, "ERROR", "Error: Missing reason")

		return
	end

	if GAMEMODE:SteamIDIsBanned(steamid) then
		ply:SendChat(nil, "ERROR", "Error: Player is already banned")

		return
	end

	duration = math.Round(duration)

	local perma = duration == 0

	GAMEMODE:AddBan(steamid, duration, reason, ply:SteamID())
	GAMEMODE:WriteLog("admin_ban", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(steamid), Reason = reason, Duration = duration})

	ply:SendChat(nil, "WARNING", (perma and "Permabanned " or "Banned ") .. steamid .. (perma and "" or " for " .. string.NiceTime(duration * 60)) .. " (" .. reason .. ")")
end, false, {TYPE_STRING, TYPE_NUMBER, TYPE_STRING})

concommand.AddAdmin("rpa_unban", function(ply, steamid)
	if not IsValidSteamID(steamid) then
		ply:SendChat(nil, "ERROR", "Error: SteamID is invalid")

		return
	end

	local bans = GAMEMODE:LookupBans(steamid)

	if table.Count(bans) < 1 then
		ply:SendChat(nil, "ERROR", "Error: No bans found")

		return
	end

	for id, data in pairs(bans) do
		GAMEMODE:RemoveBan(id, steamid, "Unbanned by " .. ply:SteamID(), ply:SteamID())
	end

	GAMEMODE:WriteLog("admin_unban", {Admin = GAMEMODE:LogPlayer(ply), SteamID = steamid})

	ply:SendChat(nil, "WARNING", "Unbanned " .. steamid)
end, false, {TYPE_STRING})

concommand.AddAdmin("rpa_givemoney", function(ply, targ, amt)
	if amt == 0 then
		ply:SendChat(nil, "ERROR", "Error: Invalid amount")

		return
	end

	targ:AddMoney(amt)
	targ:UpdateCharacterField("Money", tostring(targ:Money()))

	GAMEMODE:WriteLog("admin_givemoney", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ), Amount = amt})
end, true, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_goto", function(ply, targ)
	ply:SetPos(FindTeleportPos(targ))
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_bring", function(ply, targ)
	targ:SetPos(FindTeleportPos(ply))
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_seeall", function(ply)
	net.Start("nASeeAll")
	net.Send(ply)
end, false)

concommand.AddAdmin("rpa_setcharmodel", function(ply, targ, mdl)
	if not util.IsValidModel(mdl) then
		ply:SendChat(nil, "ERROR", "Error: Invalid model")

		return
	end

	targ:SetRPModel(mdl)
	targ.CharModel = mdl
	targ:UpdateCharacterField("Model", mdl)

	targ:RecalculatePlayerModel()

	GAMEMODE:WriteLog("admin_setmodel", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ), Model = mdl})

	ply:SendChat(nil, "WARNING", "You set " .. targ:RPName() .. "'s character model to \"" .. mdl .. "\"")
	targ:SendChat(nil, "WARNING", ply:Nick() .. " set your character model to \"" .. mdl .. "\"")
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_setcharskin", function(ply, targ, skin)
	targ:SetSkin(skin)
	targ.CharSkin = skin
	targ:UpdateCharacterField("Skin", skin)

	GAMEMODE:WriteLog("admin_setskin", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ), Skin = skin})

	ply:SendChat(nil, "WARNING", "You set " .. targ:RPName() .. "'s skin to " .. skin)
	targ:SendChat(nil, "WARNING", ply:Nick() .. " set your skin to " .. skin)
end, false, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_setcharname", function(ply, targ, name)
	if #name < GAMEMODE.MinNameLength then
		ply:SendChat(nil, "ERROR", "Error: Name is too short")

		return
	end

	if #name > GAMEMODE.MaxNameLength then
		ply:SendChat(nil, "ERROR", "Error: Name is too long")

		return
	end

	if not GAMEMODE:CheckNameValidity(name) then
		ply:SendChat(nil, "ERROR", "Error: Name cannot include '#', '~' or '%'")

		return
	end

	name = string.Trim(name)

	GAMEMODE:WriteLog("admin_setname", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ), Name = name})

	local old = targ:RPName()

	targ:SetRPName(name)
	targ:UpdateCharacterField("RPName", name)

	ply:SendChat(nil, "WARNING", "You set " .. old .. "'s name to " .. targ:RPName())
	targ:SendChat(nil, "WARNING", ply:Nick() .. " set your name to " .. targ:RPName())
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_tie", function(ply, targ)
	targ:SetTiedUp(true)
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_untie", function(ply, targ)
	targ:SetTiedUp(false)
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_givebadge", function(ply, targ, val)
	if val <= 0 or targ:HasBadge(val) then
		ply:SendChat(nil, "ERROR", "Error: Target already has this badge")

		return
	end

	targ:SetScoreboardBadges(targ:ScoreboardBadges() + val)
	targ:UpdatePlayerField("ScoreboardBadges", targ:ScoreboardBadges())
end, true, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_takebadge", function(ply, targ, val)
	if val <= 0 or not targ:HasBadge(val) then
		ply:SendChat(nil, "ERROR", "Error: Target doesn't this badge")

		return
	end

	targ:SetScoreboardBadges(targ:ScoreboardBadges() - val)
	targ:UpdatePlayerField("ScoreboardBadges", targ:ScoreboardBadges())
end, false, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_setcharflag", function(ply, targ, flag)
	targ:SetCharFlags(flag)
	targ:UpdateCharacterField("CharFlags", flag)

	targ:StripWeapons()

	GAMEMODE:PlayerCheckFlag(targ)
	GAMEMODE:PlayerLoadout(targ)

	GAMEMODE:LogAdmin("[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s character flag to \"" .. flag .. "\"", ply)

	if flag == "" then
		ply:SendChat(nil, "WARNING", "You removed " .. targ:RPName() .. "'s character flag")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " removed your character flag")
	else
		ply:SendChat(nil, "WARNING", "You set " .. targ:RPName() .. "'s character flag to \"" .. flag .. "\" (" .. GAMEMODE:CharFlagPrintName(flag) .. ")")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " set your character flag to \"" .. flag .. "\" (" .. GAMEMODE:CharFlagPrintName(flag) .. ")")
	end
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_setplayerflag", function(ply, targ, flag)
	targ:SetPlayerFlags(flag)
	targ:UpdatePlayerField("PlayerFlags", flag)

	GAMEMODE:LogAdmin("[F] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s player flag to \"" .. flag .. "\"", ply)

	if flag == "" then
		ply:SendChat(nil, "WARNING", "You removed " .. targ:RPName() .. "'s player flag")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " removed your player flag")
	else
		ply:SendChat(nil, "WARNING", "You set " .. targ:RPName() .. "'s player flag to \"" .. flag .. "\" (" .. GAMEMODE:PlayerFlagPrintName(flag) .. ")")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " set your player flag to \"" .. flag .. "\" (" .. GAMEMODE:PlayerFlagPrintName(flag) .. ")")
	end
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_flagsroster", function(ply)
	local function cb(res)
		if #res > 0 then
			net.Start("nAFlagsRoster")
				net.WriteTable(res)
			net.Send(ply)

			GAMEMODE:LogSQL("Player " .. ply:Nick() .. " retrieved flags roster")
		else
			ply:SendChat(nil, "ERROR", "Error: Could not retrieve flag roster")
		end
	end
	GAMEMODE.SQL:Query([[
		SELECT RPName, CharFlags FROM $chars
			WHERE CharFlags ~= '' AND Deleted = 0
		]], cb)
end, false)

concommand.AddAdmin("rpa_settooltrust", function(ply, targ, trust)
	trust = math.Clamp(math.Round(trust), 0, 2)

	if targ:IsAdmin() then
		ply:SendChat(nil, "ERROR", "Error: You can't do that to admins")

		return
	end

	targ:SetToolTrust(trust)
	targ:UpdatePlayerField("ToolTrust", trust)

	GAMEMODE:LogAdmin("[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s tooltrust to " .. tostring(trust), ply)

	if trust == 0 then
		targ:StripWeapon("gmod_tool")

		ply:SendChat(nil, "WARNING", "You removed " .. targ:RPName() .. "'s tooltrust")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " removed your tooltrust")
	else
		targ:Give("gmod_tool")

		local str = "basic"

		if trust == 2 then
			str = "advanced"
		end

		ply:SendChat(nil, "WARNING", "You set " .. targ:RPName() .. "'s toolrust to " .. str)
		targ:SendChat(nil, "WARNING", ply:Nick() .. " set your tooltrust to " .. str)
	end
end, false, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_setphystrust", function(ply, targ, trust)
	trust = math.Clamp(math.Round(trust), 0, 1)

	if targ:IsAdmin() then
		ply:SendChat(nil, "ERROR", "Error: You can't do that to admins")

		return
	end

	targ:SetPhysTrust(trust)

	GAMEMODE:LogAdmin("[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s phystrust to " .. tostring(trust), ply)

	if trust == 0 then
		ply:SendChat(nil, "WARNING", "You removed " .. targ:RPName() .. "'s phystrust")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " removed your phystrust")
	else
		ply:SendChat(nil, "WARNING", "You gave " .. targ:RPName() .. " phystrust")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " gave you phystrust")
	end

	targ:UpdatePlayerField("PhysTrust", trust)

	if targ:PhysTrust() == 0 then
		targ:StripWeapon("weapon_physgun")
	else
		targ:Give("weapon_physgun")
	end
end, false, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_setproptrust", function(ply, targ, trust)
	trust = math.Clamp(math.Round(trust), 0, 1)

	if targ:IsAdmin() then
		ply:SendChat(nil, "ERROR", "Error: You can't do that to admins")

		return
	end

	targ:SetPropTrust(trust)

	GAMEMODE:LogAdmin("[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s proptrust to " .. tostring(trust), ply)

	if trust == 0 then
		ply:SendChat(nil, "WARNING", "You removed " .. targ:RPName() .. "'s proptrust")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " removed your proptrust")
	else
		ply:SendChat(nil, "WARNING", "You gave " .. targ:RPName() .. " proptrust")
		targ:SendChat(nil, "WARNING", ply:Nick() .. " gave you proptrust")
	end

	targ:UpdatePlayerField("PropTrust", trust)
end, false, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_editinventory", function(ply, targ)
	for _, v in pairs(targ.Inventory) do
		v:AddNetworkedPlayer(ply)
	end

	net.Start("nAEditInventory")
		net.WriteEntity(targ)
		net.WriteFloat(targ:Money())
	net.Send(ply)
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_youtube", function(ply, url, volume)
	if volume == 0 then
		volume = 100
	end

	GAMEMODE:LogAdmin("[Y] " .. ply:Nick() .. " played youtube video " .. url, ply)

	net.Start("nAPlayYT")
		net.WriteString(ply:Nick())
		net.WriteString(url)
		net.WriteFloat(volume)
	net.Broadcast()
end, false, {TYPE_STRING, TYPE_NUMBER})

concommand.AddAdmin("rpa_stopyoutube", function(ply)
	net.Start("nAStopYT")
	net.Broadcast()
end, false)

concommand.AddAdmin("rpa_playurl", function(ply, url, volume)
	if url == "" then
		ply:SendChat(nil, "ERROR", "Error: Invalid syntax: rpa_playurl [url] [vol]")
		return
	end

	if volume == 0 then
		volume = 1
	end

	math.Clamp(volume, 0, 1)

	GAMEMODE:WriteLog("admin_playurl", {Admin = GAMEMODE:LogPlayer(ply), URL = url})

	net.Start("nAPlayURL")
		net.WriteString(ply:Nick())
		net.WriteString(url)
		net.WriteFloat(volume)
	net.Broadcast()
end, false, {TYPE_STRING, TYPE_NUMBER})

concommand.AddAdmin("rpa_stopurl", function(ply)
	net.Start("nAStopURL")
	net.Broadcast()
end, false)

concommand.AddAdmin("rpa_playmusic", function(ply, snd)
	GAMEMODE:LogAdmin("[M] " .. ply:Nick() .. " played music (" .. snd .. ")", ply)

	net.Start("nAPlayMusic")
		net.WriteString(snd)
	net.Broadcast()
end, false, {TYPE_STRING})


concommand.AddAdmin("rpa_playmusictarget", function(ply, targ, snd)
	GAMEMODE:LogAdmin("[M] " .. ply:Nick() .. " played music (" .. snd .. ") to " .. targ:Nick(), ply)

	net.Start("nAPlayMusic")
		net.WriteString(snd)
	net.Send(targ)
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_stopmusic", function(ply)
	GAMEMODE:LogAdmin("[M] " .. ply:Nick() .. " stopped any playing music", ply)

	net.Start("nAStopMusic")
	net.Broadcast()
end, false)

concommand.AddAdmin("rpa_createitem", function(ply, class, ...)
	local args = {...}

	if GAMEMODE.ItemClasses[class] then
		GAMEMODE:LogAdmin("[I] " .. ply:Nick() .. " spawned item \"" .. class .. "\"", ply)
		GAMEMODE:CreateItem(ply, class, args)
	else
		net.Start("nAListItems")
			net.WriteString(class)
		net.Send(ply)
	end
end, false, {TYPE_STRING, TYPE_NIL})

concommand.AddAdmin("rpa_playoverwatch", function(ply, line)
	if GAMEMODE.OverwatchLines[line] then
		GAMEMODE:LogAdmin("[O] " .. ply:Nick() .. " played overwatch line \"" .. GAMEMODE.OverwatchLines[line][2] .. "\"", ply)

		net.Start("nAPlayOverwatch")
			net.WriteFloat(line)
		net.Broadcast()
	end
end, false, {TYPE_STRING})

concommand.AddAdmin("rpa_playoverwatchradio", function(ply, sentence)
	for _, v in pairs(player.GetAll()) do
		if v:HasTerminatorTeam() then
			EmitSentence(sentence, v:GetPos(), v:EntIndex(), 0, 0.5, 100, 0, 100)
		end
	end
end, true, {TYPE_STRING})

concommand.AddAdmin("rpa_spawnmortar", function(ply, count, range)
	local trace = ply:GetEyeTrace()
	count = math.Clamp(count, 1, 20)
	range = math.Clamp(range, 300, 900)

	if trace.HitSky then
		ply:SendChat(nil, "ERROR", "Error: You can't target the skybox")

		return
	end

	local traceSky = util.TraceLine({start = trace.HitPos + Vector(0, 0, 10), endpos = trace.HitPos + Vector(0, 0, 16383), mask = MASK_SOLID})

	if not traceSky.HitSky then
		ply:SendChat(nil, "ERROR", "Error: Cannot trace up to the sky")

		return
	end

	local callSpot = traceSky.HitPos

	for i = 1, count do
		timer.Simple(i * 0.4, function()
			local randVec = Vector(math.Rand(-range, range), math.Rand(-range, range), 0)
			local start = callSpot + (count > 1 and randVec or Vector())

			local traceGround = util.TraceLine({start = start - Vector(0, 0, 10), endpos = trace.HitPos - Vector(0, 0, 16383), mask = MASK_SOLID})

			if not util.IsInWorld(start) or math.deg(math.acos(traceGround.HitNormal:Dot(Vector(0, 0, 1)))) > 80 then
				return
			end

			local pos = traceGround.HitPos

			local mortar = ents.Create("func_tankmortar")
				mortar:SetPos(pos)
				mortar:SetAngles(Angle(90, 0, 0))
				mortar:SetKeyValue("iMagnitude", 90000)
				mortar:SetKeyValue("firedelay", 2)
				mortar:SetKeyValue("warningtime", 2)
				mortar:SetKeyValue("incomingsound", "Weapon_Mortar.Incomming")
			mortar:Spawn()

			local target = ents.Create("info_target")
				target:SetPos(pos)
				target:SetName(tostring(target))
			target:Spawn()

			mortar:DeleteOnRemove(target)

			mortar:Fire("SetTargetEntity", target:GetName(), 0)
			mortar:Fire("Activate", "", 0)
			mortar:Fire("FireAtWill", "", 0)
			mortar:Fire("Deactivate", "", 2)
			mortar:Fire("kill", "", 1)

			mortar:EmitSound("Weapon_Mortar.Single")
		end)
	end
end, false, {TYPE_NUMBER, TYPE_NUMBER})

concommand.AddAdmin("rpa_createfire", function(ply, duration)
	local time = math.Clamp(duration, 1, 86400)
	local tr = ply:GetEyeTrace()

	local fire = ents.Create("env_fire")
	fire:SetPos(tr.HitPos)
	fire:SetKeyValue("spawnflags", "1")
	fire:SetKeyValue("attack", "4")
	fire:SetKeyValue("firesize", "128")
	fire:Spawn()
	fire:Activate()
	fire:Fire("Enable", "")
	fire:Fire("StartFire", "")

	SafeRemoveEntityDelayed(fire, time)
end, false, {TYPE_NUMBER})

concommand.AddAdmin("rpa_togglesaved", function(ply)
	local ent = ply:GetEyeTrace().Entity

	if IsValid(ent) and ent:GetClass() == "prop_physics" then
		local val = 1 - ent:PropSaved()

		ent:SetPropSaved(val)
		ent.NoDamage = tobool(val)

		local phys = ent:GetPhysicsObject()

		if IsValid(phys) then
			phys:EnableMotion(false)
			phys:Sleep()
		end

		GAMEMODE:SaveSavedProps()
		GAMEMODE:LogAdmin("[T] " .. ply:Nick() .. " togglesaved (" .. ent:PropSaved() .. ") " .. ent:GetModel() .. " belonging to " .. ent:PropCreator(), ply)
	end
end, false)

concommand.AddAdmin("rpa_unowndoor", function(ply)
	local ent = ply:GetEyeTrace().Entity

	if IsValid(ent) and ent:IsDoor() then
		ent:ResetDoor()
	end
end, false)

concommand.AddAdmin("rpa_hidebadge", function(ply, bool)
	ply:SetHideAdmin(not ply:HideAdmin())
end, false)

concommand.AddAdmin("rpa_hide", function(ply, targ)
	targ:SetHidden(not targ:Hidden())
end, false, {TYPE_ENTITY})

for _, v in pairs(GM.Stats) do
	concommand.AddAdmin("rpa_setstat" .. string.lower(v), function(ply, targ, val)
		val = math.Clamp(val, GAMEMODE.MinStats, GAMEMODE.MaxAllocatedStats)

		targ["Set" .. v](targ, val)
		targ:UpdateCharacterField("Stat" .. v, val)

		GAMEMODE:LogAdmin("[S] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s " .. v .. " stat to " .. val, ply)

		ply:SendChat(nil, "WARNING", "You set " .. targ:RPName() .. "'s " .. string.lower(v) .. " to " .. val)
		targ:SendChat(nil, "WARNING", ply:Nick() .. " set your " .. string.lower(v) .. " to " .. val)
	end, true, {TYPE_ENTITY, TYPE_NUMBER})
end

concommand.AddAdmin("rpa_setstats", function(ply, targ, val)
	val = math.Clamp(val, GAMEMODE.MinStats, GAMEMODE.MaxAllocatedStats)

	for _, v in pairs(GAMEMODE.Stats) do
		targ["Set" .. v](targ, val)
		targ:UpdateCharacterField("Stat" .. v, val)
	end

	ply:SendChat(nil, "WARNING", "You set " .. targ:RPName() .. "'s stats to " .. val)
	targ:SendChat(nil, "WARNING", ply:Nick() .. " set your stats to " .. val)

	GAMEMODE:LogAdmin("[S] " .. ply:Nick() .. " set all of player " .. targ:RPName() .. "'s stats to " .. val, ply)
end, true, {TYPE_ENTITY, TYPE_NUMBER})

local nameToLoc = {
	city = LOCATION_CITY,
	canal = LOCATION_CANAL,
	canals = LOCATION_CANAL,
	outlands = LOCATION_OUTLANDS,
	caves = LOCATION_OUTLANDS,
	coast = LOCATION_COAST,
	nexus = LOCATION_NEXUS,
}
local locToName = {
	[LOCATION_CITY] = "city",
	[LOCATION_CANAL] = "canals",
	[LOCATION_OUTLANDS] = "outlands",
	[LOCATION_COAST] = "coast",
	[LOCATION_NEXUS] = "nexus"
}

concommand.AddAdmin("rpa_setlocation", function(ply, targ, loc, port)
	local dest = nameToLoc[string.lower(loc)]

	if not dest then
		ply:SendChat(nil, "ERROR", "Error: Invalid destination")

		return
	end

	port = math.Round(port)

	if port <= 0 then
		port = 1
	end

	targ = GAMEMODE:FindPlayer(targ, ply)

	if IsValid(targ) then
		local plyName = targ:VisibleRPName()
		local plySteam = targ:SteamID()

		ply:SendChat(nil, "ERROR", plyName .. " (" .. plySteam .. ") has been sent to the " .. locToName[dest] .. " at entry port " .. port)

		GAMEMODE:LogAdmin("[V] " .. ply:Nick() .. " sent " .. plyName .. " to the " .. locToName[dest] .. " at entry port " .. port, ply)
		targ:GoToServer(dest, port)
	else
		local function cb(res)
			if #res > 0 then
				res = res[1]
				res.id = tonumber(res.id)

				GAMEMODE:UpdateCharacterFieldOffline(res.id, "Location", dest)
				GAMEMODE:UpdateCharacterFieldOffline(res.id, "EntryPort", port)
				GAMEMODE:UpdateCharacterFieldOffline(res.id, "EntryTime", os.date("!%m/%d/%y %H:%M:%S"))

				local plyName = res.rpname
				local plySteam = res.steamid
				local locNum = tonumber(res.location)
				local mesg = string.format("Moved %s (%s) from the %s to the %s at entry port %i.",
					plyName, plySteam, locToName[locNum], locToName[dest], port)
				if ply:IsValid() then
					ply:SendChat(nil, "INFO", mesg)
					GAMEMODE:LogAdmin(string.format("[V] %s moved %s from %s to %s at entry port %i.",
						ply:Nick(), plyName, locToName[locNum], locToName[dest], port), ply)
				end
			else
				ply:SendChat(nil, "ERROR", "Error: No target found")
			end
		end

		GAMEMODE.SQL:Query([[
			SELECT id, rpname, steamid, location FROM $chars
				WHERE RPName = ?
			]], targ, cb)
	end
end, false, {TYPE_STRING, TYPE_STRING, TYPE_NUMBER})

concommand.AddAdmin("rpa_wipelocation", function(ply, loc, dest, port)
	loc, dest = nameToLoc[string.lower(loc)], nameToLoc[string.lower(dest)]

	if not loc or not dest then
		ply:SendChat(nil, "ERROR", "Error: Invalid location")

		return
	end

	port = math.Round(port)

	if port <= 0 then
		port = 1
	end

	GAMEMODE.SQL:Update("$chars", {location = dest}, "location = ?", loc, function(res)
		ply:SendChat(nil, "INFO", "All characters in the " .. locToName[loc] .. " sent to " .. locToName[dest] .. " at entry port " .. port .. ".")
		GAMEMODE:LogAdmin("[V] " .. ply:Nick() .. " mass-moved " .. locToName[loc] .. " to " .. locToName[dest] .. " at entry port " .. port .. ".", ply)
	end)
end, true, {TYPE_STRING, TYPE_STRING, TYPE_NUMBER})

concommand.AddAdmin("rpa_sethealth", function(ply, targ, val)
	val = math.Clamp(val, 0, 100000)

	targ:SetHealth(val)
end, false, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_setarmor", function(ply, targ, val)
	val = math.Clamp(val, 0, 100000)

	targ:SetBodyArmor(val)
	targ:SetMaxBodyArmor(val)
end, false, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_yell", function(ply, msg)
	GAMEMODE:SendChat(ply, player.GetAll(), "ADMINYELL", msg)
end, false, {TYPE_STRING})

concommand.AddAdmin("rpa_playernotes", function(ply, targ)
	GAMEMODE:PlayerNotes(ply, targ)
end, false, {TYPE_ENTITY})

local nametotrait = {}
nametotrait["none"] = TRAIT_NONE

concommand.AddAdmin("rpa_settrait", function(ply, targ, trait)
	local name = string.lower(trait) or "none"

	trait = nametotrait[name]

	if not trait then
		ply:SendChat(nil, "ERROR", "Error: Invalid trait")

		return
	end

	targ:SetTrait(trait)
	targ:UpdateCharacterField("Trait", trait)

	GAMEMODE:LogAdmin("[T] " .. ply:Nick() .. " changed player " .. targ:RPName() .. "'s trait to " .. name .. ".", ply)

	ply:SendChat(nil, "WARNING", "You set " .. targ:RPName() .. "'s trait to " .. name)
	targ:SendChat(nil, "WARNING", ply:Nick() .. " set your trait to " .. name)
end, false, {TYPE_ENTITY, TYPE_STRING})

local nametolang = {}
nametolang["english"] = LANG_ENGLISH
nametolang["russian"] = LANG_RUSSIAN
nametolang["chinese"] = LANG_CHINESE
nametolang["japanese"] = LANG_JAPANESE
nametolang["spanish"] = LANG_SPANISH
nametolang["french"] = LANG_FRENCH
nametolang["german"] = LANG_GERMAN
nametolang["italian"] = LANG_ITALIAN

concommand.AddAdmin("rpa_givelang", function(ply, targ, lang)
	local name = string.lower(lang) or "english"

	lang = nametolang[name]

	if not lang then
		ply:SendChat(nil, "ERROR", "Error: Invalid language")

		return
	end

	if targ:HasLang(lang) then
		ply:SendChat(nil, "ERROR", "Error: They already speak this langauge")

		return
	end

	targ:SetLang(targ:Lang() + lang)
	targ:UpdateCharacterField("Lang", targ:Lang())

	GAMEMODE:LogAdmin("[T] " .. ply:Nick() .. " gave player " .. targ:RPName() .. " " .. name .. ".", ply)

	ply:SendChat(nil, "WARNING", "You gave " .. targ:RPName() .. " the ability to speak " .. name)
	targ:SendChat(nil, "WARNING", ply:Nick() .. " gave you the ability to speak " .. name)
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_takelang", function(ply, targ, lang)
	local name = string.lower(lang) or "english"

	lang = nametolang[name]

	if not lang then
		ply:SendChat(nil, "ERROR", "Error: Invalid language")

		return
	end

	if not targ:HasLang(lang) then
		ply:SendChat(nil, "ERROR", "Error: They don't speak this langauge")

		return
	end

	targ:SetLang(targ:Lang() - lang)
	targ:UpdateCharacterField("Lang", targ:Lang())

	GAMEMODE:LogAdmin("[T] " .. ply:Nick() .. " took " .. name .. " from " .. targ:RPName() .. ".", ply)

	ply:SendChat(nil, "WARNING", "You took the ability to speak " .. name .. " from " .. targ:RPName())
	targ:SendChat(nil, "WARNING", ply:Nick() .. " took away the ability to speak " .. name)
end, false, {TYPE_ENTITY, TYPE_STRING})

local function OOCMute(ply, targ)
	local val = not tobool(targ:IsOOCMuted())
	local str = " unmuted "

	if val then
		str = " muted "
	end

	targ:SetIsOOCMuted(val)
	targ:UpdatePlayerField("IsOOCMuted", val and 1 or 0)

	GAMEMODE:LogAdmin("[M] " .. ply:Nick() .. str .. targ:Nick() .. " from OOC.", ply)

	ply:SendChat(nil, "WARNING", "You" .. str .. targ:RPName() .. " from OOC")
	targ:SendChat(nil, "WARNING", ply:Nick() .. str .. "you from OOC")
end

local nametolicense = {}
nametolicense["generic"] = BUSINESS_GENERIC
nametolicense["clothing"] = BUSINESS_CLOTHING
nametolicense["medical"] = BUSINESS_MEDICAL
nametolicense["weaponry"] = BUSINESS_WEAPONRY
nametolicense["illegal"] = BUSINESS_ILLEGAL
nametolicense["quartermaster"] = BUSINESS_QUARTERMASTER

concommand.AddAdmin("rpa_givelicense", function(ply, targ, license)
	local name = string.lower(license) or "generic"

	license = nametolicense[name]

	if not license then
		ply:SendChat(nil, "ERROR", "Error: Invalid license")

		return
	end

	if targ:HasLicense(license) then
		ply:SendChat(nil, "ERROR", "Error: They already have this license")

		return
	end

	targ:SetBusinessLicenses(targ:BusinessLicenses() + license)
	targ:UpdateCharacterField("BusinessLicenses", targ:BusinessLicenses())

	GAMEMODE:LogAdmin("[T] " .. ply:Nick() .. " gave player " .. targ:RPName() .. " a " .. name .. " license.", ply)

	ply:SendChat(nil, "WARNING", "You gave " .. targ:RPName() .. " the " .. name .. " license.")
	targ:SendChat(nil, "WARNING", ply:Nick() .. " gave you the " .. name .. " license.")
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_takelicense", function(ply, targ, license)
	local name = string.lower(license) or "generic"

	license = nametolicense[name]

	if not license then
		ply:SendChat(nil, "ERROR", "Error: Invalid license")

		return
	end

	if not targ:HasLicense(license) then
		ply:SendChat(nil, "ERROR", "Error: They don't have this license")

		return
	end

	targ:SetBusinessLicenses(targ:BusinessLicenses() - license)
	targ:UpdateCharacterField("BusinessLicenses", targ:BusinessLicenses())

	GAMEMODE:LogAdmin("[T] " .. ply:Nick() .. " took " .. targ:RPName() .. "'s " .. name .. " license.", ply)

	ply:SendChat(nil, "WARNING", "You took " .. targ:RPName() .. "'s " .. name .. " license.")
	targ:SendChat(nil, "WARNING", ply:Nick() .. " took your " .. name .. " license.")
end, false, {TYPE_ENTITY, TYPE_STRING})

concommand.AddAdmin("rpa_oocmute", OOCMute, false, {TYPE_ENTITY})
concommand.AddAdmin("rpa_mute", OOCMute, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_travelban", function(ply, targ)
	local val = not tobool(targ:IsTravelBanned())
	local str = " unbanned "

	if val then
		str = " banned "
	end

	targ:SetIsTravelBanned(val)
	targ:UpdatePlayerField("IsTravelBanned", val and 1 or 0)

	GAMEMODE:LogAdmin("[M] " .. ply:Nick() .. " " .. str .. " " .. targ:Nick() .. " from travelling.", ply)

	ply:SendChat(nil, "WARNING", "You" .. str .. targ:RPName() .. " from travelling")
	targ:SendChat(nil, "WARNING", ply:Nick() .. str .. "you from travelling")
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_charlist", function(ply, steamid)
	if not GAMEMODE:IsValidSteamID(steamid) then
		ply:SendChat(nil, "ERROR", "Error: SteamID is invalid")

		return
	end

	GAMEMODE:GetCharacterList(steamid, ply)
end, false, {TYPE_STRING})

concommand.AddAdmin("rpa_getchardata", function(ply, id)
	id = math.Round(id)

	if id < 1 then
		ply:SendChat(nil, "ERROR", "Error: Character ID is invalid")

		return
	end

	GAMEMODE:GetCharacterData(id, ply)
end, false, {TYPE_NUMBER})

concommand.AddAdmin("rpa_getcharinv", function(ply, id)
	id = math.Round(id)

	if id < 1 then
		ply:SendChat(nil, "ERROR", "Error: Character ID is invalid")

		return
	end

	GAMEMODE:GetCharacterInventory(id, ply)
end, false, {TYPE_NUMBER})

concommand.AddAdmin("rpa_wipecharflags", function(ply, id)
	id = math.Round(id)

	if id < 1 then
		ply:SendChat(nil, "ERROR", "Error: Character ID is invalid")

		return
	end

	local offline = true

	for _, v in pairs(player.GetAll()) do
		if v:CharID() == id then
			v:SetCharFlags("")
			v:UpdateCharacterField("CharFlags", "")

			v:SetCombineFlag("")
			v:UpdateCharacterField("CombineFlag", "")

			v:SendChat(nil, "WARNING", ply:Nick() .. " has wiped your flags")

			offline = false

			break
		end
	end

	if offline then
		GAMEMODE:UpdateCharacterFieldOffline(id, "CharFlags", "")
		GAMEMODE:UpdateCharacterFieldOffline(id, "CombineFlag", "")
	end

	GAMEMODE:LogAdmin("[F] " .. ply:Nick() .. " has wiped the flags of character " .. id .. ".", ply)
end, false, {TYPE_NUMBER})

concommand.AddAdmin("rpa_deleteitem", function(ply, id)
	id = math.Round(id)

	if id < 1 then
		ply:SendChat(nil, "ERROR", "Error: Item ID is invalid")

		return
	end

	local item = GAMEMODE:GetItem(id)

	if item then
		ply:SendChat(nil, "ERROR", "Error: This item is currently loaded, delete it through a different method")

		return
	else
		local function cb()
			if IsValid(ply) then
				ply:SendChat(nil, "WARNING", "You've deleted item #" .. id)
			end

			GAMEMODE:WriteLog("admin_deleteitem", {Admin = GAMEMODE:LogPlayer(ply), ID = id})
		end

		GAMEMODE.SQL:Query([[
			UPDATE $items SET Deleted = 1
				WHERE id = ?
			]], id, cb)
	end
end, false, {TYPE_NUMBER})

concommand.AddAdmin("rpa_restoreitem", function(ply, id)
	id = math.Round(id)

	if id < 1 then
		ply:SendChat(nil, "ERROR", "Error: Item ID is invalid")

		return
	end

	local item = GAMEMODE:GetItem(id)

	if item then
		ply:SendChat(nil, "ERROR", "Error: This item is already loaded and doesn't have to be restored")

		return
	end

	local function cb()
		GAMEMODE:DBLoadItems({id})

		if IsValid(ply) then
			ply:SendChat(nil, "WARNING", "You've restored item #" .. id .. " to your inventory")
		end

		GAMEMODE:WriteLog("admin_restoreitem", {Admin = GAMEMODE:LogPlayer(ply), ID = id})
	end

	GAMEMODE.SQL:Query([[
		UPDATE $items SET Deleted = 0, StorageType = ?, CharacterID = ?
			WHERE id = ?
		]], ITEM_PLAYER, ply:CharID(), id, cb)
end, false, {TYPE_NUMBER})

concommand.AddAdmin("rpa_charlookup", function(ply, name)
	GAMEMODE:CharacterLookup(name, ply)
end, false, {TYPE_STRING})

concommand.AddAdmin("rpa_send", function(ply, from, to)
	local pos = FindTeleportPos(to)

	from:SetPos(pos)
end, false, {TYPE_ENTITY, TYPE_ENTITY})

concommand.AddAdmin("rpa_explode", function(ply, targ)
	targ:Kill()

	local explo = ents.Create("env_explosion")
	explo:SetPos(targ:GetPos())
	explo:SetKeyValue("iMagnitude", 0)
	explo:Spawn()
	explo:Activate()
	explo:Fire("Explode")

	GAMEMODE:WriteLog("admin_explode", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ)})
	GAMEMODE:SendChat(nil, player.GetAll(), "WARNING", ply:Nick() .. " exploded " .. targ:Nick())
end, true, {TYPE_ENTITY})

concommand.AddAdmin("rpa_adminradio", function(ply, bool)
	ply:SetAdminRadio(bool)
end, false, {TYPE_BOOL})

concommand.AddAdmin("rpa_createlootpoint", function(ply, pool)
	if not GAMEMODE.Loot.Enabled then
		ply:SendChat(nil, "ERROR", "Error: Loot is disabled")

		return
	end

	local prop = ply:GetEyeTrace().Entity

	if not IsValid(prop) or prop:GetClass() != "prop_physics" then
		ply:SendChat(nil, "ERROR", "Error: You need to be looking at a prop")

		return
	end

	if not GAMEMODE.Loot.Rates[pool] then
		ply:SendChat(nil, "ERROR", "Error: This loot pool doesn't exist")

		return
	end

	local ent = ents.Create("cc_loot")

	ent:SetModel(prop:GetModel())
	ent:SetPos(prop:GetPos())
	ent:SetAngles(prop:GetAngles())

	ent:Spawn()
	ent:Activate()

	ent:RegisterWithLootPool(pool)

	prop:Remove()

	GAMEMODE:SaveLootPoints()

	local pos = ent:GetPos()

	GAMEMODE:WriteLog("admin_createlootpoint", {
		Admin = GAMEMODE:LogPlayer(ply),
		X = math.Round(pos.x, 2),
		Y = math.Round(pos.y, 2),
		Z = math.Round(pos.z, 2),
		Pool = ent:GetLootPool(),
		Mdl = ent:GetModel()
	})
end, false, {TYPE_STRING})

function GM:PlayerNoClip(ply)
	if ply:PassedOut() then return false end
	if ply:Bottify() then return false end

	if not ply:IsAdmin() and not ply:IsEventCoordinator() then

		if CLIENT and IsFirstTimePredicted() then

			GAMEMODE:AddChat("You need to be an admin to do this.", Color(200, 0, 0, 255))

		end

		return false

	end

	if SERVER then

		if ply:IsEFlagSet(EFL_NOCLIP_ACTIVE) then

			ply:GodDisable()
			ply:SetNoTarget(false)
			ply:SetNoDraw(false)
			ply:SetNotSolid(false)

			if ply:GetActiveWeapon() ~= NULL then

				ply:GetActiveWeapon():SetNoDraw(false)
				ply:GetActiveWeapon():SetColor(Color(255, 255, 255, 255))

			end

			if ply.NoclipPos then

				ply:SetPos(ply.NoclipPos)
				ply.NoclipPos = nil

			end

		else

			ply:GodEnable()
			ply:SetNoTarget(true)
			ply:SetNoDraw(true)
			ply:SetNotSolid(true)

			if ply:GetActiveWeapon() ~= NULL then

				ply:GetActiveWeapon():SetNoDraw(true)
				ply:GetActiveWeapon():SetColor(Color(255, 255, 255, 0))

			end

			if ply:IsEventCoordinator() then

				ply.NoclipPos = ply:GetPos()

			end

		end

	end

	return true
end

concommand.AddAdmin("rpa_setplayerscale", function(ply, targ, val)
	if val > 10 or val < 0.1 then
		ply:SendChat(nil, "ERROR", "Error: Scale must be between 0.1 and 10")
		return
	end

	if SERVER then
		val = math.Clamp(val, 0.1, 10)
		targ:SetPlayerScale(val, true)
	end
end, false, {TYPE_ENTITY, TYPE_NUMBER})

concommand.AddAdmin("rpa_infiniteammo", function(ply, targ, bool)
	targ:SetInfiniteAmmo(bool)
end, false, {TYPE_ENTITY, TYPE_BOOL})

concommand.AddAdmin("rpa_heal", function(ply, targ)
	targ:SetHealth(targ:GetMaxHealth())
	targ:SetBodyArmor(targ:MaxBodyArmor())

	if SERVER then
		GAMEMODE:WriteLog("admin_heal", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(targ), Char = GAMEMODE:LogCharacter(targ), Self = ply == targ})
	end
end, false, {TYPE_ENTITY})

concommand.AddAdmin("rpa_setspawnoverride", function(ply)
	if GAMEMODE.EntryPortSpawns[1] and not GAMEMODE.SpawnBackup then
		GAMEMODE.SpawnBackup = GAMEMODE.EntryPortSpawns[1]
	end

	GAMEMODE.EntryPortSpawns[1] = {ply:GetPos()}
end)

concommand.AddAdmin("rpa_restorespawns", function(ply)
	GAMEMODE.EntryPortSpawns[1] = GAMEMODE.SpawnBackup or nil
end)