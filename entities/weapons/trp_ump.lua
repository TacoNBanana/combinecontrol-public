AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "HK UMP45"
SWEP.Category 			= "TRP - SMG's"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_ump.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_ump.mdl")

SWEP.Bodygroups 		= {
	upgrades = 1
}
SWEP.SubMaterials 		= {
	["models/tnb/weapons/frontgrip"] = "null",
	["models/tnb/weapons/glock/dot_red"] = "null"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {-1, 2, 0}

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {6000, 8000}
SWEP.JamTypes 			= {
	Rate = 60 / 300,
	Sear = 50,
	Malfunction = 125
}

SWEP.ClipSize 			= 25
SWEP.Delay 				= 60 / 500

SWEP.Damage 			= 18

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1.2

SWEP.FireSound 			= "Terminator_SilencedSnap.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -6, 2),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 2),
		Ang = Angle(15, 5, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 2),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event != 20 then
		return true
	end
end
