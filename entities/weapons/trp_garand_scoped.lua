AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M1D Garand"
SWEP.Category 			= "TRP - Snipers"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/weapons/tfa_doi/v_m1garand_scoped.mdl")
SWEP.WorldModel 		= Model("models/weapons/tfa_doi/w_m1garand_scoped.mdl")

SWEP.UseHandsFix 		= true

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {
	[2] = "models/weapons/v_models/snip_awp/v_awp_scope"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_rifle"
SWEP.Durability 		= {1500, 2000}

SWEP.ClipSize 			= 8
SWEP.Delay 				= 60 / 500
SWEP.JamTypes 			= {
	Rate = 60 / 100,
	Misfire = 4
}

SWEP.Damage 			= 24

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(100)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(75)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 4

SWEP.Scoped 			= true
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1.2

SWEP.FireSound 			= "Weapon_Garand.1"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -4, 2),
		Ang = Angle(20, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 1),
		Ang = Angle(20, 5, 0)
	},
	Aim = {
		Pos = Vector(0, 1.37, 1.02),
		Ang = Angle(0.5, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_IDLE] = "base_idle",
	[ACT_VM_IDLE_EMPTY] = "empty_idle",
	[ACT_VM_RELOAD] = "base_reloadfull",
	[ACT_VM_RELOAD_EMPTY] = "base_reloadempty"
}

SWEP.AnimEmptySupport = table.MakeAssociative({
	ACT_VM_IDLE, ACT_VM_PRIMARYATTACK, ACT_VM_RELOAD
})

SWEP.FixWorldModel 		= {
	ang = Angle(-1, -10, 178),
	pos = Vector(15, 1.2, -3.5),
	scale = 1
}
