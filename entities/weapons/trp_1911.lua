AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M1911"
SWEP.Category 			= "TRP - Pistols"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_1911.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_1911.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "pistol"
SWEP.PassiveHoldType 	= "normal"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {1000, 1500}
SWEP.JamTypes 			= {
	Misfire = 4,
	Malfunction = 40
}

SWEP.ClipSize 			= 8
SWEP.Delay 				= 60 / 300

SWEP.Damage 			= 16

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(35)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(25)}

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1.2

SWEP.FireSound 			= "Terminator_1911.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 0, 5),
		Ang = Angle(20, 0, 0)
	},
	Sprint = {
		Pos = Vector(-2, -2, -20),
		Ang = Angle(-40, 0, 0)
	},
	Aim = {
		Pos = Vector(0, 2, 2),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	return true -- Fucked
end
