module("base64", package.seeall)

local index = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function tobin(num)
	local rem = tonumber(num)
	local bits = ""

	for i = 7, 0, -1 do
		local pow = math.pow(2, i)

		if rem >= pow then
			bits = bits .. "1"
			rem = rem - pow
		else
			bits = bits .. "0"
		end
	end

	return bits
end

local function frombin(num)
	return tonumber(num, 2)
end

function Encode(str)
	local bits = ""
	local encoded = ""
	local trailing = ""

	for i = 1, #str do
		bits = bits .. tobin(string.byte(string.sub(str, i, i)))
	end

	if math.fmod(#bits, 3) == 2 then
		trailing = "=="
		bits = bits .. "0000000000000000"
	elseif math.fmod(#bits, 3) == 1 then
		trailing = "="
		bits = bits .. "00000000"
	end

	for i = 1, #bits, 6 do
		local byte = string.sub(bits, i, i + 5)
		local offset = tonumber(frombin(byte))

		encoded = encoded .. string.sub(index, offset + 1, offset + 1)
	end

	return string.sub(encoded, 1, -1 - #trailing) .. trailing
end

function Decode(str)
	local padded = string.gsub(str, "%s", "")
	local unpadded = string.gsub(padded, "=", "")

	local bits = ""
	local decoded = ""

	for i = 1, #unpadded do
		local char = string.sub(str, i, i)
		local offset = string.find(index, char)

		if not offset then
			error("Invalid character: " .. char)
		end

		bits = bits .. string.sub(tobin(offset - 1), 3)
	end

	for i = 1, #bits, 8 do
		local byte = string.sub(bits, i, i + 7)

		decoded = decoded .. string.char(frombin(byte))
	end

	local pad_len = #padded - #unpadded

	if pad_len == 1 or pad_len == 2 then
		decoded = string.sub(decoded, 1, -2)
	end

	return decoded
end