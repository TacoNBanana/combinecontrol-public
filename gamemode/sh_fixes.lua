-- correctly handles tables that contain themselves (e.g. meta.__index = meta)
function table.Merge(dest, source, seen)
	seen = seen or {}
	seen[source] = true
	seen[dest] = true

	for k, v in pairs(source) do
		if type(v) == "table" and type(dest[k]) == "table" and not seen[v] and not seen[dest[k]] then
			table.Merge(dest[k], v)
		else
			dest[k] = v
		end
	end
	return dest
end
