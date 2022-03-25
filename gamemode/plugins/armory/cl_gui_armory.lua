function GM:CreateArmoryGUI(name, parent)
	self.ArmoryParent = parent

	local panel = parent.ContentPane

	parent.ArmoryStock = vgui.Create("DListView", panel)
	parent.ArmoryStock:SetPos(10, 10)
	parent.ArmoryStock:SetSize(400, panel:GetTall() - 20)
	parent.ArmoryStock:AddColumn("Item")
	parent.ArmoryStock:AddColumn("Stock"):SetFixedWidth(90)

	function parent.ArmoryStock:Sort()
		table.Copy(self.Sorted, self.Lines)

		table.sort(self.Sorted, function(a, b)
			if not IsValid(a) then return true end
			if not IsValid(b) then return false end

			if a:GetColumnText(2) != b:GetColumnText(2) then
				return a:GetColumnText(2) > b:GetColumnText(2)
			end

			if a:GetColumnText(1) != b:GetColumnText(1) then
				return a:GetColumnText(1) < b:GetColumnText(1)
			end

			return false
		end )

		self:SetDirty(true)
		self:InvalidateLayout()
	end

	function parent.ArmoryStock:OnRowSelected(index, pnl)
		local item, stock, issued = unpack(pnl.ArmoryData)

		parent.ItemInfo:SetValue(string.format([[Selected item: %s

			%s

			Available: %s]],
			GAMEMODE:GetDefaultItemKey(item, "Name"),
			GAMEMODE:GetDefaultItemKey(item, "Description"),
			stock > 0 and string.format("%s \\ %s", stock - issued, stock) or "Many")
		)

		parent.TempItem:SetDisabled(stock == -1 or issued >= stock)
		parent.PermanentItem:SetDisabled(stock != -1)
	end

	parent.Refresh = vgui.Create("DButton", panel)
	parent.Refresh:SetPos(420, 10)
	parent.Refresh:SetSize(370, 20)
	parent.Refresh:SetText("Refresh")

	function parent.Refresh:DoClick()
		net.Start("nRequestArmoryData")
			if parent == CCP.AdminMenu then
				net.WriteString(name)
			end
		net.SendToServer()
	end

	parent.Logs = vgui.Create("DListView", panel)
	parent.Logs:SetPos(420, 40)
	parent.Logs:SetSize(370, 200)
	parent.Logs:AddColumn("Logs")

	parent.ItemInfo = vgui.Create("DTextEntry", panel)
	parent.ItemInfo:SetFont("CombineControl.LabelMedium")
	parent.ItemInfo:SetPos(420, 250)
	parent.ItemInfo:SetSize(370, 136)
	parent.ItemInfo:SetMultiline(true)
	parent.ItemInfo:SetDisabled(true)

	parent.ItemInfo:SetValue("No item selected...")

	parent.TempItem = vgui.Create("DButton", panel)
	parent.TempItem:SetPos(420, panel:GetTall() - 30)
	parent.TempItem:SetSize(180, 20)
	parent.TempItem:SetText("Issue (Temporary)")
	parent.TempItem:SetDisabled(true)

	function parent.TempItem:DoClick()
		local _, pnl = parent.ArmoryStock:GetSelectedLine()
		local item, stock, issued = unpack(pnl.ArmoryData)

		issued = issued + 1

		pnl.ArmoryData[3] = issued

		if issued >= stock then
			self:SetDisabled(true)
		end

		pnl:SetColumnText(2, string.format("%s \\ %s", stock - issued, stock))

		parent.ItemInfo:SetValue(string.format([[Selected item: %s

			%s

			Available: %s]],
			GAMEMODE:GetDefaultItemKey(item, "Name"),
			GAMEMODE:GetDefaultItemKey(item, "Description"),
			stock > 0 and string.format("%s \\ %s", stock - issued, stock) or "Many")
		)

		net.Start("nSpawnTempArmoryItem")
			net.WriteString(name)
			net.WriteString(item)
		net.SendToServer()
	end

	parent.PermanentItem = vgui.Create("DButton", panel)
	parent.PermanentItem:SetPos(610, panel:GetTall() - 30)
	parent.PermanentItem:SetSize(180, 20)
	parent.PermanentItem:SetText("Issue (Permanent)")
	parent.PermanentItem:SetDisabled(true)

	function parent.PermanentItem:DoClick()
		local _, pnl = parent.ArmoryStock:GetSelectedLine()

		net.Start("nSpawnArmoryItem")
			net.WriteString(name)
			net.WriteString(pnl.ArmoryData[1])
		net.SendToServer()
	end

	net.Start("nRequestArmoryData")
		if parent == CCP.AdminMenu then
			net.WriteString(name)
		end
	net.SendToServer()
end

net.Receive("nRequestArmoryData", function()
	local panel = GAMEMODE.ArmoryParent

	if not IsValid(panel) or not IsValid(panel.ArmoryStock) then
		return
	end

	panel.ArmoryStock:Clear()
	panel.Logs:Clear()
	panel.ItemInfo:SetValue("No item selected...")
	panel.TempItem:SetDisabled(true)
	panel.PermanentItem:SetDisabled(true)

	local count = net.ReadUInt(10)

	for i = 1, count do
		local item = net.ReadString()
		local stock = net.ReadInt(8)
		local issued = net.ReadInt(8)

		local line = panel.ArmoryStock:AddLine(GAMEMODE:GetDefaultItemKey(item, "Name"), stock > 0 and string.format("%s \\ %s", stock - issued, stock) or "Many")

		line.ArmoryData = {item, stock, issued}
	end

	panel.ArmoryStock:Sort()
end)

net.Receive("nArmoryLogs", function()
	local panel = GAMEMODE.ArmoryParent

	if not IsValid(panel) or not IsValid(panel.ArmoryStock) then
		return
	end

	panel.Logs:AddLine(net.ReadString())
	panel.Logs:PerformLayout()
	panel.Logs.VBar:SetScroll(panel.Logs.pnlCanvas:GetTall())
end)
