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

	function CCP.PlayerMenu.TopBar:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 70)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	CCP.PlayerMenu.TopBar.Buttons = {}

	CCP.PlayerMenu.TopBar.Buttons[1] = vgui.Create("DButton", CCP.PlayerMenu.TopBar)
	CCP.PlayerMenu.TopBar.Buttons[1]:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.TopBar.Buttons[1]:SetText("Description")
	CCP.PlayerMenu.TopBar.Buttons[1]:SetPos(11, 10)
	CCP.PlayerMenu.TopBar.Buttons[1]:SetSize(100, 26)
	CCP.PlayerMenu.TopBar.Buttons[1].DoClick = function(self)
		CCP.PlayerMenu.ContentPane:Clear()

		GAMEMODE:PMCreateBio()
	end

	CCP.PlayerMenu.TopBar.Buttons[1]:PerformLayout()

	CCP.PlayerMenu.TopBar.Buttons[2] = vgui.Create("DButton", CCP.PlayerMenu.TopBar)
	CCP.PlayerMenu.TopBar.Buttons[2]:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.TopBar.Buttons[2]:SetText("Inventory")
	CCP.PlayerMenu.TopBar.Buttons[2]:SetPos(124, 10)
	CCP.PlayerMenu.TopBar.Buttons[2]:SetSize(100, 26)
	CCP.PlayerMenu.TopBar.Buttons[2].DoClick = function(self)
		CCP.PlayerMenu.ContentPane:Clear()

		GAMEMODE:PMCreateInventory()
	end

	CCP.PlayerMenu.TopBar.Buttons[2]:PerformLayout()

	CCP.PlayerMenu.TopBar.Buttons[3] = vgui.Create("DButton", CCP.PlayerMenu.TopBar)
	CCP.PlayerMenu.TopBar.Buttons[3]:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.TopBar.Buttons[3]:SetText("Loans")
	CCP.PlayerMenu.TopBar.Buttons[3]:SetPos(237, 10)
	CCP.PlayerMenu.TopBar.Buttons[3]:SetSize(100, 26)
	CCP.PlayerMenu.TopBar.Buttons[3].DoClick = function(self)
		CCP.PlayerMenu.ContentPane:Clear()

		GAMEMODE:PMCreateLoans()
	end
	CCP.PlayerMenu.TopBar.Buttons[3]:PerformLayout()
	CCP.PlayerMenu.TopBar.Buttons[3]:SetDisabled(LocalPlayer():GetCharFlagAttribute("CanViewLoans"))

	CCP.PlayerMenu.TopBar.Buttons[4] = vgui.Create("DButton", CCP.PlayerMenu.TopBar)
	CCP.PlayerMenu.TopBar.Buttons[4]:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.TopBar.Buttons[4]:SetText("Business")
	CCP.PlayerMenu.TopBar.Buttons[4]:SetPos(350, 10)
	CCP.PlayerMenu.TopBar.Buttons[4]:SetSize(100, 26)
	CCP.PlayerMenu.TopBar.Buttons[4].DoClick = function(self)
		CCP.PlayerMenu.ContentPane:Clear()

		GAMEMODE:PMCreateBusiness()
	end
	CCP.PlayerMenu.TopBar.Buttons[4]:PerformLayout()

	CCP.PlayerMenu.TopBar.Buttons[5] = vgui.Create("DButton", CCP.PlayerMenu.TopBar)
	CCP.PlayerMenu.TopBar.Buttons[5]:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.TopBar.Buttons[5]:SetText("Unused")
	CCP.PlayerMenu.TopBar.Buttons[5]:SetPos(463, 10)
	CCP.PlayerMenu.TopBar.Buttons[5]:SetSize(100, 26)
	CCP.PlayerMenu.TopBar.Buttons[5].DoClick = function(self)
		CCP.PlayerMenu.ContentPane:Clear()
	end

	CCP.PlayerMenu.TopBar.Buttons[5]:PerformLayout()
	CCP.PlayerMenu.TopBar.Buttons[5]:SetDisabled(true)

	CCP.PlayerMenu.TopBar.Buttons[6] = vgui.Create("DButton", CCP.PlayerMenu.TopBar)
	CCP.PlayerMenu.TopBar.Buttons[6]:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.TopBar.Buttons[6]:SetText("Faction")
	CCP.PlayerMenu.TopBar.Buttons[6]:SetPos(576, 10)
	CCP.PlayerMenu.TopBar.Buttons[6]:SetSize(100, 26)
	CCP.PlayerMenu.TopBar.Buttons[6].DoClick = function(self)
		CCP.PlayerMenu.ContentPane:Clear()

		GAMEMODE:PMCreateFaction()
	end

	CCP.PlayerMenu.TopBar.Buttons[6]:PerformLayout()

	CCP.PlayerMenu.TopBar.Buttons[7] = vgui.Create("DButton", CCP.PlayerMenu.TopBar)
	CCP.PlayerMenu.TopBar.Buttons[7]:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.TopBar.Buttons[7]:SetText("Settings")
	CCP.PlayerMenu.TopBar.Buttons[7]:SetPos(689, 10)
	CCP.PlayerMenu.TopBar.Buttons[7]:SetSize(100, 26)
	CCP.PlayerMenu.TopBar.Buttons[7].DoClick = function(self)
		CCP.PlayerMenu.ContentPane:Clear()

		GAMEMODE:PMCreateSettings()
	end

	CCP.PlayerMenu.TopBar.Buttons[7]:PerformLayout()

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

				if CCP.PlayerMenu.CharacterName then

					CCP.PlayerMenu.CharacterName:SetText(val)

				end

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

