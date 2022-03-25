util.AddNetworkString("nChat")

local meta = FindMetaTable("Player")
function meta:SendChat(src, class, text, lang, nolog, custom)
	GAMEMODE:SendChat(src, self, class, text, lang, nolog, custom)
end

function meta:GetRF(maxd, muffled, noself)
	local ply, ent = {}, {}
	for k, v in pairs(ents.FindInSphere(self:GetPos(), maxd)) do
		if v:IsPlayer() then
			if v ~= self or not noself then
				local dist = maxd
				if maxd ~= muffled and not self:CanHear(v) then
					dist = muffled
				end
				if v:GetPos():Distance(self:GetPos()) < dist then
					ply[#ply + 1] = v
				end
			end
		elseif v.OnChat then
			ent[#ent + 1] = v
		end
	end
	return ply, ent
end

function GM:SendChat(src, rec, class, text, lang, nolog, custom)
	if not src then
		src = game.GetWorld()
	end
	if type(class) == "string" then
		class = assert(self.MessageTypes[class], "invalid message type '" .. class .. "'")
	end
	if not lang then
		lang = self.Languages.eng
	elseif type(lang) == "string" then
		lang = assert(self.Languages[lang], "invalid lang '" .. lang .. "'")
	end

	if class.CanHear then
		local tmp = {}
		if type(rec) == "table" then
			for k, v in pairs(rec) do
				if class.CanHear(src, v) then
					tmp[#tmp + 1] = v
				end
			end
		elseif class.CanHear(src, rec) then
			tmp = rec
		end
		rec = tmp
	end

	if src:IsValid() and class.Logged and not nolog then
		self:LogChatMessage({
			Entity 		= src,
			Language 	= lang,
			Class 		= class,
			Text 		= text
		})

		self:WriteChatLog(src, class, lang, text, custom)
	end

	net.Start("nChat")
		net.WriteUInt(src:EntIndex(), 8)
		net.WriteUInt(class.ID, 16)
		net.WriteUInt(lang.ID, 8)
		net.WriteString(text)
		net.WriteTable(custom or {})
	net.Send(rec)
end

function GM:SendRangedChat(src, class, text, lang)
	if type(class) == "string" then
		class = assert(self.MessageTypes[class], "invalid message type '" .. class .. "'")
	end
	if type(lang) == "string" then
		lang = assert(self.Languages[lang], "invalid lang '" .. lang .. "'")
	end

	local rec = src:GetRF(class.Range, class.MuffledRange or class.Range)
	if #rec > 0 then
		self:SendChat(src, rec, class, text, lang)
	end
end

function GM:HandleChat(ply, cmd, class, text, lang, custom)
	text = text:sub(1, 512)
	--print(string.format("%s - %s - %s - %s", tostring(ply), lang.Name, class.Name, text))
	if class.NoSend then
		return
	elseif not ply:HasLang(lang.Lang) then
		--print(string.format("can't speak language %s (Lang is %i)", lang.Name, lang.Lang))
		return
	end

	local t = table.Merge(table.Copy(class), {
		Entity		= ply,
		Name		= ply:VisibleRPName(),
		RealName	= ply:RPName(),
		Nick		= ply:Nick(),
		Language	= lang,
		Command		= cmd,
		Class		= class,
		Text		= text,
		Custom 		= custom or {}
	})

	if hook.Run("OnChat", ply, t) then
		return
	elseif t.Class.OnParsed and t.Class.OnParsed(t) then
		return
	end

	ply, class, text = t.Entity, t.Class, t.Text

	-- Don't try to broadcast simple chat commands.
	if not class.Name then return end

	if class.Range then
		self:SendRangedChat(ply, class, text, lang)
	else
		self:SendChat(ply, player.GetAll(), class, text, lang)
	end
end

hook.Add("OnChat", "ChatRestrictions", function(ply, t)
	if t.Class.Mouth then
		if false --[[ ply:HasCharFlag("S")--]] then
			ply:SendChat(nil, "ERROR", "You can't do that without a mouth.")
			return true
		end
	end

	if t.Class.Alive then
		if not ply:Alive() then
			ply:SendChat(nil, "ERROR", "You can't do that while you're dead.")
			return true
		elseif ply:PassedOut() then
			ply:SendChat(nil, "ERROR", "You can't do that while unconscious.")
			return true
		end
	end
end)

net.Receive("nChat", function(len, ply)
	ply:SetTyping(0)

	local cmd = net.ReadString()
	local classid = net.ReadUInt(16)
	local langid = net.ReadUInt(8)
	local class = GAMEMODE.MessageTypes[classid]
	if not class then
		-- check for serverside chat commands
		-- FIXME: this is FUCKING AWFUL
		class = GAMEMODE.ChatCommands[cmd]
		if not class then
			GAMEMODE:SendChat(nil, ply, "INFO", "Unknown chat command '" .. cmd .. "'!")
			return
		end
	end
	local lang = GAMEMODE.Languages[langid]
	local text = net.ReadString()
	local custom = net.ReadTable() or {}

	GAMEMODE:HandleChat(ply, cmd, class, text, lang, custom)
end)

GM:AddChatCommand({
	Commands = "/r /ry /rw /rcom",
	Alive = true,
	Mouth = true,
	OnParsed = function(t)
		local ply = t.Entity
		local ent = ply:GetEyeTrace().Entity
		local cmd = t.Command
		local loc, rem, seen, static = {}, {}, {}, {}
		local item = ply:GetEquipment(EQUIPMENT_RADIO)
		local freq

		if cmd == "/rcom" and not ply:IsSuperAdmin() then
			GAMEMODE:SendChat(nil, ply, "INFO", "Unknown chat command '" .. cmd .. "'!")
			return
		end

		if IsValid(ent) and ent:GetClass() == "cc_radio" and ply:GetPos():Distance(ent:GetPos()) <= 256 then
			freq = ent:GetChannel()
			table.insert(static, ply)
		elseif item then
			freq = item:GetPrimaryChannel()

			if not freq then
				ply:SendChat(nil, "ERROR", string.format("Your %s isn't transmitting.", item:GetName()))

				return
			end
			table.insert(rem, ply)
		else
			ply:SendChat(nil, "ERROR", "You don't have a radio.")

			return
		end

		seen[ply] = true

		t.Custom.Freq = freq
		-- Hack!
		local class = GAMEMODE.MessageTypes.SAY
		local radclass = GAMEMODE.MessageTypes.RADIO
		if cmd == "/ry" then
			class = GAMEMODE.MessageTypes.YELL
			radclass = GAMEMODE.MessageTypes.RADIOY
		elseif cmd == "/rw" then
			class = GAMEMODE.MessageTypes.WHISPER
			radclass = GAMEMODE.MessageTypes.RADIOW
		elseif cmd == "/rcom" then
			radclass = GAMEMODE.MessageTypes.RADIOC
		end

		local range, muffled = class.Range, class.MuffledRange or class.Range

		for _, v in pairs(player.GetAll()) do
			if v:IsAdmin() and v:AdminRadio() then
				table.insert(rem, v)
				seen[v] = true
			end

			if seen[v] then
				continue
			end

			local item2 = v:GetEquipment(EQUIPMENT_RADIO)

			if not item2 then
				continue
			end

			if item2:CanHearChannel(freq) then
				table.insert(rem, v)
				seen[v] = true
			end
		end

		for _, v in pairs(ply:GetRF(range, muffled)) do
			if seen[v] then
				continue
			end

			if freq >= 1000 and v:Team() ~= TEAM_SKYNET then
				continue
			end

			table.insert(loc, v)
			seen[v] = true
		end

		for _, v in pairs(ents.FindByClass("cc_radio")) do
			if v:GetChannel() ~= freq then
				continue
			end

			for _, targ in pairs(player.GetAll()) do
				if seen[targ] then
					continue
				end

				if v:GetPos():Distance(targ:GetPos()) <= range then
					table.insert(static, targ)
					seen[targ] = true
				end
			end
		end

		-- NOTE: this won't work if we ever implement multiple radios
		-- but that would require rewriting the entire item system and that won't happen

		-- Ha ha ha
		GAMEMODE:SendChat(ply, loc, class, t.Text, t.Language, true)
		GAMEMODE:SendChat(ply, rem, radclass, t.Text, t.Language, false, t.Custom)

		t.Custom.Stationary = true

		GAMEMODE:SendChat(ply, static, radclass, t.Text, t.Language, true, t.Custom)
	end
})

GM:AddChatCommand({
	Commands = "/pm",
	OnParsed = function(t)
		local ply, text = t.Entity, t.Text

		local name, args
		if text:sub(1, 1) == '"' then
			name, args = text:match('^"([^"]+)"?%s*(.-)$')
		else
			name, args = text:match("^(%S*)%s*(.-)$")
		end

		if #args == 0 then
			ply:SendChat(nil, "ERROR", "Error: Missing arguments.")

			return true
		end

		-- hack.
		local rec
		if name == "-" then
			rec = ply:GetEyeTrace().Entity
		else
			rec = GAMEMODE:FindPlayer(name, ply)
		end
		if not IsValid(rec) then
			ply:SendChat(nil, "ERROR", "Error: No player found.")
			return
		elseif (
			rec:GetClass() == "prop_physics"
			and rec:GetModel() == "models/props_lab/huladoll.mdl"
			and rec:GetPos():Distance(ply:GetPos()) <= 96
		) then
			ply:SendChat(nil, "INFO", "You whisper your secrets to the hula doll.")
			local rand = math.random(1, 3)
			if rand == 1 then
				ply:SendChat(nil, "INFO", (table.Random{
					"... There's no answer.",
					"... The doll remains silent.",
					"... Huh. Nothing."
				}))
			elseif rand == 2 then
				if not ply:IsValid() then return end
				ply:SendChat(nil, "WARNING", "Phew. You feel better with that off your chest.")
			else
				local dmg = math.random(10, 15)
				if math.random() > 0.9 or dmg >= ply:Health() then
					GAMEMODE:SendChat(nil, ents.FindInSphere(ply:GetPos(), 256), "ERROR", "The hula doll screams!")
					rec:EmitSound(table.Random{
						"ambient/creatures/town_child_scream1.wav",
						"ambient/creatures/town_zombie_call1.wav"
					}, 100, 100, 1, CHAN_AUTO)
					ply:Kill()
				else
					ply:SendChat(nil, "ERROR", (table.Random{
						"The hula doll emits a threatening aura. You've said too much...",
						"The hula doll quakes with anger. You've said too much...",
					}))
					ply:TakeDamage(dmg, ply, rec)
					rec:EmitSound(table.Random{
						"ambient/creatures/town_scared_breathing1.wav",
						"ambient/creatures/town_scared_breathing2.wav",
						"ambient/creatures/town_scared_sob1.wav",
						"ambient/creatures/town_scared_sob2.wav",
					}, 100, 100, 1, CHAN_AUTO)
				end
			end
			return
		elseif not rec:IsPlayer() then
			return
		end

		-- TODO: /ignore?

		GAMEMODE:LogFile("chat", string.format("%s\t%s\t%s(#%i) [PM TO %s(#%i)] %s",
			os.date("!%H:%M:%S"),
			ply:SteamID(),
			ply:VisibleRPName(),
			ply:CharID(),
			rec:VisibleRPName(),
			rec:CharID(),
			args))

		GAMEMODE:WriteChatLog(ply, {Name = "PM"}, nil, args, {RecChar = GAMEMODE:LogCharacter(rec), RecPly = GAMEMODE:LogPlayer(rec)})

		ply:SendChat(rec, "PMOUT", args)
		rec:SendChat(ply, "PMIN", args)
	end
})

--[[
GM:AddChatCommand({
	Commands = "/ad /adv /advert",
	Alive = true,
	OnParsed = function(t)
		local ply = t.Entity
		if ply:Money() < 10 then
			ply:SendChat(nil, "ERROR", "You need " .. util.FormatCurrency(10) .. " to make an advertisement.")
			return
		end

		if GAMEMODE.CurrentLocation ~= LOCATION_CITY then
			ply:SendChat(nil, "ERROR", "You can't advertise out here.")
			return
		end

		ply:AddMoney(-10)
		ply:UpdateCharacterField("Money", tostring(ply:Money()))

		GAMEMODE:SendChat(ply, player.GetAll(), "ADVERT", t.Text)
	end
})
--]]

GM:AddChatCommand({
	Commands = "/br /bc /broadcast",
	Alive = true,
	OnParsed = function(t)
		local ply = t.Entity

		if not ply:GetCharFlagAttribute("CanBroadcast") then
			ply:SendChat(nil, "ERROR", "Only people loyal to the combine can do that.")
			return
		end

		GAMEMODE:SendChat(ply, player.GetAll(), "BROADCAST", t.Text)
	end
})

GM:AddChatCommand({
	Commands = "/ev /event",
	Alive = true,
	OnParsed = function(t)
		local ply = t.Entity

		local flag = false
		local flagtable = {GAMEMODE.PlayerFlags, GAMEMODE.CharFlags}
		for i = 1, 2 do
			for k,v in pairs(flagtable[i]) do
				if v.EventAllowed then
					if ply:HasPlayerFlag(v.Flag) then
						flag = true
						break
					end
				end
			end
		end

		if not ply:IsAdmin() and not flag then
			ply:SendChat(nil, "ERROR", "You're not an admin.")
			return
		end

		GAMEMODE:SendChat(ply, player.GetAll(), "EVENT", t.Text)
	end
})

GM:AddChatCommand({
	Commands = "/lev /levent",
	Alive = true,
	OnParsed = function(t)
		local ply = t.Entity

		local flag = false
		local flagtable = {GAMEMODE.PlayerFlags, GAMEMODE.CharFlags}
		for i = 1, 2 do
			for k,v in pairs(flagtable[i]) do
				if v.EventAllowed then
					if ply:HasPlayerFlag(v.Flag) then
						flag = true
						break
					end
				end
			end
		end

		if not ply:IsAdmin() and not flag then
			ply:SendChat(nil, "ERROR", "You're not an admin.")
			return
		end

		GAMEMODE:SendRangedChat(ply, "LOCALEVENT", t.Text)
	end
})

GM:AddChatCommand({
	Commands = "/cid",
	OnParsed = function(t)
		local ply = t.Entity

		if #t.Text == 0 then
			ply:SendChat(nil, "INFO", "Your current CID is: " .. tostring(ply:FormattedCID()) .. ".")
			return
		end

		local old = ply:FormattedCID()
		local n = tonumber(t.Text)

		if not n then
			ply:SendChat(nil, "ERROR", "CID must be a number.")
		return
		end

		if n < 0 then
			ply:SendChat(nil, "ERROR", "CID must be greater than zero.")
			return
		elseif n > 99999 then
			ply:SendChat(nil, "ERROR", "CID must be under six digits.")
			return
		else
			ply:SetCID(n)
			ply:UpdateCharacterField("CID", tostring(n))

			local name = ply:VisibleRPName()
			GAMEMODE:LogCombine("[I] " .. name .. " changed their CID from " .. old .. " to " .. ply:FormattedCID(), ply)
		end

	end
})

GM:AddChatCommand({
	Commands = "/rset",
	OnParsed = function(t)
		local ply = t.Entity
		local radio = ply:GetEquipment(EQUIPMENT_RADIO)

		if not radio or not radio:CanInteract(ply) then
			ply:SendChat(nil, "ERROR", "You don't have a radio.")

			return
		end

		local max = radio:GetProperty("MaxChannels")

		if max <= 1 then
			ply:SendChat(nil, "ERROR", "Your radio only has one channel!")

			return
		end

		local channel = tonumber(t.Text)

		if not channel or (channel > max or channel < 1) then
			ply:SendChat(nil, "ERROR", string.format("Specify a channel between 1 and %s.", max))

			return
		end

		channel = math.floor(channel)

		radio:SetProperty("PrimaryChannel", channel)
		ply:SendChat(nil, "INFO", string.format("Now transmitting on channel %s.", channel))
	end
})