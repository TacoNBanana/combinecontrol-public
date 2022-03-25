AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "S&W Model 629"
SWEP.Category 			= "TRP - Pistols"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_magnum.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_magnum.mdl")

SWEP.Bodygroups 		= {
	upgrades = 1
}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "revolver"
SWEP.PassiveHoldType 	= "normal"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {1000, 2000}
SWEP.JamTypes 			= {
	Misfire = 2
}

SWEP.ClipSize 			= 6
SWEP.Delay 				= 60 / 80

SWEP.Damage 			= 22

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(35)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(25)}

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 2

SWEP.FireSound 			= "Weapon_Revolver.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, -1, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, 0, 2),
		Ang = Angle(20, 0, 0)
	},
	Sprint = {
		Pos = Vector(0, 1, 3),
		Ang = Angle(20, -10, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 1),
		Ang = Angle(0, 0, -1)
	}
}

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Weapon_Revolver.Draw")
	end
end
