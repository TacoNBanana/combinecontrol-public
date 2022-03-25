AddCSLuaFile()

local convar = CreateClientConVar("rp_highlight_color", "0.25 0.54 0")

local function getHighlightColor()
	local vec = Vector(convar:GetString())

	return vec:ToColor()
end

function GM:GetRadioJamming(ply)
	local jammed = GAMEMODE.RadioJammed or 0
	local zone = ply.ActiveZone.cc_zone_jamming

	if IsValid(zone) then
		jammed = math.max(jammed, zone:GetSeverity())
	end

	return jammed
end

GM.Languages = {
	-- Display name, chat command
	{Lang = LANG_ENGLISH, 	Name = "English", 	Alias = "eng"},
	{Lang = LANG_CHINESE, 	Name = "Chinese", 	Alias = "chi"},
	{Lang = LANG_FRENCH, 	Name = "French", 	Alias = "fre"},
	{Lang = LANG_GERMAN, 	Name = "German", 	Alias = "ger"},
	{Lang = LANG_ITALIAN, 	Name = "Italian", 	Alias = "ita"},
	{Lang = LANG_JAPANESE, 	Name = "Japanese", 	Alias = "jap"},
	{Lang = LANG_RUSSIAN, 	Name = "Russian", 	Alias = "rus"},
	{Lang = LANG_SPANISH, 	Name = "Spanish", 	Alias = "spa"},
}
GM.LanguageCommands = {}
for i, v in ipairs(GM.Languages) do
	v.ID = i
	GM.Languages[v.Alias] = v
	GM.LanguageCommands["/" .. v.Alias] = v
end

--[[
	/!\ WARNING /!\
	Shared calls to GM:AddMessageType/AddChatCommand -MUST- go before
	ANY server/clientside-only calls

	Chat message fields
		ID				Autoset. Don't touch this
		Name*			Alias (eg. "SAY" -> GM.MessageTypes.SAY)
		Font*			Font used in chatbox
		NameColor		If not set, doesn't show name in chatbox
		TextColor*		Text body color. Required
		Tabs*			Chatbox 'tabs' it displays in
		Commands		Table of chat commands. If not set, message must be sent
						manually by the server
		Range			If nil, sends to everyone on server
		Logged
		UsesLanguage	Only used for serverside logging right now

		CLIENT function OnSent(t)
		CLIENT function OnReceived(t)
		SERVER function OnParsed(t)

	Chat command fields
		ID
		CLIENT function OnSent(t)
		CLIENT function OnReceived(t)
		SERVER function OnParsed(t)
		^ one of these must be set
]]

GM.MessageTypes	= {}
GM.ChatCommands	= {}

