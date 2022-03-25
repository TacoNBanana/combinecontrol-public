AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "RPK"
SWEP.Category 			= "TRP - LMG's"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_akm.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_akm.mdl")

SWEP.Bodygroups 		= {
	upgrades = 2
}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.AmmoType 			= "ammo_lmg"
SWEP.Durability 		= {10000, 12000}
SWEP.JamTypes 			= {
	RateSlow = 60 / 500,
	Sear = 30,
	Malfunction = 75
}

SWEP.ClipSize 			= 75
SWEP.Delay 				= 60 / 600

SWEP.Damage 			= 23

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Terminator_M1.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(-1, -2, -1),
		Ang = Angle(10, 20, 0)
	},
	Sprint = {
		Pos = Vector(0, -1.5, -1),
		Ang = Angle(10, 10, 0)
	},
	Aim = {
		Pos = Vector(-2, 1.5, 2.5),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 20 then
		return true
	end
end
