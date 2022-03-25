GM:RegisterLogType("dev_itemimport_whitelistviolation", LOG_DEVELOPER, function(data)
	return string.format("%s tried to load non-editable property %s into %s", GAMEMODE:FormatPlayer(data.Ply), data.Property, GAMEMODE:FormatItem(data.Item))
end)

GM:RegisterLogType("dev_itemimport_typeviolation", LOG_DEVELOPER, function(data)
	return string.format("%s tried to load a different data type into %s (expected %s got %s for %s)", GAMEMODE:FormatPlayer(data.Ply), GAMEMODE:FormatItem(data.Item), data.Expected, data.Received, data.Property)
end)