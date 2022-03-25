AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "IMI UZI"
SWEP.Category 			= "TRP - SMG's"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/v_uzi.mdl")
SWEP.WorldModel 		= Model("models/weapons/w_uzi.mdl")

SWEP.UseHandsFix 		= true

SWEP.Bodygroups 		= {
	upgrades = 1
}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {-1, 0}

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {6000, 8000}
SWEP.JamTypes 			= {
	Rate = 60 / 400,
	Sear = 20,
	Malfunction = 120
}

SWEP.ClipSize 			= 22
SWEP.Delay 				= 60 / 600

SWEP.Damage 			= 18

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Terminator_SMG.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(3, -1, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(3, -1, -0.5),
		Ang = Angle(10, 25, 0)
	},
	Sprint = {
		Pos = Vector(3, 0, 0),
		Ang = Angle(15, 10, 0)
	},
	Aim = {
		Pos = Vector(2, 0.5, 0.5),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimWhitelist = table.MakeAssociative({
	ACT_VM_DRYFIRE
})

SWEP.AnimReplacements = {
	[ACT_VM_DRAW] = ACT_VM_DRAW_DEPLOYED
}

SWEP.AnimEmptySupport = table.MakeAssociative({
	ACT_VM_RELOAD
})

SWEP.FixWorldModel 		= {
	ang = Angle(-1, -5, 178),
	pos = Vector(5, 1.3, -1.5),
	scale = 0.8
}
