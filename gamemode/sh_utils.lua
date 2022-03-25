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
	return string.match(id, "^STEAM_%d:%d:%d+$" ) ~= nil
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

function util.FormatCurrency(amount, symbolOnly)
	amount = tonumber(amount)

	if not amount then
		amount = 0
	end

	local negative = amount < 0 and "-" or ""
	local currency = amount == 1 and GAMEMODE.CurrencySingular or GAMEMODE.CurrencyPlural
	local formatted = string.Comma(math.abs(amount))

	if not symbolOnly then
		return string.format("%s%s%s %s", negative, GAMEMODE.CurrencySymbol, formatted, currency)
	else
		return string.format("%s%s%s", negative, GAMEMODE.CurrencySymbol, formatted)
	end
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