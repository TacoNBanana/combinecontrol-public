AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet 45-Watt Phased Plasma Rifle"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_45watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_skynet_45watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 30
SWEP.Damage 				= 40
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_MASTERKEY, Vars = {}},
	{Mode = FIREMODE_MASTERKEY, Vars = {Name = "Underslung Slugs", Damage = 100, Count = 1, Spread = 0}}
}

SWEP.Recoil 				= 0.8

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 7 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 0
end

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA7", "tekka/weapons/plasma_single7.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.349, -12, 1.65)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
