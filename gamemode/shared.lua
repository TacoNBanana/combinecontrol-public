-- 5/25/2013

DeriveGamemode("sandbox")

GM.Name = "TnB Zombie RP"
GM.Author = "Disseminate, Gangleider, Steve, Hoplite, Thor, TankNut, DaveBrown ;D"
GM.Website = "http://taconbanana.com"
GM.Email = "gangleider@taconbanana.com"

function GM:GetGameDescription()
	return self.Name
end

math.randomseed(os.time())

local meta = FindMetaTable("Player")
local emeta = FindMetaTable("Entity")

stub = function() end -- Used in several places, might as well make it global

function GM:InitPostEntity()
	hook.Run("CC.SH.InitEnts")
end

function GM:CreateTeams()
	team.SetUp(TEAM_CITIZEN, "Humans", Color(0, 120, 0, 255), false)
	team.SetUp(TEAM_ZOMBIES, "Zombies", Color(220, 0, 0, 255), false)
	team.SetUp(TEAM_XEN, "Antlions", Color(180, 220, 32, 255), false)
end

function GM:TranslateModelToPlayer(mdl)
	for k, v in pairs(player_manager.AllValidModels()) do
		if string.lower(v) == string.lower(mdl) then
			return k
		end
	end

	return "kleiner"
end

GM.RandomSpawnItems = {
	"clothing_tshirt_white",
	"clothing_tshirt_black",
	"clothing_hoody",
	"clothing_coat_black",	
	"clothing_coat_grey",
	"clothing_coat_white",
	"clothing_coat_hood_black",	
	"clothing_coat_hood_green",
	"clothing_coat_hood_grey",	
	"clothing_puffer_grey",
	"clothing_raincoat_blue",
	"clothing_raincoat_white",
	"clothing_workshirt_blue",		
	"clothing_fleece_green"
}

------------------------ ZOMBIES CONTENT ------------------------------------
GM.DarkSkinnedModels = {
	["models/tnb/techcom/male_01.mdl"] = true,
	["models/tnb/techcom/male_03.mdl"] = true,
	["models/tnb/techcom/male_13.mdl"] = true,
	["models/tnb/techcom/male_32.mdl"] = true,
	["models/tnb/techcom/male_33.mdl"] = true,

	["models/tnb/techcom/female_03.mdl"] = true
}

GM.DarkSkinnedReplacements = {
	["models/tnb/zrp/arm_male_white"] = "models/tnb/zrp/arm_male_black",
	["models/tnb/zrp/arm_female_white"] = "models/tnb/zrp/arm_female_black"
}

GM.SurvivorModels = {}
GM.SurvivorModels[MALE] = {}
GM.SurvivorModels[FEMALE] = {}

GM.SurvivorModels[MALE][Model("models/player/group01/male_01.mdl")] = { "infected/humans/male_01/facemap_01", "infected/humans/male_01/facemap_02", "infected/humans/male_01/facemap_03", "infected/humans/male_01/facemap_04", "infected/humans/male_01/facemap_05" }
GM.SurvivorModels[MALE][Model("models/player/group01/male_02.mdl")] = { "infected/humans/male_02/facemap_01", "infected/humans/male_02/facemap_02", "infected/humans/male_02/facemap_03", "infected/humans/male_02/facemap_04", "infected/humans/male_02/facemap_07" }
GM.SurvivorModels[MALE][Model("models/player/group01/male_03.mdl")] = { "infected/humans/male_03/facemap_01", "infected/humans/male_03/facemap_02", "infected/humans/male_03/facemap_03", "infected/humans/male_03/facemap_04", "infected/humans/male_03/facemap_05", "infected/humans/male_03/facemap_06", "infected/humans/male_03/facemap_08", "infected/humans/male_03/facemap_09" }
GM.SurvivorModels[MALE][Model("models/player/group01/male_04.mdl")] = { "infected/humans/male_04/facemap_01", "infected/humans/male_04/facemap_02", "infected/humans/male_04/facemap_03", "infected/humans/male_04/facemap_04" }
GM.SurvivorModels[MALE][Model("models/player/group01/male_05.mdl")] = { "infected/humans/male_05/facemap_01", "infected/humans/male_05/facemap_02", "infected/humans/male_05/facemap_03", "infected/humans/male_05/facemap_04", "infected/humans/male_05/facemap_05", "infected/humans/male_05/facemap_06", "infected/humans/male_05/facemap_07" }
GM.SurvivorModels[MALE][Model("models/player/group01/male_06.mdl")] = { "infected/humans/male_06/facemap_01", "infected/humans/male_06/facemap_02", "infected/humans/male_06/facemap_03", "infected/humans/male_06/facemap_04", "infected/humans/male_06/facemap_05", "infected/humans/male_06/facemap_08", "infected/humans/male_06/facemap_09", "infected/humans/male_06/facemap_10", "infected/humans/male_06/facemap_11" }
GM.SurvivorModels[MALE][Model("models/player/group01/male_07.mdl")] = { "infected/humans/male_07/facemap_01", "infected/humans/male_07/facemap_02", "infected/humans/male_07/facemap_03", "infected/humans/male_07/facemap_04", "infected/humans/male_07/facemap_05", "infected/humans/male_07/facemap_06", "infected/humans/male_07/facemap_07", "infected/humans/male_07/facemap_08" }
GM.SurvivorModels[MALE][Model("models/player/group01/male_08.mdl")] = { "infected/humans/male_08/facemap_01", "infected/humans/male_08/facemap_02", "infected/humans/male_08/facemap_04", "infected/humans/male_08/facemap_05", "infected/humans/male_08/facemap_09", "infected/humans/male_08/facemap_10" }
GM.SurvivorModels[MALE][Model("models/player/group01/male_09.mdl")] = { "infected/humans/male_09/facemap_01", "infected/humans/male_09/facemap_02", "infected/humans/male_09/facemap_03", "infected/humans/male_09/facemap_04", "infected/humans/male_09/facemap_06" }

