function assertf(eval, str, ...)
	if eval then
		return eval
	end

	error(string.format(str, ...), 2)
end

function printf(msg, ...)
	print(string.format(msg, ...))
end

function errorf(msg, ...)
	error(string.format(msg, ...), 2)
end

_ = {}

_.stringToChars = function (str)
	local chars = {}

	for char in string.gmatch(str, ".") do
		table.insert(chars, char)
	end

	return chars
end

_.map = function (arr, fn)
	local result = {}

	for i,v in ipairs(arr) do
		result[i] = fn(v)
	end

	return result
end

function IsValidSteamID(id)
	return string.match(id, "^STEAM_%d:%d:%d+$" ) != nil
end

function table.AddToCopy(base, additions)
	local tab = table.Copy(base)

	return table.Add(tab, additions)
end

function table.FullCopy(tab)
	local res = {}

	for k, v in pairs(tab) do
		if type(v) == "table" then
			res[k] = table.FullCopy(v)
		elseif type(v) == "Vector" then
			res[k] = Vector(v.x, v.y, v.z)
		elseif type(v) == "Angle" then
			res[k] = Angle(v.p, v.y, v.r)
		else
			res[k] = v
		end
	end

	return res
end

-- Christ
function string.FileName(path)
	return string.StripExtension(string.GetFileFromFilename(path))
end

function string.FirstToUpper(str)
	return string.gsub(str, "^%l", string.upper)
end

-- Shouldn't be used for stuff that needs to persist between restarts or needs to be networked
function util.UID()
	g_UID = g_UID or 0
	g_UID = g_UID + 1

	return g_UID
end

function math.ApproachVector(start, target, amount)
	start.x = math.Approach(start.x, target.x, amount)
	start.y = math.Approach(start.y, target.y, amount)
	start.z = math.Approach(start.z, target.z, amount)

	return start
end

function math.RemapC(val, inMin, inMax, outMin, outMax)
	return math.Clamp(math.Remap(val, inMin, inMax, outMin, outMax), math.min(outMin, outMax), math.max(outMin, outMax))
end

function math.EasedRemap(val, inMin, inMax, outMin, outMax, func)
	local normalized = math.RemapC(val, inMin, inMax, 0, 1)

	return math.Remap(func(normalized), 0, 1, outMin, outMax)
end

function math.EasedFrac(val, min, max, func)
	return math.EasedRemap(val, 0, 1, min, max, func)
end

function math.Sign(x)
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	end

	return 0
end

function math.InRange(x, min, max)
	return x >= min and x <= max
end

function util.FormatCurrency(amount, symbolOnly)
	amount = tonumber(amount)

	if not amount then
		amount = 0
	end

	local negative = amount < 0 and "-" or ""
	local currency = amount == 1 and "Alloy" or "Alloys"
	local formatted = string.Comma(math.abs(amount))

	return string.format("%s%s %s", negative, formatted, currency)
end

function table.WeightedRandom(tab)
	local sum = 0

	for _, chance in pairs(tab) do
		sum = sum + chance
	end

	local winner = math.random() * sum

	for key, chance in pairs(tab) do
		winner = winner - chance

		if winner < 0 then
			return key
		end
	end
end

function table.MakeAssociative(tab)
	local ret = {}

	for _, v in pairs(tab) do
		ret[v] = true
	end

	return ret
end

function table.Filter(tab, callback)
	local pointer = 1

	for i = 1, #tab do
		if callback(i, tab[i]) then
			if i != pointer then
				tab[pointer] = tab[i]
				tab[i] = nil
			end

			pointer = pointer + 1
		else
			tab[i] = nil
		end
	end

	return tab
end

model = {}

function model.SetSubMaterials(ent, tab)
	local materials

	ent:SetSubMaterial()

	for k, v in pairs(tab) do
		if k == "BaseClass" then
			continue
		end

		if isstring(k) then
			if not materials then
				materials = GetMaterials(ent)

				if table.MakeAssociative(materials)["___error"] then
					error(string.format("Attempt to use string material replacement on %s affected by ___error", ent:GetModel()))
				end
			end

			for index, mat in pairs(materials) do
				if mat == k then
					ent:SetSubMaterial(index - 1, v)
				end
			end
		else
			ent:SetSubMaterial(k, v)
		end
	end
end

function model.SetNumBodygroup(ent, group, index)
	local id

	if not isnumber(index) and not isbool(index) then
		return
	end

	if isnumber(group) then
		id = group
	else
		for _, v in pairs(ent:GetBodyGroups()) do
			if string.gsub(string.lower(v.name), " ", "_") == group then
				id = v.id

				break
			end
		end
	end

	if id then
		if isbool(index) then
			index = index and 1 or 0
		end

		ent:SetBodygroup(id, index)
	end
end

size = {}
size.Head = 12
size.Streetsign = 24

function util.EffectiveRange(range, diameter)
	diameter = diameter or size.Streetsign

	local yards = (range / 0.75) / 36
	local MOA = (diameter * 100) / yards

	return MOA / 60
end

function util.RangeMeters(range, diameter)
	return util.EffectiveRange(unit.Length(range, "m", "u"), diameter)
end

function string.Gibberish(str, prob)
	local ret = ""

	for _, v in pairs(string.Explode("", str)) do
		if math.random(1, 100) < prob then
			v = ""

			for i = 1, math.random(0, 2) do
				ret = ret .. table.Random({"#", "@", "&", "%", "$", "/", "<", ">", ";", "*", "*", "*", "*", "*", "*", "*", "*"})
			end
		end

		ret = ret .. v
	end

	return ret
end

function GM:GetMapRedirect()
	local map = game.GetMap()

	while self.MapRedirect[map] do
		map = self.MapRedirect[map]
	end

	return map
end

util.GridScale = 1024
util.GridMax = 32768 / util.GridScale

local gm = GM or GAMEMODE

util.GridNoiseX = math.Round(util.SharedRandom(gm:GetMapRedirect(), 0, 999 - util.GridMax, 1))
util.GridNoiseY = math.Round(util.SharedRandom(gm:GetMapRedirect(), 0, 999 - util.GridMax, 2))

function util.ToGrid(x, y)
	x = (x + 16384) / util.GridScale
	y = (y + 16384) / util.GridScale

	y = math.abs(y - util.GridMax)

	return y, x
end

function util.FromGrid(x, y)
	x = math.abs(x - util.GridMax)

	x = x * util.GridScale - 16384
	y = y * util.GridScale - 16384

	return y, x
end

if CLIENT then
	local meta = FindMetaTable("Vector")

	meta.ToScreenOld = meta.ToScreenOld or meta.ToScreen

	function meta:ToScreen()
		local tab = self:ToScreenOld()

		if GAMEMODE:Cursed() == 2 or (GAMEMODE:Cursed() == 1 and GAMEMODE:AprilFools()) then
			tab.x = ScrW() - tab.x
		end

		return tab
	end
end
