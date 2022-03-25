firemode = firemode or {
	Registered = {},
	Default = {
		AmmoItem = false,
		AmmoPool = "base",
		Automatic = false,
		Burst = false,
		ClipSize = false,
		Name = "*INVALID*",
		SwitchFrom = stub,
		SwitchTo = stub,
		UseCrosshair = true
	}
}

function firemode.Default.CanReload(self)
	if self:GetNextPrimaryFire() > CurTime() then
		return false
	end

	if self:Clip1() >= self.Primary.ClipSize then
		return false
	end

	local item = self:GetFiremode().GetAmmoItem(self)

	if item and not self.Owner:HasItem(item) then
		return false
	end

	return true
end

function firemode.Default.Reload(self)
	self.Owner:SetAnimation(PLAYER_RELOAD)

	if self.UseReloadAnimation then
		self:SendWeaponAnim(ACT_VM_RELOAD)
	end

	local duration = self:PlayAnimation("reload")

	self:SetFinishReload(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + duration)
end
function firemode.Default.GetAmmoItem(self)
	if self.Owner:InfiniteAmmo() then
		return false
	end

	if self.Owner:GetCharFlagAttribute("InfiniteAmmo") then
		return false
	end

	return self:GetFiremode().AmmoItem or self.AmmoItem
end

function firemode.Default.CanFire(self)
	if self.Primary.ClipSize > 0 and self:Clip1() <= 0 then
		return false
	end

	return true
end

function firemode.Default.Fire(self)
	local delay = 0

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	if self:DoFireAnimation() or self.FireDelay == -1 then
		delay = self:PlayAnimation("fire")
	else
		self:PlayAnimation("fire", 1, 1)
	end

	if self.PumpAction then
		self:EmitSound("Weapon_Shotgun.Special1")
	end

	if not self:GetIsFiring() then
		self:SetIsFiring(true)
		self:StartFiring()
	end

	self:EmitSound(self.FireSound)

	self:TakePrimaryAmmo(1)
	self:FireBullet(self.Damage, self.BulletCount, self.UseClumpSpread and self.ClumpSpread or 0, self.Tracer)

	if IsFirstTimePredicted() and CLIENT then
		self:DoVMRecoil()
	end

	self:DoRecoil()

	local mode = self:GetFiremode()

	if isnumber(mode.Burst) then
		self:SetFinishBurst(CurTime() + self.FireDelay)
		self:SetBurstAmount(mode.Burst - 1)

		if self:GetFinishBurst() > 0 then
			self:SetNextPrimaryFire(math.huge)
		else
			self:SetNextPrimaryFire(CurTime() + self.FireDelay)
		end
	else
		if self.FireDelay == -1 then
			self:SetNextPrimaryFire(CurTime() + delay)
		else
			self:SetNextPrimaryFire(CurTime() + self.FireDelay)
		end
	end
end

function firemode.Default.Think(self)
	if self:GetFinishBurst() != 0 and self:GetFinishBurst() <= CurTime() then
		if not self.Owner:KeyDown(IN_ATTACK) or self:Clip1() <= 0 and self.Primary.ClipSize > -1 then
			self:SetBurstAmount(0)
			self:SetFinishBurst(0)

			self:SetNextPrimaryFire(CurTime() + self.FireDelay)

			return
		end

		local amt = self:GetBurstAmount() - 1

		self:GetFiremode().Fire(self)

		self:SetBurstAmount(amt)

		if amt > 0 then
			self:SetFinishBurst(CurTime() + self.FireDelay)
		else
			self:SetFinishBurst(0)

			self:SetNextPrimaryFire(CurTime() + self.FireDelay)
		end
	end

	if self:GetIsFiring() and (self:ShouldLower() or not self.Owner:KeyDown(IN_ATTACK) or (self:Clip1() <= 0 and self.Primary.ClipSize != -1)) then
		self:SetIsFiring(false)
		self:StopFiring()
	end

	if self:IsReloading() and self:GetFinishReload() <= CurTime() then
		self:SetFinishReload(0)

		local itemclass = self:GetFiremode().GetAmmoItem(self)
		local amt = self.Primary.ClipSize - self:Clip1()

		if self.ShotgunReload then
			amt = self.ReloadAmount
		end

		local abort = false

		if itemclass then
			local item = self.Owner:GetFirstItem(itemclass)

			if not item then
				abort = true
			else
				if class.IsTypeOf(item, "base_stacking") then
					amt = math.Min(item:GetAmount(), amt)

					if SERVER then
						item:TakeAmount(amt)
					end
				elseif SERVER then
					GAMEMODE:DeleteItem(item)
				end
			end
		end

		if not abort then
			self:SetClip1(self:Clip1() + amt)
		end

		if self.ShotgunReload then
			if self:Clip1() >= self.Primary.ClipSize or self:GetAbortReload() or abort then
				self:SetAbortReload(false)

				if self.UseReloadAnimation then
					self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
				end

				local duration = self:PlayAnimation("reloadfinish")

				self:SetNextPrimaryFire(CurTime() + duration)
			else
				if self.UseReloadAnimation then
					self:SendWeaponAnim(ACT_VM_RELOAD)
				end

				local duration = self:PlayAnimation("reloadinsert")

				self:SetFinishReload(CurTime() + duration)
				self:SetNextPrimaryFire(CurTime() + duration)
			end
		end
	end
