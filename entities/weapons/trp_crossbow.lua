AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Crossbow with A-T Darts"

SWEP.Category 				= "TRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_crossbow.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_crossbow.mdl")

SWEP.UseHands 				= true

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.ClipSize 				= 1
SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {
		Automatic = true,
		Name = "Crossbow Dart",
		Delay = -1,
		Projectile = "cc_crossbow",
		Sound = "weapons/crossbow/fire1.wav"
	}}
}

SWEP.Recoil 				= 0

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "shotgun"
SWEP.HoldTypeLowered 	= "passive"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_CROSSBOW", "weapons/crossbow/fire1.wav", 140)

SWEP.SoundScripts = {
	reload = {
		{time = 0.1, snd = "weapons/crossbow/reload1.wav"}
	}
}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -6, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-8.079, -8, 2.75)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

