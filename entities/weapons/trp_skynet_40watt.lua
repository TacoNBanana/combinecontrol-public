AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "V-40"
SWEP.Category 			= "TRP - SkyNET"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_skynet_40watt.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_skynet_40watt.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/weapons/lens1"] = "null"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.Delay 				= 60 / 460

SWEP.Plasma 			= true
SWEP.Damage 			= 16

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 2

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.8

SWEP.FireSound 			= "Terminator_Plasma.SkyNET.40watt"
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
		Pos = Vector(0, -1, 0),
		Ang = Angle(15, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 0),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event != 21 then
		return true
	end
end