end

function firemode.Register(index, tab)
	tab = table.Merge(table.FullCopy(firemode.Default), tab)

	firemode.Registered[index] = tab
end

function firemode.Get(index)
	return firemode.Registered[index]
end

firemode.Register(FIREMODE_SEMI, {Name = "Semi"})
firemode.Register(FIREMODE_BURST2, {Burst = 2, Name = "Burst"})
firemode.Register(FIREMODE_BURST3, {Burst = 3, Name = "Burst"})
firemode.Register(FIREMODE_AUTO, {Automatic = true, Name = "Auto"})

firemode.Register(FIREMODE_RPG, {
	Name = "RPG",
	Projectile = "cc_rpg",
	ClipSize = 1,
	Fire = function(self)
		local ply = self.Owner
		local delay = 0

		if self:DoFireAnimation() or self.FireDelay == -1 then
			delay = self:PlayAnimation("fire")
		else
			self:PlayAnimation("fire", 1, 1)
		end

		ply:SetAnimation(PLAYER_ATTACK1)
		self:EmitSound(self.FireSound)

		self:TakePrimaryAmmo(1)

		if SERVER then
			math.randomseed(ply:GetCurrentCommand():CommandNumber())

			local cone = self.CurrentCone
			local aimcone = Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0)

			local ent = ents.Create(self:GetFiremode().Projectile)
			ent:SetPos(ply:GetShootPos())
			ent:SetAngles(ply:EyeAngles() + ply:GetViewPunchAngles() + aimcone * 25)
			ent:SetOwner(ply)
			ent:Spawn()
			ent:Activate()
		end

		if IsFirstTimePredicted() and CLIENT then
			self:DoVMRecoil()
		end

		self:DoRecoil()

		if self.FireDelay == -1 and self:DoFireAnimation() then
			self:SetNextPrimaryFire(CurTime() + delay)
		else
			self:SetNextPrimaryFire(CurTime() + self.FireDelay)
		end
	end
})

firemode.Register(FIREMODE_M203, {
	Name = "M203 HE",
	AmmoPool = "M203_HE",
	AmmoItem = "ammo_m203",
	Projectile = "cc_m203",
	ClipSize = 1,
	Fire = function(self)
		local delay = self:PlayAnimation("fire") or 1

		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:EmitSound("tekka/weapons/weapon_m203.wav")

		self:TakePrimaryAmmo(1)

		if SERVER then
			local pos = self.Owner:GetShootPos() + self.Owner:GetForward() * 8 + self.Owner:GetRight() * 6

			local ent = ents.Create(self:GetFiremode().Projectile)
			ent:SetPos(pos)
			ent:SetAngles(self.Owner:GetAimVector():Angle())
			ent:SetOwner(self.Owner)
			ent:Spawn()
			ent:Activate()
		end

		if IsFirstTimePredicted() and CLIENT then
			self:DoVMRecoil()
		end
		self:DoRecoil()

		self:SetNextPrimaryFire(CurTime() + delay)
	end
})

