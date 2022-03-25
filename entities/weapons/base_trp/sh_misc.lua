AddCSLuaFile()

function SWEP:HandleAutomatic(force)
	if force != nil then
		self.Primary.Automatic = force
	else
		if self:GetAltMode() then
			self.Primary.Automatic = self:GetAltWeapon().Firemode == -1
		else
			self.Primary.Automatic = self:GetFiremode() == -1
		end
	end
end

function SWEP:HandleBurst()
	if self:GetNextPrimaryFire() > CurTime() then
		return
	end

	local alt = self:GetAltMode()
	local altWeapon = self:GetAltWeapon()

	local firemode = alt and altWeapon.Firemode or self:GetFiremode()

	if firemode == -1 or firemode == 0 then
		return
	end

	local ply = self:GetOwner()
	local burst = self:GetBurstAmount()

	if ply:KeyDown(IN_USE) then
		return
	end

	if self:GetMalfunction() or self:GetSearFailed() then
		return
	end

	if not ply:KeyDown(IN_ATTACK) or not self:CanFire() then
		if burst > 0 then
			self:SetBurstAmount(0)
			self:SetNextPrimaryFire(CurTime() + (self.BurstEndDelay or self.Delay))
		end

		return
	end

	if burst + 1 > firemode then
		return
	end

	self:SetBurstAmount(burst + 1)

	if alt then
		altWeapon.Fire(self, altWeapon)
	else
		self:PrimaryFire()
	end

	local burstDelay = alt and altWeapon.BurstDelay or self.BurstDelay

	if burstDelay > 0 then
		self:SetNextPrimaryFire(CurTime() + burstDelay)
	end

	local autoBurst = alt and altWeapon.AutoBurst or self.AutoBurst

	if autoBurst > 0 and self:GetBurstAmount() >= firemode then
		self:SetBurstAmount(0)
		self:SetNextPrimaryFire(CurTime() + autoBurst)
	end
end

function SWEP:HandleReload()
	local ply = self:GetOwner()

	if not ply:KeyDown(IN_RELOAD) and self:GetSwitchedModes() then
		self:SetSwitchedModes(false)
	end

	if ply:KeyDown(IN_ATTACK) and self.ShotgunReload and self:IsReloading() then
		self:SetAbortReload(true)
	end

	if self:IsReloading() and self:GetFinishReload() <= CurTime() then
		self:FinishReload()
	end
end

function SWEP:HandleHoldType()
	local holdtype = (self:GetHolstered() or self:GetOwner():IsSprinting()) and self.PassiveHoldType or self.ActiveHoldType

	if self:GetHoldType() != holdtype then
		self:SetHoldType(holdtype)
	end
end

function SWEP:HandleIdle()
	local idle = self:GetNextIdle()

	if idle != 0 and idle < CurTime() then
		if self:GetNeedPump() and self:Clip1() != 0 then
			local duration = self:DoWeaponAnim(ACT_SHOTGUN_PUMP)

			self:SetNeedPump(false)
			self:SetNextIdle(CurTime() + duration)
			self:SetNextPrimaryFire(CurTime() + duration)
		else
			self:DoWeaponAnim(ACT_VM_IDLE)
			self:SetNextIdle(0)
			self:SetDeployTime(0)
		end
	end
end

function SWEP:HandleAim(delta)
	local interp = delta and true or false

	delta = delta or self.DeltaTime

	local frac = self:GetAimFraction()
	local last = frac

	if self:GetOwner():KeyDown(IN_ATTACK2) and not self:IsSprinting() then
		frac = math.max(frac + (delta / self.AimTime), 0)
	else
		frac = math.min(frac - (delta / self.AimTime), 1)

		if self:ForceUnscope() and self:GetFireFraction() > 0.5 then
			frac = math.min(frac, self:GetFireFraction())
		end
	end

	if not interp then
		if math.InRange(frac, 0, 1) and math.InRange(last, 0, 1) and math.Round(last) != math.Round(frac) then
			self:EmitSound("Terminator_Weapon.Movement")
		end

		self:SetAimFraction(frac)
	end

	return frac
end

function SWEP:GetInterpAim()
	if CLIENT then
		return math.Clamp(self:HandleAim(CurTime() - self:GetLastThink()), 0, 1)
	end

	return math.Clamp(self:GetAimFraction(), 0, 1)
end

