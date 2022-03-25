function GM:CreateDonationsMenu()
	CCP.DonationPanel = vgui.Create("DFrame")
	CCP.DonationPanel:SetSize(800, 456)
	CCP.DonationPanel:Center()
	CCP.DonationPanel:SetTitle("Donation Panel")
	CCP.DonationPanel.lblTitle:SetFont("CombineControl.Window")
	CCP.DonationPanel:MakePopup()
	CCP.DonationPanel.PerformLayout = CCFramePerformLayout
	CCP.DonationPanel:PerformLayout()

	CCP.DonationPanel.Think = UIAutoClose

	CCP.DonationPanel.Panel = vgui.Create("CCDonations", CCP.DonationPanel)
	CCP.DonationPanel.Panel:Dock(FILL)
end

local function NewRow(property, category, parent, proptype)
	local r = parent:CreateRow(category, property)

	r.Paint = function(pnl, w, h)
		if not IsValid(pnl.Inner) then
			return
		end

		local skindata = pnl:GetSkin()

		surface.SetDrawColor(skindata.Colours.Properties.Border)
		surface.DrawRect(w - 1, 0, 1, h)
		surface.DrawRect(w * 0.45, 0, 1, h)
		surface.DrawRect(0, h-1, w, 1)

		r.Label:SetTextColor(skindata.Colours.Properties.Label_Selected)
	end

	r:GetParent().Paint = function(pnl, w, h)
		surface.SetDrawColor(Color(57, 57, 57))
		surface.DrawRect(0, 0, w, h)
	end

	r:Setup(proptype)

	r.DataChanged = function(pnl, val)
		parent.Data[category] = val
	end

	return r
end

function GM:CreateDonationPrompt(row, donation)
	CCP.DonationPrompt = vgui.Create("DFrame")
	CCP.DonationPrompt:SetSize(300, 155)
	CCP.DonationPrompt:Center()
	CCP.DonationPrompt:SetTitle("Donation Prompt")
	CCP.DonationPrompt.lblTitle:SetFont("CombineControl.Window")
	CCP.DonationPrompt:MakePopup()
	CCP.DonationPrompt.PerformLayout = CCFramePerformLayout
	CCP.DonationPrompt:PerformLayout()

	CCP.DonationPrompt.Think = UIAutoClose

	local bottom = CCP.DonationPrompt:Add("DPanel")

	bottom:SetTall(20)
	bottom:DockMargin(0, 10, 0, 0)
	bottom:Dock(BOTTOM)
	bottom.Paint = stub

	CCP.DonationPrompt.Submit = bottom:Add("DButton")
	CCP.DonationPrompt.Submit:SetWide(120)
	CCP.DonationPrompt.Submit:Dock(LEFT)
	CCP.DonationPrompt.Submit:SetText("Submit")
	CCP.DonationPrompt.Submit.DoClick = function(pnl)
		net.Start("nRedeemDonation")
			net.WriteInt(row, 16)
			net.WriteTable(CCP.DonationPrompt.Properties.Data)
		net.SendToServer()
	end

	CCP.DonationPrompt.Cancel = bottom:Add("DButton")
	CCP.DonationPrompt.Cancel:SetWide(120)
	CCP.DonationPrompt.Cancel:Dock(RIGHT)
	CCP.DonationPrompt.Cancel:SetText("Cancel")
	CCP.DonationPrompt.Cancel.DoClick = function(pnl)
		CCP.DonationPrompt:Close()
	end

	CCP.DonationPrompt.Properties = CCP.DonationPrompt:Add("DProperties")
	CCP.DonationPrompt.Properties:Dock(FILL)
	CCP.DonationPrompt.Properties.Data = {}

	for property, data in pairs(donation.Properties) do
		local default = data.Default(LocalPlayer())

		NewRow("Value", property, CCP.DonationPrompt.Properties, data.Type):SetValue(default)

		CCP.DonationPrompt.Properties.Data[property] = default
	end
end

hook.Add("OnDonationsChanged", "donations.OnDonationsChanged", function(ply, val)
	if ply == LocalPlayer() then
		if IsValid(CCP.DonationPanel) then
			CCP.DonationPanel.Panel:Refresh()
		end

		if IsValid(CCP.DonationPrompt) then
			CCP.DonationPrompt:Close()
		end
	end
end)