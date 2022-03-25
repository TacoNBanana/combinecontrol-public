AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "T-20 Repair Tool"
SWEP.Category 			= "TRP - Drones"

SWEP.SlotPos 			= 11

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_pdw.mdl")
SWEP.WorldModel 		= ""

SWEP.UseHands 			= false

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.Firemodes 			= -1

SWEP.ClipSize 			= -1
SWEP.Delay 				= 60 / 600

SWEP.Damage 			= 25

SWEP.StandingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(30)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.2

SWEP.FireSound 			= "ambient/energy/electric_loop.wav"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(-10, -5, 0.5),
		Ang = Angle(0, 0, 225)
	},
	Holster = {
		Pos = Vector(10, -5, -19),
		Ang = Angle(-90, 0, 225)
	},
	Sprint = {
		Pos = Vector(-10, -5, -7),
		Ang = Angle(-20, 0, 225)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_PRIMARYATTACK] = "base_idle"
}

function SWEP:PrimaryFire()
	local ply = self:GetOwner()

	ply:SetAnimation(PLAYER_ATTACK1)

	local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)
	local delay = self.Delay == -1 and duration or self.Delay

	self:SetNextIdle(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + delay)

	local tr = util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ply:GetAimVector() * 75,
		filter = {ply},
		mask = MASK_SOLID
	})

	if not tr.Hit then
		return
	end

	local ent = tr.Entity

	if SERVER and IsValid(ent) and ent:IsPlayer() then
		if ent:Team() == TEAM_SKYNET then
			ent:SetHealth(math.min(ent:Health() + self.Damage * self.Delay, ent:GetMaxHealth()))
		else
			local info = DamageInfo()

			info:SetDamage(self.Damage * self.Delay)
			info:SetAttacker(self:GetOwner())
			info:SetDamagePosition(tr.HitPos)
			info:SetInflictor(self)
			info:SetDamageType(DMG_SHOCK)

			ent:TakeDamageInfo(info)
		end
	end

	if IsFirstTimePredicted() then
		local ed = EffectData()

		ed:SetStart(tr.HitPos)
		ed:SetOrigin(tr.HitPos)
		ed:SetNormal(tr.HitNormal)
		ed:SetMagnitude(1.5)
		ed:SetScale(1)

		util.Effect("ElectricSpark", ed, false)
	end

	self:EmitSound(self.FireSound)

	self:SetLastFire(CurTime())
end

function SWEP:Think()
	BaseClass.Think(self)

	if CurTime() > self:GetLastFire() + self.Delay * 2 then
		self:StopSound(self.FireSound)
	end
end

function SWEP:OnRemove()
	self:StopSound(self.FireSound)
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	self:SetDeployTime(0)
end

function SWEP:FireAnimationEvent(_, _, event)
	return true
end

function SWEP:HandleAim()
	return 0
end
