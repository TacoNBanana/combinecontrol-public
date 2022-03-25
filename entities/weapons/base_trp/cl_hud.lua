local scopeColor = Color(0, 161, 255)
local dot = Circles.New(CIRCLE_OUTLINED, 4, 0, 0, 2)

dot:SetDistance(1)
dot:SetColor(scopeColor)

local dev = GetConVar("developer")

function SWEP:DoDrawCrosshair(x, y)
	if self.Scoped then
		if self:InScope() and not self:ForceUnscope() then
			dot:SetPos(x, y)
			dot()
		end

		if not LocalPlayer():IsDeveloper() or not dev:GetBool() then
			render.OverrideBlend(false)

			return true
		end
	end

	x = x - 1
	y = y - 1

	local half = math.rad(self:GetOwner():GetFOV()) * 0.5
	local ref = 320 / math.tan(half)

	local offset = math.Round(self:GetCurrentSpread() * ref * (ScrH() / 480))

	surface.SetDrawColor(255, 255, 255)

	render.OverrideBlend(true, BLEND_ONE_MINUS_DST_COLOR, BLEND_ZERO, BLENDFUNC_ADD)

	if math.Clamp(1 - self:GetInterpHolster() - self:GetInterpSprint() - self:GetInterpAlt(), 0, 1) >= 0.5 then
		surface.DrawRect(x, y, 2, 2)

		local length = 5

		surface.DrawRect(x - offset - length, y, length, 2) -- Left
		surface.DrawRect(x + offset + 2, y, length, 2) -- Right

		length = 2

		surface.DrawRect(x, y - offset - length, 2, length) -- Up
		surface.DrawRect(x, y + offset + 2, 2, length) -- Down
	end

	render.OverrideBlend(false)

	return true
end

local circle = Circles.New(CIRCLE_FILLED, 20, 0, 0)

circle:SetDistance(1)

local function roundedBox(bordersize, x, y, w, h)
	x = math.Round(x)
	y = math.Round(y)
	w = math.Round(w)
	h = math.Round(h)

	bordersize = math.min(math.Round(bordersize), math.floor(w / 2), math.floor(h / 2))

	surface.DrawRect(x + bordersize, y, w - bordersize * 2, h)
	surface.DrawRect(x, y + bordersize, bordersize, h - bordersize * 2)
	surface.DrawRect(x + w - bordersize, y + bordersize, bordersize, h - bordersize * 2)

	circle:SetRadius(bordersize)
	circle:SetAngles(0, 90)

	circle:SetPos(x + bordersize, y + bordersize)
	circle:SetRotation(180)

	circle()

	circle:SetPos(x + w - bordersize, y + bordersize)
	circle:SetRotation(-90)

	circle()

	circle:SetPos(x + bordersize, y + h - bordersize)
	circle:SetRotation(90)

	circle()

	circle:SetPos(x + w - bordersize, y + h - bordersize)
	circle:SetRotation(0)

	circle()
end

function SWEP:DrawHUDBackground()
	if not self:HasCameraControl() then
		return
	end

	local x = ScrW() * 0.5
	local y = ScrH() * 0.5

	local ply = self:GetOwner()

	if ply:ShouldDrawLocalPlayer() then
		local vec = (ply:EyeAngles() + ply:GetViewPunchAngles()):Forward()
		local trace = util.TraceLine({
			start = ply:GetShootPos(),
			endpos = ply:EyePos() + (vec * 10000),
			filter = {ply}
		})

		local tab = trace.HitPos:ToScreen()

		if tab then
			self:DoDrawCrosshair(tab.x, tab.y)

			x = tab.x
			y = tab.y
		end
	else
		self:DoDrawCrosshair(x, y)
	end

	if not self:InScope() or self:ForceUnscope() then
		return
	end

	local width = ScreenScale(300)
	local height = ScreenScale(150)

	local halfWidth = width * 0.5
	local halfHeight = height * 0.5

	draw.SimpleText(math.Round(self:GetZoomAmount(), 1) .. "x", "CombineControl.Scope", x + halfWidth - 50, y + halfHeight - 5, scopeColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

	surface.SetDrawColor(255, 255, 255, 255)

	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilFailOperation(STENCIL_REPLACE)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()

	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(1)
	render.SetStencilCompareFunction(STENCIL_NEVER)

	roundedBox(ScreenScale(1 / 0.15), x - halfWidth, y - halfHeight, width, height)

	render.SetStencilCompareFunction(STENCIL_NOTEQUAL)

	surface.SetDrawColor(0, 0, 0, 253 or 0)
	surface.DrawRect(0, 0, ScrW(), ScrH())

	render.SetStencilEnable(false)
end

local mat = Material("pp/toytown-top")

local function drawBlur(passes, height)
	cam.Start2D()
		surface.SetMaterial(mat)
		surface.SetDrawColor(255, 255, 255, 255)

		for i = 1, passes do
			render.CopyRenderTargetToTexture(render.GetScreenEffectTexture())

			surface.DrawTexturedRectUV(0, 0, ScrW(), height, 0, 0, 1, 0.99)
			surface.DrawTexturedRectUV(0, ScrH() - height, ScrW(), height, 1, 0.99, 0, 0)
		end

	cam.End2D()
end

function SWEP:RenderScreenspaceEffects()
	local val = self:GetInterpAim()

	if self.Scoped then
		val = val - (1 - self:GetInterpHolster())
	end

	drawBlur(3, ScrH() * math.RemapC(val, 0, 1, 0, 0.55))
end

function SWEP:GetHudText()
	local ammo, mode

	ammo = self:Clip1()

	if self:GetAltMode() then
		local weapon = self:GetAltWeapon()

		if weapon.Clip == -1 then
			return
		end

		ammo = self:Clip1()
		mode = weapon.Name
	else
		local firemode = self:GetFiremode()

		if firemode == -1 then
			mode = "Full-auto"
		elseif firemode == 0 then
			mode = "Semi-auto"
		else
			mode = string.format("%s-round burst", firemode)
		end

		if self.ClipSize == -1 then
			return
		else
			ammo = string.format("%s / %s", ammo, self.ClipSize)
		end
	end

	if self:GetMalfunction() then
		mode = "Jammed"
	end

	return ammo, mode
end
