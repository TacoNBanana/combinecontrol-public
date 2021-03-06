AddCSLuaFile()

PrecacheParticleSystem("Weapon_Combine_Ion_Cannon")

SWEP.PrintName 				= "Base"
SWEP.Author 				= "TankNut"

SWEP.RenderGroup 			= RENDERGROUP_TRANSLUCENT

SWEP.Category 				= "Tekka"
SWEP.Tekka 					= true
SWEP.Plasma 				= false

SWEP.Slot 					= 2

SWEP.ViewModel 				= Model("models/tekka/weapons/c_hk_alternate.mdl")
SWEP.WorldModel 			= Model("models/tekka/weapons/w_hk_alternate.mdl")

SWEP.UseHands 				= true

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ClipSize 				= -1
SWEP.Damage 				= 33
SWEP.BulletCount 			= 1
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= false

SWEP.MuzzleEffect 			= false

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= false

SWEP.PumpAction 			= false
SWEP.ShotgunReload 			= false
SWEP.ReloadAmount 			= 1

SWEP.Firemodes 				= {
}

SWEP.SwayIntensity 			= 1
SWEP.RunThreshold 			= 1.2

SWEP.ApproachSpeed 			= 10

SWEP.VMMovementScale 		= 0.4

SWEP.Recoil 				= 1

SWEP.RecoilAxisMod = {
	side = 1,
	forward = 1,
	up = 1,
	pitch = 1,
	roll = 1
}

SWEP.AimCone 				= 0.005
SWEP.HipCone 				= 0.045

SWEP.UseClumpSpread 		= false
SWEP.ClumpSpread 			= 0.1

SWEP.UseBolt 				= false
SWEP.BoltLockOnEmpty 		= false
SWEP.BoltBone 				= "v_weapon.bolt"
SWEP.BoltOffset 			= Vector(0, 0, -2.5)
SWEP.BoltRecoverySpeed 		= 40

SWEP.FireSound 				= ""

--[[
SWEP.LoopSounds = {
	loop = "NPC_Hunter.FlechetteShootLoop",
	stop = "tyrant/tyrant_attackend.wav"
}]]
SWEP.LoopSounds 			= {
}

SWEP.VMBodyGroups 			= {}
SWEP.WMBodyGroups 			= {}

SWEP.LaserLine = Material("effects/laser_citadel1.vmt")
SWEP.LaserGlow = Material("effects/blueflare1.vmt")

-- Replacing the table with just a single entry applies it as a normal material instead of a sub
-- Using true instead of a string hides the submaterial instead
SWEP.VMSubMaterials 		= {}
SWEP.WMSubMaterials 		= {}

SWEP.AllowThermals 			= false

if CLIENT then
	SWEP.HideWM						= false

	SWEP.UseRTScope 				= false
	SWEP.RTScopeAlwaysOn 			= false
	SWEP.RTScopeAlternativeAngle 	= true
	SWEP.RTScopeFOV 				= 20
	SWEP.RTScopeSCKIndex 			= -1
	SWEP.RTScopeMaterialIndex 		= 0 -- Submaterial index on the viewmodel
	SWEP.RTScopeRotation 			= {right = 0, up = 0, forward = 0} -- Some weapon models render upside-down by default
	SWEP.RTScopeReticle 			= surface.GetTextureID("scope/scope_crossx")
	SWEP.RTScopeCover 				= surface.GetTextureID("tekka/lens1")
	SWEP.RTScopeCoverPercentage 	= 0.1

	SWEP.UseAimpoint 				= false
	SWEP.AimpointMaterial 			= Material("reticles/aim_reticule")
	SWEP.AimpointColor 				= Color(255, 75, 75, 255)
	SWEP.AimpointSize 				= 0.4

	-- See cl_sck.lua
	SWEP.VElements 	= {}
	SWEP.WElements 	= {}
	SWEP.VMBoneMods = {}
end

