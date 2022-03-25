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

function string.FormatDigits(str)
	if tonumber( str ) < 10 then
		return "0" .. str
	end

	return str
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