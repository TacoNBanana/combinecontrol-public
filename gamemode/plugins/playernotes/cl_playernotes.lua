function GM:CreateNotesMenu()
	CCP.PlayerNotes = vgui.Create("DFrame")
	CCP.PlayerNotes:SetSize(800, 456)
	CCP.PlayerNotes:Center()
	CCP.PlayerNotes:SetTitle("Player notes")
	CCP.PlayerNotes.lblTitle:SetFont("CombineControl.Window")
	CCP.PlayerNotes:MakePopup()
	CCP.PlayerNotes.PerformLayout = CCFramePerformLayout
	CCP.PlayerNotes:PerformLayout()

	CCP.PlayerNotes.Think = UIAutoClose

	CCP.PlayerNotes.List = vgui.Create("DListView", CCP.PlayerNotes)
	CCP.PlayerNotes.List:SetPos(10, 34)
	CCP.PlayerNotes.List:SetSize(780, 382)
	CCP.PlayerNotes.List:SetMultiSelect(false)
	CCP.PlayerNotes.List:AddColumn("Title")
	CCP.PlayerNotes.List:AddColumn("Author")
	CCP.PlayerNotes.List:AddColumn("Added on")
	CCP.PlayerNotes.List:AddColumn("Last edit")
	CCP.PlayerNotes.List:AddColumn("Last edit by")

	CCP.PlayerNotes.List.OnRowSelected = function(self, index, row)
		CCP.PlayerNotes.ViewBut:SetDisabled(false)
		CCP.PlayerNotes.EditBut:SetDisabled(false)

		CCP.PlayerNotes.RemoveBut.ConfirmRemove = false
		CCP.PlayerNotes.RemoveBut:SetText("Remove")
		CCP.PlayerNotes.RemoveBut:SetDisabled(false)

		CCP.PlayerNotes.Selected = row.data
	end

	CCP.PlayerNotes.ViewBut = vgui.Create("DButton", CCP.PlayerNotes)
	CCP.PlayerNotes.ViewBut:SetPos(10, 426)
	CCP.PlayerNotes.ViewBut:SetSize(120, 20)
	CCP.PlayerNotes.ViewBut:SetText("View")
	CCP.PlayerNotes.ViewBut:SetDisabled(true)

	CCP.PlayerNotes.ViewBut.DoClick = function(self)
		if not CCP.PlayerNotes.Selected then
			return
		end

		GAMEMODE:ViewNote(CCP.PlayerNotes.Selected)
	end

	CCP.PlayerNotes.EditBut = vgui.Create("DButton", CCP.PlayerNotes)
	CCP.PlayerNotes.EditBut:SetPos(140, 426)
	CCP.PlayerNotes.EditBut:SetSize(120, 20)
	CCP.PlayerNotes.EditBut:SetText("Edit")
	CCP.PlayerNotes.EditBut:SetDisabled(true)

	CCP.PlayerNotes.EditBut.DoClick = function(self)
		if not CCP.PlayerNotes.Selected then
			return
		end

		GAMEMODE:EditNote(CCP.PlayerNotes.Targ, CCP.PlayerNotes.Selected)
	end

	CCP.PlayerNotes.RemoveBut = vgui.Create("DButton", CCP.PlayerNotes)
	CCP.PlayerNotes.RemoveBut:SetPos(270, 426)
	CCP.PlayerNotes.RemoveBut:SetSize(120, 20)
	CCP.PlayerNotes.RemoveBut:SetText("Remove")
	CCP.PlayerNotes.RemoveBut:SetDisabled(true)

	CCP.PlayerNotes.RemoveBut.DoClick = function(self)
		if not self.ConfirmRemove then
			self.ConfirmRemove = true
			self:SetText("Confirm?")

			return
		end

		self:SetText("Remove")

		net.Start("nRemoveNote")
			net.WriteEntity(CCP.PlayerNotes.Targ)
			net.WriteInt(CCP.PlayerNotes.Selected["id"], 32)
		net.SendToServer()
	end

	CCP.PlayerNotes.NewBut = vgui.Create("DButton", CCP.PlayerNotes)
	CCP.PlayerNotes.NewBut:SetPos(670, 426)
	CCP.PlayerNotes.NewBut:SetSize(120, 20)
	CCP.PlayerNotes.NewBut:SetText("New note")

	CCP.PlayerNotes.NewBut.DoClick = function(self)
		if not IsValid(CCP.PlayerNotes.Targ) then
			return
		end

		GAMEMODE:NoteCreateDialog(CCP.PlayerNotes.Targ)
	end

	CCP.PlayerNotes.RefreshBut = vgui.Create("DButton", CCP.PlayerNotes)
	CCP.PlayerNotes.RefreshBut:SetPos(540, 426)
	CCP.PlayerNotes.RefreshBut:SetSize(120, 20)
	CCP.PlayerNotes.RefreshBut:SetText("Refresh")

	CCP.PlayerNotes.RefreshBut.DoClick = function(self)
		if not IsValid(CCP.PlayerNotes.Targ) then
			return
		end

		net.Start("nRefreshNotes")
			net.WriteEntity(CCP.PlayerNotes.Targ)
		net.SendToServer()
	end
