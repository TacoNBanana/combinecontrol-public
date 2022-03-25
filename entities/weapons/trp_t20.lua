AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "T-20 Repeater"
SWEP.Category 			= "TRP - Drones"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_minigun_3.mdl")
SWEP.WorldModel 		= ""

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.Firemodes 			= -1

SWEP.ClipSize 			= -1
SWEP.Delay 				= 60 / 600

SWEP.Damage 			= 8

SWEP.StandingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(30)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.2

SWEP.FireSound 			= "Terminator_Minigun.ThudSoft"
SWEP.Tracer 			= "trp_minitracer"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 3, -5),
		Ang = Angle(0, -15, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, -5),
		Ang = Angle(0, 0, 0)
	},
	Aim = {
		Pos = Vector(0, -3, 7),
		Ang = Angle(-2, 0, 25)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 20 or event == 21 then
		return true
	end
end
