AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M1014"
SWEP.Category 			= "TRP - Shotguns"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_xm.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_xm.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "shotgun_ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_shotgun"
SWEP.Durability 		= {900, 1100}
SWEP.JamTypes 			= {
	Misfire = 3,
	Rate = 60 / 100,
}

SWEP.ClipSize 			= 7
SWEP.Delay 				= 60 / 120

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

SWEP.FireSound 			= "Weapon_XM1014.Fire"

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
		Ang = Angle(15, 5, 0)
	},
	Aim = {
		Pos = Vector(-2, 1, 2),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 20 then
		return true
	end
end
