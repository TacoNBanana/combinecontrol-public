AddCSLuaFile()

SWEP.PrintName 		= "Base"
SWEP.Slot 			= 1
SWEP.SlotPos 		= 1
SWEP.ViewModelFlip 	= false

SWEP.ViewModelFOV	= 54

SWEP.ViewModel 		= ""
SWEP.WorldModel 	= ""

SWEP.SwayScale		= 0

SWEP.DrawCrosshair 			= false

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Ammo			= ""
SWEP.Primary.Automatic		= false
SWEP.Primary.RecoilAdd 		= 5

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.Automatic	= false

SWEP.ReloadType				= RELOADTYPE_NORMAL
SWEP.CanReload 				= false
SWEP.Holsterable 			= true
SWEP.NoDrawHolstered 		= false
SWEP.ScopeFOV				= 20

local ActIndex = {
	[ "pistol" ] 		= ACT_HL2MP_IDLE_PISTOL,
	[ "revolver" ] 		= ACT_HL2MP_IDLE_REVOLVER,
	[ "smg" ] 			= ACT_HL2MP_IDLE_SMG1,
	[ "grenade" ] 		= ACT_HL2MP_IDLE_GRENADE,
	[ "ar2" ] 			= ACT_HL2MP_IDLE_AR2,
	[ "shotgun" ] 		= ACT_HL2MP_IDLE_SHOTGUN,
	[ "rpg" ]	 		= ACT_HL2MP_IDLE_RPG,
	[ "physgun" ] 		= ACT_HL2MP_IDLE_PHYSGUN,
	[ "crossbow" ] 		= ACT_HL2MP_IDLE_CROSSBOW,
	[ "melee" ] 		= ACT_HL2MP_IDLE_MELEE,
	[ "slam" ] 			= ACT_HL2MP_IDLE_SLAM,
	[ "normal" ]		= ACT_HL2MP_IDLE,
	[ "fist" ]			= ACT_HL2MP_IDLE_FIST,
	[ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
	[ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
	[ "knife" ]			= ACT_HL2MP_IDLE_KNIFE,
	[ "camera" ]		= ACT_HL2MP_IDLE_CAMERA,
	[ "duel" ]			= ACT_HL2MP_IDLE_DUEL,
	[ "magic" ]			= ACT_HL2MP_IDLE_MAGIC,
	[ "zombie" ]		= ACT_HL2MP_IDLE_ZOMBIE,
	[ "suitcase" ]		= ACT_HL2MP_IDLE_SUITCASE
}

function SWEP:SetWeaponHoldType(t)
	t = string.lower(t)
	local index = ActIndex[ t ]

	if (index == nil) then
		t = "normal"
		index = ActIndex[ t ]
	end

	self.ActivityTranslate = {}
	self.ActivityTranslate [ ACT_MP_STAND_IDLE ] 				= index
	self.ActivityTranslate [ ACT_MP_WALK ] 						= index+1
	self.ActivityTranslate [ ACT_MP_RUN ] 						= index+2
	self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] 				= index+3
	self.ActivityTranslate [ ACT_MP_CROUCHWALK ] 				= index+4
	self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= index+5
	self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
	self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_JUMP ] 						= index+7
	self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 				= index+8

	if t == "normal" then
		self.ActivityTranslate [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
	end

	if t == "revolver" then
		self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
	end

	if t == "passive" then
		self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] = ACT_HL2MP_IDLE_CROUCH
	end

	if t == "suitcase" then

		self.ActivityTranslate [ ACT_MP_STAND_IDLE ] 				= ACT_HL2MP_IDLE_SUITCASE
		self.ActivityTranslate [ ACT_MP_WALK ] 						= ACT_HL2MP_WALK_SUITCASE
		self.ActivityTranslate [ ACT_MP_RUN ] 						= ACT_HL2MP_IDLE+2
		self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] 				= ACT_HL2MP_IDLE+3
		self.ActivityTranslate [ ACT_MP_CROUCHWALK ] 				= ACT_HL2MP_IDLE+4
		self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= ACT_HL2MP_IDLE+5
		self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = ACT_HL2MP_IDLE+5
		self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]		 		= ACT_HL2MP_IDLE+6
		self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]		 		= ACT_HL2MP_IDLE+6
		self.ActivityTranslate [ ACT_MP_JUMP ] 						= ACT_HL2MP_IDLE+7
		self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 				= ACT_HL2MP_IDLE+8

	end
end