--[[
Takes an animation name as key and either a single sequence or a table of sequence as values

SWEP.Animations = {
	reload = "ir_reload",
	fire = {"fire1", "fire2", "fire3"}
}

fire animation is usable in conjuction with SWEP.UseFireAnimation]]
SWEP.Animations = {}

--[[
Takes a sequence as key and a table of sound data as the value

SWEP.SoundScripts = {
	reload = {
		{time = 0.33, snd = soundscript.AddReload("TEKKA_AKM_MAGOUT", "weapons/ak47/ak47_clipout.wav")},
		{time = 1.13, snd = soundscript.AddReload("TEKKA_AKM_MAGIN", "weapons/ak47/ak47_clipin.wav")},
		{time = 1.7, snd = soundscript.AddReload("TEKKA_AKM_BOLT", "weapons/ak47/ak47_boltpull.wav")}
	}
}]]
SWEP.SoundScripts = {}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.52, -10, 0.64)
}

SWEP.LoweredOffset = {
	ang = Vector(-20, 25, 0),
	pos = Vector(0, 0, 0)
}

SWEP.CrouchOffset = {
	ang = Vector(0, 0, -5),
	pos = Vector(-1, 0, 1)
}

SWEP.PlayerBodyGroups = {}

AddCSLuaFile("cl_model.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_offsets.lua")
AddCSLuaFile("cl_sck.lua")

AddCSLuaFile("sh_animations.lua")
AddCSLuaFile("sh_recoil.lua")
AddCSLuaFile("sh_firemodes.lua")

include("sh_animations.lua")
include("sh_recoil.lua")
include("sh_firemodes.lua")

if CLIENT then
	include("cl_model.lua")
	include("cl_hud.lua")
	include("cl_offsets.lua")
	include("cl_sck.lua")
end

function SWEP:Initialize()
	self:SetupWM()

	if CLIENT then
		self:SetupCustomVM(self.ViewModel)
		self:SetupSCK()

		if self.UseRTScope and not self.RTScopeTarget then
			self.RTScopeTarget = GetRenderTarget("tekka_scope_rt_" .. ScrH(), ScrH(), ScrH(), false)

			local ent = self.VM

			if self.RTScopeSCKIndex != -1 then
				ent = self.VElements[self.RTScopeSCKIndex].Entity
			end

			ent:SetSubMaterial(self.RTScopeMaterialIndex, "tekka/rtscope")

			if self.AllowThermals then
				self.RTScopeCallback = ThermalScopeCallback
			end
		end
	end

	self:SetupFiremodes()

	self:SetFiremode(nil, 1)
	self:SetClip1(not self.AmmoItem and self.ClipSize or 0)

	if CLIENT then
		self:Deploy() -- Client doesn't call deploy the first time
	end

	for k, v in pairs(self.WMBodyGroups) do
		if not isnumber(k) then
			continue
		end

		self:SetBodygroup(k, v)
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "FiremodeIndex")
	self:NetworkVar("Int", 1, "BurstAmount")

	self:NetworkVar("Float", 0, "NextModeSwitch")
	self:NetworkVar("Float", 1, "FinishReload")
	self:NetworkVar("Float", 2, "FinishBurst")

	self:NetworkVar("Bool", 0, "Holstered")
	self:NetworkVar("Bool", 1, "AbortReload")
	self:NetworkVar("Bool", 2, "IsFiring")
end

function SWEP:Deploy()
	if not IsValid(self.Owner) then
		return
	end

	self:SetHolstered(true)
	self:SetHoldType(self.HoldTypeLowered)

	if CLIENT then
		self.BlendPos, self.BlendAng = self.LoweredOffset.pos, self.LoweredOffset.ang
		self.RTScopeAlpha = 1
	end

	-- Some viewmodels have idle viewmodel sway built in which fucks with our own, this usually cancels it out
	self:PlayAnimation("draw", 1, 1, true, self.VM, true)

	local group = self.PlayerBodyGroups[self.Owner:GetModel()]

	if group then
		for k, v in pairs(group) do
			if not isnumber(k) then
				continue
			end

			self.Owner:SetBodygroup(k, v)
		end
	end
