function ITEM:ConfigureModelPanel(panel)

	panel:SetModel(self:GetProperty("Model"))
	panel:SetColor(self:GetProperty("Color"))

	local ent = panel:GetEntity()

	local tab = PositionSpawnIcon(ent, ent:GetPos())
	local fov = self:GetProperty("IconFOV")
	local camOffset = self:GetProperty("CamOffset")
	local angOffset = self:GetProperty("AngOffset")

	panel:SetFOV(fov > 0 and fov or tab.fov)
	panel:SetCamPos(tab.origin + camOffset)
	panel:SetLookAng(tab.angles)
	ent:SetAngles(angOffset)

	for _, v in pairs(ent:GetBodyGroups()) do
		ent:SetBodygroup(v.id, 0)
	end

	ent:SetSubMaterial()

	ent:SetSkin(self:GetProperty("Skin"))

	local bodygroups = self:GetProperty("Bodygroups")

	for k, v in pairs(bodygroups) do
		if not isnumber(v) then
			continue
		end

		ent:SetBodygroup(k - 1, v)
	end

	local materials = self:GetProperty("Materials")

	if isstring(materials) then
		ent:SetMaterial(materials)
	else
		for k, v in pairs(materials) do
			if not isstring(v) then
				continue
			end

			ent:SetSubMaterial(k, v)
		end
	end
end

function ITEM:CreateInventoryIcon(invtype)
	assert(type, "CreateInventoryIcon requires an INVTYPE_ enum")

	local icon = vgui.Create("DModelPanel")
	icon.ID = self.ID
	icon.Highlight = self:GetUIHighlight()

	icon:SetSize(48, 48)

	self:ConfigureModelPanel(icon)

	local p = icon.Paint

	function icon:Paint(w, h)
		if self.Highlight then
			draw.RoundedBox(8, 2, 2, w - 4, h - 4, self.Highlight)
		end

		p(self, w, h)
	end

	function icon:LayoutEntity()
	end

	function icon:DoRightClick()
		self:DoClick()

		local item = GAMEMODE:GetItem(icon.ID)

		CloseDermaMenus()

		local dmenu = DermaMenu()
		dmenu:SetPos(gui.MousePos())

		if invtype == INVTYPE_SELF then
			local options = item:GetInventoryOptions(LocalPlayer())

			if table.Count(options) > 0 then
				for k, v in pairs(options) do
					local function func()
						v.Func(item, LocalPlayer())

						net.Start("nUseItem")
							net.WriteInt(item.ID, 32)
							net.WriteInt(k, 8)
						net.SendToServer()
					end

					dmenu:AddOption(v.Name, function()
						if v.Delay then
							local id

							if IsValid(CCP.PlayerMenu) then
								id = CCP.PlayerMenu.SelectedItem
							end

							GAMEMODE:CreateTimedProgressBar(v.Delay, v.DelayName, LocalPlayer(), function()
								func()

								GAMEMODE:CreatePlayerMenu()

								if id and IsValid(CCP.PlayerMenu) then
									CCP.PlayerMenu.SelectedItem = id
								end

								GAMEMODE:PMUpdateInventory()
							end)

							CCP.PlayerMenu:Close()
						else
							func()
						end
					end)
				end
			end

			if item:CanDrop(LocalPlayer()) then
				dmenu:AddOption("Drop", function()
					net.Start("nDropItem")
						net.WriteInt(item.ID, 32)
					net.SendToServer()
				end)
			end

			if item:CanDestroy(LocalPlayer()) then
				dmenu:AddOption("Destroy", function()
					net.Start("nDestroyItem")
						net.WriteInt(item.ID, 32)
					net.SendToServer()
				end)
			end
		elseif invtype == INVTYPE_ADMIN then
			if item:CanPickup(LocalPlayer(), true) then
				dmenu:AddOption("Take", function()
					net.Start("nATakeItem")
						net.WriteInt(item.ID, 32)
					net.SendToServer()
				end)
			end

			if item:CanDestroy(LocalPlayer()) then
				dmenu:AddOption("Destroy", function()
					net.Start("nADestroyItem")
						net.WriteInt(item.ID, 32)
					net.SendToServer()
				end)
			end
		elseif invtype == INVTYPE_PATDOWN then
			if not item:GetProperty("Generic") and #item:GetProperty("UserDescription") > 0 then
				dmenu:AddOption("Examine", function()
					item:CreateUserDescription()
				end)
			end
		end

		dmenu:Open()
	end

	function icon:OnCursorEntered()
		GAMEMODE.CursorItem = GAMEMODE:GetItem(icon.ID)
	end

	function icon:OnCursorExited()
		if GAMEMODE.CursorItem and GAMEMODE.CursorItem == GAMEMODE:GetItem(icon.ID) then
			GAMEMODE.CursorItem = nil
		end
	end

	return icon
