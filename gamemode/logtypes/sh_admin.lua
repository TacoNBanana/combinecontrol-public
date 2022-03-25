GM:RegisterLogType("admin_restart", LOG_ADMIN, function(data)
	return string.format("%s restarted the server", GAMEMODE:FormatPlayer(data.Admin))
end)

GM:RegisterLogType("admin_changelevel", LOG_ADMIN, function(data)
	return string.format("%s changed the map to %s", GAMEMODE:FormatPlayer(data.Admin), data.Map)
end)

GM:RegisterLogType("admin_invisible", LOG_ADMIN, function(data)
	local eval = data.Admin.SteamID == data.Ply.SteamID
	local str = eval and "%s made themselves %s" or "%s made %s %s"
	local args = {GAMEMODE:FormatPlayer(data.Admin)}

	if not eval then
		table.insert(args, GAMEMODE:FormatCharacter(data.Char))
	end

	table.insert(args, data.Bool and "invisible" or "visible")

	return string.format(str, unpack(args))
end)

GM:RegisterLogType("admin_namewarn", LOG_ADMIN, function(data)
	return string.format("%s namewarned %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char))
end)

GM:RegisterLogType("admin_kill", LOG_ADMIN, function(data)
	return string.format("%s killed %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char))
end)

GM:RegisterLogType("admin_explode", LOG_ADMIN, function(data)
	return string.format("%s exploded %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char))
end)

GM:RegisterLogType("admin_slap", LOG_ADMIN, function(data)
	return string.format("%s slapped %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char))
end)

GM:RegisterLogType("admin_ko", LOG_ADMIN, function(data)
	return string.format("%s knocked out %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char))
end)

GM:RegisterLogType("admin_wake", LOG_ADMIN, function(data)
	return string.format("%s woke up %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char))
end)

GM:RegisterLogType("admin_kick", LOG_ADMIN, function(data)
	local str = "%s kicked %s"
	local args = {GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatPlayer(data.Ply)}

	if #data.Reason > 0 then
		str = str .. " (%s)"

		table.insert(args, data.Reason)
	end

	return string.format(str, unpack(args))
end)

GM:RegisterLogType("admin_ban", LOG_ADMIN, function(data)
	local str = "%s banned %s"
	local args = {GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatPlayer(data.Ply)}

	if data.Duration == 0 then
		str = str .. " permanently "
	else
		str = str .. " for %s"

		table.insert(args, string.NiceTime(data.Duration * 60))
	end

	str = str .. " (%s)"

	table.insert(args, data.Reason)

	return string.format(str, unpack(args))
end)

GM:RegisterLogType("admin_unban", LOG_ADMIN, function(data)
	return string.format("%s unbanned %s", GAMEMODE:FormatPlayer(data.Admin), data.SteamID)
end)

GM:RegisterLogType("admin_givemoney", LOG_ADMIN, function(data)
	local str = data.Amount > 0 and "%s gave %s to %s" or "%s took %s from %s"

	return string.format(str, GAMEMODE:FormatPlayer(data.Admin), util.FormatCurrency(math.abs(data.Amount)), GAMEMODE:FormatCharacter(data.Char))
end)

GM:RegisterLogType("admin_setmodel", LOG_ADMIN, function(data)
	return string.format("%s set %s's model to %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char), data.Model)
end)

GM:RegisterLogType("admin_setskin", LOG_ADMIN, function(data)
	return string.format("%s set %s's skin to %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char), data.Skin)
end)

GM:RegisterLogType("admin_setname", LOG_ADMIN, function(data)
	return string.format("%s set %s's name to %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char), data.Name)
end)

GM:RegisterLogType("admin_deleteitem", LOG_ADMIN, function(data)
	return string.format("%s deleted item #%s", GAMEMODE:FormatPlayer(data.Admin), data.ID)
end)

GM:RegisterLogType("admin_restoreitem", LOG_ADMIN, function(data)
	return string.format("%s restored item #%s", GAMEMODE:FormatPlayer(data.Admin), data.ID)
end)

GM:RegisterLogType("admin_heal", LOG_ADMIN, function(data)
	if data.Self then
		return string.format("%s healed themselves", GAMEMODE:FormatPlayer(data.Admin))
	else
		return string.format("%s healed %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char))
	end
end)

GM:RegisterLogType("admin_playurl", LOG_ADMIN, function(data)
	return string.format("%s played url %s", GAMEMODE:FormatPlayer(data.Admin), data.URL)
end)

GM:RegisterLogType("admin_createlootpoint", LOG_ADMIN, function(data)
	return string.format("%s created a loot point at (%s, %s, %s) (%s) with model %s", GAMEMODE:FormatPlayer(data.Admin), data.X, data.Y, data.Z, data.Pool, data.Mdl)
end)

GM:RegisterLogType("admin_deletelootpoint", LOG_ADMIN, function(data)
	return string.format("%s has deleted the loot point at (%s, %s, %s) (%s)", GAMEMODE:FormatPlayer(data.Admin), data.X, data.Y, data.Z, data.Pool)
end)

GM:RegisterLogType("admin_droneflags", LOG_ADMIN, function(data)
	if data.Give then
		return string.format("%s has given %s flags to %s", GAMEMODE:FormatPlayer(data.Admin), data.Flag, GAMEMODE:FormatPlayer(data.Ply))
	else
		return string.format("%s has taken %s flags from %s", GAMEMODE:FormatPlayer(data.Admin), data.Flag, GAMEMODE:FormatPlayer(data.Ply))
	end
end)

GM:RegisterLogType("admin_playerflags", LOG_ADMIN, function(data)
	return string.format("%s has set %s's player flags to \"%s\"", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatPlayer(data.Ply), data.Flag)
end)