end

function SWEP:Holster(weapon)
	if self:GetFinishReload() != 0 then
		return false
	end

	local group = self.PlayerBodyGroups[self.Owner:GetModel()]

	if group then
		for k, v in pairs(group) do
			if not isnumber(k) then
				continue
			end

			self.Owner:SetBodygroup(k, 0)
		end
	end

	return true
end

function SWEP:SetupWM()
	if istable(self.WMSubMaterials) then
		for k, v in pairs(self.WMSubMaterials) do
			if not isnumber(k) then
				continue
			end

			if isstring(v) then
				self:SetSubMaterial(k, v)
			else
				self:SetSubMaterial(k, "engine/occlusionproxy")
			end
		end
	else
		self:SetMaterial(self.WMSubMaterials)
	end
end

function SWEP:CanFire()
	if self:ShouldLower() then
		return false
	end

	if self:IsReloading() then
		return false
	end

	return self:GetFiremode().CanFire(self)
end

function SWEP:PrimaryAttack()
	if self.AllowThermals and self.Owner:KeyDown(IN_USE) then
		if CLIENT and not self.Owner:KeyDownLast(IN_ATTACK) and IsFirstTimePredicted() then
			local bool = self.RTScopeCallback == ThermalScopeCallback

			if bool then
				self.RTScopeCallback = false
			else
				self.RTScopeCallback = ThermalScopeCallback
			end

			self:EmitSound("weapons/smg1/switch_single.wav")
		end

		return
	end

	if self.ShotgunReload and self:IsReloading() then
		self:SetAbortReload(true)

		return
	end

	if not self:CanFire() then
		if CLIENT then
			self:EmitSound("weapons/ar2/ar2_empty.wav")
		end

		self:SetNextPrimaryFire(CurTime() + 0.2)

		return
	end

	self:GetFiremode().Fire(self)
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_USE) then
		self:CycleFiremode()
	end
end

function SWEP:CanReload()
	if self:ShouldLower() then
		return false
	end

	if self:IsReloading() then
		return false
	end

	return self:GetFiremode().CanReload(self)
end

function SWEP:Reload()
	if not self:CanReload() then
		return
	end

	return self:GetFiremode().Reload(self)
end

function SWEP:Think()
	if self:ShouldLower() then
		self:SetHoldType(self.HoldTypeLowered)
	else
		self:SetHoldType(self.HoldType)
	end

	if IsFirstTimePredicted() then
		if CLIENT and self.UseBolt then
			self:BoltThink()
		end

		self:CalculateSpread()
	end

	self:SoundThink()
	self:GetFiremode().Think(self)
end

function SWEP:ShouldLower()
	local ply = self.Owner

	if self:GetHolstered() then
		return true
	end

	if ply:GetMoveType() == MOVETYPE_NOCLIP then
		return false
	end

	if self:IsSprinting() then
		return true
	end

	return false
end

function SWEP:AimingDownSights()
	local ply = self.Owner

	if self:ShouldLower() then
		return false
	end

	if ply:KeyDown(IN_USE) then
		return false
	end

	return ply:KeyDown(IN_ATTACK2)
end

function SWEP:IsSprinting()
	local ply = self.Owner
	local vel = ply:GetVelocity():Length()
	local walk = ply:GetWalkSpeed()

	if not ply:OnGround() then
		return false
	end

	if ply:KeyDown(IN_SPEED) and vel > (walk * self.RunThreshold) then
		return true
	end

	if vel > walk * 3 then
		return true
	end

	return false
end

function SWEP:IsReloading()
	return self:GetFinishReload() != 0
end

