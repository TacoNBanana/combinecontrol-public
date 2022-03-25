AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M110 SASS"
SWEP.Category 			= "TRP - Snipers"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_m16.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_m16.mdl")

SWEP.Bodygroups 		= {
	upgrades = 4
}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "sniper"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_sniper"
SWEP.Durability 		= {1500, 2000}

SWEP.ClipSize 			= 20
SWEP.Delay 				= 60 / 550
SWEP.JamTypes 			= {
	Rate = 60 / 100,
	Misfire = 4,
	Malfunction = 40
}

SWEP.Damage 			= 28

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(200)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(150)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= {4, 10, 2}

SWEP.Scoped 			= true
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 3.5

SWEP.FireSound 			= "Terminator_SBR.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, 0),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -8, -1),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 2, 3),
		Ang = Angle(20, 5, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 1),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Weapon_M4A4.Draw")
	end
end
