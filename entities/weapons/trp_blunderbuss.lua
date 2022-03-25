AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Anti-Robot Blunderbuss Scrap-Canon"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_blunderbuss.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_blunderbuss.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.Tracer 				= "AirboatGunTracer"

SWEP.ClipSize 				= 1
SWEP.Damage 				= 50
SWEP.BulletCount 			= 30
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.PumpAction 			= false
SWEP.ShotgunReload 			= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_LASER_HEAVY", "tekka/weapons/weapon_laser_heavy.wav", 140)

SWEP.Animations = {
	fire = "fire",
	reload = "reload",
}

SWEP.HoldType 			= "shotgun"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -12, 0)
}

SWEP.AimOffset = {
	ang = Vector(-5, 0, 0),
	pos = Vector(-8.1, -12, 3.201)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
