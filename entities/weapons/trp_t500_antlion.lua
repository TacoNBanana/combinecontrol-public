AddCSLuaFile()

SWEP.RenderGroup 			= RENDERGROUP_OPAQUE

SWEP.PrintName 				= "Bunny Hop"
SWEP.Author 				= "TankNut"

SWEP.Slot 					= 1
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

SWEP.Damage 				= 60

function SWEP:Initialize()
	hook.Add("StartCommand", self, self.StartCommand)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "InJump")

	self:NetworkVar("Float", 0, "AnimEnd")

	self:NetworkVar("Int", 0, "Anim")
end

function SWEP:Holster()
	if self:GetInJump() then
		return false
	end

	if self:GetAnimEnd() >= CurTime() then
		return false
	end

	return true
end

function SWEP:Think()
	local ply = self:GetOwner()

	if ply:IsOnGround() and self:GetInJump() then
		if SERVER then
			self:SetInJump(false)

			ply:EmitSound("NPC_dog.Pneumatic_1")
		end

		ply:SetVelocity(-ply:GetVelocity())

		ply:SetBodygroup(1, 0)
	end
end

local function getJumpVelocity(startPos, endPos, minHeight, maxHorizontalVelocity) -- Thanks valve
	local gravity = -physenv.GetGravity().z
	local stepHeight = endPos.z - startPos.z

	local targetDir2D = endPos - startPos
	targetDir2D.z = 0

	local distance = endPos:Distance(startPos)

	local minHorzTime = distance / maxHorizontalVelocity
	local minHorzHeight = 0.5 * gravity * (minHorzTime * 0.5) * (minHorzTime * 0.5)

	minHeight = math.max(minHeight, minHorzHeight)
	minHeight = math.max(minHeight, stepHeight)

	local t0 = math.sqrt((2 * minHeight) / gravity)
	local t1 = math.sqrt((2 * math.abs(minHeight - stepHeight)) / gravity)

	local velHorz = distance / (t0 + t1)

	local jumpVel = targetDir2D:GetNormalized() * velHorz

	jumpVel.z = math.sqrt(2 * gravity * minHeight)

	return jumpVel
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()

	if self:GetInJump() or not ply:IsOnGround() then
		return
	end

	if self:GetAnimEnd() >= CurTime() then
		return
	end

	local trace = ply:GetEyeTrace()

	local startPos = ply:GetPos()
	local endPos = trace.HitPos

	if startPos:Distance(endPos) > 1600 then
		return
	end

	local maxVel = math.min(600, startPos:Distance(endPos))

	ply:SetVelocity(getJumpVelocity(startPos, endPos, endPos.z - startPos.z + 100, maxVel))

	if SERVER then
		ply:EmitSound("NPC_dog.Pneumatic_1")
	end

	timer.Simple(0.01, function()
		self:SetInJump(true)
	end)
end

function SWEP:SecondaryAttack()
	local ply = self:GetOwner()

	if self:GetInJump() or not ply:IsOnGround() then
		return
	end

	if self:GetAnimEnd() >= CurTime() then
		return
	end

	math.randomseed(CurTime())

	local anim = ply:LookupSequence("zapattack1")

	if SERVER then
		self:SetAnim(anim)
		self:SetAnimEnd(CurTime() + ply:SequenceDuration(anim) - 1.1)

		timer.Simple(0.5, function()
			ply:EmitSound(table.Random({
				"NPC_dog.Growl_1",
				"NPC_dog.Growl_2",
				"NPC_dog.Angry_2",
				"NPC_dog.Angry_3"
			}))
		end)
	end
end

function SWEP:CalcMainActivity(ply, vel)
	if self:GetAnimEnd() >= CurTime() then
		if ply.lastSeqOverride != self:GetAnim() then
			ply:SetCycle(0.1)
		end

		ply.CalcSeqOverride = self:GetAnim()
	end

	if self:GetInJump() then
		ply.CalcSeqOverride = ply:LookupSequence("run_all")
	end

	ply.lastSeqOverride = ply.CalcSeqOverride
end

function SWEP:UpdateAnimation(ply, vel, max)
	if self:GetInJump() then
		ply:SetPlaybackRate(1)
	elseif self:GetAnimEnd() >= CurTime() then
		ply:SetPlaybackRate(1.5)
	end
end

function SWEP:StartCommand(ply, cmd)
	if self:GetAnimEnd() >= CurTime() then
		cmd:ClearMovement()
		cmd:ClearButtons()
	end
end
