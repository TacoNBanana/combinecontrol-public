net.Receive("nAUpdateAdminVariable", function(len)
	local ply = net.ReadEntity()
	local val = net.ReadFloat()
	local friendlyvar = net.ReadString()
	GAMEMODE:AddNotification(ply:Nick() .. " set " .. friendlyvar .. " to " .. tostring(val))
end)

net.Receive("nARestart", function(len)
	local ply = net.ReadEntity()

	GAMEMODE:AddChat(ply:Nick() .. " is restarting the server in five seconds.", Color(200, 0, 0, 255), "CombineControl.ChatHuge")
end)

net.Receive("nMapList", function(len)
	local tab = net.ReadTable()

	MsgC(Color(128, 128, 128, 255), "Valid Maps:\n")

	for _, v in pairs(tab) do
		MsgC(Color(229, 201, 98, 255), "\t", v, "\n")
	end
end)

net.Receive("nARemove", function(len)
	local nick = net.ReadString()
	local ply = net.ReadEntity()

	GAMEMODE:AddChat(ply:Nick() .. " removed " .. nick .. ".", Color(229, 201, 98, 255))
end)

net.Receive("nAQuizBan", function(len)
	local nick = net.ReadString()
	local mode = net.ReadFloat()

	if mode == 1 then

		GAMEMODE:AddChat(nick .. " was auto-banned for " .. GAMEMODE.QuizBanTime .. " minutes for failing the quiz.", Color(229, 201, 98, 255))

	else

		GAMEMODE:AddChat(nick .. " was auto-banned for " .. GAMEMODE.QuizBanTime * 2 .. " minutes for failing the quiz.", Color(229, 201, 98, 255))

	end
end)

net.Receive("nASeeAll", function(len)
	GAMEMODE.SeeAll = not GAMEMODE.SeeAll
end)

net.Receive("nAFlagsRoster", function(len)
	local tab = net.ReadTable()

	MsgC(Color(128, 128, 128, 255), "FLAG ROSTER:\n")

	for _, v in pairs(tab) do

		MsgC(Color(128, 128, 128, 255), v.RPName, "\t", Color(229, 201, 98, 255), v.CharFlags, "\t", GAMEMODE:CharFlagPrintName(v.CharFlags), "\n")

	end
end)

net.Receive("nAPlayMusic", function(len)
	local song = net.ReadString()

	GAMEMODE:PlayMusic(song)
end)

net.Receive("nAStopMusic", function(len)
	GAMEMODE:FadeOutMusic()
end)

net.Receive("nAListItems", function(len)
	local filter = net.ReadString()

	if filter == "" then
		MsgC(Color(128, 128, 128, 255), "ITEM LIST:\n")
	else
		MsgC(Color(128, 128, 128, 255), "ITEM LIST (FILTER \"" .. filter .. "\"):\n")
	end

	for k in SortedPairs(GAMEMODE.ItemClasses) do
		if string.find(k, filter) or filter == "" then
			MsgC(Color(229, 201, 98, 255), k, "\n")
		end
	end
end)

net.Receive("nAPlayOverwatch", function(len)
	local id = net.ReadFloat()

	surface.PlaySound(GAMEMODE.OverwatchLines[id][1])
end)

net.Receive("nATooTight", function(len)
	GAMEMODE:AddChat("Error: You're in too tight a space to do this.", Color(200, 0, 0, 255))
end)

