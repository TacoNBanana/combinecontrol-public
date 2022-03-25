AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "T-410 Autocannon"
SWEP.Category 			= "TRP - Drones"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_skynet_90watt.mdl")
SWEP.WorldModel 		= ""

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.Firemodes 			= -1

SWEP.ClipSize 			= -1
SWEP.Delay 				= 60 / 300

SWEP.Plasma 			= true
SWEP.Damage 			= 22

SWEP.StandingAccuracy 	= {util.RangeMeters(2), util.RangeMeters(10)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilDiv 			= Vector(4, 2, 8)
SWEP.RecoilKick 		= 2

SWEP.FireSound 			= "Terminator_Minigun.T410"
SWEP.Tracer 			= "trp_laser"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(5, 0, 5),
		Ang = Angle(-2, 0, 0)
	},
	Holster = {
		Pos = Vector(5, 0, 5),
		Ang = Angle(10, -10, 0)
	},
	Sprint = {
		Pos = Vector(5, 0, 5),
		Ang = Angle(10, 0, 0)
	},
	Aim = {
		Pos = Vector(5, 0, 7),
		Ang = Angle(-2, 1, 25)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	return true
end

function SWEP:PrimaryFire()
	local ply = self:GetOwner()

	self:TakePrimaryAmmo(1)

	ply:SetAnimation(PLAYER_ATTACK1)

	local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)
	local delay = self.Delay == -1 and duration or self.Delay

	local spread = math.deg(self:GetCurrentSpread())

	if SERVER then
		local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles() + AngleRand(-spread, spread)
		local pos = LocalToWorld(Vector(0, -5, -3), angle_zero, ply:GetShootPos(), ang)

		local ent = ents.Create("cc_20mm")

		ent:SetPos(pos)
		ent:SetAngles(ang - Angle(2, 0, 0))
		ent:SetOwner(ply)
		ent:Spawn()
		ent:Activate()
	end

	self:EmitSound(self.FireSound)

	self:ViewKick(ply, self.RecoilKick)
	self:SetLastFire(CurTime())

	self:SetNextIdle(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + delay)
end
