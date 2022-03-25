hook.Add("OnGamemodeLoaded", "sh.armory", function()
	concommand.AddAdmin("rpa_setarmoryaccess", function(ply, target, name)
		local armory = GAMEMODE:ArmoryExists(name)

		if not armory then
			ply:SendChat(nil, "ERROR", "Error: This armory doesn't exist.")

			return
		end

		target:SetArmoryAccess(name)
		target:UpdateCharacterField("ArmoryAccess", name)

		if name == "" then
			ply:SendChat(nil, "WARNING", "You removed " .. target:RPName() .. "'s armory access")
			target:SendChat(nil, "WARNING", ply:Nick() .. " removed your armory access")
		else
			ply:SendChat(nil, "WARNING", "You gave " .. target:RPName() .. " access to the " .. name .. " armory")
			target:SendChat(nil, "WARNING", ply:Nick() .. " gave you access to the " .. flag .. " armory")
		end

		GAMEMODE:WriteLog("admin_armory_access", {Admin = GAMEMODE:LogPlayer(ply), Ply = GAMEMODE:LogPlayer(target), Char = GAMEMODE:LogCharacter(target), Name = name})
	end, false, {TYPE_ENTITY, TYPE_STRING})

	concommand.AddAdmin("rpa_setarmorystock", function(ply, name, item, stock, create)
		if not GAMEMODE.ItemClasses[item] then
			ply:SendChat(nil, "ERROR", "Error: This item doesn't exist.")

			return
		end

		local armory = GAMEMODE:ArmoryExists(name, ply:IsSuperAdmin() and create)

		if not armory then
			ply:SendChat(nil, "ERROR", "Error: This armory doesn't exist.")

			return
		end

		stock = math.Clamp(stock, -1, 127)

		GAMEMODE:SetArmoryStock(name, item, stock)

		GAMEMODE:WriteLog("admin_armory_stock", {Admin = GAMEMODE:LogPlayer(ply), Name = name, Item = item, Stock = stock})
	end, false, {TYPE_STRING, TYPE_STRING, TYPE_NUMBER, TYPE_BOOL})

	concommand.AddAdmin("rpa_deletearmory", function(ply, name)
		GAMEMODE:DeleteArmory(name)
	end, true, {TYPE_STRING})

	GAMEMODE:RegisterLogType("admin_armory_stock", LOG_ADMIN, function(data)
		return string.format("%s set %s's stock of %s to %s", GAMEMODE:FormatPlayer(data.Admin), data.Name, data.Item, data.Stock or "N/A")
	end)

	GAMEMODE:RegisterLogType("admin_armory_access", LOG_ADMIN, function(data)
		return string.format("%s set %s's armory access to %s", GAMEMODE:FormatPlayer(data.Admin), GAMEMODE:FormatCharacter(data.Char), data.Name)
	end)

	GAMEMODE:RegisterLogType("item_armory_checkout", LOG_ITEMS, function(data)
		return string.format("%s checked out %s", GAMEMODE:FormatCharacter(data.Char), GAMEMODE:FormatItem(data.Item))
	end)
end)