GM.SurvivorModels[FEMALE][Model("models/player/group01/female_01.mdl")] = { "infected/humans/female_01/facemap_01", "infected/humans/female_01/facemap_02", "infected/humans/female_01/facemap_03" }
GM.SurvivorModels[FEMALE][Model("models/player/group01/female_02.mdl")] = { "infected/humans/female_02/facemap_01", "infected/humans/female_02/facemap_02", "infected/humans/female_02/facemap_03" }
GM.SurvivorModels[FEMALE][Model("models/player/group01/female_03.mdl")] = { "infected/humans/female_03/facemap_01", "infected/humans/female_03/facemap_02", "infected/humans/female_03/facemap_03", "infected/humans/female_03/facemap_04" }
GM.SurvivorModels[FEMALE][Model("models/player/group01/female_04.mdl")] = { "infected/humans/female_04/facemap_01", "infected/humans/female_04/facemap_02", "infected/humans/female_04/facemap_03" }
GM.SurvivorModels[FEMALE][Model("models/player/group01/female_05.mdl")] = { "infected/humans/female_05/facemap_01", "infected/humans/female_05/facemap_02" }
GM.SurvivorModels[FEMALE][Model("models/player/group01/female_06.mdl")] = { "infected/humans/female_06/facemap_01", "infected/humans/female_06/facemap_02" }

GM.SurvivorClothes = {}
GM.SurvivorClothes[MALE] = {
	"infected/humans/male/sheet_01",
	"infected/humans/male/sheet_02",
	"infected/humans/male/sheet_03",
	"infected/humans/male/sheet_04",
	"infected/humans/male/sheet_05",
	"infected/humans/male/sheet_06",
	"infected/humans/male/sheet_07",
	"infected/humans/male/sheet_08",
	"infected/humans/male/sheet_09",
	"infected/humans/male/sheet_10",
	"infected/humans/male/sheet_11",
	"infected/humans/male/sheet_12",
	"infected/humans/male/sheet_13",
	"infected/humans/male/sheet_14",
	"infected/humans/male/sheet_15",
	"infected/humans/male/sheet_16",
	"infected/humans/male/sheet_17",
	"infected/humans/male/sheet_18",
	"infected/humans/male/sheet_19",
	"infected/humans/male/sheet_20",
	"infected/humans/male/sheet_21",
	"infected/humans/male/sheet_22",
	"infected/humans/male/sheet_23",
	"infected/humans/male/sheet_24",
	"infected/humans/male/sheet_25",
	"infected/humans/male/sheet_26",
	"infected/humans/male/sheet_27",
	"infected/humans/male/sheet_28",
	"infected/humans/male/sheet_29",
	"infected/humans/male/sheet_30",
	"infected/humans/male/sheet_31",
	"infected/humans/male/sheet_32",
	"infected/humans/male/sheet_33",
}
GM.SurvivorClothes[FEMALE] = {
	"infected/humans/female/sheet_01",
	"infected/humans/female/sheet_02",
	"infected/humans/female/sheet_03",
	"infected/humans/female/sheet_04",
	"infected/humans/female/sheet_05",
	"infected/humans/female/sheet_06",
	"infected/humans/female/sheet_07",
	"infected/humans/female/sheet_08",
	"infected/humans/female/sheet_09",
	"infected/humans/female/sheet_10",
	"infected/humans/female/sheet_11",
	"infected/humans/female/sheet_12",
	"infected/humans/female/sheet_13",
	"infected/humans/female/sheet_14",
	"infected/humans/female/sheet_15",
	"infected/humans/female/sheet_16",
	"infected/humans/female/sheet_17",
}

GM.InfectedModels = { }
GM.InfectedModels[MALE] = {}
GM.InfectedModels[FEMALE] = {}

GM.InfectedModels[MALE]["models/player/group01/male_01.mdl"] = { "infected/humans/male_01/facemap_infected" }
GM.InfectedModels[MALE]["models/player/group01/male_02.mdl"] = { "infected/humans/male_02/facemap_infected" }
GM.InfectedModels[MALE]["models/player/group01/male_03.mdl"] = { "infected/humans/male_03/facemap_infected" }
GM.InfectedModels[MALE]["models/player/group01/male_04.mdl"] = { "infected/humans/male_04/facemap_infected" }
GM.InfectedModels[MALE]["models/player/group01/male_05.mdl"] = { "infected/humans/male_05/facemap_infected" }
GM.InfectedModels[MALE]["models/player/group01/male_06.mdl"] = { "infected/humans/male_06/facemap_infected" }
GM.InfectedModels[MALE]["models/player/group01/male_07.mdl"] = { "infected/humans/male_07/facemap_infected" }
GM.InfectedModels[MALE]["models/player/group01/male_08.mdl"] = { "infected/humans/male_08/facemap_infected" }
GM.InfectedModels[MALE]["models/player/group01/male_09.mdl"] = { "infected/humans/male_09/facemap_infected" }

