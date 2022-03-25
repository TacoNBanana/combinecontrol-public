AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet 40-Watt Phased Plasma Rifle"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_40watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_skynet_40watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 40
SWEP.Damage 				= 70
SWEP.FireDelay 				= 0.13

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_BURST3, Vars = {}}
}

SWEP.Recoil 				= 0.8

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.04

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA5", "tekka/weapons/plasma_single5.wav", 140)

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 7 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 1
	SWEP.RTScopeReticle 			= true
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -2, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.3, -9, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
