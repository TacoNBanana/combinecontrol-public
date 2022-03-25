AddCSLuaFile()

SWEP.PrintName 				= "Base"
SWEP.Author 				= "TankNut"

SWEP.RenderGroup 			= RENDERGROUP_OPAQUE

SWEP.Category 				= "TRP - New"
SWEP.TRP 					= true

SWEP.Slot 					= 2

SWEP.UseHands 				= true
SWEP.UseHandsFix 			= false
SWEP.DrawCrosshair 			= false

SWEP.Bodygroups 			= {}
SWEP.SubMaterials 			= {}

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ActiveHoldType 		= "ar2"
SWEP.PassiveHoldType 		= "passive"

SWEP.Firemodes 				= 3
SWEP.AutoBurst 				= 0

SWEP.AmmoType 				= nil
SWEP.Durability 			= nil
SWEP.JamTypes 				= {}

-- Misfire => 1 in X shots don't fire at all
-- RateVary => Randomizes rate of fire between the default and X
-- RateSlow => Slows rate of fire to X
-- Sear => 1 in X full-auto shots force the gun to stop until fired again
-- Malfunction => 1 in X shots requires a reload to unfuck the gun

SWEP.ClipSize 				= -1
SWEP.Delay 					= 60 / 600
SWEP.BurstDelay 			= 0

SWEP.BulletCount 			= 1
SWEP.Damage 				= 0

SWEP.CrouchingAccuracy 		= {util.EffectiveRange(3000), util.EffectiveRange(4000)}
SWEP.StandingAccuracy 		= {util.EffectiveRange(1000), util.EffectiveRange(5000)}

SWEP.AimTime 				= 1
SWEP.ZoomLevel 				= 1

SWEP.Scoped 				= false
SWEP.ForcedUnscope 			= false

SWEP.SprintTime 			= 0.3
SWEP.HolsterTime 			= 0.3

SWEP.ShotgunReload 			= false
SWEP.ShotgunPump 			= false

SWEP.ReloadTime 			= 0

SWEP.RecoilDiv 				= Vector(1, 3, 8)
SWEP.RecoilKick 			= 0.5

SWEP.FireSound 				= "Weapon_SMG1.Single"
SWEP.Tracer 				= "trp_tracer"

SWEP.AltWeapon 				= nil

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Aim = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AltOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Aim = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimWhitelist = {}
SWEP.AnimReplacements = {}
SWEP.AnimEmptySupport = {}

AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_model.lua")

if CLIENT then
	include("cl_hud.lua")
	include("cl_model.lua")
end

include("sh_altweapons.lua")
include("sh_animation.lua")
include("sh_firemode.lua")
include("sh_helpers.lua")
include("sh_item.lua")
include("sh_misc.lua")
include("sh_reload.lua")

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "LastThink")
	self:NetworkVar("Float", 1, "NextIdle")

	self:NetworkVar("Float", 2, "AimFraction")
	self:NetworkVar("Float", 3, "HolsterFraction")

	self:NetworkVar("Float", 4, "LastFire")

	self:NetworkVar("Float", 5, "ZoomAmount")

	self:NetworkVar("Float", 6, "DeployTime")
	self:NetworkVar("Float", 7, "FinishReload")

	self:NetworkVar("Float", 8, "SprintFraction")
	self:NetworkVar("Float", 9, "AltFraction")

	self:NetworkVar("Float", 10, "Condition")

	self:NetworkVar("Int", 0, "Firemode")
	self:NetworkVar("Int", 1, "BurstAmount")
	self:NetworkVar("Int", 2, "AltAmmo")
	self:NetworkVar("Int", 3, "ItemID")

	self:NetworkVar("Bool", 0, "Holstered")
	self:NetworkVar("Bool", 1, "SwitchedModes")
	self:NetworkVar("Bool", 2, "AltMode")
	self:NetworkVar("Bool", 3, "AbortReload")
	self:NetworkVar("Bool", 4, "FirstReload")
	self:NetworkVar("Bool", 5, "SearFailed")
	self:NetworkVar("Bool", 6, "Malfunction")
	self:NetworkVar("Bool", 7, "NeedPump")
	self:NetworkVar("Bool", 8, "IsFiring")
