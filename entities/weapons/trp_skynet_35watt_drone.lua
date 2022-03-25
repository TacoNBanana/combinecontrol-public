AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet 35-Watt Plasma Carbine (One Handed)"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_35watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_skynet_35watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_PURPLE

SWEP.ClipSize 				= 20
SWEP.Damage 				= 40
SWEP.FireDelay 				= 0.13

SWEP.AmmoItem 				= false

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.6
SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.05

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA11", "tekka/weapons/plasma_single11.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 0
end

SWEP.HoldType 			= "duel"
SWEP.HoldTypeLowered 	= "slam"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.3, -10, 0)
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