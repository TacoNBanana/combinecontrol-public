AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Mossberg 590A1"
SWEP.Category 			= "TRP - Shotguns"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_mossberg.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_mossberg.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "shotgun_ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_shotgun"
SWEP.Durability 		= {900, 1100}
SWEP.JamTypes 			= {
	Misfire = 3
}

SWEP.ClipSize 			= 8
SWEP.Delay 				= -1

SWEP.BulletCount 		= 8
SWEP.Damage 			= 90

SWEP.CrouchingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(8)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(8)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.ShotgunReload 		= true

SWEP.RecoilKick 		= 4

SWEP.FireSound 			= "Terminator_Shotgun.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -8, 0),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 2),
		Ang = Angle(15, 15, 0)
	},
	Aim = {
		Pos = Vector(-5, 3, 1.5),
		Ang = Angle(-1, 0, -2)
	}
}

function SWEP:PrimaryFire()
	BaseClass.PrimaryFire(self)

	timer.Simple(0.35, function() -- No pump sound = we have to make our own
		self:EmitSound("Weapon_M3.Pump")
	end)
end

function SWEP:FireAnimationEvent(_, _, event)
	return true
end