end

function SWEP:Initialize()
	self.Initialized = true

	self:SetLastThink(CurTime())
	self.DeltaTime = 0

	self:UpdateFiremode(istable(self.Firemodes) and self.Firemodes[1] or self.Firemodes)
	self:SetZoomAmount(istable(self.ZoomLevel) and self.ZoomLevel[1] or self.ZoomLevel)

	self:SetClip1(self.ClipSize)
	self:SetCondition(100)

	self:DrawShadow(false)

	-- Sound stuff

	if CLIENT then
		self.SoundSequence = 0
		self.LastSoundTime = 0
	end
end

function SWEP:OnReloaded()
	if istable(self.Firemodes) then
		self:UpdateFiremode(self.Firemodes[table.KeyFromValue(self.Firemodes, self:GetFiremode()) or 1])
	elseif isnumber(self.Firemodes) then
		self:UpdateFiremode(self.Firemodes)
	end

	if istable(self.ZoomLevel) then
		self:SetZoomAmount(math.Clamp(self:GetZoomAmount(), self.ZoomLevel[1], self.ZoomLevel[2]))
	else
		self:SetZoomAmount(self.ZoomLevel)
	end
end

function SWEP:Deploy()
	local duration = self:DoWeaponAnim(ACT_VM_DRAW)
	local time = CurTime() + duration

	self:SetDeployTime(CurTime())

	self:SetHolstered(true)
	self:SetHolsterFraction(1)

	self:SetHoldType(self.PassiveHoldType)

	self:SetNextIdle(time)
	self:SetPlaybackRate(1)
	self:SetNextPrimaryFire(time)

	local vm = self:GetOwner():GetViewModel()

	if not IsValid(vm) then
		return
	end

	if not self.FixBodygroups then
		for k, v in pairs(self.Bodygroups) do
			model.SetNumBodygroup(vm, k, v)
		end
	end

	model.SetSubMaterials(vm, self.SubMaterials)
end

function SWEP:Holster(new)
	local ply = self:GetOwner()

	if not IsValid(ply) then
		return true
	end

	if self:IsReloading() then
		return false
	end

	if SERVER then
		self:SaveItem()
	end

	local vm = ply:GetViewModel()

	if not IsValid(vm) or new.TRP then
		return true
	end

	vm:SetBodyGroups("")
	vm:SetSubMaterial()

	if CLIENT then
		SafeRemoveEntity(self.HandsModel)
	end

	return true
end

function SWEP:OnRemove()
	local ply = self:GetOwner()

	if not IsValid(ply) then
		return
	end

	if ply:GetActiveWeapon() == self then
		local vm = ply:GetViewModel()

		if not IsValid(vm) then
			return
		end

		vm:SetBodyGroups("")
		vm:SetSubMaterial()
	end

	if self.SoundID then
		self:StopLoopingSound(self.SoundID)
	end

	if CLIENT then
		SafeRemoveEntity(self.HandsModel)
	end
end

