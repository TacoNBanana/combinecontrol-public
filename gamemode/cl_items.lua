GM.ItemQueue = {}

hook.Add("CC.SH.Think", "CL.Items.Think", function()
	for index, item in pairs(GAMEMODE.ItemQueue) do
		local ent = Entity(index)

		if not IsValid(ent) then
			continue
		end

		item.PhysicalEntity = ent
		item.PhysicalEntity.Item = item

		GAMEMODE.ItemQueue[index] = nil
	end
end)

net.Receive("nSendItem", function()
	local id = net.ReadInt(32)
	local classname = net.ReadString()
	local overrides = net.ReadTable()
	local location = net.ReadInt(8)
	local locationarg = net.ReadInt(32)
	local deleted = net.ReadBool()

	local item = GAMEMODE.Items[id]

	if not item then
		-- New items just have to be loaded, no need to handle updating
		GAMEMODE:LoadItem(id, classname, overrides, location, locationarg, deleted)
		GAMEMODE:UpdateInventoryScreens()

		return
	end

	if item.StoreType != location or (location == ITEM_PLAYER and item.CharacterID != locationarg) or (location == ITEM_WORLD and item.PhysicalEntityIndex != locationarg) then
		item:SetItemLocation(location, locationarg)
	end

	item.Overrides = overrides
	item.Deleted = deleted

	item:Updated()

	GAMEMODE:UpdateInventoryScreens()
end)

net.Receive("nUnloadItem", function()
	local id = net.ReadInt(32)
	local item = GAMEMODE.Items[id]

	if not item then
		return
	end

	GAMEMODE:UnloadItem(item)
	GAMEMODE:UpdateInventoryScreens()
end)

net.Receive("nDropAmount", function()
	local id = net.ReadInt(32)
	local item = GAMEMODE.Items[id]

	if not item then
		return
	end

	CCP.ItemDropAmount = vgui.Create("DFrame")

	local ui = CCP.ItemDropAmount

	ui.Item = item

	ui:SetSize(218, 74)
	ui:Center()
	ui:SetTitle("Item Dropping")
	ui.lblTitle:SetFont("CombineControl.Window")
	ui:MakePopup()
	ui.PerformLayout = CCFramePerformLayout
	ui:PerformLayout()

	ui.Think = UIAutoClose

	ui.Amount = vgui.Create("DTextEntry", ui)
	ui.Amount:SetPos(10, 34)
	ui.Amount:SetSize(60, 30)
	ui.Amount:SetFont("CombineControl.LabelSmall")
	ui.Amount:PerformLayout()
	ui.Amount:SetValue(1)
	ui.Amount:SetCaretPos(1)
	ui.Amount:RequestFocus()

	function ui.Amount:AllowInput(val)
		if not string.find(val, "%d") then
			return true
		end
	end

	local function submit(val)
		net.Start("nDropAmount")
			net.WriteInt(id, 32)
			net.WriteInt(math.Round(val), 32)
		net.SendToServer()

		ui:Close()
	end

	ui.DropAmount = vgui.Create("DButton", ui)
	ui.DropAmount:SetPos(78, 34)
	ui.DropAmount:SetSize(60, 30)
	ui.DropAmount:SetFont("CombineControl.LabelSmall")
	ui.DropAmount:SetText("Drop")
	ui.DropAmount:PerformLayout()

	function ui.DropAmount:DoClick()
		local val = tonumber(ui.Amount:GetValue())

		if not val or val <= 0 then
			return
		end

		submit(val)
	end

	ui.Amount.OnEnter = ui.DropAmount.DoClick

	ui.DropAll = vgui.Create("DButton", ui)
	ui.DropAll:SetPos(146, 34)
	ui.DropAll:SetSize(60, 30)
	ui.DropAll:SetFont("CombineControl.LabelSmall")
	ui.DropAll:SetText("Drop all")
	ui.DropAll:PerformLayout()

	function ui.DropAll:DoClick()
		submit(ui.Item:GetProperty("Amount"))
	end
end)

function GM:UpdateInventoryScreens()
	self:PMUpdateInventory()

	if IsValid(CCP.PatDown) then
		CCP.PatDown:Update()
	end

	if IsValid(CCP.AdminInv) then
		CCP.AdminInv:Update()
	end
end

hook.Add("NotifyShouldTransmit", "sync", function(ent)
	if ent == LocalPlayer() then
		for id, item in pairs(GAMEMODE.Items) do
			if item.Player == LocalPlayer() then
				LocalPlayer().Inventory[id] = item
			end
		end
	end
end)
