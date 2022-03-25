PANEL = {}

local path = "combinecontrol/maps/" .. game.GetMap() .. ".png"

function PANEL:Init()
	if GAMEMODE:MapEnabled() then
		net.Start("nDownloadMinimap")
			if file.Exists(path, "DATA") then
				net.WriteString(util.CRC(file.Read(path, "DATA")))
			else
				net.WriteString("")
			end
		net.SendToServer()
	end

	self.Zoom = 1
	self.OffsetX = 0
	self.OffsetY = 0

	self.Admin = false

	self.GPS = LocalPlayer():HasItem("gps")
	self.SkyNET = LocalPlayer():GetCharFlagValue("IsSkyNET", false)
end

function PANEL:OnMousePressed(code)
	if code == MOUSE_LEFT then
		self.StoredX, self.StoredY = input.GetCursorPos()

		self:MouseCapture(true)
	end
end

function PANEL:OnMouseReleased(code)
	if code == MOUSE_LEFT then
		self.StoredX = nil
		self.StoredY = nil

		self:MouseCapture(false)
	end
end

function PANEL:OnMouseWheeled(delta)
	local old = self.Zoom

	self.Zoom = math.Clamp(self.Zoom + delta * 0.5, 1, 5)

	if self.Zoom - old == 0 then
		return
	end

	self.OffsetX = self.OffsetX * (self.Zoom / old)
	self.OffsetY = self.OffsetY * (self.Zoom / old)
end

function PANEL:Think()
	if self.StoredX then
		local offsetX, offsetY = input.GetCursorPos()

		self.OffsetX = self.OffsetX + (offsetX - self.StoredX)
		self.OffsetY = self.OffsetY + (offsetY - self.StoredY)

		self.StoredX = offsetX
		self.StoredY = offsetY
	end
end

local res = 1 / 32

function PANEL:TranslatePos(vec)
	local x = math.Round(vec.y * res) + 512
	local y = math.Round(vec.x * res) + 512

	x = math.Remap(x, 0, 1024, 1024, 0)
	y = math.Remap(y, 0, 1024, 1024, 0)

	return x, y
end

local gridScale = util.GridScale

function PANEL:DrawZone(x, y, col)
	local size = (gridScale / 32)

	x = self.CacheX + (math.floor(x / size) * size) * self.Scale
	y = self.CacheY + (math.floor(y / size) * size) * self.Scale

	surface.SetDrawColor(col)
	surface.DrawRect(x + 1, y + 1, size * self.Scale, size * self.Scale)
end

local zoneColor = Color(0, 127, 31, 20)

function PANEL:DrawZones()
	if self.Admin then
		return
	end

	if self.SkyNET then
		for _, v in pairs(player.GetAll()) do
			if v == LocalPlayer() or (v:GetNoDraw() and not v:InVehicle()) then
				continue
			end

			if v:GetCharFlagValue("IsSkyNET", false) then
				continue
			end

			local x, y = self:TranslatePos(v:GetPos())

			self:DrawZone(x, y, zoneColor)
		end
	end
end

function PANEL:DrawPoint(x, y, col, blinking, blinkColor)
	x = self.CacheX + x * self.Scale
	y = self.CacheY + y * self.Scale

	if blinking and CurTime() % 2 > 1 then
		col = blinkColor or color_white
	end

	x = math.Round(x)
	y = math.Round(y)

	surface.SetDrawColor(col)
	surface.DrawLine(x - math.ceil(self.Zoom), y, x + math.ceil(self.Zoom), y)
	surface.DrawLine(x, y - math.ceil(self.Zoom), x, y + math.ceil(self.Zoom))
end

local aiColor = Color(255, 191, 0)

