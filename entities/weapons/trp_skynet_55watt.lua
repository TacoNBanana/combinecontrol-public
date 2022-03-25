AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "V-55DC"
SWEP.Category 			= "TRP - SkyNET"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_skynet_55watt.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_skynet_55watt.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/trpweapons/aim_blu_trans"] = "models/tnb/trpweapons/aim_red_trans"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.Delay 				= 60 / 500

SWEP.Plasma 			= true
SWEP.Damage 			= 20

SWEP.StandingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(40)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 2.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.6

SWEP.FireSound 			= "Terminator_Plasma.SkyNET.55watt"
SWEP.Tracer 			= "trp_laser"
SWEP.LaserColor 		= Color(255, 191, 0)

SWEP.AltWeapon 			= "20mm"

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
		Pos = Vector(0, 1, 2),
		Ang = Angle(15, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 2, 1),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AltOffsets = setmetatable({
	Default = {
		Pos = Vector(-2, 1, 0),
		Ang = Angle(-2, 0, 5)
	},
	Aim = {
		Pos = Vector(0, 2, 0),
		Ang = Angle(-2, 0, 5)
	}
}, {__index = SWEP.BaseOffsets})

SWEP.AnimReplacements = {
	[ACT_VM_PRIMARYATTACK] = "shoot1"
}

function SWEP:FireAnimationEvent(_, _, event)
	return true
end
