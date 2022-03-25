AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "M60E4"
SWEP.Category 			= "TRP - LMG's"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_m60.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_m60.mdl")

SWEP.Bodygroups 		= {
	upgrades = 1
}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "smg"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= -1

SWEP.AmmoType 			= "ammo_lmg"
SWEP.Durability 		= {10000, 12000}
SWEP.JamTypes 			= {
	RateSlow = 60 / 450,
	Sear = 30
}

SWEP.ClipSize 			= 100
SWEP.Delay 				= 60 / 650

SWEP.Damage 			= 24

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 1

SWEP.FireSound 			= "Weapon_M249.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(-1, -2, -1),
		Ang = Angle(10, 20, 0)
	},
	Sprint = {
		Pos = Vector(0, -1, 0),
		Ang = Angle(10, 20, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 1),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 20 then
		return true -- Fucked
	end
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Weapon_M249.Draw")
	end
end
