AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Ithaca 37"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_ithaca.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_ithaca.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 6
SWEP.Damage 				= 15
SWEP.BulletCount 			= 12
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.PumpAction 			= true
SWEP.ShotgunReload 			= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.5

SWEP.RecoilAxisMod = {
	side = 1,
	forward = 5,
	up = 0,
	pitch = 0,
	roll = 1
}

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.04

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SHOTGUN", "tekka/weapons/weapon_shotgun.wav", 140)

SWEP.Animations = {
	fire = {"shoot1", "shoot2"},
	reload = "start_reload",
	reloadfinish = "after_reload",
	reloadinsert = "insert"
}

SWEP.HoldType 			= "shotgun"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-3, 0, -1)
}

SWEP.AimOffset = {
	ang = Vector(1, 0, 0),
	pos = Vector(-7.8, -7, 2.5)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