firemode.Register(FIREMODE_MASTERKEY, {
	Name = "Underslung Buckshot",
	AmmoPool = "Masterkey",
	AmmoItem = "ammo_shotgun",
	ClipSize = 4,
	Damage = 15,
	Count = 12,
	Spread = 0.04,
	Fire = function(self)
		local delay = 0

		self:EmitSound("tekka/weapons/weapon_shotgunblast.wav")
		self:EmitSound("Weapon_Shotgun.Special1")
		self.Owner:SetAnimation(PLAYER_ATTACK1)

		delay = self:PlayAnimation("fire")

		self:TakePrimaryAmmo(1)

		local mode = self:GetFiremode()

		self:FireBullet(mode.Damage, mode.Count, mode.Spread, nil, function(attacker, trace, dmginfo)
			dmginfo:SetDamageType(DMG_BULLET)

			if IsValid(trace.Entity) and trace.Entity:GetClass() == "prop_door_rotating" and trace.Entity:GetPos():DistToSqr(attacker:GetShootPos()) < 150 ^ 2 then
				GAMEMODE:ExplodeDoor(trace.Entity, trace.Normal)
			end
		end)

		if IsFirstTimePredicted() and CLIENT then
			self:DoVMRecoil()
		end

		self:DoRecoil()

		self:SetNextPrimaryFire(CurTime() + delay)
	end
})

firemode.Register(FIREMODE_NONE, {
	Name = "",
	CanReload = function() return false end,
	CanFire = function() return true end,
	Fire = stub,
	Think = stub,
	UseCrosshair = false
})

firemode.Register(FIREMODE_BINOC, {
	Name = "",
	Automatic = true,
	CanReload = function() return true end,
	CanFire = function() return true end,
	Fire = function(self)
		if CLIENT then
			if not IsFirstTimePredicted() then
				return
			end

			if self.RTScopeFOV <= 1 then
				return
			end

			self.RTScopeFOV = math.max(self.RTScopeFOV - (0.1 * FrameTime() * 66), 1)
		end
	end,
	Reload = function(self)
		if CLIENT then
			if not IsFirstTimePredicted() then
				return
			end

			if self.RTScopeFOV >= 8 then
				return
			end

			self.RTScopeFOV = math.min(self.RTScopeFOV + (0.1 * FrameTime() * 66), 8)
		end
	end,
	Think = stub,
	UseCrosshair = false
})

firemode.Register(FIREMODE_EMP, {
	Name = "Concussive Blast",
	Fire = function(self)
		local delay = 0

		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		if self:DoFireAnimation() or self.FireDelay == -1 then
			delay = self:PlayAnimation("fire")
		else
			self:PlayAnimation("fire", 1, 1)
		end

		if self.PumpAction then
			self:EmitSound("Weapon_Shotgun.Special1")
		end

		self:EmitSound(self.FireSound)
		self:TakePrimaryAmmo(1)

		local trace = util.TraceHull({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + (self.Owner:EyeAngles():Forward() * 8192),
			filter = self.Owner,
			mins = Vector(-20, -20, -20),
			maxs = Vector(20, 20, 20),
			mask = MASK_SHOT_HULL
		})

		if SERVER then
			local ent = trace.Entity

			if IsValid(ent) then
				if ent:IsPlayer() then
					ent:SetConsciousness(0)
					ent:PassOut()
				elseif ent:GetClass() == "prop_ragdoll" and IsValid(ent:PropFakePlayer()) then
					ent:PropFakePlayer():SetConsciousness(0)
				end
			end
		end

		if IsFirstTimePredicted() then
			local ed = EffectData()

			ed:SetOrigin(trace.HitPos)
			ed:SetStart(self.Owner:GetShootPos())
			ed:SetEntity(self)
			ed:SetAttachment(1)

			util.Effect("cc_e_concussive", ed)
		end

		if IsFirstTimePredicted() and CLIENT then
			self:DoVMRecoil()
		end

		self:DoRecoil()

		if self.FireDelay == -1 then
			self:SetNextPrimaryFire(CurTime() + delay)
		else
			self:SetNextPrimaryFire(CurTime() + self.FireDelay)
		end
	end,
	UseCrosshair = false
})

