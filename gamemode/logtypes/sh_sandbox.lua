GM:RegisterLogType("sandbox_spawn_generic", LOG_SANDBOX, function(data)
	return string.format("%s spawned prop (%s)", GAMEMODE:FormatCharacter(data.Char), data.Mdl)
end)

GM:RegisterLogType("sandbox_spawn_npc", LOG_SANDBOX, function(data)
	return string.format("%s spawned npc (%s)", GAMEMODE:FormatCharacter(data.Char), data.Class)
end)

GM:RegisterLogType("sandbox_spawn_entity", LOG_SANDBOX, function(data)
	return string.format("%s spawned entity (%s)", GAMEMODE:FormatCharacter(data.Char), data.Class)
end)

GM:RegisterLogType("sandbox_spawn_weapon", LOG_SANDBOX, function(data)
	return string.format("%s spawned weapon (%s)", GAMEMODE:FormatCharacter(data.Char), data.Class)
end)

GM:RegisterLogType("sandbox_spawn_vehicle", LOG_SANDBOX, function(data)
	return string.format("%s spawned vehicle (%s)", GAMEMODE:FormatCharacter(data.Char), data.Type)
end)

GM:RegisterLogType("sandbox_tool", LOG_SANDBOX, function(data)
	return string.format("%s used %s on %s", GAMEMODE:FormatCharacter(data.Char), data.Tool, data.Ent)
end)

GM:RegisterLogType("sandbox_propdesc", LOG_SANDBOX, function(data)
	return string.format("%s changed the description of %s", GAMEMODE:FormatCharacter(data.Char), data.Ent)
end)

GM:RegisterLogType("sandbox_kill", LOG_SANDBOX, function(data)
	return string.format("%s killed %s using %s", GAMEMODE:FormatCharacter(data.Char), GAMEMODE:FormatCharacter(data.VictimChar), data.Weapon)
end)