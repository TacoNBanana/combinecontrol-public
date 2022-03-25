AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Winchester 1886"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_winchester.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_winchester.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 8
SWEP.Damage 				= 80
SWEP.BulletCount 			= 1
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_sniper"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.PumpAction 			= true
SWEP.ShotgunReload 			= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 2

SWEP.RecoilAxisMod = {
	side = 1,
	forward = 5,
	up = 0,
	pitch = 0,
	roll = 1
}

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

--SWEP.UseClumpSpread 		= true
--SWEP.ClumpSpread 			= 0.04

SWEP.FireSound 				= soundscript.AddFire("WEAPON_WESTERN", "tekka/weapons/weapon_western.wav", 140)

SWEP.Animations = {
	fire = {"shoot1", "shoot2"},
	reload = "start_reload",
	reloadfinish = "after_reload",
	reloadinsert = "insert"
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -8, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.699, -12, 3.701)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
