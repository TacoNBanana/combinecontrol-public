-- 5/25/2013

DeriveGamemode("sandbox")

GM.Name = "Terminator RP"
GM.Author = "Disseminate, Gangleider, Steve, Hoplite, Thor, TankNut, DaveBrown"
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
	team.SetUp(TEAM_REPROG, "Reprogrammed", Color(0, 191, 255, 255), false)
	team.SetUp(TEAM_SKYNET, "SkyNet Terminator", Color(222, 92, 0, 255), false)
	team.SetUp(TEAM_GREY, "Skynet Sympathizers and Collaborators", Color(220, 0, 0, 255), false)
--	team.SetUp(TEAM_POLICE, "San Angeles Police Department", Color(33, 106, 196, 255), false)
--	team.SetUp(TEAM_GOVERNMENT, "Government", Color(33, 106, 196, 255), false)
--	team.SetUp(TEAM_MUTANT, "Mutant", Color(222, 92, 0, 255), false)
end

function GM:TranslateModelToPlayer(mdl)
	for k, v in pairs(player_manager.AllValidModels()) do
		if string.lower(v) == string.lower(mdl) then
			return k
		end
	end

	return "kleiner"
end

----------------tekka placeholders---------------------

GM.RandomSpawnItems = {
	"radio_basic",
	"flashlight"
	--fill this area with other default clothings so not everyone looks the same on launch, testing with radio and flashlight for now
}

GM.DarkSkinnedModels = {
--	["models/tnb/techcom/male_01.mdl"] = true,
--	["models/tnb/techcom/male_03.mdl"] = true,
--	["models/tnb/techcom/male_13.mdl"] = true,
--	["models/tnb/techcom/male_32.mdl"] = true,
--	["models/tnb/techcom/male_33.mdl"] = true,
--	["models/tnb/techcom/female_03.mdl"] = true
	["models/tekka/male_98.mdl"] = true,
	["models/tekka/male_99.mdl"] = true

}

GM.DarkSkinnedReplacements = {
	["models/tekka/clothes/arm_male_white"] = "models/tekka/clothes/arm_male_black",
	["models/tekka/clothes/arm_female_white"] = "models/tekka/clothes/arm_female_black"
--also add in here other textures that are not just the default arms etc for skin tone varients
}
--needs updating with tekka arm textures

--------------------------------

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

function meta:CanSee(ent)
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
	{"terminator/autobots.mp3",			152,	SONG_IDLE,	"Transformers - Autobots"},
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
	{"terminator/edgewakeup.mp3",		105,	SONG_IDLE,	"Edge of Tomorrow - Find me when you Wake Up"},
	{"terminator/edgebeach.mp3",		120,	SONG_IDLE,	"Edge of Tomorrow - The Beach"},
	{"terminator/elysiumkruger.mp3",	96,		SONG_IDLE,	"Elysium - Kruger Suits Up"},
	{"terminator/elysiumfire.mp3",		26,		SONG_IDLE,	"Elysium - Fire and Water - part1"},
	{"terminator/elysiumwater.mp3",		41,		SONG_IDLE,	"Elysium - Fire and Water - part2"},
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
GM.BusinessLicenses[BUSINESS_GENERIC] = {"Generic", 1000} --lowered prices for TRP for small economy
GM.BusinessLicenses[BUSINESS_CLOTHING] = {"Clothing", 1500}
GM.BusinessLicenses[BUSINESS_MEDICAL] = {"Medical"}
GM.BusinessLicenses[BUSINESS_WEAPONRY] = {"Weaponry", 4000}
GM.BusinessLicenses[BUSINESS_ILLEGAL] = {"Black Market"}
GM.BusinessLicenses[BUSINESS_QUARTERMASTER] = {"Quartermaster"}

--NEEDS TO BE CHANGED or ADDED,

-- Players can only have one license at a time. To stop people having access to everything at once and specialise in one type of trade.
-- Ability to drop the license so another can be chosen instead. (No refund)
-- Sell-to-Menu button. A bit like SRP. Lets traders sell back to the menu.
-- ITEM.Sell value variable. To define how much money the trader will earn back from selling the item to menu.
-- Needed later, weapon damage percentage modifier for ITEM.Sell value......eg.... if weapon=damaged, ITEM.Sell = ###


-- TEKKA New list adding / changing special supply and illegal becomes more like lite BM
--GM.BusinessLicenses[BUSINESS_GENERIC] = {"Generic", 1000} --general supply like food and drink, basic ammos, meds, simple clothes, small variety of pistols
--GM.BusinessLicenses[BUSINESS_CLOTHING] = {"Clothing", 3000} --almost all clothes, plus tekka hairstyle options
--GM.BusinessLicenses[BUSINESS_MEDICAL] = {"Medical", 7000} --med supplies, batteries, stims, augments
--GM.BusinessLicenses[BUSINESS_WEAPONRY] = {"Weaponry.", 10000} --low to mid tier weapons
--GM.BusinessLicenses[BUSINESS_ILLEGAL] = {"Illegal.", 500} --drugs, melee, scrap weapons, some clothes relevent to class
--GM.BusinessLicenses[BUSINESS_SPECIAL] = {"Special Supply"} --exo gear, top tier guns, top tier augs maybe......flag set only like classic blackmarket

GM.Traits = {}
GM.Traits[TRAIT_NONE] = {"None", "No trait."}
--prepping some traits for Tekka
--GM.Traits[TRAIT_MECHANIC] = {"Mechanic", "Can repair weapons, craft specialist ammo types and explosives, and can assemble the frames of Exoskeletons."}
--GM.Traits[TRAIT_RUNNER] = {"Runner", "Higher carry weight, can climb short walls, quieter footsteps, can use 'City Speak' language."}
--GM.Traits[TRAIT_CITYRAT] = {"City Rat", "Can craft drugs, scrap ammo and crude explosives, can use 'City Speak' language."}
--GM.Traits[TRAIT_TRADER] = {"Trader", "Benefits from trade connections to get better deals on buying and selling items."}
--GM.Traits[TRAIT_MEDICAL] = {"Medical Technician", "Can install augmentations, can craft stimpacks, can assemble Exoskeleton interface modules."}

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

--tekka traitslist as above
--[[GM.TraitsList = {
	TRAIT_MECHANIC,
	TRAIT_RUNNER,
	TRAIT_CITYRAT,
	TRAIT_TRADER,
	TRAIT_MEDICAL
}
]]

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

function meta:HasLicense(license)
	if istable(license) then
		for _, lic in pairs(license) do
			if self:HasLicense(lic) then return true end
		end
		return false
	end

	if bit.band(self:BusinessLicenses(), license) == license then return true end
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