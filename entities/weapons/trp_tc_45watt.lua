AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "TC-P45C"
SWEP.Category 			= "TRP - TechCom"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_prototype.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_tc_prototype.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	[1] = "models/tnb/trpweapons/aim_red_trans"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 5

SWEP.AutoBurst 			= 0.5
SWEP.BurstDelay 		= 60 / 700

SWEP.Plasma 			= true
SWEP.Damage 			= 12

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(25)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 2

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Terminator_Plasma.TC.45watt"
SWEP.Tracer 			= "trp_laser"
SWEP.LaserColor 		= Color(255, 100, 100)

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 1, -1),
		Ang = Angle(1, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -7, -1),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(-2, -2, 0),
		Ang = Angle(10, 25, 0)
	},
	Aim = {
		Pos = Vector(0, 1.5, 0.5),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_PRIMARYATTACK] = "shoot1"
}

function SWEP:FireAnimationEvent(_, _, event)
	return true
end
