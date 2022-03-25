net.Receive("nCharacterList", function(len)
	GAMEMODE.Characters = net.ReadTable()
end)

function GM:CharCreateThink()
	if self.QueueCharCreate then

		if not self.IntroCamStart or not self:InIntroCam() then

			if not CCP.Quiz or not CCP.Quiz:IsValid() then

				self.QueueCharCreate = false
				cookie.Set("cc_doneintro", 2)

				self:CreateCharEditor()

			end

		end

	end
end

function GM:CreateQuiz()
	if CCP.Quiz and CCP.Quiz:IsValid() then

		CCP.Quiz:Remove()
		CCP.Quiz = nil

	end

	local submitBtn

	local frame = vgui.Create("DFrame")
		CCP.Quiz = frame
		frame:SetTitle("Newbie Quiz")
		frame.lblTitle:SetFont("CombineControl.Window")
		frame:ShowCloseButton(false)
		frame:SetDraggable(false)
		frame:MakePopup()

		local inputs = {}

		local y = 0, 0
		local i = 0
		function onSelect(self, idx, val, data)
			self.Answer = idx
			-- local ok = true
			-- for k, v in pairs(inputs) do
				-- if not v.Answer then
					-- ok = false
				-- end
			-- end
			-- if ok then
				-- submitBtn:SetDisabled(false)
			-- end
		end

		function frame:AddQuestion(text, answers, correct)
			i = i + 1
			-- local pnl = vgui.Create("DPanel", frame)
				-- function pnl:Paint(w, h) return true end

			local lbl = vgui.Create("DLabel", frame)
				lbl:SetPos(8, 32 + y)
				lbl:SetText(i .. ". " .. text)
				lbl:SetFont("CombineControl.Window")
				lbl:SizeToContents()
				lbl:PerformLayout()

			local input = vgui.Create("DComboBox", frame)
				input:SetFont("CombineControl.LabelSmall")
				input:SetValue("")
				input:SetPos(350, 30 + y)
				input:PerformLayout()
				input.Correct = correct
				input.OnSelect = onSelect

				local w = 0
				surface.SetFont("CombineControl.LabelSmall")

				for k, v in pairs(answers) do
					w = math.max(w, surface.GetTextSize(v))
					input:AddChoice(v, v)
				end

				input:SetSize(150, 20)
				inputs[i] = input

			-- pnl:SizeToChildren(true, true)

			y = y + lbl:GetTall() + 15

			return lbl, input
		end

		frame:AddQuestion("The farmer went _____ the market.", {"2", "to", "too", "two"}, 2)
		frame:AddQuestion("_____ apples are very ripe.", {"They're", "There", "Their"}, 3)
		-- frame:AddQuestion("_____ of people like candy.", {"Allot", "A lot", "Alot"}, 2)
		frame:AddQuestion("What is 6 × 8?", {"14", "40", "48", "50"}, 3)
		frame:AddQuestion("_____ is the name of the rebel scientist in Half-Life 2.", {"Barney", "Alyx", "Kleiner"}, 3)
		y = y + 32
		frame:AddQuestion("This server is ______-themed roleplay.", {"Real life", "Half-Life 2", "The Walking Dead", "Doctor Who"}, 2)
		frame:AddQuestion("What does OOC stand for?", {"Out of communication", "Out of context", "Out-of-character"}, 3)
		frame:AddQuestion("What does IC stand for?", {"In context", "In-character", "Incident Commander", "Incommunicado"}, 2)
		-- frame:AddQuestion("What year is it in-character?", {"1998", "2019", "2038"}, 3)

		frame:SizeToChildren(true, true)

		submitBtn = vgui.Create("DButton", frame)
			submitBtn:SetText("Submit")
			submitBtn:SetFont("CombineControl.LabelSmall")
			submitBtn:SetSize(100, 26)
			submitBtn:SetPos(frame:GetWide()/2 - submitBtn:GetWide() - 5, y + 48)
			function submitBtn:DoClick()
				local ok = true
				-- for k, v in pairs(inputs) do
					-- if not v.Answer then
						-- ok = false
					-- end
				-- end
				-- if not ok then return end
				for k, v in pairs(inputs) do
					if v.Answer != v.Correct then
						ok = false
					end
				end

				if ok then
					frame:Remove()
					CCP.Quiz = nil
					GAMEMODE:StartIntroCam()
					return
				end

				if cookie.GetNumber("cc_doneintro", 0) == 0 then
					cookie.Set("cc_doneintro", 1)
					net.Start("nQuizBan")
						net.WriteFloat(1)
					net.SendToServer()
				elseif cookie.GetNumber("cc_doneintro", 0) == 1 then
					net.Start("nQuizBan")
						net.WriteFloat(2)
					net.SendToServer()
				end
			end
			-- submitBtn:SetDisabled(true)
			submitBtn:PerformLayout()

		local helpBtn = vgui.Create("DButton", frame)
			helpBtn:SetText("Help")
			helpBtn:SetFont("CombineControl.LabelSmall")
			helpBtn:SetSize(100, 26)
			helpBtn:SetPos(0, y + 48)
			helpBtn:MoveRightOf(submitBtn, 5)
			function helpBtn:DoClick()
				gui.OpenURL("http://taconbanana.com")
			end
			helpBtn:PerformLayout()

		frame:SizeToChildren(true, true)
		frame:Center()
