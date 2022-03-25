AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "TC-P02"
SWEP.Category 			= "TRP - Jury-rigged"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_m4.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_tc_m4.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	[3] = "null",
	[4] = "null"
}

SWEP.SubMaterialsWM 	= {
	[10] = "null",
	[11] = "null"
}

SWEP.ActiveHoldType 	= "smg"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.Delay 				= 60 / 200

SWEP.Plasma 			= true
SWEP.Damage 			= 20

SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(30)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Terminator_Plasma.JuryRigged.M4"
SWEP.Tracer 			= "trp_laser"
SWEP.LaserColor 		= Color(255, 100, 100) * 127

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(-4, 1, -1),
		Ang = Angle(0, 0, -5)
	},
	Holster = {
		Pos = Vector(0, -10, 0),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(-2, -4, 0),
		Ang = Angle(10, 25, 0)
	},
	Aim = {
		Pos = Vector(-2, 3, 0),
		Ang = Angle(0, 0, -5)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_PRIMARYATTACK] = "fire01"
}

function SWEP:GetConditionInternal()
	return 0
end

function SWEP:FireAnimationEvent(_, _, event)
	if event != 21 then
		return true
	end
end