net.Receive("nAEditInventory", function(len)
	if not LocalPlayer():IsAdmin() then
		return
	end

	local targ = net.ReadEntity()
	local money = net.ReadFloat()

	CCP.AdminInv = vgui.Create("DFrame")

	local ui = CCP.AdminInv

	ui:SetSize(800, 426)
	ui:Center()
	ui:SetTitle(string.format("%s's Inventory - %s", targ:VisibleRPName(), util.FormatCurrency(money)))
	ui.lblTitle:SetFont("CombineControl.Window")
	ui:MakePopup()
	ui.PerformLayout = CCFramePerformLayout
	ui:PerformLayout()

	ui.Think = UIAutoClose
	ui.Player = targ

	ui.InvButtons = {}

	function ui:OnRemove()
		net.Start("nClosePlayerInventory")
			net.WriteEntity(self.Player)
		net.SendToServer()
	end

	function ui:Update()
		local ply = self.Player

		if not IsValid(ply) then
			return
		end

		local inv = ply.Inventory
		local x = 0
		local y = 0

		self.InvScroll:Clear()

		local icons = {}

		for _, item in SortedPairs(inv) do
			local icon = item:CreateInventoryIcon(INVTYPE_ADMIN)

			icons[icon.ID] = icon

			icon:SetParent(self.InvScroll)
			icon:SetPos(x, y)

			x = x + 48 + 10

			if x > self.InvScroll:GetWide() - 48 then
				x = 0
				y = y + 48 + 10
			end

			function icon:DoClick()
				ui.SelectedItem = item

				item:ConfigureModelPanel(ui.InvModel)

				ui.InvTitle:SetText(item:GetName())
				ui.InvDesc:SetText(item:GetDescription())

				item:GetAuxDescription(ui.InvDesc)

				if IsValid(ui.ButDestroy) then
					ui.ButDestroy:Remove()
				end

				ui.ButDestroy = vgui.Create("DButton", ui)
				ui.ButDestroy:SetFont("CombineControl.LabelSmall")
				ui.ButDestroy:SetText("Destroy")
				ui.ButDestroy:SetPos(ui:GetWide() - 110, ui:GetTall() - 30)
				ui.ButDestroy:SetSize(100, 20)

				table.insert(ui.InvButtons, ui.ButDestroy)

				ui.ButDestroy:SetDisabled(not item:CanDestroy(LocalPlayer()))

				function ui.ButDestroy:DoClick()
					if not self.DestroyConfirm and cookie.GetNumber("cc_destroyconfirm", 1) == 1 then
						self.DestroyConfirm = true
						self:SetTextColor(Color(200, 0, 0, 255))
					else
						net.Start("nADestroyItem")
							net.WriteInt(item.ID, 32)
						net.SendToServer()
					end
				end

				if IsValid(ui.ButTake) then
					ui.ButTake:Remove()
				end

				ui.ButTake = vgui.Create("DButton", ui)
				ui.ButTake:SetFont("CombineControl.LabelSmall")
				ui.ButTake:SetText("Take")
				ui.ButTake:SetPos(ui:GetWide() - 110, ui:GetTall() - 60)
				ui.ButTake:SetSize(100, 20)

				table.insert(ui.InvButtons, ui.ButTake)

				ui.ButTake:SetDisabled(not item:CanPickup(LocalPlayer(), true))

				function ui.ButTake:DoClick()
					net.Start("nATakeItem")
						net.WriteInt(item.ID, 32)
					net.SendToServer()
				end

				if IsValid(ui.ButExamine) then
					ui.ButExamine:Remove()
				end

				ui.ButExamine = vgui.Create("DButton", ui)
				ui.ButExamine:SetFont("CombineControl.LabelSmall")
				ui.ButExamine:SetText("Examine")
				ui.ButExamine:SetPos(ui:GetWide() - 110, ui:GetTall() - 90)
				ui.ButExamine:SetSize(100, 20)

				table.insert(ui.InvButtons, ui.ButExamine)

				ui.ButExamine:SetDisabled(item:GetProperty("Generic"))

				function ui.ButExamine:DoClick()
					item:CreateUserDescription(true)
				end
			end
		end

		if self.SelectedItem then
			local reset = true
			local id = self.SelectedItem.ID

			if inv[id] then
				reset = false

				icons[id]:DoClick()
			end

			if reset then
				self:Reset()
			end
		end
	end

	function ui:Reset()
		local inv = self.Player.Inventory

		self.InvModel:SetModel("")
		self.InvTitle:SetText("")

		if table.Count(inv) == 0 then
			self.InvDesc:SetText("They don't have any items.")
		else
			self.InvDesc:SetText("No item selected.")
		end

		for _, v in pairs(self.InvButtons) do
			v:Remove()
		end
	end

	ui.InvModel = vgui.Create("DModelPanel", ui)
	ui.InvModel:SetPos(420, 34)
	ui.InvModel:SetModel("")
	ui.InvModel:SetSize(ui:GetWide() - 430, 200)
	ui.InvModel:SetFOV(20)
	ui.InvModel:SetCamPos(Vector(50, 50, 50))
	ui.InvModel:SetLookAt(Vector(0, 0, 0))

	ui.InvModel.LayoutEntity = stub

	local p = ui.InvModel.Paint

	function ui.InvModel:Paint(w, h)
		surface.SetDrawColor(30, 30, 30, 150)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(20, 20, 20, 100)
		surface.DrawOutlinedRect(0, 0, w, h)

		p(self, w, h)
	end

	ui.InvTitle = vgui.Create("DLabel", ui)
	ui.InvTitle:SetText("")
	ui.InvTitle:SetPos(420, 244)
	ui.InvTitle:SetFont("CombineControl.LabelGiant")
	ui.InvTitle:SetSize(ui:GetWide() - 430, 22)
	ui.InvTitle:PerformLayout()

	ui.InvDesc = vgui.Create("RichText", ui)
	ui.InvDesc:SetText("No item selected.")
	ui.InvDesc:SetPos(420, 274)
	ui.InvDesc:SetSize(ui:GetWide() - 430 - 110, 144)
	ui.InvDesc:SetVerticalScrollbarEnabled(false)
	ui.InvDesc:SetWrap(true)

	function ui.InvDesc:PerformLayout()
		self:SetFontInternal("CombineControl.LabelSmall")
		self:SetBGColor(Color(0, 0, 0, 0))
	end

	ui.InvScroll = vgui.Create("DScrollPanel", ui)
	ui.InvScroll:SetPos(10, 34)
	ui.InvScroll:SetSize(400, ui:GetTall() - 50)

	function ui.InvScroll:Paint(w, h)
		surface.SetDrawColor(30, 30, 30, 150)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(20, 20, 20, 100)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	ui:Reset()
	ui:Update()
end)