GM.InfectedModels[FEMALE]["models/player/group01/female_01.mdl"] = { "infected/humans/female_01/facemap_infected" }
GM.InfectedModels[FEMALE]["models/player/group01/female_02.mdl"] = { "infected/humans/female_02/facemap_infected" }
GM.InfectedModels[FEMALE]["models/player/group01/female_03.mdl"] = { "infected/humans/female_03/facemap_infected" }
GM.InfectedModels[FEMALE]["models/player/group01/female_04.mdl"] = { "infected/humans/female_04/facemap_infected" }
GM.InfectedModels[FEMALE]["models/player/group01/female_05.mdl"] = { "infected/humans/female_05/facemap_infected" }
GM.InfectedModels[FEMALE]["models/player/group01/female_06.mdl"] = { "infected/humans/female_06/facemap_infected" }

GM.InfectedClothes = {}
GM.InfectedClothes[MALE] = {
	"infected/humans/male_inf/sheet_01",
	"infected/humans/male_inf/sheet_02",
	"infected/humans/male_inf/sheet_03",
	"infected/humans/male_inf/sheet_04",
}

GM.InfectedClothes[FEMALE] = {
	"infected/humans/female_inf/sheet_01",
	"infected/humans/female_inf/sheet_02",
	"infected/humans/female_inf/sheet_03",
	"infected/humans/female_inf/sheet_04",
	"infected/humans/female_inf/sheet_05",
	"infected/humans/female_inf/sheet_06",
}

if CLIENT then
	for k, v in pairs(GM.SurvivorModels[MALE]) do
		for _, n in pairs(v) do
			surface.SetMaterial(Material(n))
		end
	end

	for k, v in pairs(GM.SurvivorModels[FEMALE]) do
		for _, n in pairs(v) do
			surface.SetMaterial(Material(n))
		end
	end

	for k, v in pairs(GM.InfectedModels[MALE]) do
		for _, n in pairs(v) do
			surface.SetMaterial(Material(n))
		end
	end

	for k, v in pairs(GM.InfectedModels[FEMALE]) do
		for _, n in pairs(v) do
			surface.SetMaterial(Material(n))
		end
	end

	for _, v in pairs(GM.SurvivorClothes[MALE]) do
		surface.SetMaterial(Material(v))
	end

	for _, v in pairs(GM.SurvivorClothes[FEMALE]) do
		surface.SetMaterial(Material(v))
	end

	for _, v in pairs(GM.InfectedClothes[MALE]) do
		surface.SetMaterial(Material(v))
	end

	for _, v in pairs(GM.InfectedClothes[FEMALE]) do
		surface.SetMaterial(Material(v))
	end
end -- Precache the materials

function emeta:GetClothesSheet()
	if (string.find(string.lower(self:GetModel()), "/player/")) then
		local tab = self:GetMaterials()

		for k, v in pairs(tab) do
			if (string.find(v, "players_sheet")) then
				return k - 1
			end
		end

		return -1
	end

	return -1
end

function emeta:GetFacemap()
	if (string.find(string.lower(self:GetModel()), "/player/")) then
		local tab = self:GetMaterials()

		for k, v in pairs(tab) do
			if (string.find(v, "facemap")) then
				return k - 1
			end

			if (string.find(v, "cylmap")) then
				return k - 1
			end
		end

		return -1
	end

	return -1
end

-----------------------------------------------------------------------


function XRES(x)
	return x * (ScrW() / 640)
end

function YRES(y)
	return y * (ScrH() / 480)
end

function meta:IsFemale()
	local mdl = string.lower(self.CharModel or self:GetModel())

	if string.find(mdl, "female") then return true end
	if mdl == "models/player/alyx.mdl" then return true end
	if mdl == "models/player/mossman.mdl" then return true end
	if mdl == "models/player/mossman_arctic.mdl" then return true end
	if mdl == "models/player/p2_chell.mdl" then return true end
	if mdl == "models/player/police_fem.mdl" then return true end

	return false
end

function GM:FindPlayer(name, caller)
	if not name or not IsValid(caller) then
		return
	end

	name = string.lower(name)

	if name == "^" then
		return caller
	end

	if name == "-" then
		local ent = caller:GetEyeTrace().Entity

		if IsValid(ent) and (ent:IsPlayer()) then
			return ent
		end

		return
	end

	for k, v in pairs(player.GetAll()) do
		if tonumber(name) == tonumber(v:CID()) or tonumber(name) == tonumber(v:FormattedCID()) then
			return v
		end

		if string.find(string.lower(v:VisibleRPName()), name, nil, true) then
			return v
		end

		if caller:IsAdmin() and string.find(string.lower(v:Nick()), name, nil, true) then
			return v
		end

		if caller:IsAdmin() and string.lower(v:SteamID()) == name then
			return v
		end
	end
end

