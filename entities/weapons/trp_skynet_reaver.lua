AddCSLuaFile()

SWEP.Base			= "weapon_cc_base"

SWEP.PrintName 		= "Claws"
SWEP.Slot 			= 1
SWEP.SlotPos 		= 1

SWEP.UseHands		= false
SWEP.ViewModel 		= Model("models/weapons/c_arms_citizen.mdl")
SWEP.WorldModel 	= ""


SWEP.HoldType = "normal"
SWEP.HoldTypeHolster = "normal"

SWEP.Holsterable = false

SWEP.AttackAnims = {
	{"MeleeHigh1", Angle(0, 2, 0)},
	{"MeleeHigh2", Angle(0, -2, 0)},
	{"MeleeHigh3", Angle(2, 2, 0)}}

function SWEP:Precache()
	util.PrecacheSound("physics/wood/wood_crate_impact_hard2.wav")

	util.PrecacheSound("NPC_Vortigaunt.Swing")
	util.PrecacheSound("NPC_Vortigaunt.Claw")
end

function SWEP:PrimaryHolstered()
	local tr = GAMEMODE:GetHandTrace(self.Owner)

	if tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() then

		self:PlaySound("physics/wood/wood_crate_impact_hard2.wav", 100, math.random(95, 105))

		self:SetNextPrimaryFire(CurTime() + 0.1)

	end
end

function SWEP:PrimaryUnholstered()
	if not self.Owner:OnGround() then return end

	self:SetNextPrimaryFire(CurTime() + 1.3)
	self:SetNextSecondaryFire(CurTime() + 1.3)

	local anim = table.Random(self.AttackAnims)
	local sequence = self.Owner:LookupSequence(anim[1])

	GAMEMODE:FreezePlayer(self.Owner, self.Owner:SequenceDuration(sequence))

	self.Owner:PlayVCD(anim[1])
	self.Owner:SetSequence(sequence)

	timer.Simple(0.2, function()
		if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

		self:PlaySound("NPC_Vortigaunt.Swing", 100, 100)
	end)

	timer.Simple(0.3, function()
		if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

		self.Owner:ViewPunch(anim[2])
	end)

	timer.Simple(0.35, function()
		if (not IsValid(self) || not IsValid(self.Owner) || not self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() ~= self) then return end

		self:FistDamage()
	end)
end

function SWEP:FistDamage()
	if CLIENT then return end

	self.Owner:LagCompensation(true)

	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = trace.start + self.Owner:GetAimVector() * 64
	trace.filter = self.Owner
	trace.mins = Vector(-8, -8, -8)
	trace.maxs = Vector(8, 8, 8)

	local tr = util.TraceHull(trace)

	if tr.Hit then

		self:PlaySound("NPC_Vortigaunt.Claw", 100, 100)

		if tr.Entity and tr.Entity:IsValid() then

			local dmg = DamageInfo()
			dmg:SetAttacker(self.Owner)
			dmg:SetDamage(85)
			dmg:SetDamageForce(tr.Normal * 10000)
			dmg:SetDamagePosition(tr.HitPos)
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetInflictor(self)

			if tr.Entity.DispatchTraceAttack then

				tr.Entity:DispatchTraceAttack(dmg, tr)

			end

		end

	end

	self.Owner:LagCompensation(false)
end

function SWEP:SecondaryHolstered()
end

function SWEP:SecondaryUnholstered()
end

function SWEP:ThinkChild()
	self.DrawCrosshair = not self.Owner:Holstered()
end