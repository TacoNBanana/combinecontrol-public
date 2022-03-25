AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "KS-23"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_ks23.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_ks23.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.UseHands 				= true
SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 6
SWEP.Damage 				= 20
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

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.04

SWEP.FireSound 				= soundscript.AddFire("WEAPON_WARHAMMER", "tekka/weapons/weapon_warhammer.wav", 140)

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
	pos = Vector(-3, -5, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.889, -7, 1.25)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
