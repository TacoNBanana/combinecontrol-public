AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "V-45DC"
SWEP.Category 			= "TRP - SkyNET"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_skynet_45watt.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_skynet_45watt.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/weapons/lens1"] = "null"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.Delay 				= 60 / 600

SWEP.Plasma 			= true
SWEP.Damage 			= 16

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(30)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 2

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.8

SWEP.FireSound 			= "Terminator_Plasma.SkyNET.45watt"
SWEP.Tracer 			= "trp_laser"
SWEP.LaserColor 		= Color(255, 100, 100)

SWEP.AltWeapon 			= "20mm"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 1, -1),
		Ang = Angle(1, 0, 0)
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
		Pos = Vector(0, 1, 1),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AltOffsets = setmetatable({
	Default = {
		Pos = Vector(-2, 1, -2),
		Ang = Angle(-2, 0, 5)
	},
	Aim = {
		Pos = Vector(-2, 0, 0),
		Ang = Angle(-2, 0, 5)
	}
}, {__index = SWEP.BaseOffsets})

function SWEP:FireAnimationEvent(_, _, event)
	if event != 21 then
		return true
	end
end