function SWEP:HandleHolster(delta)
	local interp = delta and true or false

	delta = delta or self.DeltaTime

	local frac = self:GetHolsterFraction()

	if self:GetHolstered() then
		if frac < 1 then
			frac = math.Clamp(frac + (delta / self.HolsterTime) * (1 - frac), 0, 1)
		end
	else
		if frac > 0 then
			frac = math.Clamp(frac - (delta / self.HolsterTime) * frac, 0, 1)
		end
	end

	if not interp then
		self:SetHolsterFraction(frac)
	end

	return frac
end

function SWEP:GetInterpHolster()
	if CLIENT then
		return math.Clamp(self:HandleHolster(CurTime() - self:GetLastThink()), 0, 1)
	end

	return self:GetHolsterFraction()
end

function SWEP:HandleAlt(delta)
	if not self.AltWeapon then
		return -1
	end

	local interp = delta and true or false

	delta = delta or self.DeltaTime

	local frac = self:GetAltFraction()
	local weapon = self:GetAltWeapon()

	if self:GetAltMode() then
		frac = math.max(frac + (delta / weapon.SwitchTime), 0)
	else
		frac = math.min(frac - (delta / weapon.SwitchTime), 1)
	end

	if not interp then
		self:SetAltFraction(frac)
	end

	return frac
end

function SWEP:GetInterpAlt()
	if CLIENT then
		return math.Clamp(self:HandleAlt(CurTime() - self:GetLastThink()), 0, 1)
	end

	return math.Clamp(self:GetAltFraction(), 0, 1)
end

function SWEP:HandleSprint(delta)
	local interp = delta and true or false

	delta = delta or self.DeltaTime

	local frac = self:GetSprintFraction()

	if self:IsSprinting() then
		if frac < 1 then
			frac = math.Clamp(frac + (delta / self.SprintTime) * (1 - frac), 0, 1)
		end
	else
		if frac > 0 then
			frac = math.Clamp(frac - (delta / self.SprintTime) * frac, 0, 1)
		end
	end

	if not interp then
		self:SetSprintFraction(frac)
	end

	return frac
end

function SWEP:GetInterpSprint()
	if CLIENT then
		return math.Clamp(self:HandleSprint(CurTime() - self:GetLastThink()), 0, 1)
	end

	return self:GetSprintFraction()
end

function SWEP:HandleScope()
	if not istable(self.ZoomLevel) then
		return
	end

	local min, max, step = unpack(self.ZoomLevel)

	if self:GetAimFraction() >= 0.5 then
		local cmd = self:GetOwner():GetCurrentCommand()
		local wheel = math.Sign(cmd:GetMouseWheel()) * step

		if wheel != 0 then
			local amount = math.Clamp(self:GetZoomAmount() + wheel, min, max)

			self:SetZoomAmount(amount)
		end
	end
end

function SWEP:CanToggleHolster()
	if self:GetDeployTime() != 0 then
		return false
	end

	return true
end

function SWEP:HandleImpulse()
	local ply = self:GetOwner()

	if not IsValid(ply) or not IsValid(GetPredictionPlayer()) then
		return
	end

	local impulse = ply:GetCurrentCommand():GetImpulse()

	if impulse == 30 and self:CanToggleHolster() then
		self:EmitSound("Terminator_Weapon.Movement")
		self:SetHolstered(not self:GetHolstered())
	end
end

if CLIENT then
	function SWEP:DoSoundUpdate(sequence, last, time)
	end

	function SWEP:HandleSound()
		local ply = self:GetOwner()

		if not IsValid(ply) then
			return
		end

		local vm = ply:GetViewModel()

		if not IsValid(vm) then
			return
		end

		local sequence = vm:GetSequence()

		if sequence != self.SoundSequence then
			if self.LastSoundTime != 0 then
				self:DoSoundUpdate(vm:GetSequenceName(self.SoundSequence), self.LastSoundTime, vm:SequenceDuration(self.SoundSequence))
			end

			self.SoundSequence = sequence
			self.LastSoundTime = 0
		end

		local name = vm:GetSequenceName(sequence)
		local max = vm:SequenceDuration()
		local time = vm:GetCycle() * max

		if time < self.LastSoundTime then
			self:DoSoundUpdate(name, self.LastSoundTime, max)
			self.LastSoundTime = 0

			return
		end

		self:DoSoundUpdate(name, self.LastSoundTime, time)
		self.LastSoundTime = time
	end
end
