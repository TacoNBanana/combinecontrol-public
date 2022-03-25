SWEP.BaseCone = 0
SWEP.CurrentCone = 0

function SWEP:GetBaseCone()
	return self:AimingDownSights() and self.AimCone or self.HipCone
end

function SWEP:CrouchModifier()
	return self:AimingDownSights() and 0.9 or 0.75
end

function SWEP:CalculateSpread()
	local cone = self:GetBaseCone()
	local ply = self.Owner

	if ply:Crouching() then
		cone = cone * self:CrouchModifier()
	end

	self.BaseCone = cone
	self.CurrentCone = self:GetCurrentSpread()
end

function SWEP:GetCurrentSpread()
	local vel = self.Owner:GetVelocity():Length()
	local cone = self.BaseCone

	if self:AimingDownSights() then
		cone = math.max(cone + (vel / 10000) * 3, self.AimCone)
	else
		cone = cone + (vel / 10000)
	end

	return math.Clamp(cone, 0, 0.09)
end

function SWEP:GetRecoilModifier()
	local mod = 1

	if self.Owner:Crouching() then
		mod = mod * 0.75
	end

	if self:AimingDownSights() then
		mod = mod * 0.85
	end

	return mod
end

function SWEP:DoRecoil(mult)
	local ply = self.Owner
	local mod = self:GetRecoilModifier() * (mult or 1)

	if CLIENT and IsFirstTimePredicted() then
		ang = ply:EyeAngles()
		ang.p = ang.p - self.Recoil * 0.5 * mod
		ang.y = ang.y + math.Rand(-1, 1) * self.Recoil * 0.5 * mod

		ply:SetEyeAngles(ang)

		self:HandleBoltMovement()
	end

	ply:ViewPunch(Angle(-self.Recoil * 1.25 * mod, 0, 0))
end

if CLIENT then
	function SWEP:DoVMRecoil(mult)
		if self:AimingDownSights() then
			self.FireMove = math.Clamp(self.Recoil, 1, 3)
		else
			self.FireMove = 0.4
		end

		if self.BoltBone then
			self:HandleBoltMovement()
		end

		if not self:AimingDownSights() then
			self:ApplyVMRecoil(mult)
		end
	end
end