net.Receive("nAStopSound", function(len)
	RunConsoleCommand("stopsound")
end)

net.Receive("nAListCharacters", function(len)
	local steamID = net.ReadString()
	local tab = net.ReadTable()

	if #tab < 1 then
		MsgC(Color(200, 0, 0, 255), "No characters found for " .. steamID .. ".\n")

		return
	else
		MsgC(Color(200, 200, 200, 255), "Character list for: " .. steamID .. " (" .. #tab .. " characters)\n")
	end

	local fieldsLen = {}

	for _, char in pairs(tab) do
		for index, field in pairs(char) do
			fieldsLen[index] = math.max(fieldsLen[index] or 0, #tostring(field))
		end
	end

	for _, v in pairs(tab) do
		-- Using %-*s wouldn't work for some reason, so we'll do it the ugly way
		MsgC(Color(200, 200, 200, 255), string.format("CharID: %-" .. fieldsLen.id ..
			"s | Name: %-" .. fieldsLen.RPName ..
			"s | Flags: %-" .. fieldsLen.CharFlags ..
			"s\n",v.id, v.RPName, v.CharFlags))
	end
end)

net.Receive("nACharacterData", function(len)
	local id = net.ReadInt(32)
	local tab = net.ReadTable()

	if #tab < 1 then
		MsgC(Color(200, 0, 0, 255), "No data found for charid " .. id .. "\n")

		return
	end

	tab = tab[1]

	MsgC(Color(200, 200, 200, 255), "Character data for charid: " .. id .. "\n")

	local keyLen = 0

	for index, _ in pairs(tab) do
		keyLen = math.max(keyLen, #tostring(index))
	end

	for k, v in pairs(tab) do
		MsgC(Color(200, 200, 200, 255), string.format("%-" .. keyLen .. "s: " .. v .. "\n", k))
	end
end)

net.Receive("nACharacterInventory", function(len)
	local id = net.ReadInt(32)
	local tab = net.ReadTable()

	if #tab < 1 then
		MsgC(Color(200, 0, 0, 255), "No data found for charid " .. id .. ".\n")

		return
	end

	local inv = string.Explode("|", tab[1].Inventory)

	local function printItems(data)
		local itemTab = {}
		local keyLen = 0

		for _, v in pairs(data) do
			if #v < 1 then
				continue
			end

			local arr = string.Explode(":", v)

			itemTab[arr[1]] = arr[2]
			keyLen = math.max(keyLen, #arr[1])
		end

		if table.Count(itemTab) < 1 then
			MsgC(Color(200, 0, 0, 255), "No items found\n")

			return
		end

		for k, v in SortedPairs(itemTab) do
			MsgC(Color(200, 200, 200, 255), string.format("%-" .. keyLen .. "s: " .. v .. "\n", k))
		end
	end

	MsgC(Color(200, 200, 200, 255), "Inventory for charid " .. id .. " (" .. tab[1].RPName .. ")\n")

	if #inv > 0 then
		printItems(inv)
	else
		MsgC(Color(200, 0, 0, 255), "No items found\n")
	end
end)

net.Receive("nACharacterLookup", function(len)
	local name = net.ReadString()
	local tab = net.ReadTable()

	if #tab < 1 then
		MsgC(Color(200, 0, 0, 255), "No matches found for " .. name .. "\n")

		return
	else
		MsgC(Color(200, 200, 200, 255), "Character matches for " .. name .. ": (" .. #tab .. " matches)\n")
	end

	local fieldsLen = {}

	for _, char in pairs(tab) do
		for index, field in pairs(char) do
			fieldsLen[index] = math.max(fieldsLen[index] or 0, #tostring(field))
		end
	end

	for _, v in pairs(tab) do
		-- Using %-*s wouldn't work for some reason, so we'll do it the ugly way
		MsgC(Color(200, 200, 200, 255), string.format("CharID: %-" .. fieldsLen.id ..
			"s | Name: %-" .. fieldsLen.RPName ..
			"s | SteamID: %-" .. fieldsLen.SteamID ..
			"s | Flags: %-" .. fieldsLen.CharFlags ..
			"s\n",v.id, v.RPName, v.SteamID, v.CharFlags))
	end
end)
