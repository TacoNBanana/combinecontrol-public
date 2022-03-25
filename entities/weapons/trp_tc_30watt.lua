AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom 30-Watt Lite Plasma Rifle"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_30watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_30watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_PURPLE

SWEP.ClipSize 				= 60
SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.08

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_BURST3, Vars = {}}
}


SWEP.Recoil 				= 0.3
SWEP.VMRecoilMod 			= 3


SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.035

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA3", "tekka/weapons/plasma_single3.wav", 140)

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 10 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeSCKIndex 			= "scope"

	SWEP.VElements = {
		["scope"] = {Type = SCK_MODEL, mdl = "models/XQM/panel360.mdl", Bone = "v_weapon.aug_Parent", Pos = Vector(-1.18, -6.6, 2), Ang = Angle(-90, -90, 0), Size = Vector(0.02, 0.02, 0.02)},
	}

	SWEP.WElements = {}
	SWEP.VMBoneMods = {}
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-4.86, -14, 2.106)
}

SWEP.LoweredOffset = {
	ang = Vector(-14.764, 45, 0),
	pos = Vector(14.42, -3.013, -1.146)
}
