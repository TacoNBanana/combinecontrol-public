AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M72 LAW"
SWEP.Category 			= "TRP - Launchers"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/c_bo1_law.mdl")
SWEP.WorldModel 		= Model("models/weapons/w_bo1_law.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "rpg"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_rpg"
SWEP.Durability 		= {10, 20}
SWEP.JamTypes 			= {
	Misfire = 2
}

SWEP.ClipSize 			= 1
SWEP.Delay 				= -1

SWEP.CrouchingAccuracy 	= {util.RangeMeters(25, 64), util.RangeMeters(200, 64)}
SWEP.StandingAccuracy 	= {util.RangeMeters(20, 64), util.RangeMeters(100, 64)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 1.5

SWEP.RecoilKick 		= 0

SWEP.FireSound 			= "Terminator_RPG.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -3),
		Ang = Angle(-12.2, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -3, -3),
		Ang = Angle(0, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, -3),
		Ang = Angle(5, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 0, -1),
		Ang = Angle(-12.2, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_DRAW] = ACT_VM_DRAW_DEPLOYED
}

SWEP.FixWorldModel 		= {
	ang = Angle(0, -9, 180),
	pos = Vector(-10, 1, 1),
	scale = 1
}

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Universal.Draw")
	end
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
		local pos = LocalToWorld(Vector(8, -8, -8), angle_zero, ply:GetShootPos(), ang)

		local ent = ents.Create("cc_rpg")

		ent:SetPos(pos)
		ent:SetAngles(ang - Angle(1, 0, 0))
		ent:SetOwner(ply)
		ent:Spawn()
		ent:Activate()
	end

	self:EmitSound(self.FireSound)

	self:ViewKick(ply, self.RecoilKick)
	self:SetLastFire(CurTime())

	self:SubtractDurability(unpack(self.Durability or {}))

	self:SetNextIdle(CurTime() + duration)
	self:SetNextPrimaryFire(CurTime() + delay)
end