function GM:PMCreateStats()
	CCP.PlayerMenu.Stats = vgui.Create("DFrame")
	CCP.PlayerMenu.Stats:SetSize(308, 184)
	CCP.PlayerMenu.Stats:Center()
	CCP.PlayerMenu.Stats:SetTitle("Stats")
	CCP.PlayerMenu.Stats.lblTitle:SetFont("CombineControl.Window")
	CCP.PlayerMenu.Stats:MakePopup()
	CCP.PlayerMenu.Stats.PerformLayout = CCFramePerformLayout
	CCP.PlayerMenu.Stats:PerformLayout()

	CCP.PlayerMenu.Stats.Think = UIAutoClose

	local y = 0

	for _, v in pairs(self.Stats) do
		local label = vgui.Create("DLabel", CCP.PlayerMenu.Stats)
		label:SetText(v)
		label:SetPos(16, 35 + y)
		label:SetFont("CombineControl.LabelMedium")
		label:SizeToContents()
		label:PerformLayout()

		local stat = LocalPlayer()[v](LocalPlayer())

		local bar = vgui.Create("CCProgressBar", CCP.PlayerMenu.Stats)
		bar:SetPos(115, 35 + y)
		bar:SetSize(178, 16)
		bar:SetProgress(stat / self.MaxStats)
		bar:SetProgressText(stat .. "/" .. self.MaxStats)

		y = y + 30
	end
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

	compound.SetupModelPanel(CCP.PlayerMenu.CharacterModel, LocalPlayer())

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

	CCP.PlayerMenu.CharacterStats = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.CharacterStats:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.CharacterStats:SetText("Stats")
	CCP.PlayerMenu.CharacterStats:SetPos(710, 366)
	CCP.PlayerMenu.CharacterStats:SetSize(80, 20)
	function CCP.PlayerMenu.CharacterStats:DoClick()

		GAMEMODE:PMCreateStats()

	end
	CCP.PlayerMenu.CharacterStats:PerformLayout()

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
	CCP.PlayerMenu.InvTitle:SetSize(CCP.PlayerMenu.ContentPane:GetWide() - 430 - 110, 22)
	CCP.PlayerMenu.InvTitle:PerformLayout()

	CCP.PlayerMenu.InvWeight = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.InvWeight:SetText("")
	CCP.PlayerMenu.InvWeight:SetPos(420, CCP.PlayerMenu.ContentPane:GetTall() - 30)
	CCP.PlayerMenu.InvWeight:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.InvWeight:SetSize(CCP.PlayerMenu.ContentPane:GetWide() - 430 - 110, 22)
	CCP.PlayerMenu.InvWeight:PerformLayout()

	CCP.PlayerMenu.InvDesc = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
	CCP.PlayerMenu.InvDesc:SetText("No item selected.")
	CCP.PlayerMenu.InvDesc:SetPos(420, 250)
	CCP.PlayerMenu.InvDesc:SetFont("CombineControl.LabelSmall")
	CCP.PlayerMenu.InvDesc:SetSize(CCP.PlayerMenu.ContentPane:GetWide() - 430 - 110, 14)
	CCP.PlayerMenu.InvDesc:SetAutoStretchVertical(true)
	CCP.PlayerMenu.InvDesc:SetWrap(true)
	CCP.PlayerMenu.InvDesc:PerformLayout()

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

	for _, i in SortedPairs(LocalPlayer().Inventory) do
		local icon = i:CreateInventoryIcon(INVTYPE_SELF)

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

			if not item then
				GAMEMODE:PMResetText()

				return
			end

			item:ConfigureModelPanel(ui.InvModel)
			ui.InvModel:SetFOV(ui.InvModel:GetFOV() * 1.8)

			ui.InvTitle:SetText(item:GetName())
			ui.InvWeight:SetText("Weight: " .. item:GetWeight())
			ui.InvDesc:SetText(item:GetProperty("Description"))

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

			local options = item:GetInventoryOptions(LocalPlayer())

			if IsValid(ui.ButOptions) then
				ui.ButOptions:Remove()
			end

			ui.ButOptions = vgui.Create("DComboBox", ui.ContentPane)

			ui.ButOptions:SetFont("CombineControl.LabelSmall")
			ui.ButOptions:SetPos(ui.ContentPane:GetWide() - 110, ui.ContentPane:GetTall() - 30 + y2)
			ui.ButOptions:SetSize(100, 20)
			ui.ButOptions:SetValue("Actions")
			ui.ButOptions:SetSortItems(false)
			ui.ButOptions:SetDisabled(table.Count(options) < 1)

			table.insert(ui.InvButtons, ui.ButOptions)

			for k, v in ipairs(options) do
				ui.ButOptions:AddChoice(v.Name, {id = k, option = v})
			end

			function ui.ButOptions:OnSelect(index, name, data)
				local option = data.option

				local function func()
					option.Func(item, LocalPlayer())

					net.Start("nUseItem")
						net.WriteInt(item.ID, 32)
						net.WriteInt(data.id, 8)
					net.SendToServer()
				end

				if option.Delay then
					local id

					if IsValid(CCP.PlayerMenu) then
						id = CCP.PlayerMenu.SelectedItem
					end

					GAMEMODE:CreateTimedProgressBar(option.Delay, option.DelayName, LocalPlayer(), function()
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

				ui.ButOptions:SetValue("Actions")
			end
		end

	end

	if ui.SelectedItem then
		local reset = true
		local id = ui.SelectedItem

		if LocalPlayer().Inventory[id] then
			reset = false

			for _, v in pairs(ui.InvScroll:GetCanvas():GetChildren()) do
				if v.ID == id then
					v:DoClick()

					break
				end
			end
		end

		if reset then
			self:PMResetText()
		end
	end

	ui.InvWeightBar:SetProgress(LocalPlayer():InventoryWeight() / LocalPlayer():InventoryMaxWeight())
	ui.InvWeightBar:SetProgressText("Weight: " .. LocalPlayer():InventoryWeight() .. "/" .. LocalPlayer():InventoryMaxWeight())
end

function GM:PMCreateLoans()
	local label = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		label:SetText("Loan Amount")
		label:SetPos(10, 10)
		label:SetSize(550, 14)
		label:SetFont("CombineControl.LabelSmall")
		label:PerformLayout()
	CCP.PlayerMenu.LoansLabel = label

	local amountLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		amountLabel:SetPos(150, 10)
		amountLabel:SetSize(550, 14)
		amountLabel:SetFont("CombineControl.LabelSmall")
		amountLabel:SetTextColor(Color(200, 200, 200, 255))

		function amountLabel:Update(loan)
			amountLabel:SetText(util.FormatCurrency(loan))
			amountLabel:PerformLayout()
		end

		amountLabel:Update(LocalPlayer():Loan())

	CCP.PlayerMenu.LoansLabelAmt = amountLabel

	local takeButton = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
		takeButton:SetFont("CombineControl.LabelSmall")
		takeButton:SetText("Take Loan")
		takeButton:SetPos(10, 40)
		takeButton:SetSize(200, 20)

		function takeButton:DoClick()
			GAMEMODE:PMCreateTakeLoan()
		end

		takeButton:PerformLayout()
	CCP.PlayerMenu.LoanTakeBut = takeButton

	local giveButton = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
		giveButton:SetFont("CombineControl.LabelSmall")
		giveButton:SetText("Repay Loan")
		giveButton:SetPos(10, 70)
		giveButton:SetSize(200, 20)

		function giveButton:DoClick()
			GAMEMODE:PMCreateGiveLoan()
		end

		giveButton:PerformLayout()

	CCP.PlayerMenu.LoanGiveBut = giveButton

	local guide = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		guide:SetText("Loans are a great way to get some starting capital. You can take out up to " .. util.FormatCurrency(GAMEMODE.MaxLoan) .. ".\nHowever, not paying back your loan may get you into trouble...\n\n\nAlso, you cannot delete any character with a loan out, to prevent abuse.")
		guide:SetPos(10, 344)
		guide:SetSize(780, 14)
		guide:SetFont("CombineControl.LabelSmall")
		guide:PerformLayout()
		guide:SetWrap(true)
		guide:SetAutoStretchVertical(true)

	CCP.PlayerMenu.LoansGuide = guide
end

function GM:PMCreateTakeLoan()
	if CCP.PlayerMenu.LoanTake and CCP.PlayerMenu.LoanTake:IsValid() then
		CCP.PlayerMenu.LoanTake:Remove()
	end

	local frame = vgui.Create("DFrame")
		frame:SetSize(180, 80)
		frame:Center()
		frame:SetTitle("Take Loan")
		frame.lblTitle:SetFont("CombineControl.Window")
		frame:MakePopup()
		frame.PerformLayout = CCFramePerformLayout
		frame:PerformLayout()

		frame.Think = UIAutoClose
	CCP.PlayerMenu.LoanTake = frame

	local input = vgui.Create("DTextEntry", frame)
		input:SetFont("CombineControl.LabelBig")
		input:SetPos(10, 34)
		input:SetSize(100, 30)
		input:PerformLayout()
		input:RequestFocus()
		input:SetNumeric(true)
		input:SetCaretPos(#input:GetValue())
	frame.Entry = input

	local ok = vgui.Create("DButton", frame)
		ok:SetFont("CombineControl.LabelSmall")
		ok:SetText("OK")
		ok:SetPos(120, 34)
		ok:SetSize(50, 30)
		ok:PerformLayout()

		function ok:DoClick()
			local amt = math.Round(tonumber(input:GetValue()) or 0)

			if amt < 1 then
				frame:Remove()
			end

			if LocalPlayer():Loan() + amt > GAMEMODE.MaxLoan then
				GAMEMODE:AddChat("You can't take out this large of a loan!", Color(200, 0, 0, 255))
				return
			end

			CCP.PlayerMenu.LoansLabelAmt:Update(LocalPlayer():Loan() + amt)

			frame:Remove()

			net.Start("nTakeLoan")
				net.WriteUInt(amt, 10)
			net.SendToServer()
		end

		input.OnEnter = ok.DoClick

	frame.OK = ok
end

function GM:PMCreateGiveLoan()
	if CCP.PlayerMenu.LoanGive and CCP.PlayerMenu.LoanGive:IsValid() then
		CCP.PlayerMenu.LoanGive:Remove()
	end

	local frame = vgui.Create("DFrame")
		frame:SetSize(180, 80)
		frame:Center()
		frame:SetTitle("Repay Loan")
		frame.lblTitle:SetFont("CombineControl.Window")
		frame:MakePopup()
		frame.PerformLayout = CCFramePerformLayout
		frame:PerformLayout()

		frame.Think = UIAutoClose
	CCP.PlayerMenu.LoanGive = frame

	local input = vgui.Create("DTextEntry", frame)
		input:SetFont("CombineControl.LabelBig")
		input:SetPos(10, 34)
		input:SetSize(100, 30)
		input:PerformLayout()
		input:RequestFocus()
		input:SetNumeric(true)
		input:SetCaretPos(#input:GetValue())
	frame.Entry = input

	local ok = vgui.Create("DButton", frame)
		ok:SetFont("CombineControl.LabelSmall")
		ok:SetText("OK")
		ok:SetPos(120, 34)
		ok:SetSize(50, 30)
		ok:PerformLayout()

		function ok:DoClick()
			local amt = math.Round(tonumber(input:GetValue()) or 0)
			if amt < 1 then
				frame:Remove()
			end

			local loan, money = LocalPlayer():Loan(), LocalPlayer():Money()

			if amt > money then
				GAMEMODE:AddChat("You don't have enough money to pay back this loan!", Color(200, 0, 0, 255))
				return
			elseif amt > loan then
				amt = loan
			end

			loan = loan - amt

			CCP.PlayerMenu.LoansLabelAmt:Update(loan)

			frame:Remove()

			net.Start("nGiveLoan")
				net.WriteUInt(amt, 10)
			net.SendToServer()
		end

		input.OnEnter = ok.DoClick

	frame.OK = ok
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

function GM:PMCreateLoansList()
	if not LocalPlayer():GetCharFlagAttribute("CanViewLoans") then
		return
	end

	CCP.Loans = vgui.Create("DFrame")
	CCP.Loans:SetSize(800, 450)
	CCP.Loans:Center()
	CCP.Loans:SetTitle("Loans")
	CCP.Loans.lblTitle:SetFont("CombineControl.Window")
	CCP.Loans:MakePopup()
	CCP.Loans.PerformLayout = CCFramePerformLayout
	CCP.Loans:PerformLayout()

	CCP.Loans.Think = UIAutoClose

	CCP.Loans.List = vgui.Create("DListView", CCP.Loans)
	CCP.Loans.List:SetPos(10, 34)
	CCP.Loans.List:SetSize(780, 400 - 34)
	CCP.Loans.List:AddColumn("CID")
	CCP.Loans.List:AddColumn("Name")
	CCP.Loans.List:AddColumn("Amount Owing")

	function CCP.Loans.List:OnRowSelected(id, line)
		if not ply:GetCharFlagAttribute("CanEditLoans") then return end

		CCP.Loans.EditLoan:SetDisabled(false)
		CCP.Loans.SelectedPlayer = line.Player
	end

	for _, v in pairs(player.GetAll()) do
		if v:Loan() > 0 and v != LocalPlayer() then
			CCP.Loans.List:AddLine(v:FormattedCID(), v:VisibleRPName(), util.FormatCurrency(v:Loan())).Player = v
		end
	end

	CCP.Loans.EditLoan = vgui.Create("DButton", CCP.Loans)
	CCP.Loans.EditLoan:SetFont("CombineControl.LabelSmall")
	CCP.Loans.EditLoan:SetText("Edit Loan")
	CCP.Loans.EditLoan:SetPos(10, 410)
	CCP.Loans.EditLoan:SetSize(100, 30)

	function CCP.Loans.EditLoan:DoClick()
		GAMEMODE:PMCreateEditLoan()
	end

	CCP.Loans.EditLoan:SetDisabled(true)
	CCP.Loans.EditLoan:PerformLayout()
end

function GM:PMCreateEditLoan()
	if not ply:GetCharFlagAttribute("CanEditLoans") then return end

	if IsValid(CCP.Loans.Loan) then
		CCP.Loans.Loan:Remove()
	end

	if IsValid(CCP.Loans.SelectedPlayer) then
		CCP.Loans.Loan = vgui.Create("DFrame")
		CCP.Loans.Loan:SetSize(180, 80)
		CCP.Loans.Loan:Center()
		CCP.Loans.Loan:SetTitle("Deduct Loan")
		CCP.Loans.Loan.lblTitle:SetFont("CombineControl.Window")
		CCP.Loans.Loan:MakePopup()
		CCP.Loans.Loan.PerformLayout = CCFramePerformLayout
		CCP.Loans.Loan:PerformLayout()
		CCP.Loans.Loan.Player = CCP.Loans.SelectedPlayer

		CCP.Loans.Loan.Think = UIAutoClose

		CCP.Loans.Loan.Entry = vgui.Create("DTextEntry", CCP.Loans.Loan)
		CCP.Loans.Loan.Entry:SetFont("CombineControl.LabelBig")
		CCP.Loans.Loan.Entry:SetPos(10, 34)
		CCP.Loans.Loan.Entry:SetSize(100, 30)
		CCP.Loans.Loan.Entry:PerformLayout()
		CCP.Loans.Loan.Entry:RequestFocus()
		CCP.Loans.Loan.Entry:SetNumeric(true)
		CCP.Loans.Loan.Entry:SetCaretPos(#CCP.Loans.Loan.Entry:GetValue())

		CCP.Loans.Loan.OK = vgui.Create("DButton", CCP.Loans.Loan)
		CCP.Loans.Loan.OK:SetFont("CombineControl.LabelSmall")
		CCP.Loans.Loan.OK:SetText("OK")
		CCP.Loans.Loan.OK:SetPos(120, 34)
		CCP.Loans.Loan.OK:SetSize(50, 30)

		function CCP.Loans.Loan.OK:DoClick()
			local ply = CCP.Loans.Loan.Player

			if not IsValid(ply) then
				CCP.Loans.Loan:Remove()

				return
			end

			local val = math.Round(tonumber(CCP.Loans.Loan.Entry:GetValue())) or 0

			if val < 1 then
				CCP.Loans.Loan:Remove()

				return
			end

			local loan = ply:Loan()

			if loan - val >= 0 then
				CCP.Loans.Loan:Remove()

				if IsValid(CCP.Loans.List) then
					CCP.Loans.List:Clear()

					for _, v in pairs(player.GetAll()) do
						local loan = v:Loan()

						if v == CCP.Loans.Loan.Player then
							loan = loan - val

							if loan <= 0 then
								if CCP.Loans and CCP.Loans.EditLoan then
									CCP.Loans.EditLoan:SetDisabled(true)
								end
							end
						end

						if loan > 0 then
							CCP.Loans.List:AddLine(v:FormattedCID(), v:VisibleRPName(), util.FormatCurrency(loan)).Player = v
						end
					end
				end

				net.Start("nDeductLoan")
					net.WriteEntity(ply)
					net.WriteFloat(val)
				net.SendToServer()
			else
				GAMEMODE:AddChat("They don't have that large a loan.", Color(200, 0, 0, 255))
			end
		end

		CCP.Loans.Loan.OK:PerformLayout()
		CCP.Loans.Loan.Entry.OnEnter = CCP.Loans.Loan.OK.DoClick
	end
end

net.Receive("nLoanDeducted", function(len)
	local ply = net.ReadEntity()
	local amt = net.ReadFloat()

	GAMEMODE:AddChat(ply:VisibleRPName() .. " reduced your loan by " .. util.FormatCurrency(amt) .. ".", Color(200, 200, 200, 255))
end)

function GM:PMCreateCombineRecords()
	CCP.CombineRecords = vgui.Create("DFrame")
	CCP.CombineRecords:SetSize(490, 480)
	CCP.CombineRecords:Center()
	CCP.CombineRecords:SetTitle("Criminal Records")
	CCP.CombineRecords.lblTitle:SetFont("CombineControl.Window")
	CCP.CombineRecords:MakePopup()
	CCP.CombineRecords.PerformLayout = CCFramePerformLayout
	CCP.CombineRecords:PerformLayout()

	CCP.CombineRecords.Think = UIAutoClose

	CCP.CombineRecords.Records = vgui.Create("DListView", CCP.CombineRecords)
	CCP.CombineRecords.Records:SetPos(10, 34)
	CCP.CombineRecords.Records:SetSize(470, 406)
	CCP.CombineRecords.Records:AddColumn("CID")
	CCP.CombineRecords.Records:AddColumn("Citizen Name")

	function CCP.CombineRecords.Records:OnRowSelected(id, line)

		CCP.CombineRecords.ViewRecord:SetDisabled(false)
		CCP.CombineRecords.EditRecord:SetDisabled(false)

	end

	for k, v in pairs(player.GetAll()) do
		CCP.CombineRecords.Records:AddLine(v:FormattedCID(), v:VisibleRPName()).Player = v
	end

	CCP.CombineRecords.ViewRecord = vgui.Create("DButton", CCP.CombineRecords)
	CCP.CombineRecords.ViewRecord:SetFont("CombineControl.LabelSmall")
	CCP.CombineRecords.ViewRecord:SetText("View Record")
	CCP.CombineRecords.ViewRecord:SetPos(10, 450)
	CCP.CombineRecords.ViewRecord:SetSize(100, 20)
	function CCP.CombineRecords.ViewRecord:DoClick()

		if CCP.CombineRecords.Records:GetSelected()[1] and CCP.CombineRecords.Records:GetSelected()[1].Player and CCP.CombineRecords.Records:GetSelected()[1].Player:IsValid() then

			if CCP.CriminalRecord and CCP.CriminalRecord:IsValid() then

				CCP.CriminalRecord:Remove()

			end

			CCP.CriminalRecord = vgui.Create("DFrame")
			CCP.CriminalRecord:SetSize(490, 250)
			CCP.CriminalRecord:Center()
			CCP.CriminalRecord:SetTitle(CCP.CombineRecords.Records:GetSelected()[1].Player:VisibleRPName())
			CCP.CriminalRecord.lblTitle:SetFont("CombineControl.Window")
			CCP.CriminalRecord:MakePopup()
			CCP.CriminalRecord.PerformLayout = CCFramePerformLayout
			CCP.CriminalRecord:PerformLayout()

			CCP.CriminalRecord.Think = UIAutoClose

			CCP.CriminalRecord.Pane = vgui.Create("DScrollPanel", CCP.CriminalRecord)
			CCP.CriminalRecord.Pane:SetSize(470, 206)
			CCP.CriminalRecord.Pane:SetPos(10, 34)
			function CCP.CriminalRecord.Pane:Paint(w, h) end

			local text = vgui.Create("DLabel")
			text:SetText(CCP.CombineRecords.Records:GetSelected()[1].Player:CriminalRecord())
			text:SetPos(0, 0)
			text:SetSize(470, 14)
			text:SetFont("CombineControl.LabelSmall")
			text:PerformLayout()
			text:SetWrap(true)
			text:SetAutoStretchVertical(true)

			CCP.CriminalRecord.Pane:Add(text)

		end

	end
	CCP.CombineRecords.ViewRecord:PerformLayout()
	CCP.CombineRecords.ViewRecord:SetDisabled(true)

	CCP.CombineRecords.EditRecord = vgui.Create("DButton", CCP.CombineRecords)
	CCP.CombineRecords.EditRecord:SetFont("CombineControl.LabelSmall")
	CCP.CombineRecords.EditRecord:SetText("Edit Record")
	CCP.CombineRecords.EditRecord:SetPos(120, 450)
	CCP.CombineRecords.EditRecord:SetSize(100, 20)
	function CCP.CombineRecords.EditRecord:DoClick()

		if CCP.CombineRecords.Records:GetSelected()[1] and CCP.CombineRecords.Records:GetSelected()[1].Player and CCP.CombineRecords.Records:GetSelected()[1].Player:IsValid() then

			if CCP.CriminalRecord and CCP.CriminalRecord:IsValid() then

				CCP.CriminalRecord:Remove()

			end

			CCP.CriminalRecord = vgui.Create("DFrame")
			CCP.CriminalRecord:SetSize(490, 280)
			CCP.CriminalRecord:Center()
			CCP.CriminalRecord:SetTitle(CCP.CombineRecords.Records:GetSelected()[1].Player:VisibleRPName())
			CCP.CriminalRecord.lblTitle:SetFont("CombineControl.Window")
			CCP.CriminalRecord:MakePopup()
			CCP.CriminalRecord.PerformLayout = CCFramePerformLayout
			CCP.CriminalRecord:PerformLayout()

			CCP.CriminalRecord.Think = UIAutoClose

			CCP.CriminalRecord.Entry = vgui.Create("DTextEntry", CCP.CriminalRecord)
			CCP.CriminalRecord.Entry:SetValue(CCP.CombineRecords.Records:GetSelected()[1].Player:CriminalRecord())
			CCP.CriminalRecord.Entry:SetFont("CombineControl.LabelSmall")
			CCP.CriminalRecord.Entry:SetPos(10, 34)
			CCP.CriminalRecord.Entry:SetSize(470, 206)
			CCP.CriminalRecord.Entry:SetMultiline(true)
			CCP.CriminalRecord.Entry:PerformLayout()
			CCP.CriminalRecord.Entry:RequestFocus()
			CCP.CriminalRecord.Entry:SetCaretPos(#CCP.CriminalRecord.Entry:GetValue())

			CCP.CriminalRecord.OK = vgui.Create("DButton", CCP.CriminalRecord)
			CCP.CriminalRecord.OK:SetFont("CombineControl.LabelSmall")
			CCP.CriminalRecord.OK:SetText("OK")
			CCP.CriminalRecord.OK:SetPos(360, 250)
			CCP.CriminalRecord.OK:SetSize(100, 20)
			CCP.CriminalRecord.OK.Player = CCP.CombineRecords.Records:GetSelected()[1].Player
			function CCP.CriminalRecord.OK:DoClick()

				if not self.Player or not self.Player:IsValid() then return end

				local val = CCP.CriminalRecord.Entry:GetValue()

				CCP.CriminalRecord:Remove()

				net.Start("nUpdateRecord")
					net.WriteString(string.sub(val, 1, 1024))
					net.WriteEntity(self.Player)
				net.SendToServer()

			end
			CCP.CriminalRecord.OK:PerformLayout()

		end

	end
	CCP.CombineRecords.EditRecord:PerformLayout()
	CCP.CombineRecords.EditRecord:SetDisabled(true)
end

function GM:PMUpdatePrison()
	if not IsValid(CCP.Prison) then return end

	for _, v in pairs(CCP.Prison.Prisoners:GetLines()) do
		local d = math.max(math.ceil(v.Player:PrisonReleaseTime() - CurTime()), 0)
		local column = v:SetColumnText(2, string.ToMinutesSeconds(d))

		if d <= 0 then
			column:SetTextColor(Color(200, 0, 0, 255))
		else
			column:SetTextColor(Color(200, 200, 200, 255))
		end
	end
end

function GM:PMCreatePrison()
	CCP.Prison = vgui.Create("DFrame")
	CCP.Prison:SetSize(600, 504)
	CCP.Prison:Center()
	CCP.Prison:SetTitle("Prison Management")
	CCP.Prison.lblTitle:SetFont("CombineControl.Window")
	CCP.Prison:MakePopup()
	CCP.Prison.PerformLayout = CCFramePerformLayout
	CCP.Prison:PerformLayout()

	CCP.Prison.Think = UIAutoClose

	CCP.Prison.AllPlayers = vgui.Create("DListView", CCP.Prison)
	CCP.Prison.AllPlayers:SetPos(10, 34)
	CCP.Prison.AllPlayers:SetSize(200, 430)
	CCP.Prison.AllPlayers:AddColumn("Citizen")

	function CCP.Prison.AllPlayers:DoDoubleClick(id, line)
		CCP.Prison.Imprison:DoClick()
	end

	for k, v in pairs(player.GetAll()) do
		if v:PrisonReleaseTime() == 0 then
			CCP.Prison.AllPlayers:AddLine(v:VisibleRPName()).Player = v
		end
	end

	CCP.Prison.Prisoners = vgui.Create("DListView", CCP.Prison)
	CCP.Prison.Prisoners:SetPos(220, 34)
	CCP.Prison.Prisoners:SetSize(370, 430)
	CCP.Prison.Prisoners:AddColumn("Prisoner")
	CCP.Prison.Prisoners:AddColumn("Time Remaining")
	CCP.Prison.Prisoners:AddColumn("Reason")
	CCP.Prison.Prisoners:AddColumn("Arresting Officer")

	function CCP.Prison.Prisoners:DoDoubleClick(id, line)
		CCP.Prison.Release:DoClick()
	end

	for k, v in pairs(player.GetAll()) do
		if v:PrisonReleaseTime() > 0 then
			CCP.Prison.Prisoners:AddLine(v:VisibleRPName(), string.ToMinutesSeconds(math.max(v:PrisonReleaseTime() - CurTime(), 0)), v:PrisonReason(), v:Arrester()).Player = v
		end
	end

	CCP.Prison.Imprison = vgui.Create("DButton", CCP.Prison)
	CCP.Prison.Imprison:SetFont("CombineControl.LabelSmall")
	CCP.Prison.Imprison:SetText(">")
	CCP.Prison.Imprison:SetPos(10, 474)
	CCP.Prison.Imprison:SetSize(200, 20)

	function CCP.Prison.Imprison:DoClick()
		if not CCP.Prison.AllPlayers:GetSelected()[1] then return end

		local ply = CCP.Prison.AllPlayers:GetSelected()[1].Player

		if IsValid(ply) then
			CCP.Prison.JailPlayer = vgui.Create("DFrame")
			CCP.Prison.JailPlayer:SetSize(250, 154)
			CCP.Prison.JailPlayer:Center()
			CCP.Prison.JailPlayer:SetTitle("Imprison Citizen")
			CCP.Prison.JailPlayer.lblTitle:SetFont("CombineControl.Window")
			CCP.Prison.JailPlayer:MakePopup()
			CCP.Prison.JailPlayer.PerformLayout = CCFramePerformLayout
			CCP.Prison.JailPlayer:PerformLayout()

			CCP.Prison.JailPlayer.Think = UIAutoClose

			CCP.Prison.JailPlayer.Entry = vgui.Create("DTextEntry", CCP.Prison.JailPlayer)
			CCP.Prison.JailPlayer.Entry:SetFont("CombineControl.LabelBig")
			CCP.Prison.JailPlayer.Entry:SetPos(10, 34)
			CCP.Prison.JailPlayer.Entry:SetSize(100, 30)
			CCP.Prison.JailPlayer.Entry:PerformLayout()
			CCP.Prison.JailPlayer.Entry:RequestFocus()
			CCP.Prison.JailPlayer.Entry:SetNumeric(true)
			CCP.Prison.JailPlayer.Entry:SetCaretPos(#CCP.Prison.JailPlayer.Entry:GetValue())

			CCP.Prison.JailPlayer.Label = vgui.Create("DLabel", CCP.Prison.JailPlayer)
			CCP.Prison.JailPlayer.Label:SetText("minutes (1-10)")
			CCP.Prison.JailPlayer.Label:SetPos(120, 34)
			CCP.Prison.JailPlayer.Label:SetSize(130, 30)
			CCP.Prison.JailPlayer.Label:SetFont("CombineControl.LabelBig")
			CCP.Prison.JailPlayer.Label:PerformLayout()

			CCP.Prison.JailPlayer.Entry2 = vgui.Create("DTextEntry", CCP.Prison.JailPlayer)
			CCP.Prison.JailPlayer.Entry2:SetFont("CombineControl.LabelBig")
			CCP.Prison.JailPlayer.Entry2:SetPos(70, 74)
			CCP.Prison.JailPlayer.Entry2:SetSize(170, 30)
			CCP.Prison.JailPlayer.Entry2:PerformLayout()
			CCP.Prison.JailPlayer.Entry2:SetCaretPos(#CCP.Prison.JailPlayer.Entry:GetValue())

			CCP.Prison.JailPlayer.Label2 = vgui.Create("DLabel", CCP.Prison.JailPlayer)
			CCP.Prison.JailPlayer.Label2:SetText("Reason:")
			CCP.Prison.JailPlayer.Label2:SetPos(10, 74)
			CCP.Prison.JailPlayer.Label2:SetSize(130, 30)
			CCP.Prison.JailPlayer.Label2:SetFont("CombineControl.LabelBig")
			CCP.Prison.JailPlayer.Label2:PerformLayout()

			CCP.Prison.JailPlayer.OK = vgui.Create("DButton", CCP.Prison.JailPlayer)
			CCP.Prison.JailPlayer.OK:SetFont("CombineControl.LabelSmall")
			CCP.Prison.JailPlayer.OK:SetText("OK")
			CCP.Prison.JailPlayer.OK:SetPos(190, 114)
			CCP.Prison.JailPlayer.OK:SetSize(50, 30)

			function CCP.Prison.JailPlayer.OK:DoClick()
				if not IsValid(ply) then
					CCP.Prison.JailPlayer:Remove()

					return
				end

				local val = tonumber(CCP.Prison.JailPlayer.Entry:GetValue())

				if not val or val < 1 or val > 10 then
					CCP.Prison.JailPlayer:Remove()

					return
				end

				local val2 = CCP.Prison.JailPlayer.Entry2:GetValue()

				if #val2 > 100 then
					CCP.Prison.JailPlayer:Remove()

					return
				end

				CCP.Prison.JailPlayer:Remove()

				net.Start("nAddPrison")
					net.WriteEntity(ply)
					net.WriteFloat(val)
					net.WriteString(val2)
				net.SendToServer()

				if CCP.Prison and CCP.Prison:IsValid() then
					CCP.Prison.AllPlayers:RemoveLine(CCP.Prison.AllPlayers:GetSelected()[1]:GetID())

					local line = CCP.Prison.Prisoners:AddLine(ply:VisibleRPName(), string.ToMinutesSeconds(val * 60), val2, LocalPlayer():VisibleRPName())
					line.Player = ply
				end

			end
			CCP.Prison.JailPlayer.OK:PerformLayout()

			CCP.Prison.JailPlayer.Entry.OnEnter = CCP.Prison.JailPlayer.OK.DoClick
			CCP.Prison.JailPlayer.Entry2.OnEnter = CCP.Prison.JailPlayer.OK.DoClick
		end
	end

	CCP.Prison.Imprison:PerformLayout()

	CCP.Prison.Release = vgui.Create("DButton", CCP.Prison)
	CCP.Prison.Release:SetFont("CombineControl.LabelSmall")
	CCP.Prison.Release:SetText("<")
	CCP.Prison.Release:SetPos(220, 474)
	CCP.Prison.Release:SetSize(370, 20)

	function CCP.Prison.Release:DoClick()
		if not CCP.Prison.Prisoners:GetSelected()[1] then return end

		local ply = CCP.Prison.Prisoners:GetSelected()[1].Player

		if IsValid(ply) then
			net.Start("nRemovePrison")
				net.WriteEntity(ply)
			net.SendToServer()

			CCP.Prison.Prisoners:RemoveLine(CCP.Prison.Prisoners:GetSelected()[1]:GetID())
			CCP.Prison.AllPlayers:AddLine(ply:VisibleRPName()).Player = ply
		end
	end

	CCP.Prison.Release:PerformLayout()
end

function GM:PMCreateCombineSurveillance()
	CCP.CombineSurveillance = vgui.Create("DFrame")
	CCP.CombineSurveillance:SetSize(690, 500)
	CCP.CombineSurveillance:Center()
	CCP.CombineSurveillance:SetTitle("Local Camera Feeds")
	CCP.CombineSurveillance.lblTitle:SetFont("CombineControl.Window")
	CCP.CombineSurveillance:MakePopup()
	CCP.CombineSurveillance.PerformLayout = CCFramePerformLayout
	CCP.CombineSurveillance:PerformLayout()

	CCP.CombineSurveillance.Think = UIAutoClose

	CCP.CombineSurveillance.List = vgui.Create("DListView", CCP.CombineSurveillance)
	CCP.CombineSurveillance.List:SetPos(10, 34)
	CCP.CombineSurveillance.List:SetSize(670, 406)
	CCP.CombineSurveillance.List:AddColumn("Coordinates")
	CCP.CombineSurveillance.List:AddColumn("Camera ID")

	function CCP.CombineSurveillance.List:OnRowSelected(id, line)

		CCP.CombineSurveillance.SelectedID = id
		CCP.CombineSurveillance.ViewBut:SetDisabled(false)

	end

	for _, v in pairs(ents.FindByClass("npc_combine_camera")) do
		if v:Health() < 1 then
			continue
		end

		local pos = v:GetPos()
		pos.x = math.floor(pos.x)
		pos.y = math.floor(pos.y)
		pos.z = math.floor(pos.z)
		local line = CCP.CombineSurveillance.List:AddLine(pos.x .. ", " .. pos.y .. ", " .. pos.z, #v:GetNWString("camname") > 0 and v:GetNWString("camname") or v:EntIndex())

		line.Ent = v

	end

	for _, v in pairs(ents.FindByClass("npc_cscanner")) do

		local pos = v:GetPos()
		pos.x = math.floor(pos.x)
		pos.y = math.floor(pos.y)
		pos.z = math.floor(pos.z)
		local line = CCP.CombineSurveillance.List:AddLine(pos.x .. ", " .. pos.y .. ", " .. pos.z, v:EntIndex())

		line.Ent = v

	end

	for _, v in pairs(player.GetAll()) do
		if not v:HasCharFlag("C") then
			continue
		end

		local pos = v:GetPos()
		pos.x = math.floor(pos.x)
		pos.y = math.floor(pos.y)
		pos.z = math.floor(pos.z)

		local line = CCP.CombineSurveillance.List:AddLine(pos.x .. ", " .. pos.y .. ", " .. pos.z, v:VisibleRPName())

		line.Ent = v
	end

	CCP.CombineSurveillance.ViewBut = vgui.Create("DButton", CCP.CombineSurveillance)
	CCP.CombineSurveillance.ViewBut:SetFont("CombineControl.LabelSmall")
	CCP.CombineSurveillance.ViewBut:SetText("View")
	CCP.CombineSurveillance.ViewBut:SetPos(10, 460)
	CCP.CombineSurveillance.ViewBut:SetSize(100, 30)
	CCP.CombineSurveillance.ViewBut.DoClick = function(self)
		local line = CCP.CombineSurveillance.List:GetLine(CCP.CombineSurveillance.SelectedID)

		if IsValid(line.Ent) then
			net.Start("nSetCombineCamera")
				net.WriteEntity(line.Ent)
			net.SendToServer()
		end

	end
	CCP.CombineSurveillance.ViewBut:PerformLayout()
	CCP.CombineSurveillance.ViewBut:SetDisabled(true)

	CCP.CombineSurveillance.ResetBut = vgui.Create("DButton", CCP.CombineSurveillance)
	CCP.CombineSurveillance.ResetBut:SetFont("CombineControl.LabelSmall")
	CCP.CombineSurveillance.ResetBut:SetText("Reset")
	CCP.CombineSurveillance.ResetBut:SetPos(120, 460)
	CCP.CombineSurveillance.ResetBut:SetSize(100, 30)
	CCP.CombineSurveillance.ResetBut.DoClick = function(self)
		net.Start("nResetCombineCamera")
		net.SendToServer()
	end
	CCP.CombineSurveillance.ResetBut:PerformLayout()
end

function nPrisonNotify30(len)

	local targ = net.ReadEntity()

	GAMEMODE:AddChat(targ:VisibleRPName() .. " (#" .. targ:FormattedCID() .. ")'s imprisonment cycle will end in 30 seconds.", Color(229, 201, 98, 255))
end
net.Receive("nPrisonNotify30", nPrisonNotify30)

net.Receive("nPrisonNotify", function(len)
	local targ = net.ReadEntity()

	GAMEMODE:AddChat(targ:VisibleRPName() .. " (#" .. targ:FormattedCID() .. ")'s imprisonment cycle has ended.", Color(229, 201, 98, 255))
end)

function GM:PMCreateFaction()
	local options = {}
	local y = 10

	local function AddOption(eval, name, call)
		if eval() then
			table.insert(options, {name, call})
		end
	end

	AddOption(function() return LocalPlayer():GetCharFlagAttribute("CanViewLoans") end, "Loans", function() GAMEMODE:PMCreateLoansList() end)
	AddOption(function() return LocalPlayer():GetCharFlagAttribute("CanViewRecords") end, "Police Records", function() GAMEMODE:PMCreateCombineRecords() end)
	AddOption(function() return LocalPlayer():GetCharFlagAttribute("CanAccessPrison") end, "Prison Management", function() GAMEMODE:PMCreatePrison() end)
	AddOption(function() return LocalPlayer():GetCharFlagAttribute("CanAccessSurveillance") end, "Surveillance", function() GAMEMODE:PMCreateCombineSurveillance() end)

	if #options > 0 then
		for _, v in pairs(options) do
			local panel = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			panel:SetFont("CombineControl.LabelSmall")
			panel:SetText(v[1])
			panel:SetPos(10, y)
			panel:SetSize(150, 26)
			panel.DoClick = v[2]
			panel:PerformLayout()

			y = y + 36
		end
	else
		CCP.PlayerMenu.NoFaction = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		CCP.PlayerMenu.NoFaction:SetText("Placeholder (No faction options)")
		CCP.PlayerMenu.NoFaction:SetPos(10, 10)
		CCP.PlayerMenu.NoFaction:SetSize(780, 14)
		CCP.PlayerMenu.NoFaction:SetFont("CombineControl.LabelSmall")
		CCP.PlayerMenu.NoFaction:PerformLayout()
		CCP.PlayerMenu.NoFaction:SetWrap(true)
		CCP.PlayerMenu.NoFaction:SetAutoStretchVertical(true)
	end
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
		hudChatLabel:SetText("Show chatbox on HUD")
		hudChatLabel:SetPos(10, 70)
		hudChatLabel:SetFont("CombineControl.LabelSmall")
		hudChatLabel:SizeToContents()

	local hudChatCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		hudChatCheck:SetText("")
		hudChatCheck:SetPos(160, 70)
		hudChatCheck:SetValue(cookie.GetNumber("cc_chat", 1))
		hudChatCheck:SizeToContents()
		function hudChatCheck:OnChange(val)
			cookie.Set("cc_chat", val and 1 or 0)
		end

	local thirdPersonLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		thirdPersonLabel:SetText("Third-person camera")
		thirdPersonLabel:SetPos(10, 100)
		thirdPersonLabel:SetFont("CombineControl.LabelSmall")
		thirdPersonLabel:SizeToContents()

	local thirdPersonCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		thirdPersonCheck:SetText("")
		thirdPersonCheck:SetPos(160, 100)
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

	local motdLabel = vgui.Create("DLabel", CCP.PlayerMenu.ContentPane)
		motdLabel:SetText("Show MOTD")
		motdLabel:SetPos(10, 130)
		motdLabel:SetFont("CombineControl.LabelSmall")
		motdLabel:SizeToContents()

	local motdCheck = vgui.Create("DCheckBoxLabel", CCP.PlayerMenu.ContentPane)
		motdCheck:SetText("")
		motdCheck:SetPos(160, 130)
		motdCheck:SetValue(cookie.GetNumber("cc_motd", 1))
		motdCheck:SizeToContents()
		function motdCheck:OnChange(val)
			cookie.Set("cc_motd", val and 1 or 0)
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

	if GAMEMODE.SteamGroupURL ~= "" then
		local steamBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			steamBtn:SetFont("CombineControl.LabelSmall")
			steamBtn:SetText("Open Steam Group")
			steamBtn:SetPos(10, 306)
			steamBtn:SetSize(120, 30)
			function steamBtn:DoClick()
				gui.OpenURL(GAMEMODE.SteamGroupURL)
			end
	end

	if GAMEMODE.WebsiteURL ~= "" then
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

	if GAMEMODE.MOTDText ~= "" then
		local motdBtn = vgui.Create("DButton", CCP.PlayerMenu.ContentPane)
			motdBtn:SetFont("CombineControl.LabelSmall")
			motdBtn:SetText("Open MOTD")
			motdBtn:SetPos(140, 386)
			motdBtn:SetSize(120, 30)
			function motdBtn:DoClick()
				GAMEMODE:CreateMOTD(true)
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