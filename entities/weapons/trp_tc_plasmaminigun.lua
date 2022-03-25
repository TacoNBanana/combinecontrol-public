AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Plasma Minigun"

SWEP.Category 				= "TRP"

SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true
SWEP.Plasma 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_minigun.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_minigun.mdl")
SWEP.UseHands 				= true

SWEP.Damage 				= 10
SWEP.FireDelay 				= 0.06
SWEP.BulletCount 			= 3
SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06
SWEP.ClipSize 				= 400

SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.4

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 14
end

SWEP.LoopSounds = {
    loop = "tekka/weapons/plasma_longburst_loop.wav",
    stop = "tekka/weapons/plasma_single3.wav"
}

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -4, 3)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-4, -12, 4)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(0, 0, 0)
}