end

function GM:ViewNote(data)
	CCP.NoteViewer = vgui.Create("DFrame")
	CCP.NoteViewer:SetSize(400, 256)
	CCP.NoteViewer:Center()
	CCP.NoteViewer:SetTitle("Player note: " .. data["Title"])
	CCP.NoteViewer.lblTitle:SetFont("CombineControl.Window")
	CCP.NoteViewer:MakePopup()
	CCP.NoteViewer.PerformLayout = CCFramePerformLayout
	CCP.NoteViewer:PerformLayout()

	CCP.NoteViewer.Think = UIAutoClose

	CCP.NoteViewer.Title = vgui.Create("DLabel", CCP.NoteViewer)
	CCP.NoteViewer.Title:SetText(data["Title"])
	CCP.NoteViewer.Title:SetPos(10, 30)
	CCP.NoteViewer.Title:SetSize(380, 22)
	CCP.NoteViewer.Title:SetFont("CombineControl.LabelGiant")
	CCP.NoteViewer.Title:PerformLayout()

	CCP.NoteViewer.ContentScroll = vgui.Create("DScrollPanel", CCP.NoteViewer)
	CCP.NoteViewer.ContentScroll:SetPos(10, 57)
	CCP.NoteViewer.ContentScroll:SetSize(380, 189)
	CCP.NoteViewer.ContentScroll:PerformLayout()

	CCP.NoteViewer.Content = vgui.Create("CCLabel")
	CCP.NoteViewer.Content:SetSize(380, 10)
	CCP.NoteViewer.Content:SetFont("CombineControl.LabelSmall")
	CCP.NoteViewer.Content:SetText(data["Content"])

	CCP.NoteViewer.ContentScroll:AddItem(CCP.NoteViewer.Content)

	CCP.NoteViewer.Content:Dock(FILL)
	CCP.NoteViewer.Content:PerformLayout()
end