end

net.Receive("nOpenCharCreate", function(len)
	GAMEMODE.CCMode = net.ReadFloat()
	GAMEMODE.QueueCharCreate = true
end)

GM.CCModel = GM.CCModel or ""

function GM:CreateCharEditor()
	self.CharCreate = true
	self.CharCreateOpened = true

	net.Start("nSetCharCreate")
		net.WriteBool(true)
	net.SendToServer()

	if self.CCMode == CC_CREATE then

		self:CreateCharCreate()

	elseif self.CCMode == CC_CREATESELECT then

		self:CreateCharCreate()
		self:CreateCharSelect()

	elseif self.CCMode == CC_CREATESELECT_C then

		self:CreateCharCreate()
		self:CreateCharSelect()
		self:CreateCharDeleteCancel()

	elseif self.CCMode == CC_SELECT then

		self:CreateCharSelect(true)

	elseif self.CCMode == CC_SELECT_C then

		self:CreateCharSelect(true)
		self:CreateCharDeleteCancel()

	end
end

GM.CharCreateSelectedModel = GM.CharCreateSelectedModel or ""

local matHover = Material("vgui/spawnmenu/hover")

local allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 .-'áàâäçéèêëíìîïóòôöúùûüÿÁÀÂÄßÇÉÈÊËÍÌÎÏÓÒÔÖÚÙÛÜŸ"

