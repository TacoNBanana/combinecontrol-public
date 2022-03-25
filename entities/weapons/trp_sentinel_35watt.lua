AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "SMK-1 35MW"
SWEP.Category 			= "TRP - TechCom"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_carabine.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_tc_carabine.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/trpweapons/readout2_blu"] = "null",
	["models/tnb/trpweapons/tc_50watt_holo_1"] = "null"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {0, 3}

SWEP.Delay 				= 60 / 300
SWEP.BurstDelay 		= 60 / 1000
SWEP.BurstEndDelay 		= 60 / 150

SWEP.Plasma 			= true
SWEP.Damage 			= 16

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(120)}
SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(200)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= {4, 8, 1}

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.5

SWEP.FireSound 			= "Terminator_Plasma.Sentinel.35watt"
SWEP.Tracer 			= "trp_laser"
SWEP.LaserColor 		= Color(255, 100, 100)

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -8, -2),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(-2, -2, 2),
		Ang = Angle(20, 25, 0)
	},
	Aim = {
		Pos = Vector(0, 1.5, 1),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	return true
end
