GM.ChatHighlight = {}

function GM:CreateChat()
	if self.Chat then
		self.Chat:Remove()
	end
	self.Chat = vgui.Create("CCChat")
	self.Chat:SetPos(20, ScrH() - self.Chat:GetTall() - 200)
	self.Chat:Hide()

	if self.RadioChat then
		self.RadioChat:Remove()
	end
	self.RadioChat = vgui.Create("CCRadioChat")
	self.RadioChat:CopyPos(self.Chat)
	self.RadioChat:MoveAbove(self.Chat, 10)
end

function GM:ShowChat()
	if IsValid(self.Chat) then
		self.Chat:Show()
	else
		self:CreateChat()
		self.Chat:Show()
	end
end

function GM:HideChat()
	if IsValid(self.Chat) then
		self.Chat:Hide()
	end
end

function GM:AddChat(str, color, font)
	if not IsValid(self.Chat) then
		self:CreateChat()
	end
	self.Chat:AddText(str, color, font)
end

function GM:AddRadioChat(str, color)
	if not IsValid(self.RadioChat) then
		self:CreateChat()
	end
	self.RadioChat:AddText(str, color)
end

function GM:AddChatMessage(t)
	if not IsValid(self.Chat) then
		self:CreateChat()
	end
	self.Chat:AddMessage(t)
	self:LogChatMessage(t)
end

function GM:StartChat()
	return true
end

function GM:ParseChat(str)
	if #str == 0 then
		return
	elseif str:StartWith("//") then
		str = "/ooc " .. str:sub(3)
	elseif str:StartWith("[[") then
		str = "/looc " .. str:sub(3)
	elseif str:StartWith(".//") then
		str = "/looc " .. str:sub(4)
	elseif str:StartWith(":") then
		str = "/me " .. str:sub(2)
	elseif str:StartWith("\\") then
		str = "/it " .. str:sub(2)
	end

	local cmd, lang, args

	--MsgC(Color(0, 255, 0), "CHAT\n\tstr = '" .. str .. "'\n")

	-- /<lang>.<cmd> [<args>]
	lang, cmd, args = str:match("^/(%w+)%.(%w+)%s*(.-)%s*$")
	if lang then
		if cmd == lang or self.LanguageCommands[cmd] then
			-- squash "/ita.ita" or "/ita.rus" into "/ita"
			cmd = "/say"
		else
			cmd = "/" .. cmd
		end
	else
		-- /<cmd|lang> [<args>]  -or-  !<cmd> [<args>]
		cmd, args = str:match("^([/!]%w+)%s*(.-)%s*$")
		if not cmd then
			cmd, args = "/say", str:Trim()
		elseif self.LanguageCommands[cmd] then
			lang, cmd = cmd:sub(2), "/say"
		end
	end
	--MsgC(Color(0, 255, 0), "\tcmd = " .. tostring(cmd) .. ", args = " .. tostring(args) .. ", lang = " .. tostring(lang) .. "\n")

	lang = lang or self.LastLanguage

	if lang then
		lang = self.Languages[lang]
		if not lang then
			self:AddChat("That's not a real language.", Color(255, 32, 32))
			return
		elseif not LocalPlayer():HasLang(lang.Lang) then
			self:AddChat("You can't speak that language.", Color(255, 32, 32))
			return
		end
		-- if we used "/<lang> <text>", cmd will always be /say
		if cmd == "/say" and #args == 0 then
			self.LastLanguage = lang.Alias
			self:AddChat("Now speaking in " .. lang.Name .. ".", Color(255, 167, 73))
			return
		end
	else
		lang = self.Languages.eng
	end

	local class = self.ChatCommands[cmd]
	if not class then
		-- let the server deal with bad chat commands
		-- it may know something we don't
		net.Start("nChat")
			net.WriteString(cmd)
			net.WriteUInt(0, 16)
			net.WriteUInt(lang.ID, 8)
			net.WriteString(args)
			net.WriteTable({})
		net.SendToServer()
		return
	end
	if class.NoSend then return end

	local t = table.Merge(table.Copy(class), {
		Entity		= LocalPlayer(),
		Name		= LocalPlayer():VisibleRPName(),
		RealName	= LocalPlayer():RPName(),
		Nick		= LocalPlayer():Nick(),
		Language	= lang,
		Command		= cmd,
		Class		= class,
		Text		= args,
		Custom 		= {}
	})

	if hook.Run("OnChat", LocalPlayer(), t) then
		return
	elseif t.Class.OnSent and t.Class.OnSent(t) then
		return
	end

	net.Start("nChat")
		net.WriteString(t.Command)
		net.WriteUInt(t.Class.ID, 16)
		net.WriteUInt(t.Language.ID, 8)
		net.WriteString(t.Text)
		net.WriteTable(t.Custom)
	net.SendToServer()
end

net.Receive("nChat", function(len)
	local idx = net.ReadUInt(8)
	local ent = Entity(idx)
	local classid = net.ReadUInt(16)
	local class = assert(GAMEMODE.MessageTypes[classid], "server sent bad chat class id " .. classid)
	local langid = net.ReadUInt(8)
	local lang = assert(GAMEMODE.Languages[langid], "server sent bad chat lang id " .. langid)
	local text = net.ReadString()
	local custom = net.ReadTable() or {}

	local t = table.Merge(table.Copy(class), {
		Index		= idx,
		Entity		= idx > 0 and Entity(idx) or false,
		Class		= class,
		Language	= lang.Alias != "eng" and lang,
		Nick		= idx > 0 and ent:IsValid() and ent:Nick() or "*INVALID*",
		Name		= idx > 0 and ent:IsValid() and ent:VisibleRPName() or "*INVALID*",
		RealName	= idx > 0 and ent:IsValid() and ent:RPName() or "*INVALID*",
		Text		= text,
		Custom 		= custom
	})

	--print(t.Name, t.Text)

	if hook.Run("OnChatReceived", t) then
		return
	elseif t.Class.OnReceived and t.Class.OnReceived(t) then
		return
	end

	GAMEMODE:AddChatMessage(t)
end)

function GM:LogChatMessage(t)
	if cookie.GetNumber("cc_logging", 1) == 0 then
		return
	end

	local text = t.ConsoleText or t.Text

	if t.Name then
		text = t.Name .. text
	end

	if t.LoggedIC then
		self:WriteClientLog(text, true)
	end

	self:WriteClientLog(text)
end

function GM:WriteClientLog(text, IC)
	local folder = "cc_tnb_trp/logs/" .. os.date("%Y-%m-%d")
	local filename = folder .. "/" .. (IC and "IC" or "All") .. ".txt"

	file.AppendSafe(filename, text)
end
