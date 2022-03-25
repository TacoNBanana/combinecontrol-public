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
SWEP.FireMove = 0

SWEP.RecoilPos = Vector()
SWEP.RecoilAng = Angle()

SWEP.RecoilPos2 = Vector()
SWEP.RecoilAng2 = Angle()

SWEP.RecoilPosDiff = Vector()
SWEP.RecoilAngDiff = Angle()

SWEP.RecoilIntensity = 0
SWEP.RecoilLowerSpeed = 0

SWEP.BoltBoneID = 0
SWEP.BoltBonePos = Vector()

-- The default viewmodel is used as the source for bullet tracers, so it needs to be in the correct position
function SWEP:GetViewModelPosition(pos, ang)
	if not self.VM or not IsValid(self.VM) then
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
		elseif self:AimingDownSights() then
			mult = 0.1 + (3 * self:GetCurrentSpread())
		end

		local sin = math.sin(CT) * mult
		local cos = math.cos(CT) * mult
		local tan = math.atan(cos * sin, cos * sin) * math.max(mult, 1)

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

		if self:AimingDownSights() then
			mult2 = Vector(0.3, 0.1, 0.25)
		end

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

	-- Handle recoil
	self.RecoilLowerSpeed = math.Approach(self.RecoilLowerSpeed, 10, FT * 10)

	self.RecoilPos2 = LerpVector(FT * self.RecoilLowerSpeed * 0.9, self.RecoilPos2, self.RecoilPos)
	self.RecoilAng2 = LerpAngle(FT * self.RecoilLowerSpeed * 0.9, self.RecoilAng2, self.RecoilAng)

	self.RecoilPosDiff = self.RecoilPos - self.RecoilPos2
	self.RecoilAngDiff = self.RecoilAng - self.RecoilAng2

	self.RecoilPos = LerpVector(FT * self.RecoilLowerSpeed, self.RecoilPos, self.RecoilPosDiff)
	self.RecoilAng = LerpAngle(FT * self.RecoilLowerSpeed, self.RecoilAng, self.RecoilAngDiff)

	self.FireMove = Lerp(FT * 15, self.FireMove, 0)
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
	elseif self:AimingDownSights() and not self:ShouldLower() then
		TargetPos = self.AimOffset.pos * 1
		TargetAng = self.AimOffset.ang * 1
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

	pos = pos + (self.BlendPos.y - self.FireMove - self.RecoilPos.y) * ang:Forward()
	pos = pos + (self.BlendPos.z - self.AngleDelta.p * 0.1 * sway - self.RecoilPos.z) * ang:Up()

	-- Offset the position
	ang:RotateAroundAxis(ang:Right(), self.AngMod.x)

	ang:RotateAroundAxis(ang:Up(), self.AngMod.y)
	ang:RotateAroundAxis(ang:Forward(), self.AngMod.z)

	pos = pos + self.PosMod.x * ang:Right()
	pos = pos + self.PosMod.y * ang:Forward()
	pos = pos + self.PosMod.z * ang:Up()

	if self.IsValid(self.VM) and not self.DevFrozen then
		self.VM:SetPos(pos)
		self.VM:SetAngles(ang)
	end
end

function SWEP:ApplyVMRecoil(mult)
	mult = mult or 1

	local power = 0.25

	local up = math.Rand(0.3, 0.4) * power * 2 * mult
	local forward = math.Rand(0.75, 0.85) * power * mult
	local side = math.Rand(-0.2, 0.2) * power * 0.5 * mult
	local roll = math.Rand(-0.25, 0.25) * power * 5 * mult

	local strength = math.Clamp(self.Recoil, 0.3, 1.8)

	self.RecoilLowerSpeed = 5

	self.RecoilPos.x = strength * side * self.RecoilAxisMod.side
	self.RecoilPos.y = strength * forward * self.RecoilAxisMod.forward
	self.RecoilPos.z = strength * up * self.RecoilAxisMod.up

	self.RecoilAng.p = strength * up * 5 * self.RecoilAxisMod.pitch
	self.RecoilAng.y = strength * side * self.RecoilAxisMod.side
	self.RecoilAng.r = strength * roll * self.RecoilAxisMod.roll
end

function SWEP:HandleBoltMovement()
	if not self.UseBolt then
		return
	end

	self.BoltBonePos = self.BoltOffset * 1
	self.VM:ManipulateBonePosition(self.BoltBoneID, self.BoltBonePos)
end

function SWEP:BoltThink()
	if self:IsReloading() then
		self.BoltBonePos = Vector()
	elseif self.BoltLockOnEmpty and (self.Primary.ClipSize > 0 and self:Clip1() == 0) then
		self.BoltBonePos = self.BoltOffset * 1
	else
		self.BoltBonePos = math.ApproachVector(self.BoltBonePos, Vector(), FrameTime() * self.BoltRecoverySpeed)
	end

	self.VM:ManipulateBonePosition(self.BoltBoneID, self.BoltBonePos)
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