function GM:CreateCharCreate()
	CCP.CharCreatePanel = vgui.Create("DFrame")
	CCP.CharCreatePanel:SetSize(800, 500)
	if self.CCMode == CC_CREATE then
		CCP.CharCreatePanel:Center()
	else
		CCP.CharCreatePanel:SetPos(ScrW() / 2 - 800 / 2 - 100, ScrH() / 2 - 500 / 2)
	end
	CCP.CharCreatePanel:SetTitle("Character Creation")
	CCP.CharCreatePanel:ShowCloseButton(false)
	CCP.CharCreatePanel:SetDraggable(false)
	CCP.CharCreatePanel.lblTitle:SetFont("CombineControl.Window")
	CCP.CharCreatePanel:MakePopup()

	CCP.CharCreatePanel.NameLabel = vgui.Create("DLabel", CCP.CharCreatePanel)
	CCP.CharCreatePanel.NameLabel:SetText("Name")
	CCP.CharCreatePanel.NameLabel:SetPos(10, 30)
	CCP.CharCreatePanel.NameLabel:SetFont("CombineControl.LabelGiant")
	CCP.CharCreatePanel.NameLabel:SizeToContents()
	CCP.CharCreatePanel.NameLabel:PerformLayout()

	CCP.CharCreatePanel.NameEntry = vgui.Create("DTextEntry", CCP.CharCreatePanel)
	CCP.CharCreatePanel.NameEntry:SetFont("CombineControl.LabelBig")
	CCP.CharCreatePanel.NameEntry:SetPos(150, 30)
	CCP.CharCreatePanel.NameEntry:SetSize(300, 20)
	CCP.CharCreatePanel.NameEntry:PerformLayout()
	function CCP.CharCreatePanel.NameEntry:AllowInput(val)

		if not string.find(allowedChars, val, 1, true) then

			return true

		end

		return false

	end

	CCP.CharCreatePanel.RandomMale = vgui.Create("DButton", CCP.CharCreatePanel)
	CCP.CharCreatePanel.RandomMale:SetFont("CombineControl.LabelSmall")
	CCP.CharCreatePanel.RandomMale:SetText("Random Male")
	CCP.CharCreatePanel.RandomMale:SetPos(150, 60)
	CCP.CharCreatePanel.RandomMale:SetSize(100, 20)
	function CCP.CharCreatePanel.RandomMale:DoClick()

		CCP.CharCreatePanel.NameEntry:SetValue(table.Random(GAMEMODE.MaleFirstNames) .. " " .. table.Random(GAMEMODE.LastNames))

	end
	CCP.CharCreatePanel.RandomMale:PerformLayout()

	CCP.CharCreatePanel.RandomFemale = vgui.Create("DButton", CCP.CharCreatePanel)
	CCP.CharCreatePanel.RandomFemale:SetFont("CombineControl.LabelSmall")
	CCP.CharCreatePanel.RandomFemale:SetText("Random Female")
	CCP.CharCreatePanel.RandomFemale:SetPos(260, 60)
	CCP.CharCreatePanel.RandomFemale:SetSize(100, 20)
	function CCP.CharCreatePanel.RandomFemale:DoClick()

		CCP.CharCreatePanel.NameEntry:SetValue(table.Random(GAMEMODE.FemaleFirstNames) .. " " .. table.Random(GAMEMODE.LastNames))

	end
	CCP.CharCreatePanel.RandomFemale:PerformLayout()

	CCP.CharCreatePanel.DescLabel = vgui.Create("DLabel", CCP.CharCreatePanel)
	CCP.CharCreatePanel.DescLabel:SetText("Description")
	CCP.CharCreatePanel.DescLabel:SetPos(10, 90)
	CCP.CharCreatePanel.DescLabel:SetFont("CombineControl.LabelGiant")
	CCP.CharCreatePanel.DescLabel:SizeToContents()
	CCP.CharCreatePanel.DescLabel:PerformLayout()

	CCP.CharCreatePanel.DescEntry = vgui.Create("DTextEntry", CCP.CharCreatePanel)
	CCP.CharCreatePanel.DescEntry:SetFont("CombineControl.LabelSmall")
	CCP.CharCreatePanel.DescEntry:SetPos(150, 90)
	CCP.CharCreatePanel.DescEntry:SetSize(300, 200)
	CCP.CharCreatePanel.DescEntry:SetMultiline(true)
	CCP.CharCreatePanel.DescEntry:PerformLayout()

	CCP.CharCreatePanel.ModelLabel = vgui.Create("DLabel", CCP.CharCreatePanel)
	CCP.CharCreatePanel.ModelLabel:SetText("Model")
	CCP.CharCreatePanel.ModelLabel:SetPos(10, 300)
	CCP.CharCreatePanel.ModelLabel:SetFont("CombineControl.LabelGiant")
	CCP.CharCreatePanel.ModelLabel:SizeToContents()
	CCP.CharCreatePanel.ModelLabel:PerformLayout()

	-- TEMPORARY BREACH OF STYLE BECAUSE FUCK THIS
	local modelPicker
	local frame = CCP.CharCreatePanel
	local curModel = vgui.Create("SpawnIcon", frame)
		curModel:SetPos(150, 300)
		curModel:SetSize(80, 80)

		function curModel:DoClick()
			modelPicker:SetVisible(true)
			modelPicker:MakePopup()
			modelPicker:MoveToFront()
		end

	local skinLabel = vgui.Create("DLabel", frame)
		skinLabel:SetText("Skin")
		skinLabel:SetPos(10, 390)
		skinLabel:SetFont("CombineControl.LabelGiant")
		skinLabel:SizeToContents()
		skinLabel:PerformLayout()

	local skinBtns = {}

	modelPicker = vgui.Create("DFrame")
		modelPicker:SetTitle("Model")
		modelPicker.lblTitle:SetFont("CombineControl.Window")
		modelPicker:ShowCloseButton(false)

		local function paintOver(self, w, h)
			self:DrawSelections()
			if self.Hovered or self.Selected then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetMaterial(matHover)
				self:DrawTexturedRect()
			end
		end

		local function paint(self, w, h)
			surface.SetDrawColor(40, 40, 40, 255)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(30, 30, 30, 100)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local function doClick(self)
			modelPicker:SetVisible(false)
			for k, pnl in pairs(modelPicker:GetChildren()) do
				pnl.Selected = false
			end
			self.Selected = true

			for k, v in pairs(skinBtns) do
				v:Remove()
			end
			skinBtns = {}

			curModel:SetModel(self.ModelPath, 0)
			GAMEMODE.CharCreateSelectedModel = self.ModelPath
			GAMEMODE.CharCreateSelectedSkin = 0

			local function doClickSkin(self)
				for k, pnl in pairs(skinBtns) do
					pnl.Selected = false
				end
				self.Selected = true
				GAMEMODE.CharCreateSelectedSkin = self.SkinNumber
				curModel:SetModel(self.ModelPath, self.SkinNumber)
			end

			local numSkins = GAMEMODE.CitizenModels[self.ModelPath]
			if numSkins > 1 then
				local x, y = 0, 0
				for i = 0, numSkins - 1 do
					local icon = vgui.Create("SpawnIcon", frame)
						icon:SetPos(150 + x, 390 + y)
						icon:SetSize(56, 56)
						icon:SetModel(self.ModelPath, i)
						icon.ModelPath = self.ModelPath
						icon.SkinNumber = i
						icon.DoClick = doClickSkin
						icon.PaintOver = paintOver
						icon.Paint = paint
					skinBtns[i + 1] = icon

					x = x + 60
					if x > 360 then
						x = 0
						y = y + 60
					end
				end
				skinBtns[1].Selected = true
			end
		end

		local x, y = 0, 0
		local clicked = false
		for k in SortedPairs(self.CitizenModels) do
			local icon = vgui.Create("SpawnIcon", modelPicker)
				icon:SetPos(5 + x, 30 + y)
				icon:SetSize(56, 56)
				icon:SetModel(k, 0)
				icon.ModelPath = k
				icon.DoClick = doClick
				icon.PaintOver = paintOver
				icon.Paint = paint

			x = x + 60
			if x > 360 then
				x = 0
				y = y + 60
			end

			if not clicked then
				icon:DoClick()

				clicked = true
			end
		end

		modelPicker:SizeToChildren(true, true)
		modelPicker:Center()
		modelPicker:PerformLayout()
		modelPicker:SetVisible(false)

	local label = vgui.Create("DLabel", CCP.CharCreatePanel)
	label:SetText("Trait")
	label:SetPos(470, 300)
	label:SetFont("CombineControl.LabelGiant")
	label:SizeToContents()
	label:PerformLayout()

	CCP.CharCreatePanel.TraitLabel = vgui.Create("DLabel", CCP.CharCreatePanel)
	CCP.CharCreatePanel.TraitLabel:SetText(GAMEMODE.Traits[TRAIT_NONE][1])
	CCP.CharCreatePanel.TraitLabel:SetPos(586, 303)
	CCP.CharCreatePanel.TraitLabel:SetSize(178, 16)
	CCP.CharCreatePanel.TraitLabel:SetFont("CombineControl.LabelSmall")
	CCP.CharCreatePanel.TraitLabel:PerformLayout()
	CCP.CharCreatePanel.TraitLabel.Value = TRAIT_NONE

	local a = vgui.Create("DButton", CCP.CharCreatePanel)
	a:SetFont("CombineControl.LabelSmall")
	a:SetText("<")
	a:SetPos(560, 303)
	a:SetSize(16, 16)
	function a:DoClick()

		local n = CCP.CharCreatePanel.TraitLabel.Value / 2

		if n < TRAIT_NONE then

			n = 2 ^ (table.Count(GAMEMODE.Traits) - 1)

		end

		CCP.CharCreatePanel.TraitLabel.Value = n
		CCP.CharCreatePanel.TraitLabel:SetText(GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][1])
		CCP.CharCreatePanel.TraitDesc:SetText(GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][2])

	end
	a:PerformLayout()

	local b = vgui.Create("DButton", CCP.CharCreatePanel)
	b:SetFont("CombineControl.LabelSmall")
	b:SetText(">")
	b:SetPos(774, 303)
	b:SetSize(16, 16)
	function b:DoClick()

		local n = CCP.CharCreatePanel.TraitLabel.Value * 2

		if n > 2 ^ (table.Count(GAMEMODE.Traits) - 1) then

			n = TRAIT_NONE

		end

		CCP.CharCreatePanel.TraitLabel.Value = n
		CCP.CharCreatePanel.TraitLabel:SetText(GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][1])
		CCP.CharCreatePanel.TraitDesc:SetText(GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][2])

	end
	b:PerformLayout()

	CCP.CharCreatePanel.TraitDesc = vgui.Create("DLabel", CCP.CharCreatePanel)
	CCP.CharCreatePanel.TraitDesc:SetText(GAMEMODE.Traits[TRAIT_NONE][2])
	CCP.CharCreatePanel.TraitDesc:SetPos(470, 329)
	CCP.CharCreatePanel.TraitDesc:SetSize(320, 14)
	CCP.CharCreatePanel.TraitDesc:SetFont("CombineControl.LabelTiny")
	CCP.CharCreatePanel.TraitDesc:SetAutoStretchVertical(true)
	CCP.CharCreatePanel.TraitDesc:SetWrap(true)
	CCP.CharCreatePanel.TraitDesc:PerformLayout()

	if self.CCMode == CC_CREATE then

		CCP.CharCreatePanel.NewbLabel = vgui.Create("DLabel", CCP.CharCreatePanel)
		CCP.CharCreatePanel.NewbLabel:SetText("Are you an inexperienced roleplayer?")
		CCP.CharCreatePanel.NewbLabel:SetPos(470, 435)
		CCP.CharCreatePanel.NewbLabel:SetFont("CombineControl.LabelSmall")
		CCP.CharCreatePanel.NewbLabel:SetSize(294, 16)
		CCP.CharCreatePanel.NewbLabel:SetAutoStretchVertical(true)
		CCP.CharCreatePanel.NewbLabel:SetWrap(true)
		CCP.CharCreatePanel.NewbLabel:PerformLayout()

		net.Start("nSetNewbieStatus")
			net.WriteBit(true)
		net.SendToServer()

		CCP.CharCreatePanel.Newbie = vgui.Create("DCheckBoxLabel", CCP.CharCreatePanel)
		CCP.CharCreatePanel.Newbie:SetText("")
		CCP.CharCreatePanel.Newbie:SetPos(774, 434)
		CCP.CharCreatePanel.Newbie:SetValue(true)
		CCP.CharCreatePanel.Newbie:PerformLayout()
		function CCP.CharCreatePanel.Newbie:OnChange(val)

			net.Start("nSetNewbieStatus")
				net.WriteBit(val)
			net.SendToServer()

		end

	end

	CCP.CharCreatePanel.BadChar = vgui.Create("DLabel", CCP.CharCreatePanel)
	CCP.CharCreatePanel.BadChar:SetText("")
	CCP.CharCreatePanel.BadChar:SetPos(470, 466)
	CCP.CharCreatePanel.BadChar:SetFont("CombineControl.LabelSmall")
	CCP.CharCreatePanel.BadChar:SetSize(720, 14)
	CCP.CharCreatePanel.BadChar:PerformLayout()

	CCP.CharCreatePanel.OK = vgui.Create("DButton", CCP.CharCreatePanel)
	CCP.CharCreatePanel.OK:SetFont("CombineControl.LabelSmall")
	CCP.CharCreatePanel.OK:SetText("OK")
	CCP.CharCreatePanel.OK:SetPos(740, 460)
	CCP.CharCreatePanel.OK:SetSize(50, 30)
	function CCP.CharCreatePanel.OK:DoClick()

		local name = CCP.CharCreatePanel.NameEntry:GetValue()
		local desc = CCP.CharCreatePanel.DescEntry:GetValue()
		local model = GAMEMODE.CharCreateSelectedModel
		local skin = GAMEMODE.CharCreateSelectedSkin
		local trait = CCP.CharCreatePanel.TraitLabel.Value

		local r, err = GAMEMODE:CheckCharacterValidity(name, desc, model, skin, trait)

		if r then

			GAMEMODE:CloseCharCreate()

			net.Start("nCreateCharacter")
				net.WriteString(name)
				net.WriteString(desc)
				net.WriteString(model)
				net.WriteUInt(skin, 5)
				net.WriteFloat(trait)
			net.SendToServer()

			if not GAMEMODE.AutoMOTD and GAMEMODE.MOTDText != "" then

				GAMEMODE.AutoMOTD = true
				GAMEMODE:CreateMOTD()

			end

		else

			CCP.CharCreatePanel.BadChar:SetText(err)

		end

	end
	CCP.CharCreatePanel.OK:PerformLayout()
