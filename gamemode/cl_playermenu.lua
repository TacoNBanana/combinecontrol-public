function GM:CreatePlayerMenu()
	CCP.PlayerMenu = vgui.Create("DFrame")
	CCP.PlayerMenu:SetSize(800, 500)
	CCP.PlayerMenu:Center()
	CCP.PlayerMenu:SetTitle("Player Menu")
	CCP.PlayerMenu.lblTitle:SetFont("CombineControl.Window")
	CCP.PlayerMenu:MakePopup()
	CCP.PlayerMenu.PerformLayout = CCFramePerformLayout
	CCP.PlayerMenu:PerformLayout()

	CCP.PlayerMenu.Think = UIAutoClose

	CCP.PlayerMenu.OnKeyCodePressed = function(self, key)
		if input.LookupKeyBinding(key) and string.find(input.LookupKeyBinding(key), "showspare1") then
			self:Close()

			GAMEMODE.CursorItem = nil
		end
	end

	CCP.PlayerMenu.TopBar = vgui.Create("DPanel", CCP.PlayerMenu)
	CCP.PlayerMenu.TopBar:SetPos(0, 24)
	CCP.PlayerMenu.TopBar:SetSize(800, 50)
	CCP.PlayerMenu.TopBar:DockPadding(5, 10, 5, 10)

	function CCP.PlayerMenu.TopBar:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 70)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	CCP.PlayerMenu.TopBar.Buttons = {}

	local buttons = {
		{"Description", "PMCreateBio"},
		{"Inventory", "PMCreateInventory"},
		{"Business", "PMCreateBusiness", true},
		{"Map", "PMCreateMap", function() return LocalPlayer():IsAdmin() or LocalPlayer():HasItem("map") or LocalPlayer():GetCharFlagValue("IsSkyNET", false) end},
		{"Armory", "PMCreateArmory", function() return LocalPlayer():ArmoryAccess() != "" and IsValid(LocalPlayer().ActiveZone["cc_zone_armory"]) end},
		{"Settings", "PMCreateSettings"},
	}

	for _, v in ipairs(buttons) do
		local button = vgui.Create("DButton", CCP.PlayerMenu.TopBar)

		button:SetFont("CombineControl.LabelSmall")
		button:SetText(v[1])
		button:DockMargin(5, 0, 5, 0)
		button:Dock(LEFT)
		button:SetTall(26)
		button.DoClick = function()
			CCP.PlayerMenu.ContentPane:Clear()

			GAMEMODE[v[2]](GAMEMODE)
		end

		if v[3] then
			if not isfunction(v[3]) then
				button:SetDisabled(true)
			elseif not v[3]() then
				button:SetDisabled(true)
			end
		end

		button:PerformLayout()

		table.insert(CCP.PlayerMenu.TopBar.Buttons, button)
	end

	local w = CCP.PlayerMenu.TopBar:GetSize() - 12

	w = w - (#CCP.PlayerMenu.TopBar.Buttons * 10)

	local width = w / #CCP.PlayerMenu.TopBar.Buttons

	for _, v in pairs(CCP.PlayerMenu.TopBar.Buttons) do
		v:SetWide(width)
	end

	CCP.PlayerMenu.ContentPane = vgui.Create("DPanel", CCP.PlayerMenu)
	CCP.PlayerMenu.ContentPane:SetPos(0, 74)
	CCP.PlayerMenu.ContentPane:SetSize(800, 426)
	function CCP.PlayerMenu.ContentPane:Paint() end

	self:PMCreateInventory()
end

local allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 .-'áàâäçéèêëíìîïóòôöúùûüÿÁÀÂÄßÇÉÈÊËÍÌÎÏÓÒÔÖÚÙÛÜŸ"

function GM:PMCreateNameEdit()
	CCP.PlayerMenu.NameEdit = vgui.Create("DFrame")
	CCP.PlayerMenu.NameEdit:SetSize(300, 114)
	CCP.PlayerMenu.NameEdit:Center()
	CCP.PlayerMenu.NameEdit:SetTitle("Change Name")
	CCP.PlayerMenu.NameEdit.lblTitle:SetFont("CombineControl.Window")
	CCP.PlayerMenu.NameEdit:MakePopup()
	CCP.PlayerMenu.NameEdit.PerformLayout = CCFramePerformLayout
	CCP.PlayerMenu.NameEdit:PerformLayout()

	CCP.PlayerMenu.NameEdit.Think = UIAutoClose

	CCP.PlayerMenu.NameEdit.Label = vgui.Create("DLabel", CCP.PlayerMenu.NameEdit)
	CCP.PlayerMenu.NameEdit.Label:SetText(#LocalPlayer():RPName() .. "/" .. self.MaxNameLength)
	CCP.PlayerMenu.NameEdit.Label:SetPos(10, 74)
	CCP.PlayerMenu.NameEdit.Label:SetSize(280, 30)
	CCP.PlayerMenu.NameEdit.Label:SetFont("CombineControl.LabelGiant")
	CCP.PlayerMenu.NameEdit.Label:PerformLayout()

	CCP.PlayerMenu.NameEdit.Entry = vgui.Create("DTextEntry", CCP.PlayerMenu.NameEdit)
	CCP.PlayerMenu.NameEdit.Entry:SetFont("CombineControl.LabelBig")
	CCP.PlayerMenu.NameEdit.Entry:SetPos(10, 34)
	CCP.PlayerMenu.NameEdit.Entry:SetSize(280, 30)
	CCP.PlayerMenu.NameEdit.Entry:PerformLayout()
	CCP.PlayerMenu.NameEdit.Entry:SetValue(LocalPlayer():RPName())
	CCP.PlayerMenu.NameEdit.Entry:RequestFocus()
	CCP.PlayerMenu.NameEdit.Entry:SetCaretPos(#CCP.PlayerMenu.NameEdit.Entry:GetValue())
	function CCP.PlayerMenu.NameEdit.Entry:OnChange()

		if CCP.PlayerMenu.NameEdit.Label then

			local val = self:GetValue()

			local col = Color(200, 200, 200, 255)

			if #string.Trim(val) > GAMEMODE.MaxNameLength or #string.Trim(val) < GAMEMODE.MinNameLength then

				col = Color(200, 0, 0, 255)

			end

			CCP.PlayerMenu.NameEdit.Label:SetText(#string.Trim(val) .. "/" .. GAMEMODE.MaxNameLength)
			CCP.PlayerMenu.NameEdit.Label:SetTextColor(col)

		end

	end
	function CCP.PlayerMenu.NameEdit.Entry:AllowInput(val)

		if not string.find(allowedChars, val, 1, true) then

			return true

		end

		return false

	end

	CCP.PlayerMenu.NameEdit.OK = vgui.Create("DButton", CCP.PlayerMenu.NameEdit)
	CCP.PlayerMenu.NameEdit.OK:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.NameEdit.OK:SetText("OK")
	CCP.PlayerMenu.NameEdit.OK:SetPos(240, 74)
	CCP.PlayerMenu.NameEdit.OK:SetSize(50, 30)
	function CCP.PlayerMenu.NameEdit.OK:DoClick()

		local val = string.Trim(CCP.PlayerMenu.NameEdit.Entry:GetValue())

		if #val <= GAMEMODE.MaxNameLength and #val >= GAMEMODE.MinNameLength then

			if GAMEMODE:CheckNameValidity(val) then

				CCP.PlayerMenu.NameEdit:Remove()

				net.Start("nChangeRPName")
					net.WriteString(val)
				net.SendToServer()

			else

				GAMEMODE:AddChat("Error: Name cannot include '#', '~' or '%'.", Color(200, 0, 0, 255))

			end

		else

			GAMEMODE:AddChat("Error: Name must be between " .. GAMEMODE.MinNameLength .. " and " .. GAMEMODE.MaxNameLength .. " characters.", Color(200, 0, 0, 255))

		end

	end
	CCP.PlayerMenu.NameEdit.OK:PerformLayout()

	CCP.PlayerMenu.NameEdit.Entry.OnEnter = CCP.PlayerMenu.NameEdit.OK.DoClick
end

hook.Add("OnVisibleRPNameChanged", "playermenu", function(ply, val)
	if ply == LocalPlayer() and CCP.PlayerMenu and CCP.PlayerMenu.CharacterName then
		CCP.PlayerMenu.CharacterName:SetText(val)
	end
end)

function GM:PMCreateDescEdit()
	CCP.PlayerMenu.DescEdit = vgui.Create("DFrame")
	CCP.PlayerMenu.DescEdit:SetSize(400, 304)
	CCP.PlayerMenu.DescEdit:Center()
	CCP.PlayerMenu.DescEdit:SetTitle("Change Description")
	CCP.PlayerMenu.DescEdit.lblTitle:SetFont("CombineControl.Window")
	CCP.PlayerMenu.DescEdit:MakePopup()
	CCP.PlayerMenu.DescEdit.PerformLayout = CCFramePerformLayout
	CCP.PlayerMenu.DescEdit:PerformLayout()

	CCP.PlayerMenu.DescEdit.Think = UIAutoClose

	CCP.PlayerMenu.DescEdit.Label = vgui.Create("DLabel", CCP.PlayerMenu.DescEdit)
	CCP.PlayerMenu.DescEdit.Label:SetText(#LocalPlayer():Description() .. "/" .. self.MaxDescLength)
	CCP.PlayerMenu.DescEdit.Label:SetPos(10, 264)
	CCP.PlayerMenu.DescEdit.Label:SetSize(380, 30)
	CCP.PlayerMenu.DescEdit.Label:SetFont("CombineControl.LabelGiant")
	CCP.PlayerMenu.DescEdit.Label:PerformLayout()

	CCP.PlayerMenu.DescEdit.Entry = vgui.Create("DTextEntry", CCP.PlayerMenu.DescEdit)
	CCP.PlayerMenu.DescEdit.Entry:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.DescEdit.Entry:SetPos(10, 34)
	CCP.PlayerMenu.DescEdit.Entry:SetSize(380, 220)
	CCP.PlayerMenu.DescEdit.Entry:PerformLayout()
	CCP.PlayerMenu.DescEdit.Entry:SetValue(LocalPlayer():Description())
	CCP.PlayerMenu.DescEdit.Entry:SetMultiline(true)
	CCP.PlayerMenu.DescEdit.Entry:RequestFocus()
	CCP.PlayerMenu.DescEdit.Entry:SetCaretPos(#CCP.PlayerMenu.DescEdit.Entry:GetValue())
	function CCP.PlayerMenu.DescEdit.Entry:OnChange()

		if CCP.PlayerMenu.DescEdit.Label then

			local val = self:GetValue()

			local col = Color(200, 200, 200, 255)

			if #string.Trim(val) > GAMEMODE.MaxDescLength then

				col = Color(200, 0, 0, 255)

			end

			CCP.PlayerMenu.DescEdit.Label:SetText(#string.Trim(val) .. "/" .. GAMEMODE.MaxDescLength)
			CCP.PlayerMenu.DescEdit.Label:SetTextColor(col)

		end

	end

	CCP.PlayerMenu.DescEdit.OK = vgui.Create("DButton", CCP.PlayerMenu.DescEdit)
	CCP.PlayerMenu.DescEdit.OK:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.DescEdit.OK:SetText("OK")
	CCP.PlayerMenu.DescEdit.OK:SetPos(340, 264)
	CCP.PlayerMenu.DescEdit.OK:SetSize(50, 30)
	function CCP.PlayerMenu.DescEdit.OK:DoClick()

		local val = string.Trim(CCP.PlayerMenu.DescEdit.Entry:GetValue())

		if #val <= GAMEMODE.MaxDescLength then

			CCP.PlayerMenu.DescEdit:Remove()

			if CCP.PlayerMenu.CharacterDesc and CCP.PlayerMenu.CharacterDesc:IsValid() then

				CCP.PlayerMenu.CharacterDesc:SetText(val)

			end

			net.Start("nChangeTitle")
				net.WriteString(val)
			net.SendToServer()

		else

			GAMEMODE:AddChat("Error: Description must be less than " .. GAMEMODE.MaxDescLength .. " characters.", Color(200, 0, 0, 255))

		end

	end
	CCP.PlayerMenu.DescEdit.OK:PerformLayout()

	CCP.PlayerMenu.DescEdit.Entry.OnEnter = CCP.PlayerMenu.DescEdit.OK.DoClick
end


function GM:PMCreateNotes()
	CCP.PlayerMenu.Notes = vgui.Create("DFrame")
	CCP.PlayerMenu.Notes:SetSize(400, 304)
	CCP.PlayerMenu.Notes:Center()
	CCP.PlayerMenu.Notes:SetTitle("Notes")
	CCP.PlayerMenu.Notes.lblTitle:SetFont("CombineControl.Window")
	CCP.PlayerMenu.Notes:MakePopup()
	CCP.PlayerMenu.Notes.PerformLayout = CCFramePerformLayout
	CCP.PlayerMenu.Notes:PerformLayout()

	CCP.PlayerMenu.Notes.Think = UIAutoClose

	CCP.PlayerMenu.Notes.Entry = vgui.Create("DTextEntry", CCP.PlayerMenu.Notes)
	CCP.PlayerMenu.Notes.Entry:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.Notes.Entry:SetPos(10, 34)
	CCP.PlayerMenu.Notes.Entry:SetSize(380, 220)
	CCP.PlayerMenu.Notes.Entry:PerformLayout()
	CCP.PlayerMenu.Notes.Entry:SetValue(cookie.GetString("cc_notes_" .. LocalPlayer():CharID(), ""))
	CCP.PlayerMenu.Notes.Entry:SetMultiline(true)
	CCP.PlayerMenu.Notes.Entry:RequestFocus()
	CCP.PlayerMenu.Notes.Entry:SetCaretPos(#CCP.PlayerMenu.Notes.Entry:GetValue())

	CCP.PlayerMenu.Notes.OK = vgui.Create("DButton", CCP.PlayerMenu.Notes)
	CCP.PlayerMenu.Notes.OK:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.Notes.OK:SetText("OK")
	CCP.PlayerMenu.Notes.OK:SetPos(340, 264)
	CCP.PlayerMenu.Notes.OK:SetSize(50, 30)
	function CCP.PlayerMenu.Notes.OK:DoClick()

		local val = string.Trim(CCP.PlayerMenu.Notes.Entry:GetValue())

		CCP.PlayerMenu.Notes:Remove()

		cookie.Set("cc_notes_" .. LocalPlayer():CharID(), val)

	end
	CCP.PlayerMenu.Notes.OK:PerformLayout()

	CCP.PlayerMenu.Notes.Entry.OnEnter = CCP.PlayerMenu.Notes.OK.DoClick
end

function GM:PMCreateBio()
	CCP.PlayerMenu.CharacterModel = vgui.Create("DModelPanel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterModel:SetPos(10, 10)
	CCP.PlayerMenu.CharacterModel:SetModel(LocalPlayer():GetModel())
	CCP.PlayerMenu.CharacterModel.Entity:SetSkin(LocalPlayer():GetSkin())
	CCP.PlayerMenu.CharacterModel.Entity:SetMaterial(LocalPlayer():GetMaterial())
	CCP.PlayerMenu.CharacterModel.Entity:CopyBodygroups(LocalPlayer())
	CCP.PlayerMenu.CharacterModel:SetSize(200, 406)
	CCP.PlayerMenu.CharacterModel:SetFOV(20)
	CCP.PlayerMenu.CharacterModel:SetCamPos(Vector(50, 0, 56))
	CCP.PlayerMenu.CharacterModel:SetLookAt(Vector(0, 0, 56))
	function CCP.PlayerMenu.CharacterModel:DoClick()

		self:StartScene("scenes/expressions/citizen_angry_idle_01.vcd")

	end

	compound.SetupModelPanel(CCP.PlayerMenu.CharacterModel, LocalPlayer(), true)

	function CCP.PlayerMenu.CharacterModel.Entity:GetPlayerColor()

		if not LocalPlayer() or not LocalPlayer():IsValid() then return Vector(1, 1, 1) end

		return LocalPlayer():GetPlayerColor()

	end

	CCP.PlayerMenu.CharacterName = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterName:SetText(LocalPlayer():VisibleRPName())
	CCP.PlayerMenu.CharacterName:SetPos(220, 10)
	CCP.PlayerMenu.CharacterName:SetSize(540, 22)
	CCP.PlayerMenu.CharacterName:SetFont("CombineControl.LabelGiant")
	CCP.PlayerMenu.CharacterName:PerformLayout()

	CCP.PlayerMenu.CharacterNameEdit = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterNameEdit:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.CharacterNameEdit:SetText("Edit...")
	CCP.PlayerMenu.CharacterNameEdit:SetPos(750, 10)
	CCP.PlayerMenu.CharacterNameEdit:SetSize(40, 20)
	function CCP.PlayerMenu.CharacterNameEdit:DoClick()
		GAMEMODE:PMCreateNameEdit()
	end

	CCP.PlayerMenu.CharacterNameEdit:PerformLayout()

	CCP.PlayerMenu.CharacterDescScroll = vgui.Create("DScrollPanel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterDescScroll:SetPos(220, 40)
	CCP.PlayerMenu.CharacterDescScroll:SetSize(540, 376)
	function CCP.PlayerMenu.CharacterDescScroll:Paint(w, h) end

	CCP.PlayerMenu.CharacterDesc = vgui.Create("CCLabel")
	CCP.PlayerMenu.CharacterDesc:SetPos(0, 0)
	CCP.PlayerMenu.CharacterDesc:SetSize(530, 10)
	CCP.PlayerMenu.CharacterDesc:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.CharacterDesc:SetText(LocalPlayer():Description())
	CCP.PlayerMenu.CharacterDesc:PerformLayout()

	CCP.PlayerMenu.CharacterDescScroll:AddItem(CCP.PlayerMenu.CharacterDesc)

	CCP.PlayerMenu.CharacterDescEdit = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterDescEdit:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.CharacterDescEdit:SetText("Edit...")
	CCP.PlayerMenu.CharacterDescEdit:SetPos(750, 40)
	CCP.PlayerMenu.CharacterDescEdit:SetSize(40, 20)
	function CCP.PlayerMenu.CharacterDescEdit:DoClick()

		GAMEMODE:PMCreateDescEdit()

	end
	CCP.PlayerMenu.CharacterDescEdit:PerformLayout()

	local traits = {}

	for _, v in pairs(self.TraitsList) do

		if LocalPlayer():HasTrait(v) then

			table.insert(traits, self.Traits[v][1])

		end

	end

	CCP.PlayerMenu.CharacterTrait = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterTrait:SetText("Traits: " .. table.concat(traits, ", "))
	CCP.PlayerMenu.CharacterTrait:SetPos(220, 376)
	CCP.PlayerMenu.CharacterTrait:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.CharacterTrait:SizeToContents()
	CCP.PlayerMenu.CharacterTrait:PerformLayout()

	local langs = {}

	for _, v in pairs(self.LangsList) do

		if LocalPlayer():HasLang(v) then

			table.insert(langs, self.Langs[v][1])

		end

	end

	CCP.PlayerMenu.CharacterLang = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterLang:SetText("Languages: " .. table.concat(langs, ", "))
	CCP.PlayerMenu.CharacterLang:SetPos(220, 396)
	CCP.PlayerMenu.CharacterLang:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.CharacterLang:SizeToContents()
	CCP.PlayerMenu.CharacterLang:PerformLayout()

	CCP.PlayerMenu.CharacterNotes = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterNotes:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.CharacterNotes:SetText("Notes")
	CCP.PlayerMenu.CharacterNotes:SetPos(710, 396)
	CCP.PlayerMenu.CharacterNotes:SetSize(80, 20)
	function CCP.PlayerMenu.CharacterNotes:DoClick()

		GAMEMODE:PMCreateNotes()

	end
	CCP.PlayerMenu.CharacterNotes:PerformLayout()
end

function GM:PMCreateInventory()
	if CCP.PlayerMenu.InvButtons then

		for _, v in pairs(CCP.PlayerMenu.InvButtons) do

			v:Remove()

		end

	end

	CCP.PlayerMenu.InvButtons = {}

	CCP.PlayerMenu.InvModel = vgui.Create("DModelPanel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.InvModel:SetPos(420, 10)
	CCP.PlayerMenu.InvModel:SetModel("")
	CCP.PlayerMenu.InvModel:SetSize(CCP.PlayerMenu.ContentPane:GetWide() - 430, 200)
	CCP.PlayerMenu.InvModel:SetFOV(20)
	CCP.PlayerMenu.InvModel:SetCamPos(Vector(50, 50, 50))
	CCP.PlayerMenu.InvModel:SetLookAt(Vector(0, 0, 0))

	local p = CCP.PlayerMenu.InvModel.Paint

	function CCP.PlayerMenu.InvModel:Paint(w, h)

		surface.SetDrawColor(0, 0, 0, 70)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawOutlinedRect(0, 0, w, h)

		p(self, w, h)

	end

	function CCP.PlayerMenu.InvModel:LayoutEntity(ent) end

	CCP.PlayerMenu.InvTitle = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.InvTitle:SetText("")
	CCP.PlayerMenu.InvTitle:SetPos(420, 220)
	CCP.PlayerMenu.InvTitle:SetFont("CombineControl.LabelGiant")
	CCP.PlayerMenu.InvTitle:SetSize(CCP.PlayerMenu.ContentPane:GetWide() - 430, 22)
	CCP.PlayerMenu.InvTitle:PerformLayout()

	CCP.PlayerMenu.InvWeight = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.InvWeight:SetText("")
	CCP.PlayerMenu.InvWeight:SetPos(420, CCP.PlayerMenu.ContentPane:GetTall() - 30)
	CCP.PlayerMenu.InvWeight:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.InvWeight:SetSize(CCP.PlayerMenu.ContentPane:GetWide() - 430 - 110, 22)
	CCP.PlayerMenu.InvWeight:PerformLayout()

	CCP.PlayerMenu.InvDesc = vgui.Create("RichText", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.InvDesc:SetText("No item selected.")
	CCP.PlayerMenu.InvDesc:SetPos(420, 250)
	CCP.PlayerMenu.InvDesc:SetSize(CCP.PlayerMenu.ContentPane:GetWide() - 430 - 110, 144)
	CCP.PlayerMenu.InvDesc:SetVerticalScrollbarEnabled(false)
	CCP.PlayerMenu.InvDesc:SetWrap(true)

	function CCP.PlayerMenu.InvDesc:PerformLayout()
		self:SetFontInternal("CombineControl.LabelSmall")
		self:SetBGColor(Color(0, 0, 0, 0))
	end

	if table.Count(LocalPlayer().Inventory) == 0 then
		CCP.PlayerMenu.InvDesc:SetText("You don't have any items!")
	end

	CCP.PlayerMenu.InvScroll = vgui.Create("DScrollPanel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.InvScroll:SetPos(10, 10)
	CCP.PlayerMenu.InvScroll:SetSize(400, CCP.PlayerMenu.ContentPane:GetTall() - 50)
	function CCP.PlayerMenu.InvScroll:Paint(w, h)

		surface.SetDrawColor(0, 0, 0, 70)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawOutlinedRect(0, 0, w, h)

	end

	CCP.PlayerMenu.InvWeightBar = vgui.Create("CCProgressBar", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.InvWeightBar:SetPos(10, CCP.PlayerMenu.ContentPane:GetTall() - 30)
	CCP.PlayerMenu.InvWeightBar:SetSize(400, 20)

	self:PMUpdateInventory()
end

function GM:PMResetText()
	if CCP.PlayerMenu.InvModel then
		CCP.PlayerMenu.InvModel:SetModel("")
	end

	if CCP.PlayerMenu.InvTitle then
		CCP.PlayerMenu.InvTitle:SetText("")
	end

	if CCP.PlayerMenu.InvWeight then
		CCP.PlayerMenu.InvWeight:SetText("")
	end

	if CCP.PlayerMenu.InvDesc then
		CCP.PlayerMenu.InvDesc:SetText("No item selected.")

		if table.Count(LocalPlayer().Inventory) == 0 then
			CCP.PlayerMenu.InvDesc:SetText("You don't have any items!")
		end
	end

	for _, v in pairs(CCP.PlayerMenu.InvButtons) do
		v:Remove()
	end
end

function GM:PMUpdateInventory()
	if not IsValid(CCP.PlayerMenu) or not IsValid(CCP.PlayerMenu.ContentPane) or not IsValid(CCP.PlayerMenu.InvScroll) then
		return
	end

	local ui = CCP.PlayerMenu

	ui.InvScroll:Clear()

	local x = 0
	local y = 0

	local icons = {}

	for _, i in SortedPairs(LocalPlayer().Inventory) do
		local icon = i:CreateInventoryIcon(INVTYPE_SELF)

		icons[icon.ID] = icon

		ui.InvScroll:AddItem(icon)

		icon:SetPos(x, y)

		x = x + 48 + 10

		if x > ui.InvScroll:GetWide() - 48 then
			x = 0
			y = y + 48 + 10
		end

		function icon:DoClick()
			ui.SelectedItem = self.ID

			local item = GAMEMODE:GetItem(self.ID)
			local itemIcon = self

			if not item then
				GAMEMODE:PMResetText()

				return
			end

			item:ConfigureModelPanel(ui.InvModel)
			ui.InvModel:SetFOV(ui.InvModel:GetFOV() * 1.8)

			ui.InvTitle:SetText(item:GetName())
			ui.InvWeight:SetText("Weight: " .. item:GetWeight())
			ui.InvDesc:SetText(item:GetDescription())

			item:GetAuxDescription(ui.InvDesc)

			local y2 = 0

			if IsValid(ui.ButDestroy) then
				ui.ButDestroy:Remove()
			end

			ui.ButDestroy = vgui.Create("DButton", ui.ContentPane)
			ui.ButDestroy:SetFont("CombineControl.LabelSmall")
			ui.ButDestroy:SetText("Destroy")
			ui.ButDestroy:SetPos(ui.ContentPane:GetWide() - 110, ui.ContentPane:GetTall() - 30 + y2)
			ui.ButDestroy:SetSize(100, 20)
			ui.ButDestroy:SetDisabled(not item:CanDestroy(LocalPlayer()))

			table.insert(ui.InvButtons, ui.ButDestroy)

			function ui.ButDestroy:DoClick()
				if not self.DestroyConfirm and cookie.GetNumber("cc_destroyconfirm", 1) == 1 then
					self.DestroyConfirm = true
					self:SetTextColor(Color(200, 0, 0, 255))
				else
					net.Start("nDestroyItem")
						net.WriteInt(item.ID, 32)
					net.SendToServer()
				end
			end

			y2 = y2 - 30

			if IsValid(ui.ButDrop) then
				ui.ButDrop:Remove()
			end

			ui.ButDrop = vgui.Create("DButton", ui.ContentPane)
			ui.ButDrop:SetFont("CombineControl.LabelSmall")
			ui.ButDrop:SetText("Drop")
			ui.ButDrop:SetPos(ui.ContentPane:GetWide() - 110, ui.ContentPane:GetTall() - 30 + y2)
			ui.ButDrop:SetSize(100, 20)
			ui.ButDrop:SetDisabled(not item:CanDrop(LocalPlayer()))

			table.insert(ui.InvButtons, ui.ButDrop)

			function ui.ButDrop:DoClick()
				net.Start("nDropItem")
					net.WriteInt(item.ID, 32)
				net.SendToServer()
			end

			y2 = y2 - 30

			if IsValid(ui.ButOptions) then
				ui.ButOptions:Remove()
			end

			ui.ButOptions = vgui.Create("DButton", ui.ContentPane)

			ui.ButOptions:SetFont("CombineControl.LabelSmall")
			ui.ButOptions:SetPos(ui.ContentPane:GetWide() - 110, ui.ContentPane:GetTall() - 30 + y2)
			ui.ButOptions:SetSize(100, 20)
			ui.ButOptions:SetText("Actions")
			ui.ButOptions:SetDisabled(#item:GetInventoryOptions(LocalPlayer()) < 1)

			function ui.ButOptions:DoClick()
				itemIcon:DoRightClick()
			end
		end
	end

	if ui.SelectedItem then
		local reset = true
		local id = ui.SelectedItem

		if LocalPlayer().Inventory[id] then
			reset = false

			icons[id]:DoClick()
		end

		if reset then
			self:PMResetText()
		end
	end

	ui.InvWeightBar:SetProgress(LocalPlayer():InventoryWeight() / LocalPlayer():InventoryMaxWeight())
	ui.InvWeightBar:SetProgressText("Weight: " .. LocalPlayer():InventoryWeight() .. "/" .. LocalPlayer():InventoryMaxWeight())
end

function GM:PMPopulateBusiness(filter)
	CCP.PlayerMenu.BusinessPane:Clear()

	local y = 0

	for i in SortedPairs(self.ItemClasses) do
		if not self:CanSeeItem(i, LocalPlayer()) then
			continue
		end

		local item = baseclass.Get(i)

		if filter and filter != "" and not string.find(item.Name:lower(), filter:PatternSafe():lower()) then
			continue
		end

		local ui = vgui.Create("DPanel")
		ui:SetPos(0, y)
		ui:SetSize(556, 64)

		function ui:Paint(w, h)
			surface.SetDrawColor(0, 0, 0, 70)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		ui.icon = item:CreateInventoryIcon(INVTYPE_BUSINESS)
		ui.icon:SetParent(ui)

		ui.icon:SetPos(0, 0)
		ui.icon:SetSize(64, 64)

		ui.name = vgui.Create("DLabel", ui)
		ui.name:SetText(item.Name)
		ui.name:SetPos(74, 10)
		ui.name:SetFont("CombineControl.LabelSmall")
		ui.name:SizeToContents()
		ui.name:PerformLayout()

		local d = GAMEMODE:FormatLine(item.Description, "CombineControl.LabelTiny", 375)

		ui.desc = vgui.Create("DLabel", ui)
		ui.desc:SetText(d)
		ui.desc:SetPos(74, 24)
		ui.desc:SetFont("CombineControl.LabelTiny")
		ui.desc:SizeToContents()
		ui.desc:PerformLayout()

		ui.price = vgui.Create("DLabel", ui)
		ui.price:SetText(util.FormatCurrency(item.BuyPrice))
		ui.price:SetPos(454, 10)
		ui.price:SetSize(92, 24)
		ui.price:SetFont("CombineControl.LabelTiny")
		ui.price:SetContentAlignment(7)
		ui.price:PerformLayout()

		ui.amount = vgui.Create("DTextEntry", ui)
		ui.amount:SetFont("CombineControl.LabelSmall")
		ui.amount:SetPos(450, 30)
		ui.amount:SetSize(46, 24)
		ui.amount:PerformLayout()
		ui.amount:SetValue(1)
		ui.amount:SetCaretPos(1)
		ui.amount:SetUpdateOnType(true)

		function ui.amount:OnValueChange(val)
			local amt = tonumber(val)

			if not amt then
				return
			end

			ui.buy:Calculate(amt)
		end

		function ui.amount:AllowInput(val)
			if not string.find(val, "%d") then
				return true
			end
		end

		ui.buy = vgui.Create("DButton", ui)
		ui.buy:SetFont("CombineControl.LabelSmall")
		ui.buy:SetText("Buy")
		ui.buy:SetPos(500, 30)
		ui.buy:SetSize(46, 24)

		function ui.buy:Calculate(val)
			val = math.Round(val)

			local canBuy, err = GAMEMODE:CanBuyItem(i, LocalPlayer(), val)

			if val < 1 or not canBuy then
				self:SetDisabled(true)

				if err then
					ui.buy:SetTooltip(err)
				end
			else
				self:SetDisabled(false)
				ui.buy:SetTooltip(false)
			end

			ui.price:SetText(util.FormatCurrency(item.BuyPrice * val))
		end

		function ui.buy:Think()
			local val = tonumber(ui.amount:GetValue())

			if not val then
				return
			end

			self:Calculate(val)
		end

		function ui.buy:DoClick()
			local val = tonumber(ui.amount:GetValue())

			if not val then
				return
			end

			net.Start("nBuyItem")
				net.WriteString(i)
				net.WriteUInt(math.Round(val), 16)
			net.SendToServer()
		end

		ui.buy:Calculate(1)
		ui.buy:PerformLayout()

		CCP.PlayerMenu.BusinessPane:Add(ui)

		y = y + 64
	end
end

net.Receive("nPopulateBusiness", function(len)
	GAMEMODE:PMPopulateBusiness()
end)

function GM:PMCreateBusiness()
	local lic = LocalPlayer():BusinessLicenses()

	CCP.PlayerMenu.NoBusinessLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)

	CCP.PlayerMenu.NoBusinessLabel:SetPos(10, 10)
	CCP.PlayerMenu.NoBusinessLabel:SetSize(200, 14)
	CCP.PlayerMenu.NoBusinessLabel:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.NoBusinessLabel:PerformLayout()
	CCP.PlayerMenu.NoBusinessLabel:SetWrap(true)
	CCP.PlayerMenu.NoBusinessLabel:SetAutoStretchVertical(true)

	if lic == 0 then
		CCP.PlayerMenu.NoBusinessLabel:SetText("You don't have any business licenses available - you can buy one by clicking the buttons below to get started.")
	else
		CCP.PlayerMenu.NoBusinessLabel:SetText("You can swap your current license by choosing a different one below. Though you won't get any money back.")
	end

	local y = CCP.PlayerMenu.ContentPane:GetTall() - 30

	CCP.PlayerMenu.BusinessLicenses = {}

	for k, v in SortedPairs(self.BusinessLicenses, true) do
		if v[2] then
			local price = v[2]
			local canAfford = LocalPlayer():Money() >= price

			CCP.PlayerMenu.BusinessLicenses[k] = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			CCP.PlayerMenu.BusinessLicenses[k]:SetFont("CombineControl.LabelSmall")
			CCP.PlayerMenu.BusinessLicenses[k]:SetText(v[1] .. " - " .. util.FormatCurrency(price))
			CCP.PlayerMenu.BusinessLicenses[k]:SetPos(10, y)
			CCP.PlayerMenu.BusinessLicenses[k]:SetSize(200, 20)

			CCP.PlayerMenu.BusinessLicenses[k].DoClick = function(pnl)
				net.Start("nBuyBusinessLicense")
					net.WriteInt(k, 32)
				net.SendToServer()

				pnl:SetDisabled(true)

				for k2, v2 in SortedPairs(self.BusinessLicenses, true) do
					if k2 == k or not v2[2] then
						continue
					end

					CCP.PlayerMenu.BusinessLicenses[k2]:SetDisabled(LocalPlayer():Money() < v2[2])
				end
			end

			CCP.PlayerMenu.BusinessLicenses[k]:PerformLayout()

			if bit.band(lic, k) == k or not canAfford then
				CCP.PlayerMenu.BusinessLicenses[k]:SetDisabled(true)
			end

			y = y - 30
		end
	end

	CCP.PlayerMenu.BusinessPane = vgui.Create("DScrollPanel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.BusinessPane:SetSize(570, 384)
	CCP.PlayerMenu.BusinessPane:SetPos(220, 32)

	function CCP.PlayerMenu.BusinessPane:Paint(w, h)
		surface.SetDrawColor(30, 30, 30, 255)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(20, 20, 20, 100)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	CCP.PlayerMenu.BusinessFilter = vgui.Create("DTextEntry", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.BusinessFilter:SetFont("CombineControl.LabelMedium")
	CCP.PlayerMenu.BusinessFilter:SetSize(220, 25)
	CCP.PlayerMenu.BusinessFilter:SetPos(220, 5)
	CCP.PlayerMenu.BusinessFilter:SetUpdateOnType(true)
	CCP.PlayerMenu.BusinessFilter:PerformLayout()

	function CCP.PlayerMenu.BusinessFilter:OnValueChange(str)
		if #str > 0 then
			GAMEMODE:PMPopulateBusiness(str)
		else
			GAMEMODE:PMPopulateBusiness()
		end

	end

	GAMEMODE:PMPopulateBusiness()
end

function GM:PMCreateMap()
	local panel = CCP.PlayerMenu.ContentPane

	CCP.PlayerMenu.Map = vgui.Create("CCMap", panel)
	CCP.PlayerMenu.Map:SetSize(panel:GetTall(), panel:GetTall())
	CCP.PlayerMenu.Map:SetPos(panel:GetWide() * 0.5 - panel:GetTall() * 0.5, 0)

	if LocalPlayer():IsAdmin() then
		CCP.PlayerMenu.AdminMap = vgui.Create("DButton", panel)
		CCP.PlayerMenu.AdminMap:SetFont("CombineControl.LabelSmall")
		CCP.PlayerMenu.AdminMap:SetText("Toggle Admin Map")
		CCP.PlayerMenu.AdminMap:SetPos(10, 10)
		CCP.PlayerMenu.AdminMap:SetSize(120, 20)

		function CCP.PlayerMenu.AdminMap:DoClick()
			CCP.PlayerMenu.Map.Admin = not CCP.PlayerMenu.Map.Admin
		end
	end
end

function GM:PMCreateArmory()
	self:CreateArmoryGUI(LocalPlayer():ArmoryAccess(), CCP.PlayerMenu)
end

function GM:PMCreateSettings()
	local musicLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		musicLabel:SetText("Enable music")
		musicLabel:SetPos(10, 10)
		musicLabel:SetFont("CombineControl.LabelSmall")
		musicLabel:SizeToContents()

	local musicCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		musicCheck:SetText("")
		musicCheck:SetPos(160, 10)
		musicCheck:SetValue(cookie.GetNumber("cc_music", 1))
		function musicCheck:OnChange(val)
			cookie.Set("cc_music", val and 1 or 0)
			if not val then
				GAMEMODE:FadeOutMusic(1)
			end
		end

	local hudLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		hudLabel:SetText("Enable HUD")
		hudLabel:SetPos(10, 40)
		hudLabel:SetFont("CombineControl.LabelSmall")
		hudLabel:SizeToContents()

	local hudCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		hudCheck:SetText("")
		hudCheck:SetPos(160, 40)
		hudCheck:SetValue(cookie.GetNumber("cc_hud", 1))
		hudCheck:SizeToContents()
		function hudCheck:OnChange(val)
			cookie.Set("cc_hud", val and 1 or 0)
		end

	local hudChatLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		hudChatLabel:SetText("Always draw chat")
		hudChatLabel:SetPos(10, 70)
		hudChatLabel:SetFont("CombineControl.LabelSmall")
		hudChatLabel:SizeToContents()

	local hudChatCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		hudChatCheck:SetText("")
		hudChatCheck:SetPos(160, 70)
		hudChatCheck:SetValue(cookie.GetNumber("cc_chat", 0))
		hudChatCheck:SizeToContents()
		function hudChatCheck:OnChange(val)
			cookie.Set("cc_chat", val and 1 or 0)
		end

	local radioLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		radioLabel:SetText("Draw separate radio feed")
		radioLabel:SetPos(10, 100)
		radioLabel:SetFont("CombineControl.LabelSmall")
		radioLabel:SizeToContents()

	local radioCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		radioCheck:SetText("")
		radioCheck:SetPos(160, 100)
		radioCheck:SetValue(cookie.GetNumber("cc_radiochat", 1))
		radioCheck:SizeToContents()
		function radioCheck:OnChange(val)
			cookie.Set("cc_radiochat", val and 1 or 0)
		end

	local thirdPersonLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		thirdPersonLabel:SetText("Third-person camera")
		thirdPersonLabel:SetPos(10, 130)
		thirdPersonLabel:SetFont("CombineControl.LabelSmall")
		thirdPersonLabel:SizeToContents()

	local thirdPersonCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		thirdPersonCheck:SetText("")
		thirdPersonCheck:SetPos(160, 130)
		thirdPersonCheck:SetValue(cookie.GetNumber("cc_thirdperson", 0))
		thirdPersonCheck:SizeToContents()
		function thirdPersonCheck:OnChange(val)
			cookie.Set("cc_thirdperson", val and 1 or 0)
			if cookie.GetNumber( "cc_thirdperson", 0 ) == 1 then
				ctp:Enable()
			else
				ctp:Disable()
			end
		end

	local headbobLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		headbobLabel:SetText("Enable headbob")
		headbobLabel:SetPos(10, 160)
		headbobLabel:SetFont("CombineControl.LabelSmall")
		headbobLabel:SizeToContents()

	local headbobCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		headbobCheck:SetText("")
		headbobCheck:SetPos(160, 160)
		headbobCheck:SetValue(cookie.GetNumber("cc_headbob", 0))
		function headbobCheck:OnChange(val)
			cookie.Set("cc_headbob", val and 1 or 0)
		end

	local playSoundsSayLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		playSoundsSayLabel:SetText("Say when playing sounds")
		playSoundsSayLabel:SetPos(10, 190)
		playSoundsSayLabel:SetFont("CombineControl.LabelSmall")
		playSoundsSayLabel:SizeToContents()

	local playSoundsSayCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		playSoundsSayCheck:SetText("")
		playSoundsSayCheck:SetPos(160, 190)
		playSoundsSayCheck:SetValue(cookie.GetNumber("cc_playsoundssay", 1))
		function playSoundsSayCheck:OnChange(val)
			cookie.Set("cc_playsoundssay", val and 1 or 0)
	end

	local historyLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		historyLabel:SetText("Chat history")
		historyLabel:SetPos(10, 220)
		historyLabel:SetFont("CombineControl.LabelSmall")
		historyLabel:SizeToContents()

	local historyInput = vgui.Create("DTextEntry", CCP.PlayerMenu.ContentPane)
		historyInput:SetFont("CombineControl.LabelMedium")
		historyInput:SetPos(158, 213)
		historyInput:SetSize(40, 23)
		historyInput:SetNumeric(true)
		historyInput:SetValue(cookie.GetNumber("cc_chathistory", 100))

		function historyInput:OnEnter()
			cookie.Set("cc_chathistory", tonumber(self:GetValue()) or 100)
		end

	local loggingLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		loggingLabel:SetText("Enable chat logging")
		loggingLabel:SetPos(10, 250)
		loggingLabel:SetFont("CombineControl.LabelSmall")
		loggingLabel:SizeToContents()


	local loggingCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		loggingCheck:SetText("")
		loggingCheck:SetPos(160, 250)
		loggingCheck:SetValue(cookie.GetNumber("cc_logging", 1))
		function loggingCheck:OnChange(val)
			cookie.Set("cc_logging", val and 1 or 0)
	end

	local newbieLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		newbieLabel:SetText("Mark me as an inexperienced roleplayer")
		newbieLabel:SetPos(230, 10)
		newbieLabel:SetFont("CombineControl.LabelSmall")
		newbieLabel:SizeToContents()

	local newbieCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		newbieCheck:SetText("")
		newbieCheck:SetPos(470, 10)
		newbieCheck:SetValue(LocalPlayer():NewbieStatus() == NEWBIE_STATUS_NEW)
		function newbieCheck:OnChange(val)
			net.Start("nSetNewbieStatus")
				net.WriteBit(val)
			net.SendToServer()
		end

	local flashLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		flashLabel:SetText("Flash window on chat updates")
		flashLabel:SetPos(230, 40)
		flashLabel:SetFont("CombineControl.LabelSmall")
		flashLabel:SizeToContents()

	local flashCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		flashCheck:SetText("")
		flashCheck:SetPos(470, 40)
		flashCheck:SetValue(cookie.GetNumber("cc_flashwindow", 1))
		function flashCheck:OnChange(val)
			cookie.Set("cc_flashwindow", val and 1 or 0)
		end

	local legacyLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		legacyLabel:SetText("Legacy HUD (EXPERIMENTAL)")
		legacyLabel:SetPos(230, 70)
		legacyLabel:SetFont("CombineControl.LabelSmall")
		legacyLabel:SizeToContents()

	local legacyCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		legacyCheck:SetText("")
		legacyCheck:SetPos(470, 70)
		legacyCheck:SetValue(cookie.GetNumber("cc_legacyhud", 1))
		function legacyCheck:OnChange(val)
			cookie.Set("cc_legacyhud", val and 1 or 0)
		end

	local destroyConfirmLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		destroyConfirmLabel:SetText("Item destruction confirmation")
		destroyConfirmLabel:SetPos(230, 100)
		destroyConfirmLabel:SetFont("CombineControl.LabelSmall")
		destroyConfirmLabel:SizeToContents()

	local destroyConfirmCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		destroyConfirmCheck:SetText("")
		destroyConfirmCheck:SetPos(470, 100)
		destroyConfirmCheck:SetValue(cookie.GetNumber("cc_destroyconfirm", 1))
		function destroyConfirmCheck:OnChange(val)
			cookie.Set("cc_destroyconfirm", val and 1 or 0)
		end

	local escapeMenuCloseLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		escapeMenuCloseLabel:SetText("Escape closes menus")
		escapeMenuCloseLabel:SetPos(230, 130)
		escapeMenuCloseLabel:SetFont("CombineControl.LabelSmall")
		escapeMenuCloseLabel:SizeToContents()

	local escapeMenuCloseCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		escapeMenuCloseCheck:SetText("")
		escapeMenuCloseCheck:SetPos(470, 130)
		escapeMenuCloseCheck:SetValue(cookie.GetNumber("cc_escapemenuclose", 1))
		function escapeMenuCloseCheck:OnChange(val)
			cookie.Set("cc_escapemenuclose", val and 1 or 0)
		end

	local tooltipsLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		tooltipsLabel:SetText("Enable tooltips")
		tooltipsLabel:SetPos(230, 160)
		tooltipsLabel:SetFont("CombineControl.LabelSmall")
		tooltipsLabel:SizeToContents()

	local tooltipsCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		tooltipsCheck:SetText("")
		tooltipsCheck:SetPos(470, 160)
		tooltipsCheck:SetValue(cookie.GetNumber("cc_tooltips", 1))
		function tooltipsCheck:OnChange(val)
			cookie.Set("cc_tooltips", val and 1 or 0)
		end

	local scopelabelLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		scopelabelLabel:SetText("Disable entity labels when scoped")
		scopelabelLabel:SetPos(230, 190)
		scopelabelLabel:SetFont("CombineControl.LabelSmall")
		scopelabelLabel:SizeToContents()

	local scopelabelCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		scopelabelCheck:SetText("")
		scopelabelCheck:SetPos(470, 190)
		scopelabelCheck:SetValue(cookie.GetNumber("cc_noscopelabels", 0))
		function scopelabelCheck:OnChange(val)
			cookie.Set("cc_noscopelabels", val and 1 or 0)
		end

	if GAMEMODE.SteamGroupURL != "" then
		local steamBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			steamBtn:SetFont("CombineControl.LabelSmall")
			steamBtn:SetText("Open Steam Group")
			steamBtn:SetPos(10, 306)
			steamBtn:SetSize(120, 30)
			function steamBtn:DoClick()
				gui.OpenURL(GAMEMODE.SteamGroupURL)
			end
	end

	if GAMEMODE.WebsiteURL != "" then
		local websiteBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			websiteBtn:SetFont("CombineControl.LabelSmall")
			websiteBtn:SetText("Open Website")
			websiteBtn:SetPos(10, 346)
			websiteBtn:SetSize(120, 30)
			function websiteBtn:DoClick()
				gui.OpenURL(GAMEMODE.WebsiteURL)
			end
	end

	local decalBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
		decalBtn:SetFont("CombineControl.LabelSmall")
		decalBtn:SetText("Clear Decals")
		decalBtn:SetPos(10, 386)
		decalBtn:SetSize(120, 30)
		function decalBtn:DoClick()
			RunConsoleCommand("r_cleardecals")
		end

	local ctpBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
		ctpBtn:SetFont("CombineControl.LabelSmall")
		ctpBtn:SetText("Thirdperson Settings")
		ctpBtn:SetPos(140, 346)
		ctpBtn:SetSize(120, 30)
		function ctpBtn:DoClick()
			RunConsoleCommand("ctp_toggle_menu")
		end

	if GAMEMODE.MOTDText != "" then
		local motdBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			motdBtn:SetFont("CombineControl.LabelSmall")
			motdBtn:SetText("Open MOTD")
			motdBtn:SetPos(140, 386)
			motdBtn:SetSize(120, 30)
			function motdBtn:DoClick()
				GAMEMODE:CreateMOTD()
			end
	end

	local donationBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			donationBtn:SetFont("CombineControl.LabelSmall")
			donationBtn:SetText("Donation Panel")
			donationBtn:SetPos(270, 386)
			donationBtn:SetSize(120, 30)
			function donationBtn:DoClick()
				CCP.PlayerMenu:Close()
				GAMEMODE:CreateDonationsMenu()
			end

	if GAMEMODE.IntroCamData then
		local introBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			introBtn:SetFont("CombineControl.LabelSmall")
			introBtn:SetText("Replay Intro")
			introBtn:SetPos(690, 266)
			introBtn:SetSize(100, 30)
			function introBtn:DoClick()
				CCP.PlayerMenu:Remove()
				GAMEMODE:StartIntroCam()
			end
	end

	local resyncBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
		resyncBtn:SetFont("CombineControl.LabelSmall")
		resyncBtn:SetText("Resync Players")
		resyncBtn:SetPos(690, 306)
		resyncBtn:SetSize(100, 30)
		function resyncBtn:DoClick()
			net.Start("nRequestAllPlayerData")
			net.SendToServer()
		end

	local suicideBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
		suicideBtn:SetFont("CombineControl.LabelSmall")
		suicideBtn:SetText("Suicide")
		suicideBtn:SetPos(690, 346)
		suicideBtn:SetSize(100, 30)
		function suicideBtn:DoClick()
			RunConsoleCommand("kill")
		end

	local rejoinBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
		rejoinBtn:SetFont("CombineControl.LabelSmall")
		rejoinBtn:SetText("Rejoin")
		rejoinBtn:SetPos(690, 386)
		rejoinBtn:SetSize(100, 30)
		function rejoinBtn:DoClick()
			RunConsoleCommand("retry")
		end
end
concommand.Add("rp_togglehud", function ()
		local oldValue = cookie.GetNumber("cc_hud", 1)
		cookie.Set("cc_hud", 1 - oldValue)
	end)

function ccToggleThirdPerson(ply, cmd, args)
	cookie.Set("cc_thirdperson", 1 - cookie.GetNumber("cc_thirdperson", 0))

	if CCP.PlayerMenu and CCP.PlayerMenu:IsValid() and thirdPersonCheck and thirdPersonCheck:IsValid() then

		thirdPersonCheck:SetValue(cookie.GetNumber("cc_thirdperson", 0))

	end

	if cookie.GetNumber( "cc_thirdperson", 0 ) == 1 and ply:Alive() then
		ctp:Enable()
	else
		ctp:Disable()
	end
end
concommand.Add("rp_thirdperson", ccToggleThirdPerson)