function SWEP:CanFire()
	if self:IsLowered() then
		return false
	end

	if self:IsReloading() then
		return false
	end

	if self:GetAltMode() and self:GetAltWeapon().Clip == -1 then
		return true
	end

	if self:Clip1() == 0 then
		return false, true
	end

	return true
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()

	if self:IsLowered() or self:IsBusy() then
		return false
	end

	if ply:KeyDown(IN_USE) then
		if self.AltWeapon and not self:IsBusy() then
			self:ToggleAltWeapon()
		end

		self:HandleAutomatic(false)

		return
	end

	if self:GetMalfunction() then
		if ply:KeyPressed(IN_ATTACK) then
			self:EmitSound("Terminator_Weapon.Jam")
			self:SetNextPrimaryFire(CurTime() + 0.2)
		end

		return false
	end

	if self:GetSearFailed() then
		return false
	end

	math.randomseed(ply:GetCurrentCommand():CommandNumber())

	if self:Clip1() > 0 and self:ConditionProb(self.JamTypes.Misfire) then
		self:EmitSound("Terminator_Weapon.Jam")
		self:SetNextPrimaryFire(CurTime() + 0.2)

		return
	end

	local can, notify = self:CanFire()

	if not can then
		if notify and ply:KeyPressed(IN_ATTACK) then
			self:DoWeaponAnim(ACT_VM_DRYFIRE)
			self:EmitSound("Terminator_Weapon.Empty")
		end

		return
	end

	local handled = false

	if self:GetAltMode() then
		local weapon = self:GetAltWeapon()

		handled = weapon.Fire(self, weapon)
	else
		handled = self:PrimaryFire()
	end

	if not handled then
		self:HandleAutomatic()
	end
end

function SWEP:GetCrouchFraction()
	local ply = self:GetOwner()

	if not ply:OnGround() then
		return 0
	end

	if ply:GetViewOffset().z == ply:GetViewOffsetDucked().z then
		return 1
	end

	return math.Clamp(math.TimeFraction(ply:GetViewOffset().z, ply:GetViewOffsetDucked().z, ply:GetCurrentViewOffset().z), 0, 1)
end

function SWEP:GetSpeedFraction()
	local ply = self:GetOwner()

	return math.Clamp(ply:GetVelocity():Length() / Lerp(self:GetCrouchFraction(), ply:GetWalkSpeed(), ply:GetWalkSpeed() * ply:GetCrouchedWalkSpeed()), 0, 1)
end

local function uLerp(frac, from, to)
	return from + (to - from) * frac
end

function SWEP:GetCurrentSpread()
	local aimFrac = math.ease.InOutQuad(self:GetInterpAim()) * 1.25
	local speedFrac = math.ease.InOutQuad(self:GetSpeedFraction()) * 0.5

	local frac = math.Clamp(aimFrac - speedFrac, -0.5, 1)

	local standing = uLerp(frac, unpack(self.StandingAccuracy))
	local crouching = uLerp(frac, unpack(self.CrouchingAccuracy))

	return math.rad(Lerp(self:GetCrouchFraction(), standing, crouching) * 0.5)
end

function SWEP:PrimaryFire()
	local ply = self:GetOwner()

	self:TakePrimaryAmmo(1)

	ply:SetAnimation(PLAYER_ATTACK1)

	local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)
	local delay = self.Delay == -1 and duration or self.Delay

	if self.JamTypes.Rate then
		local rand = Lerp(self:GetConditionInternal() / 100, self.JamTypes.Rate, delay)

		delay = math.Rand(rand, delay)
	elseif self.JamTypes.RateSlow then
		delay = Lerp(self:GetConditionInternal() / 100, self.JamTypes.RateSlow, delay)
	end

	if self.ShotgunPump then
		duration = delay
	end

	local spread = self:GetCurrentSpread()
	local bullet = {}

	bullet.Attacker 	= ply
	bullet.Num 			= self.BulletCount
	bullet.Src 			= ply:GetShootPos()
	bullet.Dir 			= (ply:GetAimVector():Angle() + ply:GetViewPunchAngles()):Forward()
	bullet.Spread 		= Vector(spread, spread, 0)
	bullet.Damage 		= self.Damage / self.BulletCount
	bullet.TracerName 	= self.Tracer
	bullet.Force 		= self.Damage * 0.3

	if self.Plasma then
		GAMEMODE.PlasmaBullet = true
	end

	GAMEMODE.ShotgunDamage = self.Damage / self.BulletCount

	self:FireBullets(bullet)

	GAMEMODE.ShotgunDamage = nil
	GAMEMODE.PlasmaBullet = nil

	if self.LoopSound then
		if IsFirstTimePredicted() and not self:GetIsFiring() then
			self.SoundID = self:StartLoopingSound(self.LoopSound)
		end
	else
		self:EmitSound(self.FireSound)
	end

	self:SetIsFiring(true)

	self:ViewKick(ply, self.RecoilKick)
	self:SetLastFire(CurTime())

	self:SubtractDurability(unpack(self.Durability or {}))

	self:SetNextIdle(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + delay)

	if self.Primary.Automatic and self:ConditionProb(self.JamTypes.Sear) then
		self:EmitSound("Terminator_Weapon.Jam")
		self:SetSearFailed(true)
	end

	if self:ConditionProb(self.JamTypes.Malfunction) then
		self:EmitSound("Terminator_Weapon.Jam")
		self:SetMalfunction(true)

		if SERVER then
			ply:SendChat(nil, "WARNING", "Your weapon is jammed!")
		end
	end

	if self.ShotgunPump then
		self:SetNeedPump(true)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	local ply = self:GetOwner()

	if ply:KeyDown(IN_USE) then
		self:CycleFiremode()

		return
	end

	if not self:CanReload() then
		return
	end

	self:StartReload()