end

function GM:CharSelectPopulateCharacters()
	if not self.CharSelectCharacterButtons then self.CharSelectCharacterButtons = {} end

	for _, v in pairs(self.CharSelectCharacterButtons) do

		v:Remove()

	end

	self.CharSelectCharacterButtons = {}

	local y = 0

	for k, v in pairs(self.Characters) do

		local b = vgui.Create("DButton", CCP.CharSelect.ContentPane)
		b:SetFont("CombineControl.LabelSmall")
		b:SetText(v.RPName)
		b:SetPos(0, y)
		b:SetSize(180, 20)
		b.CharID = v.id
		b.Location = v.Location
		function b:DoClick()
			if CCP.CharSelect.DeleteMode then
				local popup = vgui.Create("DFrame")
					popup:SetSize(400, 200)
					popup:SetTitle("Confirm")
					popup:Center()
					popup:ShowCloseButton(false)
					popup:SetDraggable(false)
					popup.lblTitle:SetFont("CombineControl.Window")
					popup:MakePopup()

				local lbl = vgui.Create("DLabel", popup)
					lbl:SetText("Are you sure you want to delete " .. v.RPName .. "? This cannot be undone!")
					lbl:Dock(TOP)
					lbl:DockMargin(5, 0, 5, 0)
					lbl:SetColor(Color(255, 255, 255))
					lbl:PerformLayout()

				local wrapper = vgui.Create("DPanel", popup)
					function wrapper:Paint(w, h) return true end
					wrapper:Dock(BOTTOM)

				local no = vgui.Create("DButton", wrapper)
					no:SetText("No")
					no:SetSize(75, 25)
					function no:PerformLayout()
						self:AlignRight()
					end
					function no:DoClick()
						popup:Remove()
					end

				local yes = vgui.Create("DButton", wrapper)
					yes:SetText("Yes")
					yes:SetSize(75, 25)
					function yes:PerformLayout()
						self:SetPos(no:GetPos())
						self:MoveLeftOf(no, 5)
					end
					function yes:DoClick()
						popup:Remove()
						net.Start("nDeleteCharacter")
							net.WriteFloat(v.id)
						net.SendToServer()

						for m, n in pairs(GAMEMODE.Characters) do
							if n.id == v.id then
								table.remove(GAMEMODE.Characters, m)
							end
						end
						GAMEMODE:CharSelectPopulateCharacters()
					end

				wrapper:SizeToChildren(true, true)
				wrapper:PerformLayout()
			else
				GAMEMODE:CloseCharCreate()

				net.Start("nSelectCharacter")
					net.WriteFloat(self.CharID)
				net.SendToServer()

				if not GAMEMODE.AutoMOTD and GAMEMODE.MOTDText != "" then
					GAMEMODE.AutoMOTD = true
					GAMEMODE:CreateMOTD()
				end
			end
		end
		b:PerformLayout()
		CCP.CharSelect.ContentPane:AddItem(b)

		if LocalPlayer().CharID and b.CharID == LocalPlayer():CharID() then

			b:SetDisabled(true)

		end

		if GAMEMODE.CurrentLocation and b.Location != GAMEMODE.CurrentLocation and not LocalPlayer():CanIgnoreTravelRestrictions(v) then

			b:SetDisabled(true)

		end

		table.insert(self.CharSelectCharacterButtons, b)

		y = y + 30

	end

	CCP.CharSelect.ContentPane:PerformLayout()
