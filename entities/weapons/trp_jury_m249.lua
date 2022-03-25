AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "TC-P03"
SWEP.Category 			= "TRP - Jury-rigged"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_tc_m249.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_tc_m249.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/tnb/trpweapons/readout2_blu"] = "null"
}

SWEP.ActiveHoldType 	= "smg"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {5, -1}

SWEP.Delay 				= 60 / 450
SWEP.BurstDelay 		= 60 / 700

SWEP.Plasma 			= true
SWEP.Damage 			= 12

SWEP.StandingAccuracy 	= {util.RangeMeters(4), util.RangeMeters(15)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.8

SWEP.FireSound 			= "Terminator_Plasma.JuryRigged.M249"
SWEP.Tracer 			= "trp_laser"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(-5, 1, -2),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -8, -1),
		Ang = Angle(10, 40, 5)
	},
	Sprint = {
		Pos = Vector(-2, 0, 1),
		Ang = Angle(15, 15, 5)
	},
	Aim = {
		Pos = Vector(-8, 2.5, 0),
		Ang = Angle(0, 0, 0)
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
