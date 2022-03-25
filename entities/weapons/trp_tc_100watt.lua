AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom 100-Watt Heavy Plasma Canon" 

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_100watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_100watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_BLUE
SWEP.DoDissolve 			= true

SWEP.ClipSize 				= 10
SWEP.Damage 				= 80
SWEP.FireDelay 				= 1

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.04
SWEP.BulletCount 			= 9

SWEP.AmmoItem 				= "ammo_plasma_heavy"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("BOSS", "tekka/weapons/plasma_boss.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "shotgun"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -5, -7)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -8, -6)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
