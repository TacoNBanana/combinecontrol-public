local SOUND_SPAM_THRESHOLD = 5 -- seconds

local function soundSpamCheck(ply)
	if ply:IsDeveloper() then
		return true
	end

	if ply.LastSoundTime and (CurTime() - ply.LastSoundTime) < SOUND_SPAM_THRESHOLD then
		return false
	end

	ply.LastSoundTime = CurTime()
	return true
end

local function emitSoundData(ply, soundData, db)
	if not db then
		db = 75
	end

	if isstring(soundData) and string.match(soundData, ".-%.wav") then -- Sound file
		ply:EmitSound(soundData, db);
	elseif istable(soundData) then -- List of sound files
		soundData = table.Copy(soundData) -- Fix for soundData being influenced by previous emitSoundData calls

		local duration = 0
		local path = table.remove(soundData, 1)

		-- Preprocessing, add sound dir and .wav suffix
		for k, v in pairs(soundData) do
			local split = string.Explode(":", v)

			soundData[k] = path .. split[1] .. ".wav"

			if split[2] then
				soundData[k] = soundData[k] .. ":" .. split[2]
			end
		end

		for _, v in pairs(soundData) do
			local split = string.Explode(":", v)

			local snd = split[1]
			local pitch = split[2] or 100

			timer.Simple(duration, function()
				if not IsValid(ply) then return end
				if not ply:Alive() or ply:PassedOut() then return end

				ply:EmitSound(snd, db, pitch)
			end)

			duration = duration + SoundDuration(snd)
		end
	else -- Sentence
		EmitSentence(soundData, ply:GetPos(), ply:EntIndex(), CHAN_AUTO, 1, db, 0, 100)
	end

end

local soundFuncs = {}

soundFuncs["$cpon"] = function()
	return {"on" .. math.random(1, 2)}
end

soundFuncs["$cpoff"] = function()
	local arr = {1, 4}
	return {"off" .. arr[math.random(1, #arr)]}
end

soundFuncs["$owon"] = function()
	return {"on" .. math.random(1, 2)}
end

soundFuncs["$owoff"] = function()
	return {"off" .. math.random(1, 3)}
end

soundFuncs["$dist"] = function(ply)
	local dist = ply:GetEyeTrace().HitPos:Distance(ply:EyePos()) * 0.75 * 0.0254 -- Thanks wiremod

	local arr = {
		{1, "zero"}, {2, "one"}, {3, "two"}, {4, "three"}, {5, "four"}, {6, "five"}, {7, "six"}, {8, "seven"}, {9, "eight"}, {10, "niner"},
		{11, "ten"}, {12, "eleven"}, {13, "twelve"}, {14, "thirteen"}, {15, "fourteen"}, {16, "fifteen"}, {17, "sixteen"}, {18, "seventeen"},
		{19, "eighteen"}, {20, "nineteen"}, {30, "twenty"}, {40, "thirty"}, {50, "fourty"}, {60, "fifty"}, {70, "sixty"}, {80, "seventy"},
		{90, "eighty"}, {100, "ninety"}, {200, "onehundred"}, {300, "twohundred"}
	}

	for _, v in pairs(arr) do
		if dist < v[1] then
			return {"range", v[2], "meters"}
		end
	end

	return {"range", "threehundred", "meters"}
end

soundFuncs["$3cid"] = function(ply)
	local digits = string.Explode("", string.Left(ply:FormattedCID(), 3))
	local arr = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

	return {arr[digits[1] + 1], "_comma", arr[digits[2] + 1], "_comma", arr[digits[3] + 1], "_comma"}
end

soundFuncs["$randCode"] = function()
	local codes = {"pressure", "document", "restrict", "intercede", "preserve", "search", "suspend",
		"investigate", "interlock", "isolate", "administer", "cauterize", "inject", "innoculate",
		"examine", "apply", "prosecute", "serve", "sterilize", "amputate", "lock"
	}

	local numbers = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

	return {codes[math.random(1, #codes)], numbers[math.random(1, #numbers)], codes[math.random(1, #codes)]}
end

soundFuncs["$scannerScan"] = function()
	return {"combat_scan" .. math.random(1, 5)}
end

soundFuncs["$scannerAltScan"] = function()
	local sounds = {"scanner_scan1", "scanner_scan2",
		"scanner_scan4", "scanner_scan5"
	}

	return {sounds[math.random(1, #sounds)]}
end

local function preProcessSoundTable(speaker, data)
	local res = {}

	for _, snd in pairs(data) do
		if snd[1] != "$" then
			table.insert(res, snd)
			continue
		end

		if soundFuncs[snd] then
			local tab = soundFuncs[snd](speaker)

			for _, repl in pairs(tab) do
				table.insert(res, repl)
			end
		end
	end

	return res
end

concommand.Add("rp_playsound", function(ply, cmd, args)
	local category = GAMEMODE.SoundData[tonumber(args[1])]
	if not category then return end

	local data = table.Copy(category.sounds[tonumber(args[2])])
	if not data then return end

	if not IsValid(ply) then return end
	if not ply:Alive() then return end
	if ply:PassedOut() then return end
	if not GAMEMODE:CanPlaySound(ply, category) then return end

	if not soundSpamCheck(ply) then return end --This needs to always go last as it has some side-effects

	if istable(data[1]) then
		data[1] = preProcessSoundTable(ply, data[1])
	end

	if ply:CharFlags() == "T" then
		emitSoundData(ply, data[1], 100)
	else
		emitSoundData(ply, data[1])
	end

	GAMEMODE:LogPlaySounds(ply, data[2])

	local nearbyEnts = ents.FindInSphere(ply:GetPos(), 300)
	for _, ent in pairs(nearbyEnts) do
		if IsValid(ent) and ent:IsPlayer() then
			ent:PrintMessage(HUD_PRINTCONSOLE, ply:VisibleRPName() .. " played sound '" .. data[2] .. "'.")
		end
	end
end)

concommand.Add("rp_playdispatch", function(ply, cmd, args)
	local category = GAMEMODE.SoundData[tonumber(args[1])]
	if not category then return end

	local data = table.Copy(category.sounds[tonumber(args[2])])
	if not data then return end

	if not IsValid(ply) then return end
	if not GAMEMODE:CanPlaySound(ply, category) then return end

	if not soundSpamCheck(ply) then return end

	if istable(data[1]) then
		data[1] = preProcessSoundTable(ply, data[1]) -- Preprocessing is done here to keep consistency when randomly selecting things
	end

	for _, unit in pairs(player.GetAll()) do
		-- No synths (ask Xari)
		if false and not unit:IsEFlagSet(EFL_NOCLIP_ACTIVE) then
			emitSoundData(unit, data[1], 70)
			unit:PrintMessage(HUD_PRINTCONSOLE, ply:VisibleRPName() .. " played sound '" .. data[2] .. "'.")
		end
	end

	GAMEMODE:LogPlaySounds(ply, data[2])
end)

function GM:SoundRange(pos, range, snd)
	net.Start("nPlaySoundRange")
		net.WriteVector(pos)
		net.WriteInt(range, 32)
		net.WriteString(snd)
	net.Broadcast()
end