local PANEL = {}

function PANEL:Init()
	self.LogList = vgui.Create("DListView", self)
	self.LogList:SetPos(10, 10)
	self.LogList:SetSize(780, 316)
	self.LogList:AddColumn("Timestamp"):SetFixedWidth(120)
	self.LogList:AddColumn("Identifier"):SetFixedWidth(120)
	self.LogList:AddColumn("Log")

	self.LogList.OnRowRightClick = function(pnl, id, line)
		local dmenu = DermaMenu()

		dmenu:SetPos(gui.MousePos())
		dmenu.Think = function(menu)
			if not IsValid(self) then
				menu:Remove()
			end
		end

		dmenu:AddOption("Print to console", function()
			local tab = {}

			for i = 1, 3 do
				tab[i] = line:GetValue(i)
			end

			print(string.format("[%s] [%s] - %s", unpack(tab)))
		end)

		dmenu:AddOption("View raw data", function() GAMEMODE:OutputLogData(line.Data) end)
		dmenu:Open()
	end

	self.DateLabel = vgui.Create("DLabel", self)
	self.DateLabel:SetPos(12, 336)
	self.DateLabel:SetText("Cutoff Date")
	self.DateLabel:SetFont("CombineControl.LabelMedium")
	self.DateLabel:SizeToContents()
	self.DateLabel:PerformLayout()

	self.DateEntry = vgui.Create("DTextEntry", self)
	self.DateEntry:SetFont("CombineControl.LabelMedium")
	self.DateEntry:SetPos(100, 336)
	self.DateEntry:SetSize(80, 20)
	self.DateEntry:PerformLayout()

	self.TimeLabel = vgui.Create("DLabel", self)
	self.TimeLabel:SetPos(280, 336)
	self.TimeLabel:SetText("Cutoff Time")
	self.TimeLabel:SetFont("CombineControl.LabelMedium")
	self.TimeLabel:SizeToContents()
	self.TimeLabel:PerformLayout()

	self.TimeEntry = vgui.Create("DTextEntry", self)
	self.TimeEntry:SetFont("CombineControl.LabelMedium")
	self.TimeEntry:SetPos(380, 336)
	self.TimeEntry:SetSize(80, 20)
	self.TimeEntry:PerformLayout()

	self.TimeAutoFill = vgui.Create("DButton", self)
	self.TimeAutoFill:SetFont("CombineControl.LabelSmall")
	self.TimeAutoFill:SetText("Auto-fill cutoff")
	self.TimeAutoFill:SetPos(690, 336)
	self.TimeAutoFill:SetSize(100, 30)

	self.TimeAutoFill.DoClick = function(pnl)
		self.DateEntry:SetValue(os.date("%Y-%m-%d"))
		self.TimeEntry:SetValue(os.date("%H:%M:%S"))
	end

	self.CategoryLabel = vgui.Create("DLabel", self)
	self.CategoryLabel:SetPos(12, 366)
	self.CategoryLabel:SetText("Category")
	self.CategoryLabel:SetFont("CombineControl.LabelMedium")
	self.CategoryLabel:SizeToContents()
	self.CategoryLabel:PerformLayout()

	self.CategoryCombo = vgui.Create("DComboBox", self)
	self.CategoryCombo:SetPos(100, 366)
	self.CategoryCombo:SetSize(160, 20)

	local options = {
		{LOG_ADMIN, "Admin"},
		{LOG_SECURITY, "Security"},
		{LOG_SANDBOX, "Sandbox"},
		{LOG_ITEMS, "Items"},
		{LOG_CHARACTER, "Character"},
		{LOG_CHAT, "Chat"},
		{LOG_DEVELOPER, "Developer"}
	}

	for _, v in pairs(options) do
		self.CategoryCombo:AddChoice(v[2], v[1])
	end

	self.CategoryCombo.OnSelect = function(pnl, index, value, data)
		self:SetIdentifierChoices(data)
	end

	self.IdentifierLabel = vgui.Create("DLabel", self)
	self.IdentifierLabel:SetPos(12, 396)
	self.IdentifierLabel:SetText("Identifier")
	self.IdentifierLabel:SetFont("CombineControl.LabelMedium")
	self.IdentifierLabel:SizeToContents()
	self.IdentifierLabel:PerformLayout()

	self.IdentifierCombo = vgui.Create("DComboBox", self)
	self.IdentifierCombo:SetPos(100, 396)
	self.IdentifierCombo:SetSize(160, 20)

	self.CharacterLabel = vgui.Create("DLabel", self)
	self.CharacterLabel:SetPos(280, 366)
	self.CharacterLabel:SetText("Character ID")
	self.CharacterLabel:SetFont("CombineControl.LabelMedium")
	self.CharacterLabel:SizeToContents()
	self.CharacterLabel:PerformLayout()

	self.CharacterEntry = vgui.Create("DTextEntry", self)
	self.CharacterEntry:SetFont("CombineControl.LabelMedium")
	self.CharacterEntry:SetPos(380, 366)
	self.CharacterEntry:SetSize(100, 20)
	self.CharacterEntry:PerformLayout()

	self.CharacterEntry.AllowInput = function(pnl, val)
		if not string.find(val, "%d") then
			return true
		end
	end

	self.ItemLabel = vgui.Create("DLabel", self)
	self.ItemLabel:SetPos(280, 396)
	self.ItemLabel:SetText("Item ID")
	self.ItemLabel:SetFont("CombineControl.LabelMedium")
	self.ItemLabel:SizeToContents()
	self.ItemLabel:PerformLayout()

	self.ItemEntry = vgui.Create("DTextEntry", self)
	self.ItemEntry:SetFont("CombineControl.LabelMedium")
	self.ItemEntry:SetPos(380, 396)
	self.ItemEntry:SetSize(100, 20)
	self.ItemEntry:PerformLayout()

	self.ItemEntry.AllowInput = function(pnl, val)
		if not string.find(val, "%d") then
			return true
		end
	end

	self.PlayerLabel = vgui.Create("DLabel", self)
	self.PlayerLabel:SetPos(500, 366)
	self.PlayerLabel:SetText("SteamID")
	self.PlayerLabel:SetFont("CombineControl.LabelMedium")
	self.PlayerLabel:SizeToContents()
	self.PlayerLabel:PerformLayout()

	self.PlayerEntry = vgui.Create("DTextEntry", self)
	self.PlayerEntry:SetFont("CombineControl.LabelMedium")
	self.PlayerEntry:SetPos(570, 366)
	self.PlayerEntry:SetSize(100, 20)
	self.PlayerEntry:PerformLayout()

	self.LimitLabel = vgui.Create("DLabel", self)
	self.LimitLabel:SetPos(500, 396)
	self.LimitLabel:SetText("Max lines")
	self.LimitLabel:SetFont("CombineControl.LabelMedium")
	self.LimitLabel:SizeToContents()
	self.LimitLabel:PerformLayout()

	self.LimitEntry = vgui.Create("DTextEntry", self)
	self.LimitEntry:SetFont("CombineControl.LabelMedium")
	self.LimitEntry:SetPos(570, 396)
	self.LimitEntry:SetSize(100, 20)
	self.LimitEntry:SetText(GAMEMODE.DefaultLogLines)
	self.LimitEntry:PerformLayout()

	self.LimitEntry.AllowInput = function(pnl, val)
		if not string.find(val, "%d") then
			return true
		end
	end

	self.GetLogButton = vgui.Create("DButton", self)
	self.GetLogButton:SetFont("CombineControl.LabelSmall")
	self.GetLogButton:SetText("Get Logs")
	self.GetLogButton:SetPos(690, 386)
	self.GetLogButton:SetSize(100, 30)
	self.GetLogButton:SetDisabled(true)

	self.GetLogButton.DoClick = function(pnl)
		self:SubmitRequest()
	end

	self:PerformLayout()