end

function GM:CreateCharSelect(o)
	CCP.CharSelect = vgui.Create("DFrame")
	CCP.CharSelect:SetSize(200, 500)
	if o then
		CCP.CharSelect:Center()
	else
		CCP.CharSelect:SetPos(ScrW() / 2 + 800 / 2 - 100, ScrH() / 2 - 500 / 2)
	end
	CCP.CharSelect:SetTitle("Character Selection")
	CCP.CharSelect:ShowCloseButton(false)
	CCP.CharSelect:SetDraggable(false)
	CCP.CharSelect.lblTitle:SetFont("CombineControl.Window")
	CCP.CharSelect:MakePopup()

	CCP.CharSelect.ContentPane = vgui.Create("DScrollPanel", CCP.CharSelect)
	CCP.CharSelect.ContentPane:SetPos(10, 34)
	CCP.CharSelect.ContentPane:SetSize(200 - 20, 400)

	self:CharSelectPopulateCharacters()
end

function GM:CreateCharDeleteCancel()
	CCP.CharSelect.Think = function(pnl)
		if cookie.GetNumber("cc_escapemenuclose", 1) == 1 and input.IsKeyDown(KEY_ESCAPE) then
			GAMEMODE:CloseCharCreate()

			gui.HideGameUI()
		end
	end

	CCP.CharSelect.OnKeyCodePressed = function(pnl, key)
		if input.LookupKeyBinding(key) and string.find(input.LookupKeyBinding(key), "showteam") then
			GAMEMODE:CloseCharCreate()
		end
	end

	if CCP.CharSelect.ContentPane then

		local b = vgui.Create("DButton", CCP.CharSelect)
		b:SetFont("CombineControl.LabelSmall")
		b:SetText("Delete")
		b:SetPos(10, 500 - 60)
		b:SetSize(180, 20)
		function b:DoClick()
			if not CCP.CharSelect.DeleteMode then
				CCP.CharSelect.DeleteMode = true
				self:SetTextColor(Color(200, 0, 0, 255))

				for k, v in pairs(GAMEMODE.CharSelectCharacterButtons) do
					if LocalPlayer().CharID and v.CharID == LocalPlayer():CharID() then
						v:SetDisabled(true)
					else
						v:SetDisabled(false)
					end
				end
			else
				CCP.CharSelect.DeleteMode = false
				self:SetTextColor(Color(200, 200, 200, 255))

				for k, v in pairs(GAMEMODE.CharSelectCharacterButtons) do
					if LocalPlayer().CharID and v.CharID == LocalPlayer():CharID() then
						v:SetDisabled(true)
					elseif GAMEMODE.CurrentLocation and v.Location != GAMEMODE.CurrentLocation and not LocalPlayer():CanIgnoreTravelRestrictions(v) then
						v:SetDisabled(true)
					end
				end
			end
		end
		b:PerformLayout()

		local b = vgui.Create("DButton", CCP.CharSelect)
		b:SetFont("CombineControl.LabelSmall")
		b:SetText("Cancel")
		b:SetPos(10, 500 - 30)
		b:SetSize(180, 20)
		function b:DoClick()

			GAMEMODE:CloseCharCreate()

		end
		b:PerformLayout()

	end
