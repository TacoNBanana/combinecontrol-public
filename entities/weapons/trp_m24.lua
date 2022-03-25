AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Remington M24A2"
SWEP.Category 			= "TRP - Snipers"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_m24.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_m24.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "sniper"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_sniper"
SWEP.Durability 		= {750, 1000}
SWEP.JamTypes 			= {
	Misfire = 4,
	Malfunction = 10
}

SWEP.ClipSize 			= 5
SWEP.Delay 				= -1

SWEP.Damage 			= 30

SWEP.CrouchingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(400)}
SWEP.StandingAccuracy 	= {util.RangeMeters(2), util.RangeMeters(100)}

SWEP.AimTime 			= 0.5
SWEP.ZoomLevel 			= {6, 12, 4}

SWEP.Scoped 			= true
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 4

SWEP.FireSound 			= "Terminator_M24.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -2),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -8, 0),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 1),
		Ang = Angle(15, 5, 0)
	},
	Aim = {
		Pos = Vector(0, 0, 2),
		Ang = Angle(-1, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 5001 then
		return true -- Fucked
	end
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Weapon_SSG08.Draw")
	end
end
