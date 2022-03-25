SWEP.CrossAmount = 0

SWEP.CrossAlpha = 255
SWEP.FadeAlpha = 0

SWEP.AimTime = 0

SWEP.RTScopeMat = Material("tekka/rtscope")
SWEP.RTScopeInit = true
SWEP.RTScopeAlpha = 1

function SWEP:ShouldDrawRTScope()
	if self:ShouldLower() then
		return false
	end

	if self:IsReloading() then
		return false
	end

	if not self.RTScopeAlwaysOn and not self:AimingDownSights() then
		return false
	end

	if cookie.GetNumber( "cc_thirdperson", 0 ) == 1 then
		return false
	end

	return true
end

function SWEP:DrawRTScope()
	if not IsValid(self.VM) then
		return
	end

	local ply = self.Owner

	if self:ShouldDrawRTScope() then
		self.RTScopeAlpha = math.Approach(self.RTScopeAlpha, self.RTScopeCoverPercentage, FrameTime() * ((1 - self.RTScopeCoverPercentage) * 5))
	else
		self.RTScopeAlpha = math.Approach(self.RTScopeAlpha, 1, FrameTime() * ((1 - self.RTScopeCoverPercentage) * 5))
	end

	local x, y = ScrW(), ScrH()
	local ang

	if self.RTScopeAlternativeAngle then
		ang = self.VM:GetAngles()
	else
		ang = self.VM:GetAttachment(1).Ang
	end

	if self.ViewModelFlip then
		ang.r = ang.r - self.AimOffset.ang.z
	else
		ang.r = ang.r + self.AimOffset.ang.z
	end

	ang:RotateAroundAxis(ang:Right(), self.RTScopeRotation.right)
	ang:RotateAroundAxis(ang:Up(), self.RTScopeRotation.up)
	ang:RotateAroundAxis(ang:Forward(), self.RTScopeRotation.forward)

	local size = self.RTScopeTarget:GetMappingWidth()

	local cd = {}

	cd.x = 0
	cd.y = 0
	cd.w = size
	cd.h = size
	cd.angles = ang
	cd.origin = ply:GetShootPos()
	cd.fov = self.RTScopeFOV
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false

	render.PushRenderTarget(self.RTScopeTarget)

	render.SetViewPort(0, 0, size, size)
		if self.RTScopeAlpha < 1 or self.RTScopeInit then
			render.RenderView(cd)

			if self.RTScopeCallback then
				self:RTScopeCallback()
			end

			self.RTScopeInit = false
		end

		ang = ply:EyeAngles()
		ang.p = ang.p + self.BlendAng.x
		ang.y = ang.y + self.BlendAng.y
		ang.r = ang.r + self.BlendAng.z
		ang = -ang:Forward()

		local light = render.ComputeLighting(ply:GetShootPos(), ang)

		cam.Start2D()
			local alpha = 255 * self.RTScopeAlpha

			if self.RTScopeReticle != true then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(self.RTScopeReticle)
				surface.DrawTexturedRect(0, 0, size, size)
			end

			surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], alpha)
			surface.SetTexture(self.RTScopeCover)
			surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 0)
		cam.End2D()
	render.SetViewPort(0, 0, x, y)
	render.SetRenderTarget()

	if self.RTScopeMat then
		self.RTScopeMat:SetTexture("$basetexture", self.RTScopeTarget)
	end
end

function SWEP:CrosshairVisible()
	if self.DevFrozen then
		return false
	end

	if self:ShouldLower() then
		return false
	end

	if self:IsReloading() then
		return false
	end

	if self.Owner:IsSuperAdmin() and GetConVar("developer"):GetBool() then
		return true
	end

	if self:AimingDownSights() then
		return false
	end

	if self.Owner:OverlayMode() == OVERLAY_TARGET then
		return false
	end

	return self:GetFiremode().UseCrosshair
end

function SWEP:DoDrawCrosshair(x, y)
	local FT = FrameTime()
	local ply = self.Owner

	if ply:ShouldDrawLocalPlayer() then
		return true
	end

	if self:CrosshairVisible() then
		self.CrossAlpha = Lerp(FT * 15, self.CrossAlpha, 255)
	else
		self.CrossAlpha = Lerp(FT * 15, self.CrossAlpha, 0)
	end

	self.CrossAmount = Lerp(FT * 10, self.CrossAmount, (self.CurrentCone * 350) * (90 / math.Clamp(GetConVar("fov_desired"):GetInt(), 75, 90)))

	surface.SetDrawColor(0, 0, 0, self.CrossAlpha * 0.75) -- background

	surface.DrawRect(x - 13 - self.CrossAmount, y - 1, 12, 3) -- left
	surface.DrawRect(x + 3 + self.CrossAmount, y - 1, 12, 3) -- right
	surface.DrawRect(x - 1, y - 13 - self.CrossAmount, 3, 12) -- up
	surface.DrawRect(x - 1, y + 3 + self.CrossAmount, 3, 12) -- down

	surface.SetDrawColor(255, 255, 255, self.CrossAlpha) -- Foreground

	surface.DrawRect(x - 12 - self.CrossAmount, y, 10, 1) -- left
	surface.DrawRect(x + 4 + self.CrossAmount, y, 10, 1) -- right
	surface.DrawRect(x, y - 12 - self.CrossAmount, 1, 10) -- up
	surface.DrawRect(x, y + 4 + self.CrossAmount, 1, 10) -- down

	return true
end

function SWEP:DrawAimpoint()
	if not self.UseAimpoint or not self:AimingDownSights() or self:IsReloading() then
		return
	end

	if self.Owner:OverlayMode() == OVERLAY_TARGET then
		return
	end

	diff = self:AimPosDiff(self.AimOffset.pos, self.AimOffset.ang)

	-- draw the reticle only when it's close to center of the aiming position
	if diff > 0.9 and diff < 1.1 then
		cam.IgnoreZ(true)
			local dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
			local col = self.AimpointColor

			col.a = (0.13 - dist) / 0.13 * 255

			local ang = self.VM:GetAngles()

			ang:RotateAroundAxis(ang:Right(), -self.BlendAng.x)

			if self.ViewModelFlip then
				ang:RotateAroundAxis(ang:Up(), self.BlendAng.y)
				ang:RotateAroundAxis(ang:Forward(), self.BlendAng.z)
			else
				ang:RotateAroundAxis(ang:Up(), -self.BlendAng.y)
				ang:RotateAroundAxis(ang:Forward(), -self.BlendAng.z)
			end

			local pos = EyePos() + ang:Forward() * 100

			render.SetMaterial(self.AimpointMaterial)
			render.DrawSprite(pos, self.AimpointSize, self.AimpointSize, col)
		cam.IgnoreZ(false)
	end
end

function SWEP:DrawHUD()
	if CCP.IronDev then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawLine(0, ScrH() / 2, ScrW(), ScrH() / 2)
		surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, ScrH())
	end
end