end

function SWEP:Think()
	if not self.Initialized then
		self:Initialize()
	end

	self.DeltaTime = CurTime() - self:GetLastThink()

	if self:GetSearFailed() and not self:GetOwner():KeyDown(IN_ATTACK) then
		self:SetSearFailed(false)
	end

	self:HandleBurst()
	self:HandleReload()

	self:HandleHoldType()

	self:HandleIdle()
	self:HandleAim()
	self:HandleHolster()
	self:HandleAlt()
	self:HandleSprint()
	self:HandleScope()

	self:HandleImpulse()

	if self:GetIsFiring() and self:GetNextPrimaryFire() < CurTime() - self.Delay then
		self:SetIsFiring(false)

		if self.LoopEndSound then
			self:EmitSound(self.LoopEndSound)
		end

		if self.SoundID then
			self:StopLoopingSound(self.SoundID)
		end
	end

	local ply = self:GetOwner()

	if CLIENT and LocalPlayer() == ply and IsFirstTimePredicted() and not ply:ShouldDrawLocalPlayer() then
		self:HandleSound()
	end

	self:ResetSequence(0)

	self:SetLastThink(CurTime())
end

function SWEP:GetZoom()
	local val = Lerp(self:GetHolsterFraction(), self:GetZoomAmount(), 1.5)
	local frac = self:GetFireFraction()

	if self.ForcedUnscope and frac < 1 then
		val = math.RemapC(frac, 0.1, 0.15, val, 1) + math.RemapC(frac, 0.85, 0.9, 0, val - 1)

		if not self:GetOwner():KeyDown(IN_ATTACK2) then
			val = 1
		end
	end

	return val
end

function SWEP:TranslateFOV(fov)
	if not self:HasCameraControl() then
		self.ViewModelFOV = 54

		return fov
	end

	local desired = self:GetOwner():GetInfo("fov_desired")

	local lerp = math.ease.InOutQuad(self:GetInterpAim())
	local new = Lerp(lerp, fov, fov / self:GetZoom())

	self.ViewModelFOV = 54 + (desired - new) * 0.6

	return new
end

if CLIENT then
	hook.Add("CreateMove", "base_trp", function()
		if not vgui.CursorVisible() then
			if not BPressed and input.WasKeyPressed(KEY_B) then
				BPressed = true
				RunConsoleCommand("impulse", 30)
			end

			if not input.IsKeyDown(KEY_B) then
				BPressed = nil
			end
		end
	end)

	function SWEP:AdjustMouseSensitivity()
		if not self:HasCameraControl() then
			return 1
		end

		return Lerp(math.ease.InOutQuad(self:GetInterpAim()), 1, 1 / self:GetZoom())
	end
end
