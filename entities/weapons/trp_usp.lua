AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "HK USP"
SWEP.Category 			= "TRP - Pistols"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/tfa_ins2/c_usp_match.mdl")
SWEP.WorldModel 		= Model("models/weapons/tfa_ins2/w_usp_match.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	["models/weapons/tfa_ins2/usp_match/usp_weapon"] = "models/weapons/tfa_ins2/usp_match/skins/chrome/usp_weapon",
}

SWEP.ActiveHoldType 	= "pistol"
SWEP.PassiveHoldType 	= "normal"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {1000, 1500}
SWEP.JamTypes 			= {
	Misfire = 6,
	Malfunction = 60
}

SWEP.ClipSize 			= 12
SWEP.Delay 				= 60 / 600

SWEP.Damage 			= 16

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(35)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(25)}

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1.2

SWEP.FireSound 			= "TFA_INS2.USP_M.1"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(3, -2.5, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -2, 2),
		Ang = Angle(22, 0, 0)
	},
	Sprint = {
		Pos = Vector(2, -5, -12),
		Ang = Angle(-45, 0, 0)
	},
	Aim = {
		Pos = Vector(1, -0.5, 0.3),
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
	ACT_VM_RELOAD, ACT_VM_IDLE, ACT_VM_PRIMARYATTACK
})

SWEP.FixWorldModel 		= {
	ang = Angle(-1, -5, 178),
	pos = Vector(5, 1.3, -1.5),
	scale = 1
}
