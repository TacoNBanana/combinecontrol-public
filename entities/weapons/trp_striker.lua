AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Striker-12"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_striker.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_striker.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 10
SWEP.Damage 				= 15
SWEP.BulletCount 			= 12
SWEP.FireDelay 				= 0.5

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.07

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.RecoilAxisMod = {
	side = 1,
	forward = 5,
	up = 0,
	pitch = 0,
	roll = 1
}

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SHOTGUN2", "tekka/weapons/weapon_shotgun2.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -4, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.36, -10, 2.401)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