function SWEP:SetWeaponHoldTypeHolster(t)
	t = string.lower(t)
	local index = ActIndex[ t ]

	if (index == nil) then
		t = "normal"
		index = ActIndex[ t ]
	end

	self.ActivityTranslateHolster = {}
	self.ActivityTranslateHolster [ ACT_MP_STAND_IDLE ] 				= index
	self.ActivityTranslateHolster [ ACT_MP_WALK ] 						= index+1
	self.ActivityTranslateHolster [ ACT_MP_RUN ] 						= index+2
	self.ActivityTranslateHolster [ ACT_MP_CROUCH_IDLE ] 				= index+3
	self.ActivityTranslateHolster [ ACT_MP_CROUCHWALK ] 				= index+4
	self.ActivityTranslateHolster [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= index+5
	self.ActivityTranslateHolster [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]  = index+5
	self.ActivityTranslateHolster [ ACT_MP_RELOAD_STAND ]		 		= index+6
	self.ActivityTranslateHolster [ ACT_MP_RELOAD_CROUCH ]		 		= index+6
	self.ActivityTranslateHolster [ ACT_MP_JUMP ] 						= index+7
	self.ActivityTranslateHolster [ ACT_RANGE_ATTACK1 ] 				= index+8

	if t == "normal" then
		self.ActivityTranslateHolster [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
	end

	if t == "revolver" then
		self.ActivityTranslateHolster [ ACT_RANGE_ATTACK1 ] = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
	end

	if t == "passive" then
		self.ActivityTranslateHolster [ ACT_MP_CROUCH_IDLE ] = ACT_HL2MP_IDLE_CROUCH
	end

	if t == "suitcase" then

		self.ActivityTranslateHolster [ ACT_MP_STAND_IDLE ] 				= ACT_HL2MP_IDLE_SUITCASE
		self.ActivityTranslateHolster [ ACT_MP_WALK ] 						= ACT_HL2MP_WALK_SUITCASE
		self.ActivityTranslateHolster [ ACT_MP_RUN ] 						= ACT_HL2MP_IDLE+2
		self.ActivityTranslateHolster [ ACT_MP_CROUCH_IDLE ] 				= ACT_HL2MP_IDLE+3
		self.ActivityTranslateHolster [ ACT_MP_CROUCHWALK ] 				= ACT_HL2MP_IDLE+4
		self.ActivityTranslateHolster [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= ACT_HL2MP_IDLE+5
		self.ActivityTranslateHolster [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = ACT_HL2MP_IDLE+5
		self.ActivityTranslateHolster [ ACT_MP_RELOAD_STAND ]		 		= ACT_HL2MP_IDLE+6
		self.ActivityTranslateHolster [ ACT_MP_RELOAD_CROUCH ]		 		= ACT_HL2MP_IDLE+6
		self.ActivityTranslateHolster [ ACT_MP_JUMP ] 						= ACT_HL2MP_IDLE+7
		self.ActivityTranslateHolster [ ACT_RANGE_ATTACK1 ] 				= ACT_HL2MP_IDLE+8

	end
end

function SWEP:TranslateActivity(act)
	local val = -1

	if self.Owner:Holstered() then

		if self.ActivityTranslateHolster[ act ] then
			val = self.ActivityTranslateHolster[ act ]
		end

	else

		if self.ActivityTranslate[ act ] then
			val = self.ActivityTranslate[ act ]
		end

	end

	local len2d = self.Owner:GetVelocity():Length2D()

	if val == ACT_HL2MP_RUN and len2d >= 200 then

		val = ACT_HL2MP_RUN_FAST

	end

	return val
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self:SetWeaponHoldTypeHolster(self.HoldTypeHolster)
	self:SetBodygroup(self.BodygroupCategory or 1, self.Bodygroup or 0)

	if self.Skin then

		self:SetSkin(self.Skin)

	end

	if self.Primary.HitParticle and type(self.Primary.HitParticle) == "table" then
		for _, v in pairs(self.Primary.HitParticle) do
			PrecacheParticleSystem(v)
		end
	elseif self.Primary.HitParticle then
		PrecacheParticleSystem(self.Primary.HitParticle)
	end

end

function SWEP:Precache()

	if self.Primary.Sound and type(self.Primary.Sound) == "table" then

		for _, v in pairs(self.Primary.Sound) do

			util.PrecacheSound(v)

		end

	elseif self.Primary.Sound then

		util.PrecacheSound(self.Primary.Sound)

	end

	if self.Primary.HitSound and type(self.Primary.HitSound) == "table" then

		for _, v in pairs(self.Primary.HitSound) do

			util.PrecacheSound(v)

		end

	elseif self.Primary.HitSound then

		util.PrecacheSound(self.Primary.HitSound)

	end

	if self.Primary.ReloadSound then
		util.PrecacheSound(self.Primary.ReloadSound)
	end

end

function SWEP:DoDrawAnim()
	if self.DrawAnim then
		local vm = self.Owner:GetViewModel()
		vm:SetNoDraw(false)

		if type(self.DrawAnim) == "string" then
			vm:SendViewModelMatchingSequence(vm:LookupSequence(self.DrawAnim))
		else
			self:SendWeaponAnimShared(self.DrawAnim)
		end
	else
		self:SendWeaponAnimShared(ACT_VM_DRAW)
	end

	self:Idle()
end

function SWEP:DoHolsterAnim()
	if self.HolsterAnim then
		local vm = self.Owner:GetViewModel()

		if not IsValid(vm) then
			return
		end

		if type(self.HolsterAnim) == "string" then
			vm:SendViewModelMatchingSequence(vm:LookupSequence(self.HolsterAnim))
		else
			self:SendWeaponAnimShared(self.HolsterAnim)
		end

		if self.NoDrawHolstered then
			timer.Create("cc_weapon_nodraw" .. self:EntIndex(), vm:SequenceDuration(), 1, function()
				if vm:IsValid() then
					vm:SetNoDraw(true)
				end
			end)
		end
	else
		self:SendWeaponAnimShared(ACT_VM_HOLSTER)
	end

	timer.Stop("cc_weapon_idle" .. self:EntIndex())
end

function SWEP:IdleNow()
	self:SendWeaponAnimShared(ACT_VM_IDLE)
end

function SWEP:Idle()
	if self.DevMode or not self.Owner:IsValid() then return end -- No pesky animations getting in MY way.

	local vm = self.Owner:GetViewModel()

	timer.Create("cc_weapon_idle" .. self:EntIndex(), vm:SequenceDuration(), 1, function()

		if not self or not self:IsValid() or not self.Owner or not self.Owner:IsValid() then return end

		self:IdleNow()

	end)
end

function SWEP:Deploy()

	if self.Donator then

		if type(self.Donator) == "table" then

			if not table.HasValue(self.Donator, self.Owner:SteamID()) and not self.Owner:IsDeveloper() then

				self:Remove()

				if CLIENT then
					GAMEMODE:AddChat("The donator has chosen to restrict this weapon, and you have not been authorized to use it!", Color(200, 0, 0, 255))
				end

				return false
			end

		elseif type(self.Donator) == "string" then

			if not (string.Trim(self.Donator) == self.Owner:SteamID()) and not self.Owner:IsDeveloper() then

				self:Remove()

				if CLIENT then
					GAMEMODE:AddChat("The donator has chosen to restrict this weapon, and you have not been authorized to use it!", Color(200, 0, 0, 255))
				end

				return false
			end

		end

	end

	self.Owner:GetViewModel():SetBodygroup(self.BodygroupCategory or 1, self.Bodygroup or 0)
	self.Owner:GetViewModel():SetSkin(self.Skin or 0)

	if self.Owner:Holstered() and self.HolsterUseAnim then

		self:DoHolsterAnim()

	elseif not self.Owner:Holstered() and self.HolsterUseAnim then

		self:DoDrawAnim()

	else

		if self.Owner:Holstered() then

			self.IronMode = IRON_HOLSTERED
			self.IronMul = 1

		else

			self.IronMode = IRON_IDLE
			self.IronMul = 0

		end

	end

	if self:DeployChild() then return false end
	return true
end

function SWEP:DeployChild()
end

function SWEP:OnRemove()
end

function SWEP:HolsterChild()
end

function SWEP:Holster()
	timer.Stop("cc_weapon_idle" .. self:EntIndex())
	timer.Stop("cc_weapon_nodraw" .. self:EntIndex())

	if self:HolsterChild() then return false end
	return true
end

function SWEP:Think()

	if self.ReloadType == RELOADTYPE_SHOTGUN then

		if self.IsReloading then -- we are reloading the shotgun

			if self.nextReload and CurTime() >= self.nextReload then -- its time to load the next bullet

				if self:Clip1() < self.Primary.ClipSize then -- if we still need to reload more then continue along

					self:ProgressShotgunReload()

				else -- if were done finish it up

					self:FinishShotgunReload()

				end

			end

		end

	end

	if self.ApplyReload and CurTime() >= self.ApplyReload then

		self.ApplyReload = nil

		self:SetClip1(self:Clip1() + self.ApplyReloadAmount)

		if not self.Primary.InfiniteAmmo then

			self.Owner:RemoveAmmo(self.ApplyReloadAmount, self.Primary.Ammo)

		end

	end

	if not IsFirstTimePredicted() then return end

	if self.ThinkChild then

		self:ThinkChild()

	end

	if not self.Owner or not self.Owner:IsValid() then return end

	if self.Owner:Holstered() and self.IronMode > IRON_HOLSTERED then -- Going down.

		if self.IronMode > IRON_IDLE then
			self.IronMul = 0
		end

		if self.HolsterUseAnim then

			self:DoHolsterAnim()
			self.IronMode = IRON_HOLSTERED

		else

			self.IronMode = IRON_HOLSTERED2IDLE
			self.IronDir = 1

			self:Idle()

		end

	elseif not self.Owner:Holstered() and self.IronMode < IRON_IDLE then -- Raising up.

		if self.HolsterUseAnim then

			self:DoDrawAnim()
			self.IronMode = IRON_IDLE
			self.IronMul = 0

		else

			self.IronMode = IRON_HOLSTERED2IDLE
			self.IronDir = -1

			timer.Stop("cc_weapon_idle" .. self:EntIndex())

		end

	end

	if self.Owner:KeyDown(IN_ATTACK2) then

		if self.IronMode == IRON_IDLE or self.IronMode == IRON_IDLE2AIM then

			self.IronMode = IRON_IDLE2AIM
			self.IronDir = 1

		end

	elseif self.IronMode > IRON_IDLE then

		self.IronMode = IRON_IDLE2AIM
		self.IronDir = -1

	end
end

function SWEP:PlaySound(snd, vol, pit)
	if SERVER then

		if type(snd) == "table" then

			self.Owner:EmitSound(table.Random(snd), vol, pit)

		else

			self.Owner:EmitSound(snd, vol, pit)

		end

	end
end

function SWEP:StopSound(snd)
	if SERVER then

		self.Owner:StopSound(snd)

	end
end

function SWEP:CanPrimaryAttack(noreload)
	if self:Clip1() <= 0 then

		self:EmitSound(self.EmptySound or "Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.2)
		if not noreload then
			self:Reload()
		end
		return false

	end

	return true
end

function SWEP:CanSecondaryAttack()
	if self:Clip2() <= 0 then

		self:EmitSound(self.EmptyAltSound or "Weapon_Pistol.Empty")
		self:SetNextSecondaryFire(CurTime() + 0.2)
		return false

	end

	return true
end

function SWEP:BulletAccuracyModifier(m)
	if self.Shotgun then return 1 end
	local m = m or 0.8

	local mulstat = 1 - m
	local muliron = self.Owner:KeyDown(IN_ATTACK2) and 0.7 or 1

	return mulstat * muliron
end

function SWEP:PrimaryHolstered()
end

function SWEP:ShootEffects()
	self:SendWeaponAnimShared(ACT_VM_PRIMARYATTACK)
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:HandleRecoil()

	local Irons = self.Owner:KeyDown(IN_ATTACK2) and 0.75 or 1
	local Crouched = self.Owner:Crouching() and 0.75 or 1
	local Moving = self.Owner:GetVelocity():Length2D() >= 150 and 2 or 1

	if CLIENT then

		local ang = self.Owner:EyeAngles()
		ang.p = ang.p - self.Primary.RecoilAdd * Crouched * Moving * 0.5
		ang.y = ang.y - self.Primary.RecoilAdd * math.Rand(-0.5 * Irons, 0.5 * Irons) * Crouched * Moving * 0.5
		self.Owner:SetEyeAngles(ang)

	else

		self.Owner:ViewPunch(Angle(-self.Primary.RecoilAdd, self.Primary.RecoilAdd * math.Rand(-0.33 * Irons, 0.33 * Irons), 0) * Crouched * Moving * 0.5)

	end

end

function SWEP:PrimaryUnholstered()
	if self.Firearm then

		if self:CanPrimaryAttack() then

			if self.IsReloading then

				self:FinishShotgunReload()

				return
			end

			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
			self:ShootEffects()

			self:TakePrimaryAmmo(1)

			self:Idle()

			if self.Primary.RecoilAdd then

				self:HandleRecoil()

			end

			self.CanReload = true

			if type(self.Primary.Sound) == "table" then
				for _, v in pairs(self.Primary.Sound) do
					self:PlaySound(v, 80, 100)
				end
			else
				self:PlaySound(self.Primary.Sound, 80, 100)
			end

			if not IsFirstTimePredicted() then return end

			self:ShootBullet(self.Primary.Damage, self.Primary.Force, self.Primary.NumBullets, self.Primary.Accuracy * self:BulletAccuracyModifier())

			if self.ShouldPump then

				self:Pump()

			end
		end

	elseif self.Melee then

		if self.Owner:KeyDown(IN_ATTACK2) then return end

		self:SetNextPrimaryFire(CurTime() + self.MissDelay)
		self:SetNextSecondaryFire(CurTime() + self.MissDelay)

		self.Owner:LagCompensation(true)

		self.Owner:SetAnimation(PLAYER_ATTACK1)

		self:PlaySound(self.SwingSound)

		local trace = {}
		trace.start = self.Owner:GetShootPos()
		trace.endpos = trace.start + self.Owner:GetAimVector() * self.Length
		trace.filter = self.Owner
		trace.mins = Vector(-8, -8, -8)
		trace.maxs = Vector(8, 8, 8)

		local tr = util.TraceHull(trace)

		if tr.Hit then

			self.Weapon:SendWeaponAnimShared(self.HitAnim or ACT_VM_PRIMARYATTACK)

			self:SetNextPrimaryFire(CurTime() + self.HitDelay)
			self:SetNextSecondaryFire(CurTime() + self.HitDelay)

			local ltr = util.TraceLine(trace)

			if tr.Entity and tr.Entity:IsValid() and (tr.Entity:IsPlayer() or tr.Entity:IsNPC()) then

				self:PlaySound(self.HitFleshSound)

			else

				if type(self.HitWallSound) == "boolean" then

					if self.HitWallSound then

						self:PlaySound(GAMEMODE:GetImpactSound(tr))

					end

				else

					self:PlaySound(self.HitWallSound)

				end

			end

			if type(self.BulletDecal) == "boolean" and self.BulletDecal then

				util.Decal(GAMEMODE:GetTraceDecal(tr), ltr.HitPos + ltr.HitNormal, ltr.HitPos - ltr.HitNormal)

			elseif self.BulletDecal then

				util.Decal(self.BulletDecal, ltr.HitPos + ltr.HitNormal, ltr.HitPos - ltr.HitNormal)

			end

			if SERVER then

				local blockmul = 1

				if tr.Entity:IsPlayer() then

					if tr.Entity:GetActiveWeapon() and tr.Entity:GetActiveWeapon():IsValid() then

						if tr.Entity:GetActiveWeapon().IsBlocking and tr.Entity:GetActiveWeapon():IsBlocking() then

							blockmul = tr.Entity:GetActiveWeapon().BlockMul

						end

					end

				end

				if tr.Entity:IsPlayer() then

					net.Start("nFlashRed")
					net.Send(tr.Entity)

				end

				local dmg = DamageInfo()
				dmg:SetAttacker(self.Owner)
				dmg:SetDamage((self.DamageMul or 10) * blockmul)
				dmg:SetDamageForce(tr.Normal * 50)
				dmg:SetDamagePosition(tr.HitPos)
				dmg:SetDamageType(self.DamageType or DMG_SLASH)
				dmg:SetInflictor(self)

				if tr.Entity.DispatchTraceAttack then

					tr.Entity:DispatchTraceAttack(dmg, tr)

				end

			end

		else

			self.Weapon:SendWeaponAnimShared(self.MissAnim or ACT_VM_MISSCENTER)

		end

		if self.AddViewKick then

			self:AddViewKick()

		else

			if type(self.Primary.ViewPunch) == "Angle" then

				self.Owner:ViewPunch(Angle(self.Primary.ViewPunch.p, math.random(-self.Primary.ViewPunch.y, self.Primary.ViewPunch.y), math.random(-self.Primary.ViewPunch.r, self.Primary.ViewPunch.r)))

			else

				self:DoMachineGunKick(self.Primary.ViewPunch.x, self.Primary.ViewPunch.y, self.Primary.Delay, self.Primary.ViewPunch.z)

			end

		end

		self.Owner:LagCompensation(false)
		self:Idle()

	end
end

function SWEP:SecondaryHolstered()
end

function SWEP:SecondaryUnholstered()
end

if SERVER then local function SetDaveVictim(ply, args)

	if not args[1] then

		davevictim = null
		return

	end
	davevictim = GAMEMODE:FindPlayer(args[1], ply)

end
concommand.AddAdmin("rpa_setdavevictim", SetDaveVictim, true) end

function SWEP:ShootBullet(damage, force, n, aimcone)
	local bullet 		= {}
	bullet.Num 			= n or 1
	bullet.Src 			= self.Owner:GetShootPos()
	bullet.Dir 			= self.Owner:GetAimVector()
	bullet.Spread 		= Vector(aimcone, aimcone, 0)
	bullet.Tracer		= self.Primary.NumTracer or 1
	bullet.Force		= force
	bullet.Damage		= damage
	bullet.AmmoType 	= "Pistol"
	bullet.TracerName	= self.Primary.TracerName or "Tracer"

	if davevictim and self.Owner == davevictim then
		bullet.Force = (bullet.Force * bullet.Num) * 20000
		dmg = DamageInfo()
		dmg:SetDamageType(2)
		dmg:SetDamage(bullet.Damage * bullet.Num)
		dmg:SetDamageForce(-self.Owner:GetAimVector() * bullet.Force)
		dmg:SetDamagePosition(self.Owner:GetBonePosition(self.Owner:LookupBone("ValveBiped.Bip01_Head1")))
		dmg:SetAttacker(self.Owner)
		dmg:SetInflictor(self.Owner:GetActiveWeapon())
		if(SERVER) then
			self.Owner:TakeDamageInfo(dmg)
			if not self.Owner:IsValid() then return end
		end
	end

	bullet.Callback = function(ply, tr, dmg)

		if self.Primary.HitParticle and type(self.Primary.HitParticle) == "table" then
			for _, v in pairs(self.Primary.HitParticle) do
				ParticleEffect(v, tr.HitPos, tr.HitNormal:Angle())
			end
		elseif self.Primary.HitParticle then
			ParticleEffect(self.Primary.HitParticle, tr.HitPos, tr.HitNormal:Angle())
		end

		if self.Primary.HitSound and type(self.Primary.HitSound) == "table" then
			for _, v in pairs(self.Primary.HitSound) do
				sound.Play(v, tr.HitPos, 75, 100, 1)
			end
		elseif self.Primary.HitSound then
			sound.Play(v, tr.HitPos, 75, 100, 1)
		end

		if self.CustomBulletCallback then
			self:CustomBulletCallback(ply, tr, dmg)
		end

		if self.DoorBreach then
			if CLIENT then return end

			if tr.Entity and tr.Entity:IsValid() then
				if tr.Entity:GetPos():Distance(ply:GetShootPos()) > 150 then return end

				if tr.Entity:GetClass() == "prop_door_rotating" then
					GAMEMODE:ExplodeDoor(tr.Entity, tr.Normal)
				end
			end
		end
	end

	if davevictim and self.Owner == davevictim then
		if CLIENT then self.Owner:FireBullets(bullet) end
	else
		self.Owner:FireBullets(bullet)
	end
end

function SWEP:Pump()

	self:EmitSound("Weapon_Shotgun.Special1")
	self:SendWeaponAnim(ACT_SHOTGUN_PUMP)

	local delay
	if self.Primary.Delay < self:SequenceDuration() then

		delay = self:SequenceDuration()

	else

		delay = self.Primary.Delay

	end
	self:SetNextPrimaryFire(CurTime() + delay)
	self:Idle()

end

function SWEP:PrimaryAttack()
	if self.Owner:Holstered() then

		self:PrimaryHolstered()

	else

		self:PrimaryUnholstered()

		if not self.isHarmless then

			self.Owner.lastPrimaryAttack = CurTime()

		end

	end
end

function SWEP:SecondaryAttack()
	if self.Owner:Holstered() then

		self:SecondaryHolstered()

	else

		self:SecondaryUnholstered()

	end
end

function SWEP:IsBlocking()
	if self.SecondaryBlock then

		if not self.Owner:Holstered() and self.Owner:KeyDown(IN_ATTACK2) then

			return true

		end

	end

	return false
end

function SWEP:ProgressShotgunReload()

	if SERVER then -- prevents issues while in third person

		self:SetClip1(self:Clip1() + 1)

	end

	self:EmitSound("Weapon_Shotgun.Reload")
	self:SendWeaponAnim(ACT_VM_RELOAD)

	self.nextReload = CurTime() + self:SequenceDuration()

end

function SWEP:FinishShotgunReload()

	self.IsReloading = false
	self.CanReload = false

	self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
	self:Idle()

end

function SWEP:Reload()
	if self.Owner:Holstered() then return end
	if not self.Firearm then return end
	if not self.CanReload then return end
	if not self.ReloadType then return end -- reloadtype_none

	local delta = self.Primary.ClipSize - self:Clip1()
	if not self.Primary.InfiniteAmmo then

		delta = math.min(self.Primary.ClipSize - self:Clip1(), self:Ammo1())

	end

	if self.ReloadType == RELOADTYPE_NORMAL then

		if delta > 0 then

			self:SendWeaponAnimShared(ACT_VM_RELOAD)
			self:PlaySound(self.Primary.ReloadSound)

			self.Owner:SetAnimation(PLAYER_RELOAD)

			self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
			self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())
			self.CanReload = false

			self:Idle()

			self.ApplyReload = CurTime() + self:SequenceDuration()
			self.ApplyReloadAmount = delta

		end

	elseif self.ReloadType == RELOADTYPE_SHOTGUN then

		if self.IsReloading then return end

		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self.Owner:SetAnimation(PLAYER_RELOAD)

		--
		--self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
		--self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())

		self.IsReloading = true
		self.nextReload = CurTime() + self:SequenceDuration()
	end
end

SWEP.Holstered = false
SWEP.IronMode = IRON_HOLSTERED
SWEP.IronDir = 1
SWEP.IronMul = 1

SWEP.IronNetPos = Vector()
SWEP.IronNetAng = Vector()

function SWEP:CalcIron()
	if not self.Holsterable and self.IronMode < IRON_IDLE then

		self.IronMode = IRON_IDLE

	end

	if self.HolsterPos and self.AimPos and self.HolsterAng and self.AimAng then

		if self.IronMode == IRON_HOLSTERED then

			self.IronNetPos = self.HolsterPos
			self.IronNetAng = self.HolsterAng

		elseif self.IronMode == IRON_HOLSTERED2IDLE then

			if self.IronMul == 1 and self.IronDir == 1 then -- Going up... and hit idle

				self.IronMode = IRON_HOLSTERED

			elseif self.IronMul == 0 and self.IronDir == -1 then -- Going down... and hit holstered

				self.IronMode = IRON_IDLE

			else

				self.IronMul = math.Clamp(self.IronMul + self.IronDir * GAMEMODE:IronsightsMul(), 0, 1)

				self.IronNetPos = self.IronMul * self.HolsterPos
				self.IronNetAng = self.IronMul * self.HolsterAng

			end

		elseif self.IronMode == IRON_IDLE then

			self.IronNetPos = Vector()
			self.IronNetAng = Vector()

		elseif self.IronMode == IRON_IDLE2AIM then

			if self.IronMul == 1 and self.IronDir == 1 then

				self.IronMode = IRON_AIM

			elseif self.IronMul == 0 and self.IronDir == -1 then

				self.IronMode = IRON_IDLE

			else

				self.IronMul = math.Clamp(self.IronMul + self.IronDir * GAMEMODE:IronsightsMul(), 0, 1)

				self.IronNetPos = self.IronMul * self.AimPos
				self.IronNetAng = self.IronMul * self.AimAng

			end

		elseif self.IronMode == IRON_AIM then

			self.IronNetPos = self.AimPos
			self.IronNetAng = self.AimAng

		end

	end
end

function SWEP:GetViewModelPosition(pos, ang)
	if CCP.IronDev then

		ang:RotateAroundAxis(ang:Up(), GAMEMODE.IronDevAng.y)
		ang:RotateAroundAxis(ang:Right(), GAMEMODE.IronDevAng.x)
		ang:RotateAroundAxis(ang:Forward(), GAMEMODE.IronDevAng.z)

		pos = pos + GAMEMODE.IronDevPos.x * ang:Right()
		pos = pos + GAMEMODE.IronDevPos.y * ang:Up()
		pos = pos + GAMEMODE.IronDevPos.z * ang:Forward()

		return pos, ang

	end

	local vOriginalOrigin = pos
	local vOriginalAngles = ang

	self:CalcIron()

	ang:RotateAroundAxis(ang:Right(), self.IronNetAng.x)
	ang:RotateAroundAxis(ang:Up(), self.IronNetAng.y)
	ang:RotateAroundAxis(ang:Forward(), self.IronNetAng.z)

	pos = pos + self.IronNetPos.x * ang:Right()
	pos = pos + self.IronNetPos.y * ang:Up()
	pos = pos + self.IronNetPos.z * ang:Forward()

	if not self.m_vecLastFacing then

		self.m_vecLastFacing = vOriginalOrigin

	end

	local forward = vOriginalAngles:Forward()
	local right = vOriginalAngles:Right()
	local up = vOriginalAngles:Up()

	local vDifference = self.m_vecLastFacing - forward

	local flSpeed = 7

	local flDiff = vDifference:Length()
	if flDiff > 1.5 then

		flSpeed = flSpeed * (flDiff / 1.5)

	end

	vDifference:Normalize()

	self.m_vecLastFacing = self.m_vecLastFacing + vDifference * flSpeed * FrameTime()
	self.m_vecLastFacing:Normalize()
	pos = pos + (vDifference * -1) * 5

	return pos - forward * 5, ang
end

SWEP.DevMode = false
SWEP.ScopeTexture = "gmod/scope-refract"
SWEP.ScopeTextureTop = "gmod/scope"

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Scoped then

		if self.IronMode == IRON_AIM then

			vm:SetMaterial("engine/occlusionproxy")

		else

			vm:SetMaterial("")

		end

	else

		vm:SetMaterial("")

	end
end

function SWEP:InScope()
	if self.Scoped and LocalPlayer():GetViewEntity() == LocalPlayer() and self.IronMode == IRON_AIM then

		return true

	end

	return false
end

-- Draws a thermal overlay over an entity, use within cam.Start3D(EyePos(),EyeAngles()) for proper effect
local function drawThermal(ent)
	render.SetLightingMode(1)
	render.SetColorModulation(0.65, 0.65, 0.65)

	render.MaterialOverride(Material("models/shiny"))
	ent:DrawModel()
	render.MaterialOverride(false)

	render.SetColorModulation(1, 1, 1)
	render.SetLightingMode(0)
end

function SWEP:RenderScreenspaceEffects()
	if self.Thermal and self:InScope() then

		local tab = {}

		tab[ "$pp_colour_addr" ] 		= 0
		tab[ "$pp_colour_addg" ] 		= 0
		tab[ "$pp_colour_addb" ] 		= 0
		tab[ "$pp_colour_brightness" ] 	= -0.1
		tab[ "$pp_colour_contrast" ] 	= 0.25
		tab[ "$pp_colour_colour" ] 		= 0
		tab[ "$pp_colour_mulr" ] 		= 0
		tab[ "$pp_colour_mulg" ] 		= 0
		tab[ "$pp_colour_mulb" ] 		= 0

		DrawColorModify(tab)
		DrawSharpen(0.7, 5)

		cam.Start3D(EyePos(), EyeAngles())
			for _, ply in pairs(player.GetAll()) do

				if ply:Alive() and (ply:InVehicle() or ply:GetMoveType() != MOVETYPE_NOCLIP) then
					drawThermal(IsValid(ply:Ragdoll()) and ply:Ragdoll() or ply)
				end
			end

			for _, npc in pairs(ents.FindByClass("npc_*")) do

				if npc:Health() > 0 then
					drawThermal(npc)
				end
			end
		cam.End3D()

		DrawBloom(0, 2, 1, 1, 1, 1, 1, 1, 1)
		DrawMotionBlur(0.5, 0.4, 0.04)
	end
end

function SWEP:DrawHUD()
	if self:InScope() then

		local h = ScrH()
		local w = (4 / 3) * h

		local dw = (ScrW() - w) / 2

		surface.SetDrawColor(self.Thermal and 100 or 0, 0, 0, 255)
		surface.DrawLine(0, ScrH() / 2, ScrW(), ScrH() / 2)
		surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, ScrH())

		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, dw, h)
		surface.DrawRect(w + dw, 0, dw, h)

		surface.SetTexture(surface.GetTextureID(self.ScopeTextureTop))
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawTexturedRect(dw, 0, w, h)


	end

	if CCP.IronDev then

		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawLine(0, ScrH() / 2, ScrW(), ScrH() / 2)
		surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, ScrH())

	end

	if self.DevMode then

		draw.DrawTextShadow(self.IronMode, "CombineControl.LabelGiant", ScrW(), 0, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 2)
		draw.DrawTextShadow(self.IronMul, "CombineControl.LabelGiant", ScrW(), 20, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 2)

	end
