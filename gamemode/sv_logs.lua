GM.ConsoleLog = false

function GM:DataFolder()
	return "cc_" .. self.DataFolders[self.LogLocation or self.CurrentLocation or LOCATION_CITY]
end

function GM:SetupDataDirectories()
	file.CreateDir(self:DataFolder())
	file.CreateDir("combinecontrol/savedprops/v3")
	file.CreateDir("combinecontrol/loot")
	file.CreateDir(self:DataFolder() .. "/logs")
	file.CreateDir(self:DataFolder() .. "/logs/" .. os.date("!%Y-%m-%d"))
end

function GM:LogFile(name, text)
	local folder = self:DataFolder() .. "/logs/"
	file.AppendSafe(folder .. os.date("!%Y-%m-%d") .. "/" .. name .. ".txt", text)
end

net.Receive("nGetLogList", function(len, ply)
	if not ply:IsAdmin() then return end

	local id = net.ReadString()
	local date = net.ReadString()
	local n = math.Clamp(net.ReadFloat(), 0, 10000)

	local c = file.Read(GAMEMODE:DataFolder() .. "/logs/" .. date .. "/" .. id .. ".txt") or ""
	local otab = string.Explode("\n", c)
	local tab = string.Explode("\n", c)

	if n > 0 then
		for i = 1, #tab - (n + 1) do
			table.remove(tab, 1)
		end
	end

	net.Start("nLogList")
		net.WriteTable(tab)
		net.WriteFloat(#otab)
	net.Send(ply)
end)

function GM:LogSQL(text)
	if #text > 120 then
		text = string.sub(text, 1, 120) .. " (...)"
	end

	local ins = os.date("!%H:%M:%S") .. "\t" .. text
	self:LogFile("sql", ins)

	if self.ConsoleLog then
		MsgC(Color(200, 200, 200, 255), ins, "\n")
	end
end

function GM:LogBug(text, forceconsole)
	local ins = os.date("!%H:%M:%S") .. "\t" .. text
	self:LogFile("bugs", ins)

	if self.ConsoleLog or forceconsole then
		MsgC(Color(255, 0, 0, 255), ins, "\n")
	end
end

function GM:LogAdmin(text, ply)
	local ins = os.date("!%H:%M:%S") .. "\t" .. ply:SteamID() .. "\t" .. text
	self:LogFile("admin", ins)

	if self.ConsoleLog then
		MsgC(Color(200, 200, 200, 255), ins, "\n")
	end
end

function GM:LogPlaySounds(ply, sound)
  local ins = string.format("%s\t%s\t%s(#%i) [%s]: %s",
    os.date("!%H:%M:%S"),
    ply:SteamID(),
    ply:VisibleRPName(),
    ply:CharID(),
    "SOUND",
    sound
  )
  self:LogFile("chat", ins)

  if self.ConsoleLog then
    MsgC(Color(200, 200, 200, 255), ins, "\n")
  end
end

function GM:LogSecurity(steamid, networkid, name, text)
	local ins = os.date("!%H:%M:%S") .. "\t" .. steamid .. "\t" .. networkid .. "\t" .. name .. "\t" .. text
	self:LogFile("security", ins)

	if self.ConsoleLog then
		MsgC(Color(200, 200, 200, 255), ins, "\n")
	end
end

function GM:LogChat(text, ply)
	local ins = os.date("!%H:%M:%S") .. "\t" .. ply:SteamID() .. "\t" .. text
	self:LogFile("chat", ins)
end

function GM:LogChatMessage(t)
	local ply, class, lang, text = t.Entity, t.Class, t.Language, t.Text
	if not ply:IsPlayer() then return end

	if lang and lang.Alias != "eng" and class.UsesLanguage then
		self:LogFile("chat", string.format("%s\t%s\t%s(#%i) [%s-%s]: %s",
			os.date("!%H:%M:%S"),
			ply:SteamID(),
			ply:VisibleRPName(),
			ply:CharID(),
			class.Name,
			lang.Alias:upper(),
			text
		))
	else
		self:LogFile("chat", string.format("%s\t%s\t%s(#%i) [%s]: %s",
			os.date("!%H:%M:%S"),
			ply:SteamID(),
			ply:VisibleRPName(),
			ply:CharID(),
			class.Name,
			text
		))
	end
end

function GM:LogSandbox(text, ply)
	local ins = os.date("!%H:%M:%S") .. "\t" .. ply:SteamID() .. "\t" .. text
	self:LogFile("sandbox", ins)

	if self.ConsoleLog then
		MsgC(Color(200, 200, 200, 255), ins, "\n")
	end
end

function GM:LogItems(text, ply)
	local ins = os.date("!%H:%M:%S") .. "\t" .. ply:SteamID() .. "\t" .. text
	self:LogFile("items", ins)

	if self.ConsoleLog then
		MsgC(Color(200, 200, 200, 255), ins, "\n")
	end
end

function GM:LogCombine(text, ply)
	local ins = os.date("!%H:%M:%S") .. "\t" .. ply:SteamID() .. "\t" .. text
	self:LogFile("combine", ins)

	if self.ConsoleLog then
		MsgC(Color(200, 200, 200, 255), ins, "\n")
	end
end

function GM:LogCredits(text, ply)
	local ins = os.date("!%H:%M:%S") .. "\t" .. ply:SteamID() .. "\t" .. text
	self:LogFile("credits", ins)

	if self.ConsoleLog then
		MsgC(Color(200, 200, 200, 255), ins, "\n")
	end
end

function GM:LogAll(text)
	local ins = os.date("!%H:%M:%S") .. "\t" .. text

	self:LogFile("sql", ins)
	self:LogFile("bugs", ins)
	self:LogFile("admin", ins)
	self:LogFile("chat", ins)
	self:LogFile("security", ins)
	self:LogFile("sandbox", ins)
	self:LogFile("items", ins)
	self:LogFile("combine", ins)
	self:LogFile("credits", ins)
end
