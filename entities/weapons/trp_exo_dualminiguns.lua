AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Exoskeleton: Dual Miniguns"

SWEP.Category 				= "TRP Exo Weapons"

SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_minigun_3_dual.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_minigun_3_dual.mdl")
SWEP.UseHands 				= true

SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.05
SWEP.BulletCount 			= 4
SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.Tracer 				= "tracer"

SWEP.UseHands 				= false

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.4

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 10
	
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 7 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 6
	SWEP.RTScopeReticle 			= true	
end


SWEP.LoopSounds = {
    loop = "tekka/weapons/minigun_loop.wav",
    stop = "tekka/weapons/minigun_winddown.wav"
}

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "duel"
SWEP.HoldTypeLowered 	= "slam"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 2, 2)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}