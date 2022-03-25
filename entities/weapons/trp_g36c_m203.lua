AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "HK G36C M203"
SWEP.Category 			= "TRP - Rifles"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_g36c.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_g36c.mdl")

SWEP.Bodygroups 		= {
	upgrades = 2
}
SWEP.SubMaterials 		= {
	["models/tnb/weapons/acog"] = "null",
	["models/tnb/weapons/glock/dot_red"] = "null"
}

SWEP.ActiveHoldType 	= "ar2"
SWEP.PassiveHoldType 	= "passive"

SWEP.Firemodes 			= {-1, 0}

SWEP.AmmoType 			= "ammo_rifle"
SWEP.Durability 		= {6000, 8000}
SWEP.JamTypes 			= {
	Rate = 60 / 500,
	Sear = 30,
	Malfunction = 150
}

SWEP.ClipSize 			= 30
SWEP.Delay 				= 60 / 750

SWEP.Damage 			= 22

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(45)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(35)}

SWEP.AimTime 			= 0.4
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.8

SWEP.FireSound 			= "Terminator_USP.Fire"

SWEP.AltWeapon 			= "M203"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(0, 0, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -8, 0),
		Ang = Angle(10, 40, 0)
	},
	Sprint = {
		Pos = Vector(0, 0, 1),
		Ang = Angle(15, 15, 0)
	},
	Aim = {
		Pos = Vector(0, 1, 2),
		Ang = Angle(0, 0, 0)
	}
}

SWEP.AltOffsets = setmetatable({
	Default = {
		Pos = Vector(-2, 1, -2),
		Ang = Angle(-8, 0, 10)
	},
	Aim = {
		Pos = Vector(-2, 2, -1),
		Ang = Angle(-8, 0, 10)
	}
}, {__index = SWEP.BaseOffsets})

function SWEP:FireAnimationEvent(_, _, event)
	if self:GetAltMode() then
		return true
	end

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
