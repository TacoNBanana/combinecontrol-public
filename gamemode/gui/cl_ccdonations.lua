local PANEL = {}

function PANEL:Init()
	local top = self:Add("DLabel")

	top:SetTall(20)
	top:DockMargin(5, 0, 0, 10)
	top:Dock(TOP)
	top:SetFont("CombineControl.LabelBig")
	top:SetText("Donations are applied to your current character, make sure you are on the correct character before redeeming!")

	local bottom = self:Add("DPanel")

	bottom:SetTall(30)
	bottom:DockMargin(0, 10, 0, 0)
	bottom:Dock(BOTTOM)
	bottom.Paint = stub

	self.RedeemButton = bottom:Add("DButton")
	self.RedeemButton:SetWide(120)
	self.RedeemButton:Dock(LEFT)
	self.RedeemButton:SetText("Redeem")
	self.RedeemButton:SetDisabled(true)
	self.RedeemButton.DoClick = function(pnl)
		self:Submit()
	end

	self.RefreshButton = bottom:Add("DButton")
	self.RefreshButton:SetWide(120)
	self.RefreshButton:DockMargin(10, 0, 0, 0)
	self.RefreshButton:Dock(LEFT)
	self.RefreshButton:SetText("Refresh")
	self.RefreshButton.DoClick = function(pnl)
		self:Refresh()
	end

	self.LogList = self:Add("DListView")
	self.LogList:Dock(FILL)
	self.LogList:AddColumn("Time of purchase"):SetFixedWidth(120)
	self.LogList:AddColumn("Type"):SetFixedWidth(120)
	self.LogList:AddColumn("Used"):SetFixedWidth(60)
	self.LogList:AddColumn("Donation")
	self.LogList.OnRowSelected = function(pnl, index, row)
		self:OnSelect(index, row)
	end

	self:PerformLayout()
	self:Refresh()
end

function PANEL:Refresh()
	self.LogList:Clear()

	for k, v in pairs(LocalPlayer():Donations()) do
		local donation = GAMEMODE.DonationTypes[v.Type]
		local redeemed = "No"

		if v.Redeemed then
			redeemed = "Yes"
		elseif donation.NoRedeem then
			redeemed = "Multi-use"
		end

		local line = self.LogList:AddLine(os.date("%Y-%m-%d %H:%M:%S", v.Timestamp), donation.Type, redeemed, donation.Name)

		line.Data = v
		line.Donation = donation
	end

	self.RedeemButton:SetDisabled(true)
	self.SelectedRow = nil
	self.Donation = nil
end

function PANEL:OnSelect(index, row)
	self.RedeemButton:SetDisabled(row.Redeemed)
	self.SelectedRow = index
	self.Donation = row.Donation
end

function PANEL:Submit()
	if not self.SelectedRow then
		return
	end

	if self.Donation.UsePrompt then
		GAMEMODE:CreateDonationPrompt(self.SelectedRow, self.Donation)
	else
		net.Start("nRedeemDonation")
			net.WriteInt(self.SelectedRow, 16)
			net.WriteTable({})
		net.SendToServer()
	end
end

function PANEL:Paint(w, h)
end

derma.DefineControl("CCDonations", "", PANEL, "DPanel")