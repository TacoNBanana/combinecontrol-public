CHAT_WIDTH	= 600
CHAT_HEIGHT	= 300

local CHATBOX = {}

function CHATBOX:Init()
	local chatbox = self
	self:SetSize(CHAT_WIDTH, CHAT_HEIGHT)
	self:MakePopup()

	self.Buffer = {}
	self.BufferHeight = 0
	self.Tabs = cookie.GetNumber("cc_chatfilter", TAB_DEFAULT)

	-- local layer = vgui.Create("DPanel", self)
		-- layer:SetSize(self:GetSize())
		-- function layer:Paint(w, h) return true end
	-- self.Layer = layer

	local scroll = vgui.Create("CCScrollPanel", self)
		scroll.Autoscroll = true
		scroll.PreferBottom = true
		scroll.ScrollAmount = draw.GetFontHeight("CombineControl.ChatNormal")
		scroll:SetPos(10, 40)
		-- scroll:SetSize(GAMEMODE.ChatWidth - 20, cookie.GetNumber("cc_chatheight", 300) - 80)
		scroll:SetSize(CHAT_WIDTH - 20, CHAT_HEIGHT - 80)
		scroll:UpdateLayout()

		function scroll:Paint(w, h)
			-- surface.SetDrawColor(0, 0, 0)
			-- surface.DrawOutlinedRect(0, 0, w, h)

			if chatbox.IsOpen then
				surface.SetDrawColor(0, 0, 0, 70)
				surface.DrawRect(0, 0, w, h)
				surface.SetDrawColor(0, 0, 0, 100)
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end

	self.Scroll = scroll

	local canvas = scroll.Canvas
		local nameCol = Color(0, 0, 0)
		local textCol = Color(0, 0, 0)
		local outlineCol = Color(0, 0, 0)
		function canvas:Paint(w, h)
			-- surface.SetDrawColor(0, 255, 0)
			-- surface.DrawOutlinedRect(0, 0, w, h)

			local diff = canvas:GetTall() - scroll:GetTall()
			diff = diff > 0 and diff or 0
			local _, cy = canvas:GetPos()
			local limit = scroll:GetTall() + diff + cy - 3
			local y = h - 3

			local ct = 0

			for i = #chatbox.Buffer, 1, -1 do
				ct = ct + 1

				local t = chatbox.Buffer[i]
				local lifetime = CurTime() - t.Received
				local alpha = 255
				if not chatbox.IsOpen then
					if lifetime >= 15 then
						break
					elseif lifetime > 10 then
						alpha = (15 - lifetime)*0.2 * 255
					end
				end
				textCol.r, textCol.g, textCol.b, textCol.a = t.TextColor.r, t.TextColor.g, t.TextColor.b, alpha
				outlineCol.a = alpha

				if bit.band(chatbox.Tabs, t.Tabs) ~= 0 then
					for j = #t.Lines, t.Name and 2 or 1, -1 do
						-- print(t.Lines[i])
						y = y - draw.GetFontHeight(t.Font)
						draw.SimpleTextOutlined(t.Lines[j], t.Font, 5, y, textCol, 0, 0, 1, outlineCol)
					end
					if t.Name then
						local x = 5
						nameCol.r, nameCol.g, nameCol.b, nameCol.a = t.NameColor.r, t.NameColor.g, t.NameColor.b, alpha
						y = y - draw.GetFontHeight(t.Font)
						draw.SimpleTextOutlined(t.Name, t.Font, x, y, nameCol, 0, 0, 1, outlineCol)
						x = x + t.NameWidth
						draw.SimpleTextOutlined(t.Lines[1], t.Font, x, y, textCol, 0, 0, 1, outlineCol)
					end
					if (h - y) > limit then
						break
					end
				end
			end
		end
	self.Canvas = canvas

	local input = vgui.Create("CCChatInput", self)
		input:SetSize(self:GetWide() - 20, 20)
		input:SetPos(10, self:GetTall() - input:GetTall() - 10)
	self.Input = input

	local closeBtn = vgui.Create("DButton", self)
		closeBtn:SetFont("marlett")
		closeBtn:SetText("r")
		closeBtn:SetSize(20, 20)
		closeBtn:SetPos(self:GetWide() - closeBtn:GetWide() - 10, 10)

		function closeBtn:DoClick()
			chatbox:Hide()
		end
	self.CloseButton = closeBtn

	local function doClick(self)
		self:SetColor(Color(200, 200, 200))
		if bit.band(chatbox.Tabs, self.Tab) ~= 0 then
			chatbox.Tabs = bit.band(chatbox.Tabs, bit.bnot(self.Tab))
		else
			chatbox.Tabs = bit.bor(chatbox.Tabs, self.Tab)
		end
		cookie.Set("cc_chatfilter", chatbox.Tabs)
		chatbox:RecalculateBuffer()
	end
	local function paint(self, w, h)
		surface.SetDrawColor(40, 40, 40, 255)
		surface.DrawRect(0, 0, w, h)
		if bit.band(chatbox.Tabs, self.Tab) == 0 then
			surface.SetDrawColor(30, 30, 30, 255)
			surface.DrawRect(1, 1, w - 2, h - 2)
			return
		end
		surface.SetDrawColor(60, 60, 60, 255)
		surface.DrawRect(1, 1, w - 2, h - 2)
	end

	self.TabButtons = {}
	self.TabLookup = {}
	local tabs = {
		{"LOOC",	TAB_LOOC},
		{"OOC",		TAB_OOC},
		{"IC",		TAB_IC},
		{"Admin",	TAB_ADMIN},
		{"PM",		TAB_PRIVMSG},
		{"Radio",	TAB_RADIO},
	}
	local lastBtn
	for k, t in pairs(tabs) do
		local btn = vgui.Create("DButton", self)
			btn:SetFont("CombineControl.LabelSmall")
			btn:SetText(t[1])
			btn:SetSize(60, 20)
			btn:SetPos(10, 10)
			if lastBtn then
				btn:MoveRightOf(lastBtn, 10)
			else
				btn:SetPos(10, 10)
			end
			btn.Tab = t[2]
			btn.DoClick = doClick
			btn.Paint = paint

		self.TabLookup[t[2]] = btn
		self.TabButtons[#self.TabButtons + 1] = btn
		lastBtn = btn
	end
end

function CHATBOX:Show()
	self.IsOpen = true
	self:SetKeyboardInputEnabled(true)
	self:SetMouseInputEnabled(true)

	for k, v in pairs(self.TabButtons) do
		v:Show()
	end

	self.Scroll.NoScrollbar = false
	self.Scroll:ShowScrollbar()

	self.CloseButton:Show()
	self.Input:Show()
	self.Input:RequestFocus()
	self.Input.ChatHistoryIndex = 0
end

function CHATBOX:Hide()
	self.IsOpen = false
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(false)

	for k, v in pairs(self.TabButtons) do
		v:Hide()
	end

	self.Scroll.NoScrollbar = true
	self.Scroll:HideScrollbar()
	self.Scroll:MoveToBottom()

	self.CloseButton:Hide()
	self.Input:Hide()
	self.Input:SetText("")

	net.Start("nSetTyping")
		net.WriteFloat(0)
	net.SendToServer()
end

-- TODO: This is really ugly, but markup is worse.
function CHATBOX:AddMessage(t)
	surface.SetFont(t.Font)

	if t.Name then
		MsgC(t.NameColor, t.Name, ": ")
	end
	MsgC(t.TextColor, t.ConsoleText or t.Text)
	MsgN()

	if t.Name then
		t.Name = t.Name .. ": "
		t.NameWidth = surface.GetTextSize(t.Name)
		t.Lines = GAMEMODE:FormatText(t.Name .. t.Text, t.Font, CHAT_WIDTH - 45, true)
		t.Lines[1] = t.Lines[1]:sub(#t.Name + 1)
	else
		t.Lines = GAMEMODE:FormatText(t.Text, t.Font, CHAT_WIDTH - 45, true)
	end
	t.Height = #t.Lines * draw.GetFontHeight(t.Font)

	if t.Tabs == TAB_CURRENT then
		-- TAB_CURRENT just uses whatever the player is filtering for, so it's always visible.
		-- May be a bad idea.
		t.Tabs = self.Tabs
	end
	t.Received = CurTime()

	self.Buffer[#self.Buffer + 1] = t

	if bit.band(self.Tabs, t.Tabs) ~= 0 then
		self.BufferHeight = self.BufferHeight + t.Height

		-- mother fucker!
		while self.BufferHeight > 2^15-1 do
			local line = table.remove(self.Buffer, 1)
			self.BufferHeight = self.BufferHeight - line.Height
		end

		self.Scroll:ResizeCanvas(self.BufferHeight)
	else
		local btn = self.TabLookup[t.Tabs]
		btn:SetColor(Color(255, 50, 50))
	end

	if not system.HasFocus() and bit.band(self.Tabs, t.Tabs) ~= 0
		and cookie.GetNumber("cc_flashwindow", 1) == 1
	then
		system.FlashWindow()
	end
end

function CHATBOX:RecalculateBuffer()
	local visibleHeight = 0
	for k, t in pairs(self.Buffer) do
		if bit.band(self.Tabs, t.Tabs) ~= 0 then
			visibleHeight = visibleHeight + t.Height
		end
	end
	self.BufferHeight = visibleHeight
	self.Scroll:ResizeCanvas(visibleHeight)
end

function CHATBOX:AddText(str, color, font)
	local class = GAMEMODE.MessageTypes.INFO
	self:AddMessage(table.Merge(table.Copy(class), {
		Name		= false,
		Class		= class,
		Font		= font or assert(class.Font),
		TextColor	= color or assert(class.TextColor),
		Text		= str
	}))
end

function CHATBOX:Paint(w, h)
	if self.IsOpen then
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(30, 30, 30, 200))
	end
	return true
end

derma.DefineControl("CCChat", "", CHATBOX, "EditablePanel")
