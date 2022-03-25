AddCSLuaFile()

SWEP.PrintName 				= "Base"
SWEP.Author 				= "TankNut"

SWEP.RenderGroup 			= RENDERGROUP_TRANSLUCENT

SWEP.Category 				= "Tekka"
SWEP.Tekka 					= true

SWEP.Slot 					= 2

SWEP.ViewModel 				= "models/tekka/weapons/c_hk_alternate.mdl"
SWEP.WorldModel 			= "models/tekka/weapons/w_hk_alternate.mdl"

SWEP.UseHands 				= true

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.SwingSound 			= Sound("Weapon_Crowbar.Single")
SWEP.HitFleshSound 			= Sound("Weapon_Crowbar.Melee_Hit")

SWEP.HitDelay 				= 0.5
SWEP.MissDelay 				= 0.8

SWEP.Damage 				= 0
SWEP.DamageType 			= DMG_SLASH

SWEP.SwayIntensity 			= 1
SWEP.RunThreshold 			= 1.2

SWEP.ApproachSpeed 			= 10

SWEP.VMMovementScale 		= 0.4

SWEP.VMBodyGroups 			= {}
SWEP.WMBodyGroups 			= {}

-- Replacing the table with just a single entry applies it as a normal material instead of a sub
-- Using true instead of a string hides the submaterial instead
SWEP.VMSubMaterials 		= {}
SWEP.WMSubMaterials 		= {}

if CLIENT then
	SWEP.HideWM					= false

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

SWEP.HoldType 			= "grenade"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(-20, 25, 0),
	pos = Vector(0, 0, 0)
}

SWEP.CrouchOffset = {
	ang = Vector(0, 0, -5),
	pos = Vector(-1, 0, 1)
}

AddCSLuaFile("cl_model.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_offsets.lua")
AddCSLuaFile("cl_sck.lua")

AddCSLuaFile("sh_animations.lua")

include("sh_animations.lua")

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
	end

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
	self:NetworkVar("Float", 1, "NextModeSwitch")

	self:NetworkVar("Bool", 0, "Holstered")
end

function SWEP:Deploy()
	if not IsValid(self.Owner) then
		return
	end

	self:SetHolstered(true)
	self:SetHoldType(self.HoldTypeLowered)

	if CLIENT then
		self.BlendPos, self.BlendAng = self.LoweredOffset.pos, self.LoweredOffset.ang
	end

	self:PlayAnimation("draw", -1, 1, true, self.VM, true)
end

function SWEP:Holster(weapon)
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

	return true
end

function SWEP:PrimaryAttack()
	if not self:CanFire() then
		return
	end

	local ply = self.Owner

	ply:LagCompensation(true)

	ply:SetAnimation(PLAYER_ATTACK1)
	self:EmitSound(self.SwingSound)

	local info = {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + (ply:GetAimVector() * 50),
		filter = ply,
		mins = Vector(-8, -8, -8),
		maxs = Vector(8, 8, 8)
	}

	local tr = util.TraceHull(info)

	if tr.Hit then
		self:PlayAnimation("hit")

		local traceline = util.TraceLine(info)

		if IsValid(traceline.Entity) and (traceline.Entity:IsPlayer() or traceline.Entity:IsNPC()) then
			self:EmitSound(self.HitFleshSound)
		else
			self:EmitSound(GAMEMODE:GetImpactSound(tr))
		end

		if CLIENT then
			util.Decal(GAMEMODE:GetTraceDecal(tr), traceline.HitPos + traceline.HitNormal, traceline.HitPos - traceline.HitNormal)
		end

		local dmg = DamageInfo()
		dmg:SetAttacker(ply)
		dmg:SetDamage(self.Damage)
		dmg:SetDamageForce(tr.Normal * 50)
		dmg:SetDamagePosition(tr.HitPos)
		dmg:SetDamageType(DMG_SLASH)
		dmg:SetInflictor(self)

		if tr.Entity.DispatchTraceAttack then
			tr.Entity:DispatchTraceAttack(dmg, tr)
		end

		self:SetNextPrimaryFire(CurTime() + self.HitDelay)
	else
		self:PlayAnimation("miss")

		self:SetNextPrimaryFire(CurTime() + self.MissDelay)
	end

	ply:LagCompensation(false)
end

function SWEP:SecondaryAttack()
end

function SWEP:IsBlocking()
	if self:ShouldLower() then
		return false
	end

	return self.Owner:KeyDown(IN_ATTACK2)
end

function SWEP:Think()
	if self:ShouldLower() then
		self:SetHoldType(self.HoldTypeLowered)
	else
		self:SetHoldType(self.HoldType)
	end

	self:SoundThink()
end

function SWEP:ShouldLower()
	local ply = self.Owner

	if self:GetHolstered() then
		return true
	end

	if ply:GetMoveType() == MOVETYPE_NOCLIP then
		return false
	end

	if not ply:OnGround() then
		return true
	end

	return false
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

function SWEP:ToggleHolster()
	if CurTime() < self:GetNextModeSwitch() then
		return
	end

	local bool = not self:GetHolstered()

	self:SetHolstered(bool)

	local duration = 0

	if bool then
		duration = self:PlayAnimation("draw", -1, 0, true, self.VM, true)
	else
		duration = self:PlayAnimation("draw", 1, 0, true, self.VM, true)
	end

	self:SetNextModeSwitch(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + duration)
end

function SWEP:OnRemove()
	if CLIENT then
		self:RemoveManagedCSModels()
	end
end

function SWEP:GetThrowPosition(pos)
	local tr = util.TraceHull({
		start = self.Owner:EyePos(),
		endpos = pos,
		mins = Vector(-4, -4, -4),
		maxs = Vector(4, 4, 4),
		filter = self.Owner
	})

	return tr.Hit and tr.HitPos or pos
end

function SWEP:OnReloaded()
	if CLIENT then
		local pos = self.VM:GetPos()
		local ang = self.VM:GetAngles()

		self:SetupCustomVM(self.ViewModel)

		self.VM:SetPos(pos)
		self.VM:SetAngles(ang)
	end
end

function SWEP:FireAnimationEvent(pos, ang, event, name)
	return true
end