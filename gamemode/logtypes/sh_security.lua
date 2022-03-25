GM:RegisterLogType("security_protected_entity", LOG_SECURITY, function(data)
	return string.format("%s tried to paste protected entity %s", GAMEMODE:FormatPlayer(data.Ply), data.Class)
end)

GM:RegisterLogType("security_banned", LOG_SECURITY, function(data)
	if data.Perma then
		return string.format("Access denied: %s [%s] (Permanently banned)", data.Nick, data.SteamID)
	else
		return string.format("Access denied: %s [%s] (Banned for %s)", data.Nick, data.SteamID, string.NiceTime(data.Duration * 60))
	end
end)

GM:RegisterLogType("security_privatemode", LOG_SECURITY, function(data)
	return string.format("Access denied: %s [%s] (Private mode)", data.Nick, data.SteamID)
end)

GM:RegisterLogType("security_badpassword", LOG_SECURITY, function(data)
	return string.format("Access denied: %s [%s] (Bad password: %s)", data.Nick, data.SteamID, data.Password)
end)

GM:RegisterLogType("security_failedquiz", LOG_SECURITY, function(data)
	return string.format("Access denied: %s (Failed quiz)", GAMEMODE:FormatPlayer(data.Ply))
end)