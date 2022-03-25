SWEP.BlendPos = Vector()
SWEP.BlendAng = Vector()

SWEP.RecoilPos = Vector()
SWEP.RecoilAng = Angle()

SWEP.OldDelta = Angle()
SWEP.AngDiff = Angle()

SWEP.AngleDelta = Angle()
SWEP.AngleDelta2 = Angle()

SWEP.PosMod = Vector()
SWEP.AngMod = Vector()

SWEP.RunTime = 0

-- The default viewmodel is used as the source for bullet tracers, so it needs to be in the correct position
function SWEP:GetViewModelPosition(pos, ang)
	if not self.VM then
		return
	end

	pos = self.VM:GetPos()
	ang = self.VM:GetAngles()

	return pos, ang
end

function SWEP:ProcessVMSway(FT, eye)
	local delta = Angle(eye.p, eye.y, 0) - self.OldDelta

	delta.p = math.Clamp(delta.p, -5, 5)

	self.AngleDelta2 = LerpAngle(math.Clamp(FT * 12, 0, 1), self.AngleDelta2, self.AngleDelta)
	self.AngDiff.p = self.AngleDelta.p - self.AngleDelta2.p
	self.AngDiff.y = self.AngleDelta.y - self.AngleDelta2.y
	self.AngleDelta = LerpAngle(math.Clamp(FT * 10, 0, 1), self.AngleDelta, delta + self.AngDiff)
	self.AngleDelta.y = math.Clamp(self.AngleDelta.y, -25, 25)

	self.OldDelta.p = eye.p
	self.OldDelta.y = eye.y
end

-- Sets up the position and angles of the custom VM
function SWEP:HandleVMOffsets()
	local CT = UnPredictedCurTime()
	local FT = FrameTime()

	local eye = EyeAngles()
	local ply = self.Owner

	local vel = ply:GetVelocity()
	local len = vel:Length()
	local walk = ply:GetWalkSpeed()

	local pos = Vector()
	local ang = Vector()

	self:ProcessVMSway(FT, eye)

	if len < (walk * self.RunThreshold) or not ply:OnGround() then
		-- Idle sway
		local mult = 1

		if CCP.IronDev then
			mult = 0
		end

		local sin = math.sin(CT) * mult
		local cos = math.cos(CT) * mult
		local tan = math.atan(cos * sin, cos * sin) * mult

		ang.x = ang.x + tan * 1.15
		ang.y = ang.y + cos * 0.4
		ang.z = ang.z + tan

		pos.y = pos.y + tan * 0.2
	end

	if len > 10 and len < (walk * self.RunThreshold) then
		-- Walk sway
		local mod = 6 + walk / 130
		local mult = math.Clamp(len / walk, 0, 1)
		local mult2 = Vector(1, 1, 1)

		local sin = math.sin(CT * mod) * mult
		local cos = math.cos(CT * mod) * mult
		local tan = math.atan(cos * sin, cos * sin) * mult

		ang.x = ang.x + (tan * 2 * self.VMMovementScale) * mult2.x
		ang.y = ang.y + (cos * self.VMMovementScale) * mult2.y
		ang.z = ang.z + (sin * self.VMMovementScale) * mult2.z

		pos.x = pos.x + (sin * 0.1 * self.VMMovementScale)
		pos.y = pos.y + (tan * 0.4 * self.VMMovementScale)
		pos.z = pos.z - (tan * 0.1 * self.VMMovementScale)
	end

	if self:IsSprinting() then
		-- Sprint sway
		local run = ply:GetRunSpeed()
		local mult = math.Clamp(len / run, 0, 1)

		self.RunTime = self.RunTime + FT * (7.5 + math.Clamp(len / 120, 0, 5))

		local runtime = self.RunTime

		local sin1 = math.sin(runtime) * mult
		local cos1 = math.cos(runtime) * mult
		local tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mult

		ang.x = ang.x + tan1 * mult * self.VMMovementScale
		ang.y = ang.y - sin1 * -10 * mult * self.VMMovementScale
		ang.z = ang.z + cos1 * 4 * mult * self.VMMovementScale

		pos.x = pos.x - cos1 * 0.6 * mult * self.VMMovementScale
		pos.y = pos.y + sin1 * 0.6 * mult * self.VMMovementScale
		pos.z = pos.z + tan1 * 2 * mult * self.VMMovementScale
	end

	local TargetPos, TargetAng = self:GetVMTarget()

	self.BlendPos = LerpVector(FT * self.ApproachSpeed, self.BlendPos, TargetPos)
	self.BlendAng = LerpVector(FT * self.ApproachSpeed, self.BlendAng, TargetAng)

	self.PosMod = LerpVector(FT * 10, self.PosMod, pos)
	self.AngMod = LerpVector(FT * 10, self.AngMod, ang)