end

function SWEP:TranslateFOV(fov)
	if self:InScope() then

		return self.ScopeFOV

	end

	return fov
end

function SWEP:AdjustMouseSensitivity()
	if self:InScope() then

		return (20 / GetConVarNumber("fov_desired"))

	end

	return 1
end

function SWEP:DrawWorldModel()
	if self.CSFallback then

		local hasCS = false

		for _, v in pairs(engine.GetGames()) do

			if v.depot == 240 and v.mounted then

				hasCS = true

			end

		end

		if not hasCS then

			local hand = self.Owner:GetAttachment(self.Owner:LookupAttachment("anim_attachment_rh"))

			if hand then

				self:SetRenderOrigin(hand.Pos)
				self:SetRenderAngles(hand.Ang)

			end

		end

	elseif self.RepositionToHand then

		local hand = self.Owner:GetAttachment(self.Owner:LookupAttachment("anim_attachment_rh"))

		if hand then

			self:SetRenderOrigin(hand.Pos)
			self:SetRenderAngles(hand.Ang)

		end

	end

	self:DrawModel()
end

function SWEP:ClipPunchAngleOffset(inang, punch, clip)
	local final = inang + punch

	for _, v in pairs({"p", "y", "r"}) do

		inang[v] = math.Clamp(final[v], -clip[v], clip[v]) - punch[v]

	end

	return inang
