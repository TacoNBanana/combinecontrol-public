AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "T-500 Plasma Repeater"
SWEP.Category 			= "TRP - Drones"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_minigun_3.mdl")
SWEP.WorldModel 		= ""

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.Firemodes 			= -1

SWEP.ClipSize 			= -1
SWEP.Delay 				= 60 / 750

SWEP.Plasma 			= true
SWEP.Damage 			= 10

SWEP.StandingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(30)}
SWEP.CrouchingAccuracy 	= SWEP.StandingAccuracy

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilDiv 			= Vector(3, 2, 8)
SWEP.RecoilKick 		= 0.5

SWEP.FireSound 			= "Terminator_Plasma.T500"
SWEP.Tracer 			= "trp_laser"

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
	if event == 20 or event == 5001 then
		return true
	end
end
