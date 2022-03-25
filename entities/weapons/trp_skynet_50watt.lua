AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "V-50R"
SWEP.Category 			= "TRP - SkyNET"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_skynet_50watt.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_skynet_50watt.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/trpweapons/aim_red"] = "models/tnb/trpweapons/aim_red_trans"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.Delay 				= 60 / 200

SWEP.Plasma 			= true
SWEP.Damage 			= 40

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(120)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.6
SWEP.ZoomLevel 			= 4

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Terminator_Plasma.SkyNET.50watt"
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

function SWEP:FireAnimationEvent(_, _, event)
	if event != 21 then
		return true
	end
end
