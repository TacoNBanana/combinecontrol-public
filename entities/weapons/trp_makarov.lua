AddCSLuaFile()
DEFINE_BASECLASS("base_trp")

SWEP.Base 				= "base_trp"

SWEP.PrintName 			= "Marakov PM"
SWEP.Category 			= "TRP - Pistols"

SWEP.AdminOnly 			= true
SWEP.Spawnable 			= true

SWEP.ViewModel 			= Model("models/tnb/weapons/c_makarov.mdl")
SWEP.WorldModel 		= Model("models/tnb/weapons/w_makarov.mdl")

SWEP.Bodygroups 		= {}
SWEP.SubMaterials 		= {}

SWEP.ActiveHoldType 	= "pistol"
SWEP.PassiveHoldType 	= "normal"

SWEP.Firemodes 			= 0

SWEP.AmmoType 			= "ammo_pistol"
SWEP.Durability 		= {1000, 1500}
SWEP.JamTypes 			= {
	Misfire = 4,
	Malfunction = 40
}

SWEP.ClipSize 			= 8
SWEP.Delay 				= 60 / 600

SWEP.Damage 			= 11

SWEP.CrouchingAccuracy 	= {util.RangeMeters(10), util.RangeMeters(35)}
SWEP.StandingAccuracy 	= {util.RangeMeters(5), util.RangeMeters(25)}

SWEP.AimTime 			= 0.3
SWEP.ZoomLevel 			= 1.5

SWEP.Scoped 			= false
SWEP.ForcedUnscope 		= false

SWEP.RecoilKick 		= 0.7

SWEP.FireSound 			= "Weapon_P2000.Fire"

SWEP.BaseOffsets = {
	Default = {
		Pos = Vector(3, -2.5, -1),
		Ang = Angle(0, 0, 0)
	},
	Holster = {
		Pos = Vector(0, -2, 6),
		Ang = Angle(22, 0, 0)
	},
	Sprint = {
		Pos = Vector(2, -5, -18),
		Ang = Angle(-45, 0, 0)
	},
	Aim = {
		Pos = Vector(1, 1, 3),
		Ang = Angle(0, 0, 0)
	}
}

function SWEP:FireAnimationEvent(_, _, event)
	if event == 6001 then
		return true
	end
end

function SWEP:StartReload()
	BaseClass.StartReload(self)

	if CLIENT then
		self:EmitSound("Weapon_Pistol.NPC_Reload")
	end
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if CLIENT then
		self:EmitSound("Weapon_P2000.Draw")
	end
end
