AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "APU - Dual Plasma Canons"

SWEP.Category 				= "TRP Exo Weapons"
SWEP.Plasma 				= true

SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_exo_dualplasma.mdl")
SWEP.WorldModel 			= ""


SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= COLOR_RED
SWEP.DoDissolve 			= true

SWEP.Damage 				= 100
SWEP.FireDelay 				= 0.07


SWEP.UseHands 				= false
SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.1


SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.02

SWEP.LoopSounds = {
    loop = "tekka/weapons/plasma_longburst_loop.wav",
    stop = "tekka/weapons/plasma_heavy3.wav"
}

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8

	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 7 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 7
	SWEP.RTScopeReticle 			= true
end

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 2, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5, -1, -2.65)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 2, -1)
}
