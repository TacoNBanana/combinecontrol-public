GM:RegisterLogType("item_created_admin", LOG_ITEMS, function(data)
	return string.format("%s created (spawned by %s)", GAMEMODE:FormatItem(data.Item), GAMEMODE:FormatPlayer(data.Ply))
end)

GM:RegisterLogType("item_drop", LOG_ITEMS, function(data)
	return string.format("%s dropped %s", GAMEMODE:FormatCharacter(data.Char), GAMEMODE:FormatItem(data.Item))
end)

GM:RegisterLogType("item_pickup", LOG_ITEMS, function(data)
	return string.format("%s picked up %s", GAMEMODE:FormatCharacter(data.Char), GAMEMODE:FormatItem(data.Item))
end)

GM:RegisterLogType("item_destroy", LOG_ITEMS, function(data)
	return string.format("%s destroyed %s", GAMEMODE:FormatCharacter(data.Char), GAMEMODE:FormatItem(data.Item))
end)

GM:RegisterLogType("item_destroy_admin", LOG_ITEMS, function(data)
	return string.format("%s admin-deleted %s's %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char), GAMEMODE:FormatItem(data.Item))
end)

GM:RegisterLogType("item_take_admin", LOG_ITEMS, function(data)
	return string.format("%s took %s from %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatItem(data.Item), GAMEMODE:FormatCharacter(data.Char))
end)