end

-- Gets the target position for the viewmodel
function SWEP:GetVMTarget()
	local ply = self.Owner
	local eye = EyeAngles()

	local vel = ply:GetVelocity()
	local len = vel:Length()

	local TargetPos = self.DefaultOffset.pos * 1
	local TargetAng = self.DefaultOffset.ang * 1

	if CCP.IronDev then
		return GAMEMODE.IronDevPos * 1, GAMEMODE.IronDevAng * 1
	end

	if self:ShouldLower() then
		TargetPos = self.LoweredOffset.pos * 1
		TargetAng = self.LoweredOffset.ang * 1

		-- Offset the weapon depending on the view pitch
		local verticalOffset = EyeAngles().p * 0.4

		TargetAng.x = TargetAng.x - math.Clamp(verticalOffset, 0, 10) * 1
		TargetAng.y = TargetAng.y - verticalOffset * 0.5 * 1
		TargetAng.z = TargetAng.z - verticalOffset * 0.2 * 1

		TargetPos.z = TargetPos.z + math.Clamp(verticalOffset * 0.2, -10, 3)
	end

	-- Apply a roll based on our sideways velocity
	local roll = math.Clamp((vel:Dot(eye:Right()) * 0.04) * len / ply:GetWalkSpeed(), -5, 5)

	if self.ViewModelFlip then
		TargetAng.z = TargetAng.z - roll
	else
		TargetAng.z = TargetAng.z + roll
	end

	return TargetPos, TargetAng
end

-- Applies the VM position and angles
function SWEP:ApplyVMOffsets()
	local pos = EyePos()
	local ang = EyeAngles()

	-- Apply the weapon's position
	ang:RotateAroundAxis(ang:Right(), self.BlendAng.x + self.RecoilAng.p)

	local sway = self.SwayIntensity

	if self.ViewModelFlip then
		ang:RotateAroundAxis(ang:Up(), -self.BlendAng.y + self.RecoilAng.y - self.AngleDelta.y * 0.4 * sway)
		ang:RotateAroundAxis(ang:Forward(), -self.BlendAng.z + self.RecoilAng.r + self.AngleDelta.y * 0.4 * sway)

		pos = pos - (self.BlendPos.x - self.AngleDelta.y * 0.05 * sway - self.RecoilPos.z) * ang:Right()
	else
		ang:RotateAroundAxis(ang:Up(), self.BlendAng.y + self.RecoilAng.y - self.AngleDelta.y * 0.4 * sway)
		ang:RotateAroundAxis(ang:Forward(), self.BlendAng.z + self.RecoilAng.r + self.AngleDelta.y * 0.4 * sway)

		pos = pos + (self.BlendPos.x + self.AngleDelta.y * 0.05 * sway + self.RecoilPos.z) * ang:Right()
	end

	pos = pos + (self.BlendPos.y - self.RecoilPos.y) * ang:Forward()
	pos = pos + (self.BlendPos.z - self.AngleDelta.p * 0.1 * sway - self.RecoilPos.z) * ang:Up()

	-- Offset the position
	ang:RotateAroundAxis(ang:Right(), self.AngMod.x)

	ang:RotateAroundAxis(ang:Up(), self.AngMod.y)
	ang:RotateAroundAxis(ang:Forward(), self.AngMod.z)

	pos = pos + self.PosMod.x * ang:Right()
	pos = pos + self.PosMod.y * ang:Forward()
	pos = pos + self.PosMod.z * ang:Up()

	if not self.DevFrozen then
		self.VM:SetPos(pos)
		self.VM:SetAngles(ang)
	end
end

function SWEP:AimPosDiff(pos, ang)
	local sway = (self.AngleDelta.p * 0.65 + self.AngleDelta.y * 0.75) * 0.05

	pos = self.BlendPos - pos
	ang = self.BlendAng - ang

	ang.z = 0

	pos = pos:Length()
	ang = ang:Length() - sway

	local dependance = pos + ang

	return 1 - dependance
end