AddCSLuaFile()

SWEP.RenderGroup 			= RENDERGROUP_OPAQUE

SWEP.PrintName 				= "Reaver"
SWEP.Author 				= "TankNut"

SWEP.Slot 					= 2
SWEP.SlotPos 				= 5

SWEP.DrawCrosshair 			= true

SWEP.ViewModel 				= Model("models/weapons/c_arms_citizen.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.Damage 				= 120

function SWEP:Initialize()
	hook.Add("StartCommand", self, self.StartCommand)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "AnimEnd")
	self:NetworkVar("Float", 1, "NextReload")

	self:NetworkVar("Int", 0, "Anim")
end

function SWEP:Holster()
	if self:GetAnimEnd() >= CurTime() then
		return false
	end

	return true
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()

	if not ply:IsOnGround() then
		return
	end

	if self:GetAnimEnd() >= CurTime() then
		return
	end

	math.randomseed(CurTime())

	local anim = ply:LookupSequence(table.Random({"meleehigh1", "meleehigh2"}))

	if SERVER then
		self:SetAnim(anim)
		self:SetAnimEnd(CurTime() + ply:SequenceDuration(anim))

		timer.Simple(0.5, function()
			ply:EmitSound(table.Random({
				"weapons/knife/knife_hit_01.wav",
				"weapons/knife/knife_hit_02.wav",
				"weapons/knife/knife_hit_03.wav",
				"weapons/knife/knife_hit_04.wav",
				"weapons/knife/knife_hit_05.wav"
			}))
		end)
	end

	local trace = util.TraceHull({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ply:GetAimVector() * 100,
		filter = ply,
		mins = Vector(-20, -20, -20),
		maxs = Vector(20, 20, 20),
		mask = MASK_SHOT_HULL
	})

	local ent = trace.Entity

	if SERVER and IsValid(ent) then
		local info = DamageInfo()
		info:SetAttacker(ply)
		info:SetDamageForce(trace.Normal * 10000)
		info:SetDamagePosition(trace.HitPos)
		info:SetDamageType(bit.bor(DMG_CLUB, DMG_SLASH))
		info:SetInflictor(self)

		if ent:IsNPC() then
			info:SetDamage(ent:Health() * 6)
		else
			info:SetDamage(self.Damage)
		end

		ent:TakeDamageInfo(info)
	end
end

function SWEP:SecondaryAttack()
	local ply = self:GetOwner()

	if not ply:IsOnGround() then
		return
	end

	if self:GetAnimEnd() >= CurTime() then
		return
	end

	math.randomseed(CurTime())

	local anim = ply:LookupSequence("meleehigh3")

	if SERVER then
		self:SetAnim(anim)
		self:SetAnimEnd(CurTime() + ply:SequenceDuration(anim))

		timer.Simple(0.5, function()
			ply:EmitSound(table.Random({
				"weapons/knife/knife_hit_01.wav",
				"weapons/knife/knife_hit_02.wav",
				"weapons/knife/knife_hit_03.wav",
				"weapons/knife/knife_hit_04.wav",
				"weapons/knife/knife_hit_05.wav"
			}))
		end)
	end

	local trace = util.TraceHull({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ply:GetAimVector() * 100,
		filter = ply,
		mins = Vector(-20, -20, -20),
		maxs = Vector(20, 20, 20),
		mask = MASK_SHOT_HULL
	})

	local ent = trace.Entity

	if SERVER and IsValid(ent) then
		local info = DamageInfo()
		info:SetAttacker(ply)
		info:SetDamageForce(trace.Normal * 10000)
		info:SetDamagePosition(trace.HitPos)
		info:SetDamageType(bit.bor(DMG_CLUB, DMG_SLASH))
		info:SetInflictor(self)

		if ent:IsNPC() then
			info:SetDamage(ent:Health() * 6)
		else
			info:SetDamage(self.Damage)
		end

		ent:TakeDamageInfo(info)
	end
end

function SWEP:Reload()
	if self:GetNextReload() > CurTime() then
		return
	end

	local ply = self:GetOwner()

	ply:PlayVCD("gest_chant")

	if SERVER then
		timer.Simple(0.5, function()
			ply:EmitSound("npc/combine_gunship/gunship_moan.wav")
		end)
	end

	self:SetNextReload(CurTime() + 2)
end

function SWEP:CalcMainActivity(ply, vel)
	if self:GetAnimEnd() >= CurTime() then
		if ply.lastSeqOverride != self:GetAnim() then
			ply:SetCycle(0.1)
		end

		ply.CalcSeqOverride = self:GetAnim()
	end

	ply.lastSeqOverride = ply.CalcSeqOverride
end

function SWEP:UpdateAnimation(ply, vel, max)
	if self:GetAnimEnd() >= CurTime() then
		ply:SetPlaybackRate(1)
	end
end

function SWEP:StartCommand(ply, cmd)
	if self:GetAnimEnd() >= CurTime() then
		cmd:ClearMovement()
		cmd:ClearButtons()
	end
end