local i = 1
function GM:AddMessageType(t)
	if t.Name then
		local orig = self.MessageTypes[t.Name]
		if orig then
			table.Merge(orig, t)
			return
		end
	elseif t.Commands then
		local orig = self.ChatCommands[t.Commands:match("[^; ]+")]
		if orig then
			table.Merge(orig, t)
			return
		end
	end

	t.ID, i = i, i + 1

	-- Shared. Simple but ugly.
	self.MessageTypes[t.ID] = t

	-- message type
	if t.Name then
		assert(t.Name, "Name is required for chat filters")
		assert(t.Font, "Font is required for chat filters")
		assert(t.TextColor, "TextColor is required for chat filters")
		assert(t.Tabs, "Tabs is required for chat filters")

		self.MessageTypes[t.Name] = t
	end

	if t.Commands then
		if not t.Name then
			-- plain chat command
			assert(t.Commands and #t.Commands > 0, "Commands is required for chat commands")
		end
		for cmd in t.Commands:gmatch("[^; ]+") do
			assert(not self.ChatCommands[cmd], "Reused chat command '" .. cmd .. "'")
			assert(not self.LanguageCommands[cmd], "Command '" .. cmd .. "' is masked by a language command")
			self.ChatCommands[string.lower(cmd)] = t
		end
	end

	if t.Logged then
		local name = t.LogName and string.lower(t.LogName) or string.lower(t.Name)

		self:RegisterLogType("chat_" .. name, LOG_CHAT, ParseChatLog)
	end
end
-- alias, for clarity's sake
GM.AddChatCommand = GM.AddMessageType

local function textOnly(t) t.Name, t.RealName = nil end

GM:AddMessageType({
	Name			= "SYSTEM",
	Font			= "CombineControl.ChatNormal",
	NameColor		= nil,
	TextColor		= Color(200, 200, 200),
	Tabs			= TAB_SYSTEM,
	Range			= nil,
	Logged			= nil,
	NoSend			= true,
	UsesLanguage	= nil,

	OnReceived	= textOnly
})

GM:AddMessageType({
	Name		= "INFO",
	Font		= "CombineControl.ChatNormal",
	TextColor	= Color(255, 255, 255),
	Tabs		= TAB_SYSTEM,
	OnReceived	= textOnly
})

GM:AddMessageType({
	Name		= "WARNING",
	Font		= "CombineControl.ChatNormal",
	TextColor	= Color(229, 201, 98),
	Tabs		= TAB_SYSTEM,
	OnReceived	= textOnly
})

GM:AddMessageType({
	Name		= "ERROR",
	Font		= "CombineControl.ChatNormal",
	TextColor	= Color(200, 0, 0),
	Tabs		= TAB_SYSTEM,
	OnReceived	= textOnly
})

GM:AddMessageType({
	Name		= "ERRORBIG",
	Font		= "CombineControl.ChatHuge",
	TextColor	= Color(200, 0, 0),
	Tabs		= TAB_SYSTEM,
	OnReceived	= textOnly
})

GM:AddMessageType({
	Name		= "CONSOLE",
	Font		= "CombineControl.ChatNormal",
	NameColor	= Color(232, 20, 225),
	TextColor	= Color(200, 200, 200),
	Tabs		= TAB_OOC,
	OnReceived	= textOnly
})

GM:AddMessageType({
	Name			= "OOC",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(200, 200, 200),
	Tabs			= TAB_OOC,
	Commands		= "/ooc",
	Logged			= true,
	LogName 		= "OOC",
	OnParsed	= function(t)
		local ply = t.Entity

		if GAMEMODE:OOCDisabled() then
			ply:SendChat(nil, "ERROR", "OOC is disabled.")
			return true
		end

		if ply:IsOOCMuted() then
			ply:SendChat(nil, "ERROR", "You are muted from OOC.")
			return true
		end

		if not ply:IsAdmin() and ply.LastOOC and CurTime() < ply.LastOOC + GAMEMODE:OOCDelay() then
			ply:SendChat(nil, "INFO", "Wait " .. tostring(math.Round(ply.LastOOC + GAMEMODE:OOCDelay() - CurTime())) .. " seconds to talk in OOC.")
			return true
		end
		ply.LastOOC = CurTime()
	end,
	OnReceived		= function(t)
		t.NameColor = team.GetColor(IsValid(t.Entity) and t.Entity:Team() or TEAM_UNASSIGNED)
		t.Text = "[OOC] " .. t.Text
		t.ConsoleText = t.Text
	end
})

GM:AddMessageType({
	Name			= "LOOC",
	Font			= "CombineControl.ChatNormal",
	NameColor		= Color(138, 185, 209),
	TextColor		= Color(138, 185, 209),
	Tabs			= TAB_LOOC,
	Commands		= "/looc",
	Range			= 400,
	Logged			= true,
	LogName 		= "OOC",
	OnReceived		= function(t)
		t.Text = "[LOCAL-OOC] " .. t.Text
	end
})

GM:AddMessageType({
	Name			= "ADMIN",
	Font			= "CombineControl.ChatNormal",
	NameColor		= Color(255, 107, 218),
	TextColor		= Color(255, 156, 230),
	Tabs			= TAB_ADMIN,
	Commands		= "!a /a",
	Logged			= true,
	CanHear			= function(src, rec) return src == rec or rec:IsAdmin() end,
	OnReceived		= function(t)
		if LocalPlayer():IsAdmin() then
			if not t.Entity or t.Entity:IsAdmin() then
				t.Text = "[ADMIN] " .. t.Text
			else
				t.Text = "[ADMIN] ! " .. t.Text
			end
			t.Name = t.Name .. " (" .. t.Nick .. ")"
		elseif t.Entity == LocalPlayer() then
			t.Text = "[TO ADMINS] " .. t.Text
			t.Name = t.Name .. " (" .. t.Nick .. ")"
		else
			-- NOREACH
			return true
		end
	end
})

GM:AddMessageType({
	Name		= "ADMINYELL",
	Font		= "CombineControl.LabelMassive",
	NameColor	= Color(255, 255, 255),
	TextColor	= Color(232, 20, 20),
	Tabs		= TAB_OOC,
	OnReceived		= function(t)
		t.ConsoleText = string.format("[ANGRY] %s", t.Text)
	end
})

GM:AddMessageType({
	Name			= "KICK",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(232, 20, 225),
	Tabs			= TAB_OOC
})

GM:AddMessageType({
	Name			= "PMOUT",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(160, 255, 160),
	Tabs			= TAB_PRIVMSG,
	NoSend			= true,
	OnReceived		= function(t)
		if t.Entity == LocalPlayer() then return true end
		t.Text = "[PM to " .. t.Name .. "] " .. t.Text
		t.Name = nil
	end
})

GM:AddMessageType({
	Name			= "PMIN",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(160, 255, 160),
	Tabs			= TAB_PRIVMSG,
	NoSend			= true,
	OnReceived		= function(t)
		t.Text = "[PM from " .. t.Name .. "] " .. t.Text
		t.Name = nil

		GAMEMODE.LastMessenger = t.Entity and t.Entity.VisibleRPName and t.Entity:VisibleRPName() or nil
	end
})

GM:AddMessageType({
	Name			= "SAY",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(91, 166, 221),
	Tabs			= TAB_IC,
	Commands		= "/say",
	Range			= 400,
	MuffledRange	= 150,
	Logged			= true,
	LogName 		= "IC",
	LoggedIC		= true,
	UsesLanguage	= true,
	Alive			= true,
	Mouth 			= true,
	OnReceived		= function(t)
		if t.Language then
			local lang = t.Language

			t.TextColor = Color(255, 167, 73)

			if LocalPlayer():HasLang(lang.Lang) then
				t.Text = string.format("[%s] %s: %s", string.upper(lang.Alias), t.Name, t.Text)
			else

				local says = "says"
				local p = t.Text:reverse():match("[%?!%.]")

				if p == "?" then
					says = "asks"
				elseif p == "!" then
					says = "exclaims"
				end

				t.Text = string.format("%s %s something in %s.", t.Name, says, lang.UnknownName or lang.Name)
			end
		else
			t.Text = t.Name .. ": " .. t.Text
		end

		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end
	end
})

GM:AddMessageType({
	Name			= "WHISPER",
	Font			= "CombineControl.ChatItalic",
	TextColor		= Color(91, 166, 221),
	Tabs			= TAB_IC,
	Commands		= "/whisper /w",
	Range			= 150,
	MuffledRange	= 0,
	Logged			= true,
	LogName 		= "IC",
	LoggedIC		= true,
	UsesLanguage	= true,
	Alive			= true,
	Mouth 			= true,
	OnReceived		= function(t)
		if t.Language then
			local lang = t.Language

			t.TextColor = Color(255, 167, 73)

			if LocalPlayer():HasLang(lang.Lang) then
				t.Text = string.format("[%s] %s: [WHISPER] %s", string.upper(lang.Alias), t.Name, t.Text)
			else
				t.Text = string.format("%s whispers in %s.", t.Name, lang.UnknownName or lang.Name)
			end
		else
			t.Text = t.Name .. ": [WHISPER] " .. t.Text
		end

		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end
	end
})

GM:AddMessageType({
	Name			= "YELL",
	Font			= "CombineControl.ChatBold",
	TextColor		= Color(255, 50, 50),
	Tabs			= TAB_IC,
	Commands		= "/yell /y",
	Range			= 800,
	Logged			= true,
	LogName 		= "IC",
	LoggedIC		= true,
	UsesLanguage	= true,
	Alive			= true,
	Mouth 			= true,
	OnReceived	= function(t)
		if t.Language then
			local lang = t.Language

			t.TextColor = Color(255, 167, 73)

			if LocalPlayer():HasLang(lang.Lang) then
				t.Text = string.format("[%s] %s: [YELL] %s", string.upper(lang.Alias), t.Name, t.Text)
			else
				t.Text = string.format("%s yells in %s!", t.Name, lang.UnknownName or lang.Name)
			end
		else
			t.Text = t.Name .. ": [YELL] " .. t.Text
		end

		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end
	end
})

GM:AddMessageType({
	Name			= "EMOTE",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(131, 196, 251),
	Tabs			= TAB_IC,
	Commands		= "/me /emote",
	Range			= 1024,
	MuffledRange	= 128,
	Logged			= true,
	LogName 		= "EMOTE",
	LoggedIC		= true,
	OnReceived		= function(t)
		if t.Text:match("^[,.']") then
			t.Text = string.format("** %s%s", t.Name, t.Text)
		else
			t.Text = string.format("** %s %s", t.Name, t.Text)
		end

		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end
	end
})

GM:AddMessageType({
	Name			= "LONGEMOTE",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(131, 196, 251),
	Tabs			= TAB_IC,
	Commands		= "/lme /lemote",
	Range			= 2048,
	Logged			= true,
	LogName 		= "EMOTE",
	LoggedIC		= true,
	OnReceived		= function(t)
		if t.Text:match("^[,.']") then
			t.Text = string.format("** %s%s", t.Name, t.Text)
		else
			t.Text = string.format("** %s %s", t.Name, t.Text)
		end

		t.ConsoleText = string.format("[L] %s", t.Text)
		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end
	end
})

GM:AddMessageType({
	Name			= "IT",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(131, 196, 251),
	Tabs			= TAB_IC,
	Commands		= "/it",
	Range			= 1024,
	MuffledRange	= 128,
	Logged			= true,
	LogName 		= "EMOTE",
	LoggedIC		= true,
	OnReceived		= function(t)
		t.Text = string.format("** %s **", t.Text)
		t.ConsoleText = string.format("(%s) %s", t.Name, t.Text)
		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end
	end
})

GM:AddMessageType({
	Name			= "LONGIT",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(131, 196, 251),
	Tabs			= TAB_IC,
	Commands		= "/lit",
	Range			= 2048,
	Logged			= true,
	LogName 		= "EMOTE",
	LoggedIC		= true,
	OnReceived		= function(t)
		t.Text = string.format("** %s **", t.Text)
		t.ConsoleText = string.format("[L] (%s) %s", t.Name, t.Text)
		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end
	end
})

GM:AddMessageType({
	Name			= "RADIO",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(72, 118, 255),
	Tabs			= TAB_RADIO,
	Logged			= true,
	LogName 		= "RADIO",
	LoggedIC		= true,
	UsesLanguage	= true,
	Alive			= true,
	Mouth 			= true,
	OnReceived		= function(t)
		local freq = t.Custom.Freq

		if freq == 2000 then
			freq = "LONG-RANGE"
		elseif freq >= 1000 then
			if freq % 1000 == 0 then
				freq = "SKYNET"
			else
				freq = "SKYNET-" .. (freq % 1000)
			end
		else
			freq = string.format("%i MHz", freq)
		end

		if t.Custom.Stationary then
			freq = "Stationary Radio"
		end

		local jammed = t.Custom.Jammed

		if jammed then
			local selfJammed = GAMEMODE:GetRadioJamming(LocalPlayer())

			if jammed < selfJammed then
				t.Text = string.Gibberish(t.Text, selfJammed - jammed)
			end

			if jammed >= 25 then
				t.Name = "Unknown"
			end
		end

		if t.Language then
			local lang = t.Language

			t.TextColor = Color(255, 167, 73)

			if LocalPlayer():HasLang(lang.Lang) then
				t.Text = string.format("[%s] %s: %s", string.upper(lang.Alias), t.Name, t.Text)
			else

				local says = "says"
				local p = t.Text:reverse():match("[%?!%.]")

				if p == "?" then
					says = "asks"
				elseif p == "!" then
					says = "exclaims"
				end

				t.Text = string.format("%s %s something in %s.", t.Name, says, lang.UnknownName or lang.Name)
			end

			t.Text = string.format("[%s] %s", freq, t.Text)
		else
			t.Text = string.format("[%s] %s: %s", freq, t.Name, t.Text)
		end

		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end

		-- TODO: Radio style config setting
		GAMEMODE:AddRadioChat(t.Text)
	end
})

GM:AddMessageType({
	Name			= "RADIOY",
	Font			= "CombineControl.ChatBold",
	TextColor		= Color(72, 118, 255),
	Tabs			= TAB_RADIO,
	Logged			= true,
	LogName 		= "RADIO",
	LoggedIC		= true,
	UsesLanguage	= true,
	Alive			= true,
	Mouth 			= true,
	OnReceived		= function(t)
		local freq = t.Custom.Freq

		if freq == 2000 then
			freq = "LONG-RANGE"
		elseif freq >= 1000 then
			if freq % 1000 == 0 then
				freq = "SKYNET"
			else
				freq = "SKYNET-" .. (freq % 1000)
			end
		else
			freq = string.format("%i MHz", freq)
		end

		if t.Custom.Stationary then
			freq = "Stationary Radio"
		end

		local jammed = t.Custom.Jammed

		if jammed then
			local selfJammed = GAMEMODE:GetRadioJamming(LocalPlayer())

			if jammed < selfJammed then
				t.Text = string.Gibberish(t.Text, selfJammed - jammed)
			end

			if jammed >= 25 then
				t.Name = "Unknown"
			end
		end

		if t.Language then
			local lang = t.Language

			t.TextColor = Color(255, 167, 73)

			if LocalPlayer():HasLang(lang.Lang) then
				t.Text = string.format("[%s] %s: [YELL] %s", string.upper(lang.Alias), t.Name, t.Text)
			else
				t.Text = string.format("%s yells in %s!", t.Name, lang.UnknownName or lang.Name)
			end

			t.Text = string.format("[%s] %s", freq, t.Text)
		else
			t.Text = string.format("[%s] %s: [YELL] %s", freq, t.Name, t.Text)
		end

		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end

		-- TODO: Radio style config setting
		GAMEMODE:AddRadioChat(t.Text)
	end
})

GM:AddMessageType({
	Name			= "RADIOW",
	Font			= "CombineControl.ChatItalic",
	TextColor		= Color(72, 118, 255),
	Tabs			= TAB_RADIO,
	Logged			= true,
	LogName 		= "RADIO",
	LoggedIC		= true,
	UsesLanguage	= true,
	Alive			= true,
	Mouth 			= true,
	OnReceived		= function(t)
		local freq = t.Custom.Freq

		if freq == 2000 then
			freq = "LONG-RANGE"
		elseif freq >= 1000 then
			if freq % 1000 == 0 then
				freq = "SKYNET"
			else
				freq = "SKYNET-" .. (freq % 1000)
			end
		else
			freq = string.format("%i MHz", freq)
		end

		if t.Custom.Stationary then
			freq = "Stationary Radio"
		end

		local jammed = t.Custom.Jammed

		if jammed then
			local selfJammed = GAMEMODE:GetRadioJamming(LocalPlayer())

			if jammed < selfJammed then
				t.Text = string.Gibberish(t.Text, selfJammed - jammed)
			end

			if jammed >= 25 then
				t.Name = "Unknown"
			end
		end

		if t.Language then
			local lang = t.Language

			t.TextColor = Color(255, 167, 73)

			if LocalPlayer():HasLang(lang.Lang) then
				t.Text = string.format("[%s] %s: [WHISPER] %s", string.upper(lang.Alias), t.Name, t.Text)
			else
				t.TextColor = Color(255, 167, 73)
				t.Text = string.format("%s whispers in %s.", t.Name, lang.UnknownName or lang.Name)
			end

			t.Text = string.format("[%s] %s", freq, t.Text)
		else
			t.Text = string.format("[%s] %s: [WHISPER] %s", freq, t.Name, t.Text)
		end

		t.Name = nil

		if IsValid(t.Entity) and t.Entity:IsPlayer() and GAMEMODE.ChatHighlight[t.Entity:CharID()] then
			t.TextColor = getHighlightColor()
		end

		-- TODO: Radio style config setting
		GAMEMODE:AddRadioChat(t.Text)
	end
})

GM:AddMessageType({
	Name			= "RADIOC",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(232, 20, 20),
	Tabs			= TAB_RADIO,
	Logged			= true,
	LogName 		= "RADIO",
	LoggedIC		= true,
	UsesLanguage	= true,
	Alive			= true,
	Mouth 			= true,
	OnReceived		= function(t)
		local freq = t.Custom.Freq

		if freq == 2000 then
			freq = "LONG-RANGE"
		elseif freq >= 1000 then
			if freq % 1000 == 0 then
				freq = "SKYNET"
			else
				freq = "SKYNET-" .. (freq % 1000)
			end
		else
			freq = string.format("%i MHz", freq)
		end

		if t.Custom.Stationary then
			freq = "Stationary Radio"
		end

		local jammed = t.Custom.Jammed

		if jammed then
			local selfJammed = GAMEMODE:GetRadioJamming(LocalPlayer())

			if jammed < selfJammed then
				t.Text = string.Gibberish(t.Text, selfJammed - jammed)
			end

			if jammed >= 25 then
				t.Name = "Unknown"
			end
		end

		if t.Language then
			local lang = t.Language

			if LocalPlayer():HasLang(lang.Lang) then
				t.Text = string.format("[%s] %s: %s", string.upper(lang.Alias), t.Name, t.Text)
			else

				local says = "says"
				local p = t.Text:reverse():match("[%?!%.]")

				if p == "?" then
					says = "asks"
				elseif p == "!" then
					says = "exclaims"
				end

				t.Text = string.format("%s %s something in %s.", t.Name, says, lang.UnknownName or lang.Name)
			end

			t.Text = string.format("[%s] %s", freq, t.Text)
		else
			t.Text = string.format("[%s] %s: %s", freq, t.Name, t.Text)
		end

		t.Name = nil

		-- TODO: Radio style config setting
		GAMEMODE:AddRadioChat(t.Text, t.TextColor)
	end
})

GM:AddMessageType({
	Name			= "ADVERT",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(111, 186, 241),
	Tabs			= TAB_IC,
	Logged			= true,
	LoggedIC		= true,
	Alive			= true,
	OnReceived		= function(t)
		t.Text = string.format("[ADVERT] %s", t.Text)
		t.ConsoleText = string.format("(%s) %s", t.Name, t.Text)
		t.Name = nil
	end
})

GM:AddMessageType({
	Name			= "BROADCAST",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(111, 186, 241),
	Tabs			= TAB_IC,
	Logged			= true,
	LoggedIC		= true,
	Alive			= true,
	OnReceived		= function(t)
		t.Text = string.format("[BROADCAST] %s", t.Text)
		t.ConsoleText = string.format("(%s) %s", t.Name, t.Text)
		t.Name = nil
	end
})

GM:AddMessageType({
	Name			= "DISPATCH",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(111, 186, 241),
	Tabs			= TAB_IC,
	Logged			= true,
	LoggedIC		= true,
	Alive			= true,
	OnReceived		= function(t)
		t.Text = string.format("[DISPATCH] %s", t.Text)
		t.ConsoleText = string.format("(%s) %s", t.Name, t.Text)
		t.Name = nil
	end
})

GM:AddMessageType({
	Name			= "EVENT",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(0, 191, 255),
	Tabs			= TAB_IC,
	Logged			= true,
	LogName 		= "EVENT",
	LoggedIC		= true,
	OnReceived		= function(t)
		t.Text = string.format("[EVENT] ** %s **", t.Text)
		t.ConsoleText = string.format("(%s) %s", t.Name, t.Text)
		t.Name = nil
	end
})

GM:AddMessageType({
	Name			= "LOCALEVENT",
	Font			= "CombineControl.ChatNormal",
	TextColor		= Color(255, 117, 48, 255),
	Tabs			= TAB_IC,
	Range 			= 4096,
	Logged			= true,
	LogName 		= "EVENT",
	LoggedIC		= true,
	OnReceived		= function(t)
		t.Text = string.format("[EVENT] ** %s **", t.Text)
		t.ConsoleText = string.format("[L] (%s) %s", t.Name, t.Text)
		t.Name = nil
	end
})


GM:AddChatCommand({
	Commands = "/blorp",
	OnSent = function(t)
		if not LocalPlayer():Alive() then
			GAMEMODE:AddChat("That is not dead which can eternal blorp.", Color(128, 32, 32))
			return
		end

		GAMEMODE:AddChat("... blorp!", Color(math.random(32, 255), math.random(32, 255), math.random(32, 255)))

		return true
	end
})

GM:AddChatCommand({
	Commands = "/blorpfest",
	OnSent = function(t)
		local function blorpfest()
			if math.random() > 0.8 then
				GAMEMODE:AddChat("... bloooorp!", Color(math.random(32, 255), math.random(32, 255), math.random(32, 255)))

				return
			end

			GAMEMODE:AddChat("... blorp!", Color(math.random(32, 255), math.random(32, 255), math.random(32, 255)))

			timer.Simple(math.random(5, 30) / 10, blorpfest)
		end

		GAMEMODE:AddChat("Blorp!", Color(math.random(32, 255), math.random(32, 255), math.random(32, 255)))

		timer.Simple(math.random(5, 30) / 10, blorpfest)

		return true
	end
})

GM:AddChatCommand({
	Commands	= "/reply",
	OnSent		= function(t)
		if not GAMEMODE.LastMessenger then
			-- oh god this is so ugly
			-- we need a helper func for this
			GAMEMODE:AddChat("No one to reply to!", GAMEMODE.MessageTypes.ERROR.TextColor)

			return true
		end

		-- hack!
		GAMEMODE:ParseChat("/pm \"" .. GAMEMODE.LastMessenger .. "\" " .. t.Text)

		return true
	end
})

GM:AddChatCommand({
	Commands = "/highlight /hl",
	OnSent = function(t)
		if #t.Text == 0 then
			GAMEMODE:AddChat("Error: Missing arguments.", GAMEMODE.MessageTypes.ERROR.TextColor)

			return true
		end

		local rec

		if t.Text == "-" then
			rec = LocalPlayer():GetEyeTrace().Entity
		else
			rec = GAMEMODE:FindPlayer(t.Text, LocalPlayer())
		end

		if not IsValid(rec) or not rec:IsPlayer() then
			GAMEMODE:AddChat("Error: Invalid target.", GAMEMODE.MessageTypes.ERROR.TextColor)

			return true
		end

		local id = rec:CharID()

		if GAMEMODE.ChatHighlight[id] then
			GAMEMODE.ChatHighlight[id] = nil
			GAMEMODE:AddChat("Disabled chat highlighting for " .. rec:VisibleRPName(), GAMEMODE.MessageTypes.WARNING.TextColor)
		else
			GAMEMODE.ChatHighlight[id] = true
			GAMEMODE:AddChat("Enabled chat highlighting for " .. rec:VisibleRPName(), GAMEMODE.MessageTypes.WARNING.TextColor)
		end

		return true
	end
})

local adminCommands = {
	["rpa_bring"] 	= "/bring !bring",
	["rpa_goto"] 	= "/goto !goto",
	["rpa_kill"] 	= "/kill !kill /slay !slay",
	["rpa_slap"] 	= "/slap !slap",
	["rpa_kick"] 	= "/kick !kick",
	["rpa_mute"] 	= "/mute !mute"
}

for k, v in pairs(adminCommands) do
	GM:AddChatCommand({
		Commands = v,
		OnSent = function(t)
			if #t.Text == 0 then
				GAMEMODE:AddChat("Error: No target found.", GAMEMODE.MessageTypes.ERROR.TextColor)
				return
			end
			RunConsoleCommand(k, t.Text)
		end
	})
end