function SWEP:ToggleHolster()
	if CurTime() < self:GetNextModeSwitch() then
		return
	end

	self:SetNextModeSwitch(CurTime() + 0.3)

	self:SetHolstered(not self:GetHolstered())
end

function SWEP:DoFireAnimation()
	if self:AimingDownSights() then
		return self.UseFireAnimationADS
	else
		return self.UseFireAnimationHip
	end
end

function SWEP:OnRemove()
	if CLIENT then
		self:RemoveManagedCSModels()
	end

	if self:GetIsFiring() then
		self:StopFiring()
	end
end

function SWEP:StartFiring()
	if self.LoopSounds.loop then
		self:EmitSound(self.LoopSounds.loop)
	end
end

function SWEP:StopFiring()
	if self.LoopSounds.loop then
		self:StopSound(self.LoopSounds.loop)
	end

	if self.LoopSounds.stop then
		self:EmitSound(self.LoopSounds.stop)
	end
end

function SWEP:FireBullet(damage, amt, clump, tracer)
	local ply = self.Owner
	local cone = self.CurrentCone
	local lance = tracer == "lance"

	if lance then
		tracer = ""
	end

	clump = clump or 0

	math.randomseed(ply:GetCurrentCommand():CommandNumber())

	local aimcone = Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0)
	local bullet = {}

	bullet.Num 			= amt
	bullet.Src 			= ply:GetShootPos()
	bullet.Dir 			= (ply:GetAimVector():Angle() + ply:GetViewPunchAngles() + aimcone * 25):Forward()
	bullet.Spread 		= Vector(clump, clump, 0)
	bullet.Damage 		= damage
	bullet.Tracer 		= 1
	bullet.TracerName 	= tracer or "tracer"
	bullet.Force 		= damage * 0.3
	bullet.AmmoType 	= ""

	bullet.Callback 	= function(attacker, tr, dmg)
		if self.DoDissolve then
			dmg:SetDamageType(bit.bor(DMG_AIRBOAT, DMG_DISSOLVE))
		end

		if lance and IsFirstTimePredicted() then
			local e = EffectData()

			e:SetOrigin(tr.HitPos)
			e:SetNormal(tr.HitNormal)

			util.Effect("cc_e_art", e)
		end
	end

	if lance and IsFirstTimePredicted() then
		util.ParticleTracerEx("Weapon_Combine_Ion_Cannon", bullet.Src, util.TraceLine({
			start = bullet.Src,
			endpos = bullet.Src + (bullet.Dir * 8192),
			mask = MASK_SHOT,
			filter = {self, ply}
		}).HitPos, true, self:EntIndex(), 1)
	end

	ply:FireBullets(bullet)
end

function SWEP:OnReloaded()
	if CLIENT then
		local pos = self.VM:GetPos()
		local ang = self.VM:GetAngles()

		self:SetupCustomVM(self.ViewModel)

		self.VM:SetPos(pos)
		self.VM:SetAngles(ang)

		if self.UseRTScope then
			local ent = self.VM

			if self.RTScopeSCKIndex != -1 then
				ent = self.VElements[self.RTScopeSCKIndex].Entity
			end

			ent:SetSubMaterial(self.RTScopeMaterialIndex, "tekka/rtscope")
		end
	end

	self:SetupFiremodes()

	self:SetFiremode(nil, self:GetFiremodeIndex())
	self:PlayAnimation("draw", 1, 1, true, self.VM, true)
end

function SWEP:AdjustMouseSensitivity()
	local fov = self.Owner:GetFOV()

	if self:AimingDownSights() and self.UseRTScope then
		fov = self.RTScopeFOV
	end

	fov = math.Remap(fov, 5, 90, 0.25, 1)

	return math.Clamp(fov, 0.1, 1)
end

function SWEP:FireAnimationEvent(pos, ang, event, name)
	if event == 5001 then
		return true
	end

	if self.Plasma and (event == 6001 or event == 20) then
		return true
	end
end