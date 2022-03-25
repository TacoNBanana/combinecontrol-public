AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "TC-P40"
SWEP.Category 			= "TRP - TechCom"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_35watt.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_tc_35watt.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	[0] = "models/tnb/trpweapons/aim_red_trans"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.Delay 				= 60 / 300

SWEP.Plasma 			= true
SWEP.Damage 			= 18

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 2.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.6

SWEP.FireSound 			= "Terminator_Plasma.TC.40watt"
SWEP.Tracer 			= "trp_laser"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -8, -1),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(-2, -2, -2),
		Ang = Angle(10, 25, 0)
	},
	Aim = {
		Pos = Vector(0, 1.5, 1),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	return true
end