function GM:EditNote(ply, data)
	CCP.NoteEdit = vgui.Create("DFrame")
	CCP.NoteEdit:SetSize(400, 256)
	CCP.NoteEdit:Center()
	CCP.NoteEdit:SetTitle("Edit note: " .. data["Title"])
	CCP.NoteEdit.lblTitle:SetFont("CombineControl.Window")
	CCP.NoteEdit:MakePopup()
	CCP.NoteEdit.PerformLayout = CCFramePerformLayout
	CCP.NoteEdit:PerformLayout()

	CCP.NoteEdit.Think = UIAutoClose

	CCP.NoteEdit.Content = vgui.Create("DTextEntry", CCP.NoteEdit)
	CCP.NoteEdit.Content:SetPos(10, 34)
	CCP.NoteEdit.Content:SetSize(380, 182)
	CCP.NoteEdit.Content:SetFont("CombineControl.LabelSmall")
	CCP.NoteEdit.Content:SetMultiline(true)
	CCP.NoteEdit.Content:PerformLayout()

	CCP.NoteEdit.Content:SetText(data["Content"])

	CCP.NoteEdit.Content.OnChange = function(self)
		if #CCP.NoteEdit.Content:GetValue() > 0 then
			CCP.NoteEdit.Submit:SetDisabled(false)
		else
			CCP.NoteEdit.Submit:SetDisabled(true)
		end

		self.OldVal = self.OldVal or ""

		if #self:GetValue() > 2048 then
			self:SetText(self.OldVal)
			self:SetValue(self.OldVal)
			self:SetCaretPos(#self.OldVal)
		else
			self.OldVal = self:GetValue()
		end
	end

	CCP.NoteEdit.Submit = vgui.Create("DButton", CCP.NoteEdit)
	CCP.NoteEdit.Submit:SetFont("CombineControl.LabelSmall")
	CCP.NoteEdit.Submit:SetText("Submit")
	CCP.NoteEdit.Submit:SetPos(250, 224)
	CCP.NoteEdit.Submit:SetSize(140, 20)
	CCP.NoteEdit.Submit:SetDisabled(true)

	CCP.NoteEdit.Submit.DoClick = function(self)
		local content = CCP.NoteEdit.Content:GetValue()

		net.Start("nEditNote")
			net.WriteEntity(ply)
			net.WriteInt(data["id"], 32)
			net.WriteString(content)
		net.SendToServer()

		CCP.NoteEdit:Remove()
	end
end

function GM:NoteCreateDialog(ply)
	local function CheckRequirements()
		local title = (#CCP.NoteCreation.Title:GetValue() > 0)
		local content = (#CCP.NoteCreation.Content:GetValue() > 0)

		if title and content then
			CCP.NoteCreation.Submit:SetDisabled(false)
		else
			CCP.NoteCreation.Submit:SetDisabled(true)
		end
	end

	CCP.NoteCreation = vgui.Create("DFrame")
	CCP.NoteCreation:SetSize(400, 256)
	CCP.NoteCreation:Center()
	CCP.NoteCreation:SetTitle("New note: " .. ply:SteamID())
	CCP.NoteCreation.lblTitle:SetFont("CombineControl.Window")
	CCP.NoteCreation:MakePopup()
	CCP.NoteCreation.PerformLayout = CCFramePerformLayout
	CCP.NoteCreation:PerformLayout()

	CCP.NoteCreation.Think = UIAutoClose

	CCP.NoteCreation.Title = vgui.Create("DTextEntry", CCP.NoteCreation)
	CCP.NoteCreation.Title:SetFont("CombineControl.LabelSmall")
	CCP.NoteCreation.Title:SetPos(10, 34)
	CCP.NoteCreation.Title:SetSize(230, 20)
	CCP.NoteCreation.Title:PerformLayout()

	CCP.NoteCreation.Title.OnChange = function(self)
		CheckRequirements()

		self.OldVal = self.OldVal or ""

		if #self:GetValue() > 100 then
			self:SetText(self.OldVal)
			self:SetValue(self.OldVal)
			self:SetCaretPos(#self.OldVal)
		else
			self.OldVal = self:GetValue()
		end
	end

	CCP.NoteCreation.Content = vgui.Create("DTextEntry", CCP.NoteCreation)
	CCP.NoteCreation.Content:SetPos(10, 64)
	CCP.NoteCreation.Content:SetSize(380, 182)
	CCP.NoteCreation.Content:SetFont("CombineControl.LabelSmall")
	CCP.NoteCreation.Content:SetMultiline(true)
	CCP.NoteCreation.Content:PerformLayout()

	CCP.NoteCreation.Content.OnChange = function(self)
		CheckRequirements()

		self.OldVal = self.OldVal or ""

		if #self:GetValue() > 2048 then
			self:SetText(self.OldVal)
			self:SetValue(self.OldVal)
			self:SetCaretPos(#self.OldVal)
		else
			self.OldVal = self:GetValue()
		end
	end

	CCP.NoteCreation.Submit = vgui.Create("DButton", CCP.NoteCreation)
	CCP.NoteCreation.Submit:SetFont("CombineControl.LabelSmall")
	CCP.NoteCreation.Submit:SetText("Submit")
	CCP.NoteCreation.Submit:SetPos(250, 34)
	CCP.NoteCreation.Submit:SetSize(140, 20)
	CCP.NoteCreation.Submit:SetDisabled(true)

	CCP.NoteCreation.Submit.DoClick = function(self)
		local title = CCP.NoteCreation.Title:GetValue()
		local content = CCP.NoteCreation.Content:GetValue()

		net.Start("nAddNote")
			net.WriteEntity(ply)
			net.WriteString(title)
			net.WriteString(content)
		net.SendToServer()

		CCP.NoteCreation:Remove()
	end
end

net.Receive("nPlayerNotes", function(len)
	local ply = net.ReadEntity()
	local tab = net.ReadTable()

	if not IsValid(CCP.PlayerNotes) then
		GAMEMODE:CreateNotesMenu()
	end

	CCP.PlayerNotes.Targ = ply

	CCP.PlayerNotes:SetTitle("Player notes: " .. ply:SteamID())
	CCP.PlayerNotes.List:Clear()

	for _, v in pairs(tab) do
		CCP.PlayerNotes.List:AddLine(v["Title"], v["Admin"], v["Date"], v["LastEdit"], v["LastEditor"]).data = v
	end

	cookie.Set("cc_lastnoteread_" .. ply:SteamID64(), os.time() + 5) // Bit of a buffer to give the database time to update the timer on the accessor time of things
end)