function PANEL:DrawPoints()
	if self.SkyNET or self.Admin then
		for _, v in pairs(ents.FindByClass("term_ai*")) do
			local x, y = self:TranslatePos(v:GetPos())

			self:DrawPoint(x, y, aiColor)
		end
	end

	if self.Admin then
		for _, v in pairs(player.GetAll()) do
			if v:Team() == TEAM_UNASSIGNED then
				continue
			end

			local x, y = self:TranslatePos(v:GetPos())

			self:DrawPoint(x, y, team.GetColor(v:Team()))
		end

		local x, y = self:TranslatePos(LocalPlayer():GetPos())

		self:DrawPoint(x, y, team.GetColor(LocalPlayer():Team()), true)

		return
	end

	if self.GPS or self.SkyNET then
		local x, y = self:TranslatePos(LocalPlayer():GetPos())

		self:DrawPoint(x, y, team.GetColor(LocalPlayer():Team()), true)
	end

	if self.SkyNET then
		for _, v in pairs(player.GetAll()) do
			if v == LocalPlayer() or (v:GetNoDraw() and not v:InVehicle()) then
				continue
			end

			if not v:GetCharFlagValue("IsSkyNET", false) then
				continue
			end

			local x, y = self:TranslatePos(v:GetPos())

			self:DrawPoint(x, y, team.GetColor(v:Team()))
		end
	end
end

function PANEL:Paint(w, h)
	if not GAMEMODE:MapEnabled() then
		draw.SimpleText("Map unavailable.", "CombineControl.LabelMassive", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

		return
	end

	if GAMEMODE.MinimapBuffer or not GAMEMODE.MinimapMaterial then
		local text = "Loading" .. string.rep(".", (CurTime() % 3) + 1)

		draw.SimpleText(text, "CombineControl.LabelMassive", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		draw.SimpleText("This may take a while... (you can close this window)", "CombineControl.LabelSmall", w * 0.5, h * 0.5, Color(100, 100, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

		return
	end

	self.OffsetX = math.Clamp(self.OffsetX, (-w * 0.5) * self.Zoom, (w * 0.5) * self.Zoom)
	self.OffsetY = math.Clamp(self.OffsetY, (-w * 0.5) * self.Zoom, (h * 0.5) * self.Zoom)

	local x = w * 0.5 - (w * 0.5 * self.Zoom) + self.OffsetX
	local y = h * 0.5 - (h * 0.5 * self.Zoom) + self.OffsetY

	self.CacheX = x
	self.CacheY = y

	self.Scale = (h / 1024) * self.Zoom

	surface.SetMaterial(GAMEMODE.MinimapMaterial)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(x, y, w * self.Zoom, h * self.Zoom)

	self:DrawZones()

	surface.SetDrawColor(0, 0, 0, 150)

	for i = gridScale / 32, 1023, gridScale / 32 do
		local scaled = math.floor(i * self.Scale)

		surface.DrawLine(math.floor(x) + scaled, math.floor(y), math.floor(x) + scaled, math.floor(y) + h * self.Zoom)
		surface.DrawLine(math.floor(x), math.floor(y) + scaled, math.floor(x) + h * self.Zoom, math.floor(y) + scaled)
	end

	local mouseX, mouseY = self:ScreenToLocal(input.GetCursorPos())

	local active = math.InRange(mouseX, math.max(x, 0), math.min(w, x + w * self.Zoom)) and math.InRange(mouseY, math.max(y, 0), math.min(h, y + h * self.Zoom))
	local offset = 20

	self:SetCursor(active and "blank" or "arrow")

	if active then
		surface.SetDrawColor(200, 0, 0, 255)

		surface.DrawLine(0, mouseY, math.max(mouseX - offset, 0), mouseY)
		surface.DrawLine(mouseX + offset, mouseY, h, mouseY)
		surface.DrawLine(mouseX, 0, mouseX, math.max(mouseY - offset, 0))
		surface.DrawLine(mouseX, mouseY + offset, mouseX, h)
	end

	self:DrawPoints()

	if active then
		local mapX = mouseY - y
		local mapY = mouseX - x

		-- Game coordinates
		local gridX = -((mapX - 512 * self.Scale) * (32 / self.Scale))
		local gridY = -((mapY - 512 * self.Scale) * (32 / self.Scale))

		gridX, gridY = util.ToGrid(gridX, gridY)

		gridX = math.Truncate(gridX)
		gridY = math.Truncate(gridY)

		DisableClipping(true)
			draw.SimpleText(string.format("%03i %03i", gridX + util.GridNoiseX, gridY + util.GridNoiseY), "BudgetLabel", mouseX + offset, mouseY, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end
end

derma.DefineControl("CCMap", "", PANEL, "DPanel")
