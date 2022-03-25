AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "TC-P01"
SWEP.Category 			= "TRP - Jury-rigged"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_sten.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_tc_sten.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.JamTypes 			= {
	Rate = 60 / 300
}

SWEP.Delay 				= 60 / 550

SWEP.Plasma 			= true
SWEP.Damage 			= 12

SWEP.StandingAccuracy 	= {util.RangeMeters(3), util.RangeMeters(10)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.8

SWEP.FireSound 			= "Terminator_Plasma.JuryRigged.Sten"
SWEP.Tracer 			= "trp_laser"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, -1, 0),
		Ang = Angle(0, 0, -5)
	},
	Holster = {
		Pos = Vector(0, -11, 3),
		Ang = Angle(10, 40, 10)
	},
	Sprint = {
		Pos = Vector(-2, -6, -5),
		Ang = Angle(-5, 25, 10)
	},
	Aim = {
		Pos = Vector(0, 2, 2),
		Ang = Angle(0, 0, -10)
	}
}

function SWEP:GetConditionInternal()
	return 0
end

function SWEP:FireAnimationEvent(_, _, event)
	if event != 21 then
		return true
	end
end