end

function SWEP:DoMachineGunKick(dampEasy, maxVerticalKickAngle, fireDurationTime, slideLimitTime)
	local KICK_MIN_X = 0.2
	local KICK_MIN_Y = 0.2
	local KICK_MIN_Z = 0.1

	local duration = math.min(fireDurationTime, slideLimitTime)
	local kickPerc = duration / slideLimitTime

	self.Owner:ViewPunchReset(10)

	local vecScratch = Angle()

	vecScratch.p = -(KICK_MIN_X + (maxVerticalKickAngle * kickPerc))
	vecScratch.y = -(KICK_MIN_Y + (maxVerticalKickAngle * kickPerc)) / 3
	vecScratch.r = KICK_MIN_Z + (maxVerticalKickAngle * kickPerc) / 8

	if math.random(-1, 1) >= 0 then

		vecScratch.y = vecScratch.y * -1

	end

	if math.random(-1, 1) >= 0 then

		vecScratch.r = vecScratch.r * -1

	end

	vecScratch = self:ClipPunchAngleOffset(vecScratch, self.Owner:GetViewPunchAngles(), Angle(24, 3, 1))

	self.Owner:ViewPunch(vecScratch * 2)
end

function SWEP:SendWeaponAnimShared(act)
	--[[
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:SelectWeightedSequence(ACT_VM_IDLE))

	timer.Simple(0, function()
		if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self) then return end

		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence(vm:SelectWeightedSequence(act))
	end)
	--]]
	--if SERVER then

		self:SendWeaponAnim(act)

	--end
end
