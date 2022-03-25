parser = {}

local rules = {
	rename = {
		["type"] = "Type",
		["model"] = "mdl",
		["bone"] = "Bone",
		["rel"] = "Parent",
		["pos"] = "Pos",
		["angle"] = "Ang",
		["size"] = "Size",
		["color"] = "Color",
		["surpresslightning"] = "Fullbright",
		["material"] = "Material",
		["submat"] = "SubMaterials",
		["skin"] = "Skin",
		["hidden"] = "Hidden",
		["bodygroup"] = "Bodygroups",
	},

	defaults = {
		Bone = "",
		Parent = "",
		Size = Vector(1, 1, 1),
		Color = Color(255, 255, 255, 255),
		Fullbright = false,
		Material = "",
		SubMaterials = 0,
		Skin = 0,
		Hidden = false,
		Bodygroups = 0
	},

	types = {
		[0] = "SCK_MODEL",
		[1] = "SCK_SPRITE",
		[2] = "**NOT SUPPORTED**",
		[3] = "SCK_QUAD"
	}
}

function parser.tostring(val, options)
	local valtype = type(val)

	options = options or {}

	if valtype == "number" and options.key == "Type" then
		return rules.types[val]
	elseif valtype == "string" then
		return options.noquotes and val or string.format("\"%s\"", val)
	elseif valtype == "Vector" then
		return string.format("Vector(%s, %s, %s)", math.Round(val.x, 3), math.Round(val.y, 3), math.Round(val.z, 3))
	elseif valtype == "Angle" then
		return string.format("Angle(%s, %s, %s)", math.Round(val.p, 3), math.Round(val.y, 3), math.Round(val.r, 3))
	elseif IsColor(val) then
		return string.format("Color(%s, %s, %s, %s)", val.r, val.g, val.b, val.a)
	elseif valtype == "table" then
		local str = "{"
		local first = true

		for k, v in pairs(val) do
			if not first then
				str = str .. ", "
			end

			first = false

			str = string.format(options.inner and "%s%s = %s" or "%s\n[%s] = %s", str, parser.tostring(k, options.inner and {noquotes = true}), parser.tostring(v, {inner = true, key = k}))
		end

		if table.Count(val) > 0 and not options.inner then
			str = str .. "\n"
		end

		return str .. "}"
	else
		return tostring(val)
	end
end

function parser.equal(a, b)
	local valtype = type(a)

	if valtype == "table" and not IsColor(a) then
		return table.Count(a) == b
	else
		return a == b
	end
end

function parser.parse(val, var)
	if not istable(val) then
		val = weapons.GetStored(val)[var]
	end

	local res = {}

	for k, v in pairs(val) do
		local tab = {}

		for i, j in pairs(v) do
			local renamed = rules.rename[i]

			if renamed then
				tab[renamed] = j
			else
				tab[i] = j
			end
		end

		for i, j in pairs(tab) do
			if parser.equal(j, rules.defaults[i]) then
				tab[i] = nil
			end
		end

		res[k] = tab
	end

	return parser.tostring(res)
end