end

function GM:CloseCharCreate()
	self.CharCreate = false

	net.Start("nSetCharCreate")
		net.WriteBool(false)
	net.SendToServer()

	if CCP.CharCreatePanel then

		CCP.CharCreatePanel:Remove()

	end

	if CCP.CharSelect then

		CCP.CharSelect:Remove()

	end

	CCP.CharCreatePanel = nil
	CCP.CharSelect = nil
end

function GM:CreateMOTD()
	if not self.MOTDText then return end

	CCP.MOTD = vgui.Create("DFrame")
	CCP.MOTD:SetSize(400, 600)
	CCP.MOTD:Center()
	CCP.MOTD:SetTitle("MOTD")
	CCP.MOTD.lblTitle:SetFont("CombineControl.Window")
	CCP.MOTD:MakePopup()
	CCP.MOTD.PerformLayout = CCFramePerformLayout
	CCP.MOTD:PerformLayout()

	CCP.MOTD.Think = UIAutoClose

	CCP.MOTD.ContentPane = vgui.Create("DScrollPanel", CCP.MOTD)
	CCP.MOTD.ContentPane:SetPos(10, 34)
	CCP.MOTD.ContentPane:SetSize(400 - 20, 556)

	CCP.MOTD.Content = vgui.Create("CCLabel")
	CCP.MOTD.Content:SetPos(10, 0)
	CCP.MOTD.Content:SetSize(400 - 50, 14)
	CCP.MOTD.Content:SetFont("CombineControl.LabelSmall")
	CCP.MOTD.Content:SetText(self.MOTDText)
	CCP.MOTD.Content:PerformLayout()

	CCP.MOTD.ContentPane:AddItem(CCP.MOTD.Content)
end
