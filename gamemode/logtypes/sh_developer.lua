GM:RegisterLogType("donation_parsed", LOG_DEVELOPER, function(data)
	return string.format("Parsed donation '%s' for %s (Price: %s)", data.Type, GAMEMODE:FormatPlayer(data.Ply), data.Price)
end)

GM:RegisterLogType("donation_redeemed", LOG_DEVELOPER, function(data)
	return string.format("Redeemed donation '%s' for %s", data.Type, GAMEMODE:FormatPlayer(data.Ply))
end)

GM:RegisterLogType("dev_itemimport_whitelistviolation", LOG_DEVELOPER, function(data)
	return string.format("%s tried to load non-editable property %s into %s", GAMEMODE:FormatPlayer(data.Ply), data.Property, GAMEMODE:FormatItem(data.Item))
end)

GM:RegisterLogType("dev_itemimport_typeviolation", LOG_DEVELOPER, function(data)
	return string.format("%s tried to load a different data type into %s (expected %s got %s for %s)", GAMEMODE:FormatPlayer(data.Ply), GAMEMODE:FormatItem(data.Item), data.Expected, data.Received, data.Property)
end)