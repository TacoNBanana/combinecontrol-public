AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet 75-Watt Plasma-Caster"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_75watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_skynet_75watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_ORANGE

SWEP.ClipSize 				= 100
SWEP.Damage 				= 70
SWEP.FireDelay 				= 0.14

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.04
SWEP.BulletCount 			= 3

SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 1


SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.04

SWEP.FireSound 				= soundscript.AddFire("TRP_SINGLE7", "tekka/weapons/plasma_single7.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 7 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 4
	SWEP.RTScopeReticle 			= true
end

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -6, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.3, -9, 1)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
