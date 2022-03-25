AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "V-30S"
SWEP.Category 			= "TRP - SkyNET"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_skynet_30watt.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_skynet_30watt.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/weapons/lens1"] = "null",
	["models/tnb/trpweapons/readout2_blu"] = "null",
	["models/tnb/trpweapons/readout_blu"] = "null"
}

SWEP.ActiveHoldType 	= "smg"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.Delay 				= 60 / 750

SWEP.Plasma 			= true
SWEP.Damage 			= 12

SWEP.StandingAccuracy 	= {util.RangeMeters(4), util.RangeMeters(25)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.6

SWEP.FireSound 			= "Terminator_Plasma.SkyNET.30watt"
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
		Pos = Vector(0, 1.5, 0),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_PRIMARYATTACK] = "fire01"
}

function SWEP:FireAnimationEvent(_, _, event)
	if event != 21 then
		return true
	end
end
