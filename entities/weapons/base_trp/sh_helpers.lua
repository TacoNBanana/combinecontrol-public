AddCSLuaFile()

function SWEP:GetMaxAmmo()
	return (self.AltWeapon and self:GetAltMode()) and self:GetAltWeapon().Clip or self.ClipSize
end

function SWEP:GetReloadTime()
	return (self.AltWeapon and self:GetAltMode()) and self:GetAltWeapon().ReloadTime or self.ReloadTime
end

function SWEP:GetFireFraction()
	return math.Clamp(math.TimeFraction(self:GetLastFire(), self:GetNextPrimaryFire(), CurTime()), 0, 1)
end

function SWEP:HasCameraControl()
	local ply = self:GetOwner()

	if CLIENT and not ply:ShouldDrawLocalPlayer() then
		return true
	end

	return ply:GetViewEntity() == ply
end

function SWEP:InScope()
	return self.Scoped and not self:IsLowered() and self:GetAimFraction() >= 0.9
end

function SWEP:ForceUnscope()
	return self.ForcedUnscope and math.InRange(self:GetFireFraction(), 0.15, 0.85)
end

function SWEP:IsLowered()
	return math.Truncate(self:GetInterpHolster(), 1) > 0 or math.Truncate(self:GetSprintFraction(), 1) > 0
end

function SWEP:IsBusy()
	local alt = self:GetInterpAlt()

	if alt != math.Round(alt) then
		return true
	end

	if self:IsReloading() then
		return true
	end

	if self:GetNextPrimaryFire() > CurTime() then
		return true
	end

	return false
end

function SWEP:IsSprinting()
	local ply = self:GetOwner()

	return ply:IsSprinting() or (ply:GetMoveType() != MOVETYPE_NOCLIP and not ply:OnGround())
end

function SWEP:IsReloading()
	return self:GetFinishReload() != 0
end

function SWEP:ViewKick(ply, kick)
	local min = Angle(0.2, 0.2, 0.1)

	ply:ViewPunchReset(math.huge)

	local ang = Angle(
		-(min.p + kick / self.RecoilDiv.x),
		-(min.y + kick / self.RecoilDiv.y),
		min.r + kick / self.RecoilDiv.z
	)

	ang.y = ang.y * math.Rand(-1, 1)

	if math.random(0, 1) == 1 then
		ang.z = -ang.z
	end

	ply:ViewPunch(ang * 0.5)

	if CLIENT then
		local mult = Lerp(self:GetCrouchFraction(), 1, 0.75)
		local eyeAng = ply:EyeAngles() + ang * 0.1 * mult

		eyeAng.r = 0

		ply:SetEyeAngles(eyeAng)
	end
end

function SWEP:SubtractDurability(min, max)
	if not self:GetItem() or not min or not max then
		return
	end

	if self:GetOwner():GetCharFlagValue("NoWeaponDegradation", false) then
		return
	end

	if self:GetItem():IsTempItem() then
		return
	end

	local decrease = 100 / math.random(min, max)

	self:SetCondition(self:GetCondition() - decrease)

	if SERVER and self:GetCondition() <= 0 then
		self:SaveItem()
	end
end

function SWEP:GetConditionInternal()
	return self:GetCondition()
end

function SWEP:ConditionProb(prob)
	if not self:GetItem() then
		return false
	end

	if self:GetOwner():GetCharFlagValue("NoWeaponDegradation", false) then
		return false
	end

	if self:GetItem():IsTempItem() then
		return false
	end

	if not prob then
		return false
	end

	return math.random(1, prob) == prob and math.random(1, math.max(self:GetConditionInternal(), 0)) == 1
end
