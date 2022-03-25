AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Glock 19"
SWEP.Category 			= "TRP - Pistols"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_glock_edit.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_glock.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "pistol"
SWEP.PassiveHoldType 	= "normal"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {1000, 1500}
SWEP.JamTypes 			= {
	Misfire = 8,
	Malfunction = 75
}

SWEP.ClipSize 			= 15
SWEP.Delay 				= 60 / 600

SWEP.Damage 			= 13

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(35)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(25)}

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Weapon_Glock.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(5, -2, 3),
		Ang = Angle(22, 0, 0)
	},
	Sprint = {
		Pos = Vector(2, -5, -18),
		Ang = Angle(-45, 0, 0)
	},
	Aim = {
		Pos = Vector(1, 2, 2),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	return true
end
