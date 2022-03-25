ITEM = class.Create("base_equipment")
DEFINE_BASECLASS("base_equipment")

ITEM.Name 				= "base_radio"

ITEM.Slots 				= {EQUIPMENT_RADIO}

ITEM.ChannelData 		= {}
ITEM.ActiveChannels 	= {}

ITEM.PrimaryChannel 	= 0

ITEM.MaxChannels 		= 0
ITEM.MaxActiveChannels 	= 0

ITEM.ChannelRange 		= {1, 999}

function ITEM:GetActiveChannels()
	local channels = self:GetProperty("ActiveChannels")
	local data = self:GetProperty("ChannelData")
	local tab = {}

	for k in pairs(channels) do
		local chan = data[k]

		if chan then
			tab[chan] = true
		end
	end

	return tab
end

function ITEM:GetPrimaryChannel()
	return self:GetProperty("ChannelData")[self:GetProperty("PrimaryChannel")]
end

function ITEM:CanHearChannel(chan)
	return self:GetActiveChannels()[chan] and true or false
end

function ITEM:GetInventoryOptions(ply)
	local tab = {}

	table.insert(tab, {
		Name = "Configure",
		Func = function(item, user)
			if CLIENT then
				item:OpenRadioUI()
			end
		end
	})

	table.Add(tab, BaseClass.GetInventoryOptions(self, ply))

	return tab
end

if CLIENT then
	function ITEM:Updated()
		BaseClass.Updated(self)

		local ui = CCP.RadioConfigUI

		if IsValid(ui) then
			ui:UpdateActiveButtons()
			ui:UpdatePrimaryButtons()
			ui:UpdateChannels()
		end
	end

	function ITEM:OpenRadioUI()
		CCP.RadioConfigUI = vgui.Create("DFrame")

		local ui = CCP.RadioConfigUI

		ui.Item = self

		ui:DockPadding(34, 10, 10, 10)
		ui:SetTitle("Radio Configuration")
		ui.lblTitle:SetFont("CombineControl.Window")
		ui.PerformLayout = CCFramePerformLayout
		ui:PerformLayout()

		ui.Think = UIAutoClose

		local y = 34

		ui.buttonsActive = {}
		ui.buttonsPrimary = {}
		ui.entries = {}

		function ui:UpdateActiveButtons()
			local channels = self.Item:GetProperty("ActiveChannels")
			local max = self.Item:GetProperty("MaxActiveChannels")
			local over = table.Count(channels) >= max

			for k, v in pairs(self.buttonsActive) do
				local bool = channels[k]

				v.Active = bool
				v:SetDisabled((over and not bool) and true or false)
				v:SetText(bool and "Listening" or "Listen")
			end
		end

		function ui:UpdatePrimaryButtons()
			local primary = self.Item:GetProperty("PrimaryChannel")

			for k, v in pairs(self.buttonsPrimary) do
				local bool = k == primary

				v.Active = bool
			end
		end

		function ui:UpdateChannels()
			local data = self.Item:GetProperty("ChannelData")

			for k, v in pairs(self.entries) do
				v:SetValue(data[k] or "")
			end
		end

		for i = 1, self:GetProperty("MaxChannels") do
			local entry = vgui.Create("DTextEntry", ui)

			entry:SetPos(10, y)
			entry:SetSize(60, 30)
			entry:SetFont("CombineControl.LabelSmall")
			entry:PerformLayout()

			function entry:AllowInput(val)
				if not string.find(val, "%d") then
					return true
				end
			end

			local save = vgui.Create("DButton", ui)

			save:SetPos(78, y)
			save:SetSize(60, 30)
			save:SetText("Save")

			function save:DoClick()
				net.Start("nSetRadioChannel")
					net.WriteInt(ui.Item.ID, 32)
					net.WriteInt(i, 8)
					net.WriteString(entry:GetValue())
				net.SendToServer()
			end

			local active = vgui.Create("DButton", ui)

			active:SetPos(146, y)
			active:SetSize(60, 30)

			function active:DoClick()
				net.Start("nSetRadioChannelActive")
					net.WriteInt(ui.Item.ID, 32)
					net.WriteInt(i, 8)
				net.SendToServer()
			end

			local paint = active.Paint

			function active:Paint(w, h)
				if self.Active then
					surface.SetDrawColor(60, 0, 0, 255)
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(150, 20, 20, 255)
					surface.DrawRect(1, 1, w - 2, h - 2)
				else
					paint(self, w, h)
				end
			end

			local primary = vgui.Create("DButton", ui)

			primary:SetPos(214, y)
			primary:SetSize(60, 30)
			primary:SetText("Transmit")

			function primary:DoClick()
				net.Start("nSetRadioChannelPrimary")
					net.WriteInt(ui.Item.ID, 32)
					net.WriteInt(self.Active and 0 or i, 8)
				net.SendToServer()
			end

			function primary:Paint(w, h)
				if self.Active then
					surface.SetDrawColor(60, 0, 0, 255)
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(150, 20, 20, 255)
					surface.DrawRect(1, 1, w - 2, h - 2)
				else
					paint(self, w, h)
				end
			end

			table.insert(ui.buttonsActive, active)
			table.insert(ui.buttonsPrimary, primary)
			table.insert(ui.entries, entry)

			y = y + 35
		end

		ui:UpdateActiveButtons()
		ui:UpdatePrimaryButtons()
		ui:UpdateChannels()

		ui:InvalidateLayout(true)
		ui:SizeToChildren(true, true)
		ui:Center()
		ui:MakePopup()
	end
else
	net.Receive("nSetRadioChannel", function(len, ply)
		local id = net.ReadInt(32)
		local index = net.ReadInt(8)
		local chan = net.ReadString()

		local item = GAMEMODE.Items[id]

		if not item or not item:CanInteract(ply) then
			return
		end

		if index < 1 or index > item:GetProperty("MaxChannels") then
			return
		end

		local data = item:GetProperty("ChannelData")

		chan = tonumber(chan)

		if chan then
			chan = math.Round(chan)
			chan = math.Clamp(chan, unpack(item:GetProperty("ChannelRange")))

			data[index] = chan
		else
			data[index] = nil
		end

		item:SetProperty("ChannelData", data)
	end)

	net.Receive("nSetRadioChannelActive", function(len, ply)
		local id = net.ReadInt(32)
		local index = net.ReadInt(8)

		local item = GAMEMODE.Items[id]

		if not item or not item:CanInteract(ply) then
			return
		end

		local data = item:GetProperty("ActiveChannels")
		local max = item:GetProperty("MaxActiveChannels")

		if data[index] then
			data[index] = nil
		elseif table.Count(data) + 1 <= max then
			data[index] = true
		else
			return
		end

		item:SetProperty("ActiveChannels", data)
	end)

	net.Receive("nSetRadioChannelPrimary", function(len, ply)
		local id = net.ReadInt(32)
		local index = net.ReadInt(8)

		local item = GAMEMODE.Items[id]

		if not item or not item:CanInteract(ply) then
			return
		end

		item:SetProperty("PrimaryChannel", index)
	end)
end
