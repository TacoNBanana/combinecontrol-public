AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "T-400 Rocket Launcher"
SWEP.Category 			= "TRP - Drones"

SWEP.SlotPos 			= 11

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_rocketlauncher.mdl")
SWEP.WorldModel 		= ""

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	[1] = "null"
}

SWEP.Firemodes 			= 0

SWEP.ClipSize 			= -1
SWEP.Delay 				= -1

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(30)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Weapon_RPG.Single"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -5),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 0, -2),
		Ang = Angle(10, 15, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, -2),
		Ang = Angle(10, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 0, -2),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:PrimaryFire()
	local ply = self:GetOwner()

	self:TakePrimaryAmmo(1)

	ply:SetAnimation(PLAYER_ATTACK1)

	local duration = self:DoWeaponAnim(ACT_VM_PRIMARYATTACK)
	local delay = self.Delay == -1 and duration or self.Delay

	local spread = math.deg(self:GetCurrentSpread())

	if SERVER then
		local ang = ply:GetAimVector():Angle() + ply:GetViewPunchAngles() + AngleRand(-spread, spread)
		local pos = LocalToWorld(Vector(8, -8, -8), angle_zero, ply:GetShootPos(), ang)

		local ent = ents.Create("cc_rpg_skynet")

		ent:SetPos(pos)
		ent:SetAngles(ang - Angle(1, 0, 0))
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