end

function PANEL:GetCutoff()
	local year, month, day = string.match(self.DateEntry:GetValue(), "(%d+)-(%d+)-(%d+)")
	local hour, min, sec = string.match(self.TimeEntry:GetValue(), "(%d+):(%d+):(%d+)")

	-- Required for some reason
	if not year or not month or not day then
		return -1
	end

	return os.time({year = year, month = month, day = day, hour = hour, min = min, sec = sec})
end

function PANEL:SubmitRequest()
	local _, category = self.CategoryCombo:GetSelected()
	local identifier = self.IdentifierCombo:GetSelected()
	local charid = tonumber(self.CharacterEntry:GetText()) or -1
	local itemid = tonumber(self.ItemEntry:GetText()) or -1
	local steamid = tostring(self.PlayerEntry:GetText()) or ""
	local limit = tonumber(self.LimitEntry:GetText()) or -1
	local timestamp = self:GetCutoff()

	self.LogList:Clear()

	net.Start("nRequestLogs")
		net.WriteInt(category, 8)
		net.WriteString(identifier)
		net.WriteInt(charid, 32)
		net.WriteInt(itemid, 32)
		net.WriteString(steamid)
		net.WriteInt(limit, 32)
		net.WriteInt(timestamp, 32)
	net.SendToServer()
end

function PANEL:SetIdentifierChoices(category)
	self.IdentifierCombo:Clear()
	self.IdentifierCombo:AddChoice("Any", "", true)

	for k, v in pairs(GAMEMODE.LogTypes) do
		if v.Category == category then
			self.IdentifierCombo:AddChoice(k)
		end
	end

	self.GetLogButton:SetDisabled(false)
end

function PANEL:AddLog(identifier, timestamp, data)
	data = util.JSONToTable(data)

	self.LogList:AddLine(os.date("%Y-%m-%d %H:%M:%S", timestamp), identifier, string.FirstToUpper(GAMEMODE:ParseLog(identifier, data))).Data = data
	self.LogList:SortByColumn(1, false)
end

function PANEL:Paint(w, h)
end

derma.DefineControl("CCLogs", "", PANEL, "DPanel")