AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Tavor TAR-21"
SWEP.Category 			= "TRP - Rifles"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_tar.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_tar.mdl")

SWEP.Bodygroups 		= {
	upgrades = 1
}
SWEP.SubMaterials 		= {
	["models/tnb/weapons/m16/m16_silencer"] = "null",
	["models/tnb/weapons/mp7/mp7_lens_red"] = "null"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {-1, 0}

SWEP.AmmoType 			= "ammo_rifle"
SWEP.Durability 		= {6000, 8000}
SWEP.JamTypes 			= {
	Rate = 60 / 600,
	Sear = 20,
	Malfunction = 150
}

SWEP.ClipSize 			= 30
SWEP.Delay 				= 60 / 800

SWEP.Damage 			= 22

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.7

SWEP.FireSound 			= "Terminator_Sharp.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -6, 1),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 1, 1),
		Ang = Angle(15, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 1.5),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AnimReplacements = {
	[ACT_VM_PRIMARYATTACK] = "shoot1"
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 20 then
		return true
	end
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Weapon_M4A4.Draw")
	end
end