local allowedChars = "!?#abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 .-'áàâäçéèêëíìîïóòôöúùûüÿÁÀÂÄßÇÉÈÊËÍÌÎÏÓÒÔÖÚÙÛÜŸ"

function GM:CheckNameValidity(name)
	for _, char in pairs(string.Explode("", name)) do
		if not string.find(allowedChars, char, 1, true) then
			return false
		end
	end
	return true
end

function GM:CheckCharacterValidity(name, desc, model, skin, stats, sum, trait)
	if #name < self.MinNameLength then
		return false, "Name must be longer than " .. self.MinNameLength .. " characters."
	end

	if #name > self.MaxNameLength then
		return false, "Name must be shorter than " .. self.MaxNameLength .. " characters."
	end

	if #desc > self.MaxDescLength then
		return false, "Description must be shorter than " .. self.MaxDescLength .. " characters."
	end

	if not self.CitizenModels[string.lower(model)] then
		return false, "Invalid model."
	end

	if skin < 0 or skin > GAMEMODE.CitizenModels[model] then
		return false, "Invalid skin."
	end

	if string.find(name, "#", nil, true) or string.find(name, "~", nil, true) or string.find(name, "%", nil, true) then
		return false, "Invalid name."
	end

	for _, v in pairs(stats) do
		if v > GAMEMODE.MaxAllocatedStats then
			return false, "Invalid stat allocation."
		end
	end

	if sum < 0 or sum > GAMEMODE.StatsAvailable then
		return false, "Too many stats allocated."
	end

	if not self.Traits[trait] then
		return false, "Invalid trait."
	end

	if not self:CheckNameValidity(name) then
		return false, "Invalid characters in name."
	end

	return true
end

local fontCache = {}
local function getCharWidth(char, fc)
	if not fc[char] then
		fc[char] = surface.GetTextSize(char)
	end
	return fc[char]
end

