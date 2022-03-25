GM.LogTypes = {}

function GM:RegisterLogType(identifier, category, parser)
	self.LogTypes[identifier] = {Category = category or LOG_NONE, Parser = parser}
end

function GM:ParseLog(identifier, data)
	if not self.LogTypes[identifier] then
		return string.format("** INVALID LOG TYPE: %s **", identifier)
	end

	return string.FirstToUpper(self.LogTypes[identifier].Parser(data))
end

function GM:FormatPlayer(tab)
	return string.format("%s [%s]", tab.Nick, tab.SteamID)
end

function GM:FormatCharacter(tab)
	return string.format("character [%s][%s]", tab.CharName, tab.CharID)
end

function GM:FormatItem(tab)
	local str

	if tab.Stacking then
		str = string.format("item [%s][x%s]", tab.ItemClass, tab.Amount)
	else
		str = string.format("item [%s][%s]", tab.ItemClass, tab.ItemID)
	end

	return str
end

-- Not going to make a whole new logtype file just for this one line
GM:RegisterLogType("chat_pm", LOG_CHAT, ParseChatLog)