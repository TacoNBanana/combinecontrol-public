AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom 70-Watt Plasma Canon"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_70watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_70watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 1
SWEP.Damage 				= 200
SWEP.FireDelay 				= 1.5

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.03
SWEP.BulletCount 			= 6

SWEP.AmmoItem 				= "ammo_plasma_heavy"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 4

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMACLANK", "tekka/weapons/plasma_clank.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "shotgun"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.599, -9, -0.699)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
