AddCSLuaFile()

SWEP.PrintName 				= "Antlion"
SWEP.Slot 					= 1
SWEP.SlotPos 				= 1

SWEP.UseHands 				= false
SWEP.ViewModel 				= "models/weapons/c_arms.mdl"
SWEP.WorldModel 			= ""

SWEP.InfoText 				= [[Primary: Slash
Secondary: Jump]]

SWEP.Damage 				= 80

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Ammo			= ""
SWEP.Primary.Automatic 		= true

SWEP.Secondary.ClipSize 	= 1
SWEP.Secondary.DefaultClip 	= 1
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.Automatic 	= false

function SWEP:Initialize()
	self.BaseClass.Initialize(self)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "InJump")

	self:NetworkVar("Float", 0, "AnimEnd")

	self:NetworkVar("Int", 0, "Anim")

	self.SetupDone = true
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
	if self.Owner:IsOnGround() and self:GetInJump() then
		if SERVER then
			self:SetInJump(false)

			self.Owner:StopSound("antlion_flight_loop")
			self.Owner:EmitSound("antlion_flight_land")
		end

		self.Owner:SetVelocity(-self.Owner:GetVelocity())

		self.Owner:SetBodygroup(1, 0)
	end
end

function SWEP:OwnerTakeDamage(ply, dmg)
	if self:GetInJump() or self:GetAnimEnd() >= CurTime() then
		dmg:ScaleDamage(0.5)
	end
end

function SWEP:PrimaryAttack()
	if self:GetInJump() or not self.Owner:IsOnGround() then
		return
	end

	if self:GetAnimEnd() >= CurTime() then
		return
	end

	math.randomseed(CurTime())

	local anim = self.Owner:LookupSequence("attack" .. math.random(6))

	GAMEMODE:FreezePlayer(self.Owner, self.Owner:SequenceDuration(anim))

	if SERVER then
		self:SetAnim(anim)
		self:SetAnimEnd(CurTime() + self.Owner:SequenceDuration(anim))

		self.Owner:EmitSound("NPC_Antlion.MeleeAttackSingle")
	end

	local trace = util.TraceHull({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 100,
		filter = self.Owner,
		mins = Vector(-20, -20, -15),
		maxs = Vector(20, 20, 15),
		mask = MASK_SHOT_HULL
	})

	local ent = trace.Entity

	if SERVER and IsValid(ent) then
		local info = DamageInfo()
		info:SetAttacker(self.Owner)
		info:SetDamageForce(trace.Normal * 10000)
		info:SetDamagePosition(trace.HitPos)
		info:SetDamageType(bit.bor(DMG_CLUB, DMG_SLASH))
		info:SetInflictor(self)

		if ent:IsNPC() then
			info:SetDamage(ent:Health())
		else
			info:SetDamage(self.Damage)
		end

		ent:TakeDamageInfo(info)

		if ent:GetClass() == "prop_door_rotating" then
			GAMEMODE:ExplodeDoor(ent, trace.Normal * 10)
		end
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

function SWEP:SecondaryAttack()
	if self:GetInJump() or not self.Owner:IsOnGround() then
		return
	end

	if self:GetAnimEnd() >= CurTime() then
		return
	end

	local trace = self.Owner:GetEyeTrace()

	local startPos = self.Owner:GetPos()
	local endPos = trace.HitPos

	if startPos:Distance(endPos) > 1600 then
		return
	end

	local maxVel = math.min(800, startPos:Distance(endPos))

	self.Owner:SetVelocity(getJumpVelocity(startPos, endPos, 0, maxVel))

	if SERVER then
		self.Owner:EmitSound("antlion_flight_loop")
	end

	self.Owner:SetBodygroup(1, 1)

	timer.Simple(0.01, function()
		self:SetInJump(true)
	end)
end

function SWEP:CalcMainActivity(ply, vel)
	if self:GetAnimEnd() >= CurTime() then
		if ply.lastSeqOverride != self:GetAnim() then
			ply:SetCycle(0)
		end

		ply.CalcSeqOverride = self:GetAnim()
	end

	if self:GetInJump() then
		ply.CalcSeqOverride = ply:LookupSequence("jump_glide")
	end

	ply.lastSeqOverride = ply.CalcSeqOverride
end