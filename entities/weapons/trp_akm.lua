AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "AKM"
SWEP.Category 			= "TRP - Rifles"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/tfa_ins2/c_akz.mdl")
SWEP.WorldModel 		= Model("models/weapons/tfa_ins2/w_akz.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {-1, 0}

SWEP.AmmoType 			= "ammo_rifle"
SWEP.Durability 		= {6000, 8000}

SWEP.ClipSize 			= 30
SWEP.Delay 				= 60 / 600
SWEP.JamTypes 			= {
	Rate = 60 / 300,
	Sear = 15,
	Malfunction = 150
}

SWEP.Damage 			= 22

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1.2

SWEP.FireSound 			= "Terminator_AK47.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -12, -1),
		Ang = Angle(10, 45, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(15, 5, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 1),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_DRAW] = ACT_VM_DRAW_DEPLOYED
}

SWEP.AnimEmptySupport = table.MakeAssociative({
	ACT_VM_RELOAD
})

SWEP.FixWorldModel 		= {
	ang = Angle(-1, -5, 178),
	pos = Vector(5, 1.3, -1.5),
	scale = 1
}
