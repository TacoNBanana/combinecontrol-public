AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Jury Rigged 1887"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_winchester.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_winchester.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.Tracer 				= "AirboatGunTracer"

SWEP.ClipSize 				= 10
SWEP.Damage 				= 40
SWEP.BulletCount 			= 12
SWEP.FireDelay 				= 1.2

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.PumpAction 			= true
SWEP.ShotgunReload 			= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.FireSound 				= soundscript.AddFire("PLASMA_SNIPER", "tekka/weapons/plasma_sniper.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}


SWEP.HoldType 			= "shotgun"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -10, 2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.449, -14, 2.84)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
