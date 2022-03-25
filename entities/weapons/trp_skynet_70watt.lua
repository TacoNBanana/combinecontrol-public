AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "V-70H"
SWEP.Category 			= "TRP - SkyNET"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_skynet_75watt.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_skynet_75watt.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/trpweapons/skynet_40watt_1"] = "null",
	["models/tnb/weapons/lens1"] = "null"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.Delay 				= 1

SWEP.Plasma 			= true
SWEP.Damage 			= 80

SWEP.StandingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(70)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 3

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 2

SWEP.FireSound 			= "Terminator_Plasma.SkyNET.70watt"
SWEP.Tracer 			= "trp_laser"
SWEP.LaserColor 		= Color(0, 100, 255)

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
		Pos = Vector(0, 1, 1),
		Ang = Angle(15, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 2, 1),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	return true
end