firemode.Register(FIREMODE_FLAMETHROWER, {
	Name = "Flamethrower",
	Automatic = true,
	CanReload = function() return false end,
	CanFire = function() return true end,
	Fire = function(self)
		if not self:GetIsFiring() then
			self:SetIsFiring(true)
			self:StartFiring()

			if vFireInstalled then
				local effectdata = EffectData()
				effectdata:SetAttachment(1)
				effectdata:SetEntity(self)

				util.Effect("cc_e_flamethrower_vfire", effectdata, true, true)
			end
		end

		local trace = util.TraceLine({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + (self.Owner:EyeAngles():Forward() * 400),
			filter = self.Owner,
		})

		if vFireInstalled then
			if not SERVER then
				return
			end

			local forwardBoost = math.Rand(20, 40)
			local frac = self.Owner:GetEyeTrace().Fraction

			if frac < 0.001245 then
				forwardBoost = 1
			end

			local forward = self.Owner:EyeAngles():Forward()
			local pos = self.Owner:GetShootPos() + forward * forwardBoost
			local vel = forward * math.Rand(900, 1000)

			CreateVFireBall(math.Rand(4, 8) * 2.15, 20, pos, vel, self.Owner)
		else
			if IsFirstTimePredicted() then
				local ed = EffectData()

				ed:SetEntity(self)
				ed:SetAttachment(1)
				ed:SetAngles(self.Owner:EyeAngles())
				ed:SetMagnitude(5)

				util.Effect("cc_e_flamethrower", ed)
			end

			if SERVER then
				for _, ent in pairs(ents.FindInSphere(trace.HitPos, 16)) do
					if IsValid(ent) and IsValid(ent:GetPhysicsObject()) and ent != self.Owner then
						local dmg = DamageInfo()

						dmg:SetAttacker(self.Owner)
						dmg:SetInflictor(self)
						dmg:SetDamageType(DMG_BURN)
						dmg:SetDamage(1)

						ent:TakeDamageInfo(dmg)
						ent:Ignite(ent:IsPlayer() and 12 or 60)
					end
				end
			end
		end
	end,
	Reload = stub,
	Think = function(self)
		if self:GetIsFiring() and (self:ShouldLower() or not self.Owner:KeyDown(IN_ATTACK)) then
			self:SetIsFiring(false)
			self:StopFiring()
		end
	end,
	UseCrosshair = false
})

local function TargetSolution(target, origin, velocity, gravity, high)
	local elevation = target.z - origin.z
	local distance = Vector(target.x, target.y, 0):Distance(Vector(origin.x, origin.y, 0))

	gravity = -(gravity).z

	if high then
		return math.atan(((velocity ^ 2) * (1 + math.sqrt(1 - (gravity * (gravity * (distance ^ 2) + 2 * (velocity ^ 2) * elevation)) / (velocity ^ 4)))) / (gravity * distance))
	else
		return math.atan(((velocity ^ 2) * (1 - math.sqrt(1 - (gravity * (gravity * (distance ^ 2) + 2 * (velocity ^ 2) * elevation)) / (velocity ^ 4)))) / (gravity * distance))
	end
end

firemode.Register(FIREMODE_CANNON, {
	Automatic = false,
	Name = "Cannon",
	Delay = 1,
	Projectile = "cc_cannon",
	Sound = "tekka/weapons/weapon_m203_smoke.wav",
	Fire = function(self)
		local mode = self:GetFiremode()
		local delay = mode.Delay

		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:EmitSound(mode.Sound)

		self:TakePrimaryAmmo(1)

		if SERVER then
			local target = self.Owner:GetEyeTrace().HitPos
			local pos = self.Owner:GetShootPos() + self.Owner:GetForward() * 8 + self.Owner:GetRight() * 6
			local ang = self.Owner:GetAimVector():Angle()

			local ent = ents.Create(mode.Projectile)

			local pitch = TargetSolution(target, pos, ent.Velocity, physenv.GetGravity() * ent.GravityMultiplier, mode.High)

			if pitch == pitch and self:AimingDownSights() then
				ang.p = math.deg(-pitch)
			end

			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:SetOwner(self.Owner)
			ent:Spawn()
			ent:Activate()
		end

		if IsFirstTimePredicted() and CLIENT then
			self:DoVMRecoil()
		end
		self:DoRecoil()

		self:SetNextPrimaryFire(CurTime() + delay)
	end,
	Think = function(self)
		firemode.Default.Think(self)

		local mode = self:GetFiremode()

		if CLIENT then
			local target = self.Owner:GetEyeTrace().HitPos
			local pos = self.Owner:GetShootPos() + self.Owner:GetForward() * 8 + self.Owner:GetRight() * 6

			local velocity = scripted_ents.GetMember(mode.Projectile, "Velocity")
			local gravity = physenv.GetGravity() * scripted_ents.GetMember(mode.Projectile, "GravityMultiplier")

			local pitch = TargetSolution(target, pos, velocity, gravity, mode.High)

			self.AimpointColor = (pitch == pitch) and Color(0, 255, 0) or Color(255, 0, 0)
		end
	end,
	CanFire = function(self)
		if self.Primary.ClipSize > 0 and self:Clip1() <= 0 then
			return false
		end

		local mode = self:GetFiremode()

		if mode.NoBlind then
			local target = self.Owner:GetEyeTrace().HitPos
			local pos = self.Owner:GetShootPos() + self.Owner:GetForward() * 8 + self.Owner:GetRight() * 6

			local velocity = scripted_ents.GetMember(mode.Projectile, "Velocity")
			local gravity = physenv.GetGravity() * scripted_ents.GetMember(mode.Projectile, "GravityMultiplier")

			local pitch = TargetSolution(target, pos, velocity, gravity, mode.High)

			if not self:AimingDownSights() or pitch != pitch then
				return false
			end
		end

		return true
	end,
	SwitchFrom = function(self)
		if CLIENT then
			self.AimpointColor = weapons.GetStored(self:GetClass()).AimpointColor
		end
	end,
	UseCrosshair = false
})

