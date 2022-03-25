AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "AMR-20A"
SWEP.Category 			= "TRP - Snipers"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/trpweapons/c_zrg.mdl")
SWEP.WorldModel 		= Model("models/tnb/trpweapons/w_zrg.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_20mm"

SWEP.ClipSize 			= 4
SWEP.Delay 				= -1

SWEP.Damage 			= 120

SWEP.CrouchingAccuracy 	= {util.EffectiveRange(300), util.EffectiveRange(6000, size.Head)}
SWEP.StandingAccuracy 	= {util.EffectiveRange(100), util.EffectiveRange(4000)}

SWEP.AimTime 			= 0.6
SWEP.ZoomLevel 			= {6, 24, 2}

SWEP.Scoped 			= true
SWEP.ForcedUnscope 		= true

SWEP.RecoilTime 		= 0
SWEP.RecoilKick 		= 3

SWEP.FireSound 			= "Weapon_AWP.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -5),
		Ang = Angle(-2, 1, 0)
	},
	Holster = {
		Pos = Vector(0, -9, -2),
		Ang = Angle(10, 45, 0)
	},
	Sprint = {
		Pos = Vector(-2, -2, -15),
		Ang = Angle(-40, 0, 0)
	},
	Aim = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	}
}
