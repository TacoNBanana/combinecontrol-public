AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Saiga-12"
SWEP.Category 			= "TRP - Shotguns"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_saiga12.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_saiga12.mdl")

SWEP.Bodygroups 		= {
	upgrades = 1
}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "shotgun_smg"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_shotgun"
SWEP.Durability 		= {900, 1100}
SWEP.JamTypes 			= {
	RateSlow = 60 / 100,
	Sear = 5,
	Malfunction = 20
}

SWEP.ClipSize 			= 10
SWEP.Delay 				= 60 / 140

SWEP.BulletCount 		= 8
SWEP.Damage 			= 90

SWEP.CrouchingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(8)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(8)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 3

SWEP.FireSound 			= "Terminator_Shotgun2.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -8, 0),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 2, 2),
		Ang = Angle(15, 10, 0)
	},
	Aim = {
		Pos = Vector(-3, 2, 1.5),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 20 then
		return true
	end
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Weapon_FAMAS.Draw")
	end
end
