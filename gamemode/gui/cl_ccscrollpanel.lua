local PANEL = {}

function PANEL:Init()
	self.ScrollAmount = draw.GetFontHeight("ChatFont")

	local outer = self
	local canvas = vgui.Create("EditablePanel", self)
		canvas:SetSize(self:GetWide() - 15, 0)
		function canvas:Paint(w, h)
			return true
		end
	self.Canvas = canvas

	local up = vgui.Create("CCScrollButton", self)
		up:SetPos(self:GetWide() - 15, 0)
		up:SetDirection(1)
	self.ScrollUp = up

	local down = vgui.Create("CCScrollButton", self)
		down:SetPos(self:GetWide() - 15, 0)
		down:SetDirection(-1)
	self.ScrollDown = down

	local grip = vgui.Create("CCScrollGrip", self)
		grip:SetPos(self:GetWide() - 15, 15)
	self.ScrollGrip = grip

	self:UpdateLayout()
	self:HideScrollbar()
end

function PANEL:Paint(w, h)
	draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 100))
	surface.SetDrawColor(Color(0, 0, 0, 70))
	surface.DrawOutlinedRect(0, 0, w, h)
	return true
end

function PANEL:UpdateLayout()
	self.ScrollUp:SetPos(self:GetWide() - 15, 0)
	self.ScrollDown:SetPos(self:GetWide() - 15, self:GetTall() - 15)
	self.ScrollGrip:SetPos(self:GetWide() - 15, 0)
	self:UpdateScrollbar()
end

function PANEL:Think()
	if self.GripY then
		local x, y, w, h = self.ScrollGrip:GetBounds()
		local dy = gui.MouseY() - self.MouseY
		local newy = math.Clamp(self.GripY + dy, 15, self:GetTall() - h - 15)

		self.ScrollGrip:SetPos(x, newy)

		local trackHeight = self:GetTall() - 30
		local amountHidden = trackHeight - h
		local amountAbove = y - 15
		self.Canvas:SetPos(0, -amountAbove/amountHidden*(self.Canvas:GetTall() - self:GetTall()))
	end
end

function PANEL:OnGripped(gripped)
	if gripped then
		local _, y = self.ScrollGrip:GetPos()
		self.GripY = y
		self.MouseY = gui.MouseY()
	else
		self.GripY, self.MouseY = nil
	end
end

function PANEL:ResizeCanvas(height, forcescroll)
	if height == self.Canvas:GetTall() then return end
	local scrolled = not self:IsAtBottom()

	self.Canvas:SetSize(self:GetWide() - 15, height)

	if height > self:GetTall() and not self.NoScrollbar then
		self.ScrollUp:Show()
		self.ScrollDown:Show()
		self.ScrollGrip:Show()
	else
		self.ScrollUp:Hide()
		self.ScrollDown:Hide()
		self.ScrollGrip:Hide()
	end

	if self.Autoscroll and (not scrolled or forcescroll) then
	-- if self.Autoscroll and not scrolled then
		self.Canvas:SetPos(0, self:GetBottom())
	else
		local x, y = self.Canvas:GetPos()
		self.Canvas:SetPos(0, math.Clamp(y, self:GetBottom(), 0))
	end

	self:UpdateScrollbar()
end

function PANEL:UpdateScrollbar()
	local canvasHeight = self.Canvas:GetTall()
	local viewHeight = self:GetTall()

	-- local x, y, w, h = self:GetBounds()
	local trackHeight = viewHeight - 30
	local percentShown = math.Clamp(viewHeight / canvasHeight, 0, 1)
	self.ScrollGrip:SetSize(15, math.Clamp(math.ceil(percentShown * trackHeight), 30, trackHeight))

	local x, y, w, h = self.ScrollGrip:GetBounds()
	local _, offset = self.Canvas:GetPos()
	local amountHidden = canvasHeight - viewHeight
	local amountAbove = -offset
	self.ScrollGrip:SetPos(x, amountAbove/amountHidden*(trackHeight - h) + 15)
end

function PANEL:MoveCanvas(delta)
	local x, y, w, h = self.Canvas:GetBounds()
	if self:GetTall() >= w or delta == 0 then return end
	self.Canvas:SetPos(x, math.Clamp(y + delta, self:GetTall() - self.Canvas:GetTall(), 0))
	self:UpdateScrollbar()
end

function PANEL:OnMouseWheeled(delta)
	if self:GetTall() > self.Canvas:GetTall() then return end
	self:MoveCanvas(delta*self.ScrollAmount)
end

function PANEL:GetTop()
	return 0
end

function PANEL:GetBottom()
	if self.PreferBottom then
		return self:GetTall() - self.Canvas:GetTall()
	end
	return self.Canvas:GetTall() > self:GetTall() and self:GetTall() - self.Canvas:GetTall() or 0
end

function PANEL:MoveToBottom()
	self.Canvas:SetPos(0, self:GetBottom())
	self:UpdateScrollbar()
end

function PANEL:IsAtBottom()
	local _, y = self.Canvas:GetPos()
	return y == self:GetBottom()
end

function PANEL:ShowScrollbar(force)
	if self.NoScrollbar then
		return
	elseif not force and self.Canvas:GetTall() < self:GetTall() then
		return
	end
	self.ScrollUp:Show()
	self.ScrollDown:Show()
	self.ScrollGrip:Show()
end

function PANEL:HideScrollbar()
	self.ScrollUp:Hide()
	self.ScrollDown:Hide()
	self.ScrollGrip:Hide()
end

derma.DefineControl("CCScrollPanel", "", PANEL, "EditablePanel")

local GRIP = {}

function GRIP:Init()
	self:SetWide(15)
	self:Hide()
end

function GRIP:OnMousePressed(key)
	self:MouseCapture(true)
	self:GetParent():OnGripped(true)
end

function GRIP:OnMouseReleased(key)
	self:MouseCapture(false)
	self:GetParent():OnGripped(false)
end

function GRIP:Paint(w, h)
	surface.SetDrawColor(57, 57, 57)
	surface.DrawRect(1, 1, w - 1, h - 1)
	surface.SetDrawColor(35, 35, 35)
	surface.DrawOutlinedRect(0, 0, w, h)
	return true
end

derma.DefineControl("CCScrollGrip", "", GRIP, "EditablePanel")

local BUTTON = {}

function BUTTON:Init()
	self:SetSize(15, 15)
	self:Hide()
end

function BUTTON:SetDirection(dir)
	self:SetFont("marlett")
	self:SetText(dir > 0 and "t" or "6")
	self.Direction = dir
end

function BUTTON:OnMousePressed()
	self:MouseCapture(true)
	self.Pressed = CurTime()
	self.NextScroll = CurTime() + 0.5
	self:GetParent():OnMouseWheeled(self.Direction)
end

function BUTTON:OnMouseReleased()
	self:MouseCapture(false)
	self.Pressed = nil
end

function BUTTON:Think()
	if self.Pressed then
		if CurTime() > self.NextScroll then
			self:GetParent():OnMouseWheeled(self.Direction * math.ceil((CurTime() - self.Pressed)*0.5))
			self.NextScroll = CurTime() + 0.05
		end
	end
end

derma.DefineControl("CCScrollButton", "", BUTTON, "DButton")