function GM:FormatText(str, font, maxWidth, indent)
	str = string.gsub(str:Trim(), "\r", "")
	if #str <= 1 then return {str} end

	surface.SetFont(font)
	if not fontCache[font] then
		fontCache[font] = {}
	end
	local fc = fontCache[font]
	indent = indent and getCharWidth("  ", fc)

	local t = string.ToTable(str)
	local i, len, start, lastSpace = 1, #str, 1
	local curWidth = indent or 0
	local res = {}

	local indentNextLine = false
	while i <= len do
		local c = t[i]
		local isBreak = c == "\n"
		local width = getCharWidth(c, fc)

		if isBreak or curWidth + width + (#res > 0 and indent or 0) > maxWidth then
			local stop = isBreak and i or lastSpace or i - 1

			local line = string.Trim(str:sub(start, stop))
			res[#res + 1] = (indentNextLine and "  " or "") .. line

			start = str:find("[%S\r\n]", stop + 1)
			if not start then
				return res
			end
			lastSpace = nil
			i = start
			curWidth = 0

			indentNextLine = indent and not isBreak
		else
			curWidth = curWidth + width
			if i == len then
				local line = string.Trim(str:sub(start))
				res[#res + 1] = (indentNextLine and " " or "") .. line
			elseif c:match("[^%w_\"'%.]") then
				lastSpace = i
			end
			i = i + 1
		end
	end

	return res
end

function GM:FormatLine(str, font, maxWidth)
	local t = self:FormatText(str, font, maxWidth)
	return table.concat(t, "\n"), #t
end

function GM:CanSeePos(pos1, pos2, filter)
	local trace = {
		start = pos1,
		endpos = pos2,
		filter = filter,
		mask = MASK_SOLID + CONTENTS_WINDOW + CONTENTS_GRATE
	}
	local tr = util.TraceLine(trace)
	return tr.Fraction == 1, tr.Fraction
end

function emeta:CanSee(ent)
	return GAMEMODE:CanSeePos(self:EyePos(), ent:EyePos(), {self, ent})
end

function meta:CanHear(ent)
	if self == ent then return true end
	local trace = {
		start = self:EyePos(),
		endpos = ent:EyePos(),
		filter = self,
		mask = MASK_OPAQUE
	}
	local tr = util.TraceLine(trace)
	return tr.Fraction == 1 or tr.Entity == ent
end

function emeta:IsDoor()
	if self:GetClass() == "prop_door_rotating" then return true end
	if self:GetClass() == "func_door_rotating" then return true end
	if self:GetClass() == "func_door" then return true end

	return false
end

function GM:ShouldCollide(e1, e2)
	if string.find(e1:GetClass(), "inf_zombie*") and string.find(e2:GetClass(), "inf_zombie*") then
		return false
	end

	return true
end

function GM:GetHandTrace(ply, len)
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * (len or 50)
	trace.filter = ply

	return util.TraceLine(trace)
end

function util.TimeSinceDate(d)
	if not d or d == "" then return 0 end

	local c = os.date("!*t")

	local sides = string.Explode(" ", d)
	local d2 = string.Explode("/", sides[1])
	local t2 = string.Explode(":", sides[2])

	local cmonth = tonumber(d2[1])
	local cday = tonumber(d2[2])
	local cyear = tonumber(d2[3])
	local chour = tonumber(t2[1])
	local cmin = tonumber(t2[2])
	local csec = tonumber(t2[3])

	c.year = c.year - 2000

	local count = (c.year - cyear) * 525600
	count = count + (c.month - cmonth) * 43200
	count = count + (c.day - cday) * 1440
	count = count + (c.hour - chour) * 60
	count = count + (c.min - cmin)
	count = count + math.ceil((c.sec - csec) / 60)

	return count
end

GM.Stats = {
	"Speed",
	"Strength",
	"Endurance",
	"Agility",
	"Dexterity"
}

GM.Music = {
	{"music/hl1_song3.mp3", 131, SONG_IDLE, "Black Mesa Inbound"},
	{"music/hl1_song20.mp3", 84, SONG_IDLE, "Escape Array"},
	{"music/hl1_song21.mp3", 84, SONG_IDLE, "Dirac Shore"},
	{"music/hl2_song0.mp3", 39, SONG_IDLE, "Entanglement"},
	{"music/hl2_song1.mp3", 98, SONG_IDLE, "Particle Ghost"},
	{"music/hl2_song2.mp3", 172, SONG_IDLE, "Lab Practicum"},
	{"music/hl2_song8.mp3", 59, SONG_IDLE, "Highway 17"},
	{"music/hl2_song10.mp3", 29, SONG_IDLE, "A Red Letter Day"},
	{"music/hl2_song11.mp3", 34, SONG_IDLE, "Sandtraps"},
	{"music/hl2_song13.mp3", 53, SONG_IDLE, "Suppression Field"},
	{"music/hl2_song17.mp3", 61, SONG_IDLE, "Broken Symmetry"},
	{"music/hl2_song19.mp3", 115, SONG_IDLE, "Nova Prospekt"},
	{"music/hl2_song26_trainstation1.mp3", 90, SONG_IDLE, "Train Station 1"},
	{"music/hl2_song27_trainstation2.mp3", 72, SONG_IDLE, "Train Station 2"},
	{"music/hl2_song30.mp3", 104, SONG_IDLE, "Calabi-Yau Model"},
	{"music/hl1_song5.mp3", 96, SONG_ALERT, "Echoes of a Resonance Cascade"},
	{"music/hl1_song6.mp3", 99, SONG_ALERT, "Zero Point Energy Field"},
	{"music/hl1_song9.mp3", 93, SONG_ALERT, "Neutrino Trap"},
	{"music/hl1_song11.mp3", 34, SONG_ALERT, "Hazardous Environments"},
	{"music/hl1_song14.mp3", 90, SONG_ALERT, "Triple Entanglement"},
	{"music/hl1_song17.mp3", 123, SONG_ALERT, "Tau-9"},
	{"music/hl1_song19.mp3", 115, SONG_ALERT, "Negative Pressure"},
	{"music/hl1_song24.mp3", 77, SONG_ALERT, "Singularity"},
	{"music/hl1_song26.mp3", 37, SONG_ALERT, "Xen Relay"},
	{"music/hl2_song7.mp3", 50, SONG_ALERT, "Ravenholm Reprise"},
	{"music/hl2_song26.mp3", 69, SONG_ALERT, "Our Resurrected Teleport"},
	{"music/hl2_song31.mp3", 98, SONG_ALERT, "Brane Scan"},
	{"music/hl2_song32.mp3", 42, SONG_ALERT, "Slow Light"},
	{"music/hl2_song33.mp3", 84, SONG_ALERT, "Probably Not a Problem"},
	{"music/hl1_song10.mp3", 104, SONG_ACTION, "Lambda Core"},
	{"music/hl1_song15.mp3", 120, SONG_ACTION, "Something Secret Steers Us"},
	{"music/hl2_song3.mp3", 90, SONG_ACTION, "Dark Energy"},
	{"music/hl2_song4.mp3", 65, SONG_ACTION, "The Innsbruck Experiment"},
	{"music/hl2_song6.mp3", 45, SONG_ACTION, "Pulse Phase"},
	{"music/hl2_song12_long.mp3", 73, SONG_ACTION, "Hard Fought"},
	{"music/hl2_song14.mp3", 159, SONG_ACTION, "You're Not Supposed to Be Here"},
	{"music/hl2_song15.mp3", 69, SONG_ACTION, "Kaon"},
	{"music/hl2_song16.mp3", 170, SONG_ACTION, "LG Orbifold"},
	{"music/hl2_song20_submix0.mp3", 103, SONG_ACTION, "CP Violation"},
	{"music/hl2_song20_submix4.mp3", 139, SONG_ACTION, "CP Violation (remix)"},
	{"music/hl2_song29.mp3", 135, SONG_ACTION, "Apprehension and Evasion"},
	{"music/stingers/hl1_stinger_song7.mp3", 23, SONG_STINGER, "Apprehensive"},
	{"music/stingers/hl1_stinger_song8.mp3", 9, SONG_STINGER, "Bass String"},
	{"music/stingers/hl1_stinger_song16.mp3", 16, SONG_STINGER, "Scared Confusion"},
	{"music/stingers/hl1_stinger_song27.mp3", 17, SONG_STINGER, "Dark Piano"},
	{"music/stingers/hl1_stinger_song28.mp3", 7, SONG_STINGER, "Sharp Piano"},
}

GM.TRPMusic = {
	{"terminator/t1title.mp3",			137,	SONG_IDLE,	"T1 - Future War Theme"},
	{"terminator/t1theme.mp3",			256,	SONG_IDLE,	"T1 - Future Classic Theme"},
	{"terminator/bunker.mp3",			66,		SONG_IDLE,	"T1 - Future Flashback"},
	{"terminator/lovescene.mp3",		225,	SONG_IDLE,	"T1 - Love Scene"},
	{"terminator/destiny.mp3",			184,	SONG_IDLE,	"T1 - Sarah's Destiny"},
	{"terminator/surgery.mp3",			95,		SONG_IDLE,	"T1 - T800 Surgery"},
	{"terminator/wade.mp3",				136,	SONG_IDLE,	"T1 - T800 Arrival"},
	{"terminator/chase.mp3",			85,		SONG_IDLE,	"T1 - Chase Scene"},
	{"terminator/t2maintheme.mp3",		118,	SONG_IDLE,	"T2 - Main Theme"},
	{"terminator/desert.mp3",			208,	SONG_IDLE,	"T2 - Desert"},
	{"terminator/dysonattack.mp3",		249,	SONG_IDLE,	"T2 - Attack on Dyson"},
	{"terminator/goodbye.mp3",			276,	SONG_IDLE,	"T2 - Goodbye"},
	{"terminator/heavy.mp3",			99,		SONG_IDLE,	"T2 - Trust Me"},
	{"terminator/freeze.mp3",			183,	SONG_IDLE,	"T2 - T1000 Frozen"},
	{"terminator/impaled.mp3",			126,	SONG_IDLE,	"T2 - T800 Impaled"},
	{"terminator/illbeback.mp3",		240,	SONG_IDLE,	"T2 - I'll Be Back"},
	{"terminator/nucleardream.mp3",		111,	SONG_IDLE,	"T2 - Nuclear Nightmare"},
	{"terminator/revives.mp3",			135,	SONG_IDLE,	"T2 - T800 Revives"},
	{"terminator/swat.mp3",				205,	SONG_IDLE,	"T2 - SWAT Team Attack"},
	{"terminator/t1000.mp3",			109,	SONG_IDLE,	"T2 - Hospital Escape"},
	{"terminator/t4title.mp3",			100,	SONG_IDLE,	"Salvation - Opening Theme"},
	{"terminator/broadcast.mp3",		199,	SONG_IDLE,	"Salvation - Broadcast"},
	{"terminator/escape.mp3",			81,		SONG_IDLE,	"Salvation - Escape"},
	{"terminator/farewell.mp3",			100,	SONG_IDLE,	"Salvation - Farewell"},
	{"terminator/freeside.mp3",			91,		SONG_IDLE,	"Salvation - Fireside"},
	{"terminator/plan.mp3",				103,	SONG_IDLE,	"Salvation - No Plan"},
	{"terminator/salvation.mp3",		187,	SONG_IDLE,	"Salvation - Salvation"},
	{"terminator/serena.mp3",			148,	SONG_IDLE,	"Salvation - Serena"},
	{"terminator/solution.mp3",			104,	SONG_IDLE,	"Salvation - Solution"},
	{"terminator/shortopen.mp3",		141,	SONG_IDLE,	"Salvation - Short Open Theme"},
	{"terminator/marcusenters.mp3",		49,		SONG_IDLE,	"Salvation - Marcus Enters Skynet"},
	{"terminator/skynetlab.mp3",		27,		SONG_IDLE,	"Salvation - Skynet Lab"},
	{"terminator/reveal.mp3",			46,		SONG_IDLE,	"Salvation - Reveal"},
	{"terminator/arrivaltoearth.mp3",	186,	SONG_IDLE,	"Transformers - Arrival to Earth"},
	{"terminator/flight.mp3",			85,		SONG_IDLE,	"Transformers - Scorponok"},
	{"terminator/soldier.mp3",			67,		SONG_IDLE,	"Transformers - You're A Soldier Now"},
	{"terminator/weweregods.mp3",		197,	SONG_IDLE,	"Transformers - We Were Gods Once"},
	{"terminator/shockwave.mp3",		117,	SONG_IDLE,	"Transformers - Shockwave"},
	{"terminator/frenzy.mp3",			102,	SONG_IDLE,	"Transformers - Frenzy"},
	{"terminator/farcrycommando.mp3",	133,	SONG_IDLE,	"Far Cry - Cyber Commando"},
	{"terminator/farcryhelo.mp3",		78,		SONG_IDLE,	"Far Cry - Helo-73"},
	{"terminator/farcryrex.mp3",		109,	SONG_IDLE,	"Far Cry - Rex Colt"},
	{"terminator/farcrytheme.mp3",		117,	SONG_IDLE,	"Far Cry - Blood Dragon theme"},
	{"terminator/farcrywarcry.mp3",		145,	SONG_IDLE,	"Far Cry - Warcry"},
	{"terminator/farcrywarzone.mp3",	158,	SONG_IDLE,	"Far Cry - Warzone"},
	{"terminator/farcrycalm.mp3",		207,	SONG_IDLE,	"Far Cry - Moment Of Calm"},
	{"terminator/rock.mp3",				140,	SONG_IDLE,	"The Rock - Rock House Jail"},
	{"terminator/rock2.mp3",			48,		SONG_IDLE,	"The Rock - Navy Seals"},
	{"terminator/prepare.mp3",			283,	SONG_IDLE,	"Predator - Prepare"},
	{"terminator/trumpet1.mp3",			87,		SONG_IDLE,	"Predator - Blaine's Burial"},
	{"terminator/trumpet2.mp3",			71,		SONG_IDLE,	"Predator - Night Watch"},
	{"terminator/darkknight.mp3",		115,	SONG_IDLE,	"Dark Knight - End Theme"},
	{"terminator/dogstart.mp3",			112,	SONG_IDLE,	"Dark Knight - Dog Chasing Cars"},
	{"terminator/dog.mp3",				116,	SONG_IDLE,	"Dark Knight - Dog Chasing Cars (part 2)"},
	{"terminator/electro.mp3",			38,		SONG_IDLE,	"Black Hawk Down - Wounded"},
	{"terminator/starship.mp3",			133,	SONG_IDLE,	"Starship Troopers - Main Theme"},
	{"terminator/runningman.mp3",		120,	SONG_IDLE,	"The Running Man - Main Theme"},
	{"terminator/factory.mp3",			71,		SONG_IDLE,	"Fear Factory - Metallic Division"},
	{"terminator/signal.mp3",			69,		SONG_IDLE,	"Fear Factory - Terminator Slams"},
	{"terminator/reptile.mp3",			61,		SONG_IDLE,	"Nine Inch Nails - Reptile"},
	{"terminator/gnr.mp3",				240,	SONG_IDLE,	"Guns N' Roses - You Could Be Mine"},
	{"terminator/lovesexmoney.mp3",		62,		SONG_IDLE,	"Gravity Kills - Love, Sex & Money"},
	{"terminator/watchtower.mp3",		125,	SONG_IDLE,	"Jimi Hendrix - All Along The Watchtower"},
	{"terminator/instinct.mp3",			53,		SONG_IDLE,	"Killer Instinct - The Instinct"},




}

GM.EP2Music = {
	{"music/vlvx_song26.mp3", 110, SONG_IDLE, "Inhuman Frequency"},
	{"music/vlvx_song3.mp3", 95, SONG_IDLE, "Dark Interval"},
	{"music/vlvx_song15.mp3", 107, SONG_IDLE, "Nectarium"},
	{"music/vlvx_song20.mp3", 124, SONG_IDLE, "Extinction Event Horizon"},
	{"music/vlvx_song23ambient.mp3", 158, SONG_IDLE, "Shu'ulathoi"},
	{"music/vlvx_song0.mp3", 62, SONG_ALERT, "No One Rides For Free"},
	{"music/vlvx_song9.mp3", 74, SONG_ALERT, "Crawl Yard"},
	{"music/vlvx_song25.mp3", 167, SONG_ALERT, "Abandoned In Place"},
	{"music/vlvx_song28.mp3", 193, SONG_ALERT, "Eon Trap"},
	{"music/vlvx_song22.mp3", 194, SONG_ACTION, "Vortal Combat"},
	{"music/vlvx_song23.mp3", 166, SONG_ACTION, "Sector Sweep"},
	{"music/vlvx_song24.mp3", 127, SONG_ACTION, "Last Legs"},
	{"music/vlvx_song27.mp3", 209, SONG_ACTION, "Hunting Party"},
}

function GM:GetSongList(e)
	local tab = {}

	for _, v in pairs(self.Music) do

		if v[3] == e then

			table.insert(tab, v[1])

		end

	end

	return tab
end

GM.OverwatchLines = {
	{"npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav", "Attention, ground units. Anticitizen reported in this community. Code: lock, cauterize, stabilize."},
	{"npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav", "You are charged with anticivil activity level one. Protection units: prosecution code duty, sword, operate."},
	{"npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav", "Protection team alert: Evidence of anticivil activity in this community. Code: assemble, clamp, contain."},
	{"npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav", "Individual: you are charged with capital malcompliance. Anticitizen status approved."},
	{"npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav", "Individual: you are now charged with socioendangerment level five. Cease evasion immediately receive your verdict."},
	{"npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav", "Individual: you are convicted of multi anticivil violations. Implicit citizenship revoked. Status: malignant."},
	{"npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav", "Attention please: unidentified person of interest, confirm your civil status with local protection team immediately."},
	{"npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav", "Attention please: evasion behavior consistant with malcompliant defendant. Ground protection team: alert. Code: isolate, expose, administer."},
	{"npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav", "Citizen reminder: inaction is conspiracy. Report counterbehavior to a civil protection team immediately."},
	{"npc/overwatch/cityvoice/f_localunrest_spkr.wav", "Alert, community ground protection units: local unrest structure detected. Assemble, administer, pacify."},
	{"npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav", "Attention protection team: status evasion in progress in this community. Respond, isolate, inquire."},
	{"npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav", "Attention all ground protection teams: autonomous judgement is now in effect. Sentencing is now discretionary. Code: amputate, zero, confirm."},
	{"npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav", "Attention all ground protection teams: Judgement waiver now in effect. Capital prosecution is discretionary."},
	{"npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav", "Attention occupants: your block is now charged with permissive inactive coersion. Five ration units deducted."},
	{"npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav", "Individual: you are charged with socioendangerment level one. Protection units, prosecution code: duty, sword, midnight."},
	{"npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav", "Citizen notice: priority identification check in progress. Please assemble in your designated inspection positions."},
	{"npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav", "Attention, please. All citizens in local residential block, assume your inspection positions."},
	{"npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav", "Attention, residents. Miscount detected in your block. Cooperation with your civil protection team permits full ration reward."},
	{"npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav", "Attention, residents. This block contains potential civil infection. Inform, cooperate, assemble."},
	{"npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav", "Citizen notice: failure to cooperate will result in permanent offworld relocation."},
	{"npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav", "Attention, community: unrest procedure code is now in effect. Inoculate, shield, pacify. Code: pressure, sword, sterilize."},
}

GM.RadioDispatchLines = {}
GM.RadioDispatchLines.CameraDestroyed = {
"METROPOLICE_IDLE_CR13", --on3 V_RNDCODECRIM_P inprogress, investigateandreport off2
"METROPOLICE_IDLE_CR4", --on3 allunitsbolfor243suspect off2
"METROPOLICE_IDLE_CR8", --on3 restrictedincursioninprogress, officerat V_G1_LOCATION_MAP__P V_G3_NUMBP investigateandreport off2
"METROPOLICE_IDLE_CR9", --on3 socialfractureinprogress off2
}

GM.BusinessLicenses = {}
GM.BusinessLicenses[BUSINESS_GENERIC] = {"Generic", 500}
GM.BusinessLicenses[BUSINESS_CLOTHING] = {"Clothing", 700}
GM.BusinessLicenses[BUSINESS_MEDICAL] = {"Electronics", 1000}
GM.BusinessLicenses[BUSINESS_WEAPONRY] = {"Misc.", 400}
GM.BusinessLicenses[BUSINESS_ILLEGAL] = {"Black Market"}

GM.Traits = {}
GM.Traits[TRAIT_NONE] = {"None", "No trait."}

GM.Langs = {}
GM.Langs[LANG_ENGLISH] = {"English", "The default language. Pick this if you do not want additional languages for your character."}
GM.Langs[LANG_RUSSIAN] = {"Russian", "Can additionally speak Russian with /rus."}
GM.Langs[LANG_CHINESE] = {"Chinese", "Can additionally speak Chinese with /chi."}
GM.Langs[LANG_JAPANESE] = {"Japanese", "Can additionally speak Japanese with /jap."}
GM.Langs[LANG_SPANISH] = {"Spanish", "Can additionally speak Spanish with /spa."}
GM.Langs[LANG_FRENCH] = {"French", "Can additionally speak French with /fre."}
GM.Langs[LANG_GERMAN] = {"German", "Can additionally speak German with /ger."}
GM.Langs[LANG_ITALIAN] = {"Italian", "Can additionally speak Italian with /ita."}

GM.TraitsList = {
}

GM.LangsList = {
	LANG_ENGLISH,
	LANG_RUSSIAN,
	LANG_CHINESE,
	LANG_JAPANESE,
	LANG_SPANISH,
	LANG_FRENCH,
	LANG_GERMAN,
	LANG_ITALIAN
}

function meta:HasTrait(trait)
	if bit.band(self:Trait(), trait) == trait then return true end
	return false
end

function meta:HasLang(lang)
	if bit.band(self:Lang(), lang) == lang then return true end
	return false
end

function meta:IsEventCoordinator()
	return self:GetUserGroup() == "eventcoordinator"
end

function game.GetIP()
	local hostip = tonumber(GetConVarString("hostip"))

	local ip = {}
	ip[1] = bit.rshift(bit.band(hostip, 0xFF000000), 24)
	ip[2] = bit.rshift(bit.band(hostip, 0x00FF0000), 16)
	ip[3] = bit.rshift(bit.band(hostip, 0x0000FF00), 8)
	ip[4] = bit.band(hostip, 0x000000FF)

	return table.concat(ip, ".")
end

function game.GetPort()
	return tonumber(GetConVarString("hostport"))
end

function GM:IsValidSteamID(steamid) -- Thanks Ulib
	if not steamid then
		return false
	end

	return string.match(steamid, "^STEAM_%d:%d:%d+$") != nil
end

function ParseChatLog(data)
	local format = ""
	local args = {}

	local function add(str, arg)
		format = format .. str
		table.insert(args, arg)
	end

	add("[%s", data.Class)

	if data.Lang then
		add(".%s] ", data.Lang)
	else
		add("] ")
	end

	if data.Freq then
		add("[%s MHz] ", data.Freq)
	end

	add("%s", data.Char.CharName)

	if data.RecChar then
		add(" -> %s", data.RecChar.CharName)
	end

	add(": %s", data.Text)

	return string.format(format, unpack(args))
end

-- Maps a yaw to 0 -> 360
function math.AngleToHeading(yaw)
	return (-yaw % 360) + 360 % 360
end

-- Takes a heading and returns the compass direction
function GM:GetHeading(heading)
	local northSouth = (heading < 67.5 or heading > 292.5) and "N" or
		(heading > 112.5 and heading < 247.5) and "S" or ""

	local eastWest = (heading > 22.5 and heading < 157.5) and "E" or
		(heading > 202.5 and heading < 337.5) and "W" or ""

	return northSouth .. eastWest
end

GM.ViewOffset = 64 / 72
GM.ViewOffsetCrouched = 28 / 72

GM.HullOffsetDucked = 36 / 72