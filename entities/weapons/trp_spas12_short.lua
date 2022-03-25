AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SPAS-12 Shorty"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_spas12.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_spas12.mdl")

SWEP.UseHands 				= true
SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}
SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 8
SWEP.Damage 				= 15
SWEP.BulletCount 			= 12
SWEP.FireDelay 				= 0.45

SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.ShotgunReload 			= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 2


SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.01

SWEP.UseClumpSpread 		= true
SWEP.ClumpSpread 			= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SHOTGUN2", "tekka/weapons/weapon_shotgun2.wav", 140)

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
	pos = Vector(-3, -10, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.9, -12, 1.3)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