firemode.Register(FIREMODE_ACID, {
	Automatic = false,
	Name = "Acid Cannon",
	Delay = 1,
	Projectile = "cc_acid",
	Fire = function(self)
		local mode = self:GetFiremode()
		local delay = mode.Delay

		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:EmitSound("npc/antlion/antlion_shoot1.wav")

		self:TakePrimaryAmmo(1)

		if SERVER then
			local target = self.Owner:GetEyeTrace().HitPos
			local pos = self.Owner:GetShootPos() + self.Owner:GetForward() * 8 + self.Owner:GetRight() * 6
			local ang = self.Owner:GetAimVector():Angle()

			local ent = ents.Create(mode.Projectile)

			local pitch = TargetSolution(target, pos, ent.Velocity, physenv.GetGravity() * ent.GravityMultiplier)

			if pitch == pitch and self:AimingDownSights() then
				ang.p = math.deg(-pitch)
			end

			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:SetOwner(self.Owner)
			ent:Spawn()
			ent:Activate()
		end

		if IsFirstTimePredicted() and CLIENT then
			self:DoVMRecoil()
		end
		self:DoRecoil()

		self:SetNextPrimaryFire(CurTime() + delay)
	end,
	Think = function(self)
		firemode.Default.Think(self)

		local mode = self:GetFiremode()

		if CLIENT then
			local target = self.Owner:GetEyeTrace().HitPos
			local pos = self.Owner:GetShootPos() + self.Owner:GetForward() * 8 + self.Owner:GetRight() * 6

			local velocity = scripted_ents.GetMember(mode.Projectile, "Velocity")
			local gravity = physenv.GetGravity() * scripted_ents.GetMember(mode.Projectile, "GravityMultiplier")

			local pitch = TargetSolution(target, pos, velocity, gravity)

			self.AimpointColor = (pitch == pitch) and Color(0, 255, 0) or Color(255, 0, 0)
		end
	end,
	SwitchFrom = function(self)
		if CLIENT then
			self.AimpointColor = weapons.GetStored(self:GetClass()).AimpointColor
		end
	end,
	UseCrosshair = false
})

firemode.Register(FIREMODE_RAILGUN, {
	Automatic = false,
	Name = "Railgun",
	ChargeDelay = 0.5,
	Delay = 1,
	Fire = function(self)
		local mode = self:GetFiremode()

		self:SetStartFire(CurTime())
		self:EmitSound("tekka/weapons/weapon_chargeup.wav")

		self:SetNextPrimaryFire(CurTime() + mode.Delay)
	end,
	Think = function(self)
		firemode.Default.Think(self)

		local mode = self:GetFiremode()
		local ply = self.Owner

		if CLIENT then
			local color = weapons.GetStored(self:GetClass()).AimpointColor

			color = Vector(color.r, color.g, color.b)

			if self:GetStartFire() > 0 then
				local time = CurTime() - self:GetStartFire()
				local frac = math.Remap(math.Clamp(time, 0, mode.ChargeDelay), 0, mode.ChargeDelay, 0, 1)

				color = LerpVector(frac, color, Vector(0, 255, 0))
			end

			self.AimpointColor = Color(color.x, color.y, color.z)
		end

		if self:GetStartFire() > 0 and not ply:KeyDown(IN_ATTACK) then
			self:SetStartFire(0)
			self:SetNextPrimaryFire(CurTime() + mode.ChargeDelay)

			return
		end

		if self:GetStartFire() > 0 and CurTime() - self:GetStartFire() > mode.ChargeDelay then
			self:SetStartFire(0)

			ply:SetAnimation(PLAYER_ATTACK1)
			self:EmitSound("tekka/weapons/weapon_burstcharge.wav")

			self:TakePrimaryAmmo(1)
			self:FireBullet(self.Damage, self.BulletCount, self.UseClumpSpread and self.ClumpSpread or 0, self.Tracer)

			self:SetNextPrimaryFire(CurTime() + mode.Delay)

			if IsFirstTimePredicted() and CLIENT then
				self:DoVMRecoil()
			end

			self:DoRecoil()
		end
	end,
	SwitchFrom = function(self)
		if CLIENT then
			self.AimpointColor = weapons.GetStored(self:GetClass()).AimpointColor
		end
	end,
	UseCrosshair = false
})

