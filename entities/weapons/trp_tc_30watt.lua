AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "TC-P30C"
SWEP.Category 			= "TRP - TechCom"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_30watt.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_tc_30watt.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/trpweapons/readout2_blu"] = "null",
	["models/tnb/trpweapons/tc_rocketlauncher_1"] = "null",
	["models/tnb/skynet/t600_eye_glow2"] = "null"
}

SWEP.ActiveHoldType 	= "smg"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {3, -1}

SWEP.Delay 				= 60 / 600
SWEP.BurstDelay 		= 60 / 750

SWEP.Plasma 			= true
SWEP.Damage 			= 12

SWEP.StandingAccuracy 	= {util.RangeMeters(4), util.RangeMeters(25)}
SWEP.CrouchingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 2.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.8

SWEP.FireSound 			= "Terminator_Plasma.TC.30watt"
SWEP.Tracer 			= "trp_laser"

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
