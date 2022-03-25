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

SWEP.FireDelay 				= 0

SWEP.AmmoItem 				= false
SWEP.ThrowEntity 			= ""
SWEP.ThrowSound 			= ""

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
	self:NetworkVar("Int", 0, "ThrowMode")

	self:NetworkVar("Float", 0, "FinishReload")
	self:NetworkVar("Float", 1, "NextModeSwitch")
	self:NetworkVar("Float", 2, "FinishThrow")

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
	if self:IsReloading() then
		return false
	end

	if self:IsThrowing() then
		return false
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

	if self:IsThrowing() then
		return false
	end

	return true
end

function SWEP:IsThrowing()
	return self:GetFinishThrow() != 0
end

function SWEP:PrimaryAttack()
	if not self:CanFire() then
		return
	end

	local duration = self:PlayAnimation("drawbackhigh")

	self:SetThrowMode(THROW_NORMAL)
	self:SetFinishThrow(CurTime() + duration)
end

function SWEP:SecondaryAttack()
	if not self:CanFire() then
		return
	end

	local duration = self:PlayAnimation("drawbacklow")

	if self.Owner:Crouching() then
		self:SetThrowMode(THROW_ROLL)
	else
		self:SetThrowMode(THROW_LOB)
	end

	self:SetFinishThrow(CurTime() + duration)
end

function SWEP:Think()
	if self:ShouldLower() then
		self:SetHoldType(self.HoldTypeLowered)
	else
		self:SetHoldType(self.HoldType)
	end

	self:SoundThink()

	if self:IsThrowing() and self:GetFinishThrow() <= CurTime() then
		self:SetFinishThrow(0)

		self.Owner:SetAnimation(PLAYER_ATTACK1)

		local mode = self:GetThrowMode()

		if SERVER then
			local ent = self:CreateEntity()

			if not IsValid(ent) or not IsValid(ent:GetPhysicsObject()) then
				return
			end

			local phys = ent:GetPhysicsObject()

			if mode == THROW_NORMAL then
				local pos = self.Owner:EyePos() + (self.Owner:GetForward() * 18) + (self.Owner:GetRight() * 8)

				ent:SetPos(self:GetThrowPosition(pos))

				phys:SetVelocity(self.Owner:GetVelocity() + self.Owner:GetForward() * 1200)
				phys:AddAngleVelocity(Vector(600, math.random(-1200, 1200), 0))
			elseif mode == THROW_ROLL then
				local pos = self.Owner:GetPos() + Vector(0, 0, 4)
				local facing = self.Owner:GetAimVector()

				facing.z = 0
				facing = facing:GetNormalized()

				local tr = util.TraceLine({
					start = pos,
					endpos = pos + Vector(0, 0, -16),
					filter = self.Owner
				})

				if tr.Fraction != 1 then
					local tan = facing:Cross(tr.Normal)

					facing = tr.Normal:Cross(tan)
				end

				pos = pos + (facing * 18)

				ent:SetPos(self:GetThrowPosition(pos))
				ent:SetAngles(Angle(0, self.Owner:GetAngles().y, -90))

				phys:SetVelocity(self.Owner:GetVelocity() + self.Owner:GetForward() * 700)
				phys:AddAngleVelocity(Vector(0, 0, 720))
			elseif mode == THROW_LOB then
				local pos = self.Owner:EyePos() + (self.Owner:GetForward() * 18) + (self.Owner:GetRight() * 8)

				ent:SetPos(self:GetThrowPosition(pos))

				phys:SetVelocity(self.Owner:GetVelocity() + self.Owner:GetForward() * 350 + Vector(0, 0, 50))
				phys:AddAngleVelocity(Vector(200, math.random(-600, 600), 0))
			end
		end

		self:EmitSound(self.ThrowSound)

		local duration = 0

		if mode == THROW_NORMAL then
			duration = self:PlayAnimation("throw")
		elseif mode == THROW_ROLL then
			duration = self:PlayAnimation("roll")
		elseif mode == THROW_LOB then
			duration = self:PlayAnimation("lob")
		end

		self:SetFinishReload(CurTime() + duration)
	elseif self:IsReloading() and self:GetFinishReload() <= CurTime() then
		self:SetFinishReload(0)

		local itemclass = self.AmmoItem

		if itemclass then
			local item = self.Owner:GetFirstItem(itemclass)

			if not item then
				return
			end

			if class.IsTypeOf(item, "base_stacking") then
				if SERVER then
					item:TakeAmount(1)
				end
			else
				if SERVER then
					GAMEMODE:DeleteItem(item)
				end
			end

			if not IsValid(self.Owner) then
				return
			end
		end

		local duration = self:PlayAnimation("draw")

		self:SetNextPrimaryFire(CurTime() + duration)
	end
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

function SWEP:IsReloading()
	return self:GetFinishReload() != 0
end

function SWEP:ToggleHolster()
	if CurTime() < self:GetNextModeSwitch() then
		return
	end

	if self:IsThrowing() or self:IsReloading() then
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
	self:SetNextSecondaryFire(CurTime() + duration)
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

function SWEP:CreateEntity()
	local ent = ents.Create(self.ThrowEntity)

	ent:SetPos(self.Owner:GetPos())
	ent:SetAngles(self.Owner:EyeAngles())
	ent:SetOwner(self.Owner)
	ent:Spawn()
	ent:Activate()

	return ent
end

function SWEP:OnReloaded()
	if CLIENT then
		local pos = self.VM:GetPos()
		local ang = self.VM:GetAngles()

		self:SetupCustomVM(self.ViewModel)

		self.VM:SetPos(pos)
		self.VM:SetAngles(ang)
	end

	self:PlayAnimation("reload", 1, 1, true, self.VM, true)
end

function SWEP:FireAnimationEvent(pos, ang, event, name)
	return true
end