end

local template = [[
<font=CombineControl.LabelBig><colour=ltgrey>%s</colour></font>
<font=CombineControl.LabelSmall><colour=white>%s</colour></font>
]]

function ITEM:DrawTooltip()
	local name = self:GetName()

	if #name <= 0 and #self:GetProperty("UserDescription") <= 0 then return end

	if not self.Tooltip or self.ReloadTooltip then
		local str = string.format(template, name, self:GetProperty("UserDescription"))
		self.Tooltip = markup.Parse(str, 256)

		self.ReloadTooltip = false
	end

	local x, y = gui.MouseX() + 15 , gui.MouseY() + 5
	local w, h = self.Tooltip:Size()

	surface.SetDrawColor(0, 0, 0, 240)
	surface.DrawRect(x - 5, y - 5, w + 10, h + 10)

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawOutlinedRect(x - 5, y - 5, w + 10, h + 10)

	self.Tooltip:Draw(x, y)
end

function ITEM:CreateUserDescription(allowEdits)
	CCP.ItemDescEdit = vgui.Create("DFrame")

	local ui = CCP.ItemDescEdit

	ui.Item = self
	ui.Original = self:GetProperty("UserDescription")

	ui:SetSize(400, allowEdits and 304 or 264)
	ui:Center()
	ui:SetTitle("Item Description")
	ui.lblTitle:SetFont("CombineControl.Window")
	ui:MakePopup()
	ui.PerformLayout = CCFramePerformLayout
	ui:PerformLayout()

	ui.Think = UIAutoClose

	ui.Entry = vgui.Create("DTextEntry", ui)
	ui.Entry:SetFont("CombineControl.LabelSmall")
	ui.Entry:SetPos(10, 34)
	ui.Entry:SetSize(380, 220)
	ui.Entry:PerformLayout()
	ui.Entry:SetValue(ui.Original)
	ui.Entry:SetMultiline(true)
	ui.Entry:RequestFocus()
	ui.Entry:SetCaretPos(#ui.Original)
	ui.Entry:SetDisabled(not allowEdits)

	if allowEdits then
		ui.Label = vgui.Create("DLabel", ui)
		ui.Label:SetText(#ui.Original .. "/" .. GAMEMODE.MaxItemDescLength)
		ui.Label:SetPos(10, 264)
		ui.Label:SetSize(380, 30)
		ui.Label:SetFont("CombineControl.LabelGiant")
		ui.Label:PerformLayout()

		function ui.Entry:OnChange()
			if IsValid(ui.Label) then
				local val = self:GetValue()
				local col = Color(200, 200, 200, 255)

				if #string.Trim(val) > GAMEMODE.MaxItemDescLength then
					col = Color(200, 0, 0, 255)

					ui.Ok:SetDisabled(true)
				else
					ui.Ok:SetDisabled(false)
				end

				ui.Label:SetText(#string.Trim(val) .. "/" .. GAMEMODE.MaxItemDescLength)
				ui.Label:SetTextColor(col)
			end
		end

		ui.Ok = vgui.Create("DButton", ui)
		ui.Ok:SetFont("CombineControl.LabelSmall")
		ui.Ok:SetText("OK")
		ui.Ok:SetPos(340, 264)
		ui.Ok:SetSize(50, 30)

		function ui.Ok:DoClick()
			local val = string.Trim(ui.Entry:GetValue())

			if #val > GAMEMODE.MaxItemDescLength then
				return
			end

			if val != ui.Original then
				net.Start("nSetItemUserDescription")
					net.WriteInt(ui.Item.ID, 32)
					net.WriteString(val)
				net.SendToServer()
			end

			ui:Remove()
		end

		ui.Ok:PerformLayout()
	end
end

function ITEM:GetUIHighlight()
	if self:IsBroken() then
		return Color(150, 0, 0, 25)
	end
end