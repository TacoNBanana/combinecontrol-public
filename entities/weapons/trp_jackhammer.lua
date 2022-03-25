AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Jackhammer"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_jackhammer.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_jackhammer.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 12
SWEP.Damage 				= 15
SWEP.BulletCount 			= 12
SWEP.FireDelay 				= 0.25

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.FireSound 				= soundscript.AddFire("WEAPON_WESTERN", "tekka/weapons/weapon_western.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -5, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.25, -3, -0.4)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
