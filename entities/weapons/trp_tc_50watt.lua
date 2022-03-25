AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "TC-P50R"
SWEP.Category 			= "TRP - TechCom"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_longrifles.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_tc_longrifles.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.Delay 				= 60 / 200

SWEP.Plasma 			= true
SWEP.Damage 			= 40

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(120)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 4

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Terminator_Plasma.TC.50watt"
SWEP.Tracer 			= "trp_laser"
SWEP.LaserColor 		= Color(255, 100, 100)

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(-5, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -12, 0),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(-5, -1, 3),
		Ang = Angle(15, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 2, 1),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_PRIMARYATTACK] = "shoot1"
}

function SWEP:FireAnimationEvent(_, _, event)
	return true
end
