AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet 95-Watt Plasma Canon"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_90watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_skynet_90watt.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 100
SWEP.Damage 				= 100
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_plasma"
SWEP.DoDissolve 			= true

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("TRP_RIFLE3", "tekka/weapons/plasma_rifle3.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(0, 100, 255, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.HoldType 			= "duel"
SWEP.HoldTypeLowered 	= "slam"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, 5, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-3, 1, 2)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}


SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t800.mdl"] = {1, 0},
	["models/tnb/skynet/t700.mdl"] = {1, 0},
	["models/tnb/skynet/t700_repro.mdl"] = {1, 0},
	["models/tnb/skynet/t600.mdl"] = {2, 0},
	["models/tnb/skynet/t600_skinjob.mdl"] = {3, 0},
	["models/tnb/skynet/t600_repro.mdl"] = {2, 0}
}