firemode.Register(FIREMODE_EXTINGUISHER, {
	Name = "Extinguisher",
	Automatic = true,
	CanReload = function() return false end,
	CanFire = function() return true end,
	Fire = function(self)
		if not self:GetIsFiring() then
			self:SetIsFiring(true)
			self:StartFiring()

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		end

		if IsFirstTimePredicted() then
			local ed = EffectData()

			ed:SetAttachment(1)
			ed:SetEntity(self.Owner)
			ed:SetOrigin(self.Owner:GetShootPos())
			ed:SetNormal(self.Owner:GetAimVector())
			ed:SetScale(1)

			util.Effect("cc_e_extinguisher", ed)
		end

		if SERVER then
			local trace = util.TraceLine({
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + (self.Owner:EyeAngles():Forward() * 256),
				filter = self.Owner,
			})

			for _, ent in pairs(ents.FindInSphere(trace.HitPos, 80)) do
				if IsValid(ent) then
					if math.Rand(0, 1) > 0.75 then
						local ret = hook.Call("ExtinguisherDoExtinguish", nil, ent)
						if ret == true then
							continue
						end

						if ent:IsOnFire() then
							ent:Extinguish()
						end

						if string.find(ent:GetClass(), "env_fire") then
							ent:Fire("Extinguish")
						end
					end

					if IsValid(ent:GetPhysicsObject()) then
						ent:GetPhysicsObject():ApplyForceOffset(self.Owner:GetAimVector() * 196, trace.HitPos)
					end
				end
			end

		end

		self:SetNextPrimaryFire(CurTime() + self.FireDelay)
	end,
	Reload = stub,
	Think = function(self)
		if self:GetIsFiring() and (self:ShouldLower() or not self.Owner:KeyDown(IN_ATTACK)) then
			self:SetIsFiring(false)
			self:StopFiring()

			self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		end
	end,
	UseCrosshair = false
})

firemode.Register(FIREMODE_TESLA, {
	Name = "Tesla Coil",
	Automatic = false,
	ChargeDelay = 0.9,
	Delay = 0.5,
	Fire = function(self)
		local mode = self:GetFiremode()

		self:SetStartFire(CurTime())
		self:EmitSound("npc/roller/mine/rmine_shockvehicle2.wav")

		self:SetNextPrimaryFire(CurTime() + mode.Delay)
	end,
	Think = function(self)
		firemode.Default.Think(self)

		local mode = self:GetFiremode()
		local ply = self.Owner

		if CLIENT then
			local color = weapons.GetStored(self:GetClass()).AimpointColor

			color = Vector(color.r, color.g, color.b)

			if self:GetStartFire() > 0 then
				local time = CurTime() - self:GetStartFire()
				local frac = math.Remap(math.Clamp(time, 0, mode.ChargeDelay), 0, mode.ChargeDelay, 0, 1)

				color = LerpVector(frac, color, Vector(0, 255, 0))
			end

			self.AimpointColor = Color(color.x, color.y, color.z)
		end

		if self:GetStartFire() > 0 and not ply:KeyDown(IN_ATTACK) then
			self:SetStartFire(0)
			self:SetNextPrimaryFire(CurTime() + mode.ChargeDelay)

			return
		end

		if self:GetStartFire() > 0 and CurTime() - self:GetStartFire() > mode.ChargeDelay then
			self:SetStartFire(0)

			ply:SetAnimation(PLAYER_ATTACK1)
			self:EmitSound("npc/roller/mine/rmine_explode_shock1.wav")

			self:TakePrimaryAmmo(1)
			self:FireBullet()

			self:SetNextPrimaryFire(CurTime() + mode.Delay)

			if IsFirstTimePredicted() and CLIENT then
				self:DoVMRecoil()
			end

			self:DoRecoil()
		end
	end,
	SwitchFrom = function(self)
		if CLIENT then
			self.AimpointColor = weapons.GetStored(self:GetClass()).AimpointColor
		end
	end,
	UseCrosshair = false
})