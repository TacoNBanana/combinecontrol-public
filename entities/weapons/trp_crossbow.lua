AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Crossbow"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_crossbow.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_crossbow.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.ClipSize 				= 1
SWEP.FireDelay 				= -1

SWEP.AmmoCaliber 			= "crossbow"

SWEP.FireSound 				= soundscript.AddFire("FIRE1", "weapons/crossbow/fire1.wav", 70)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 0

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.002

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.SoundScripts = {
	reload = {
		{time = 0.1, snd = "weapons/crossbow/reload1.wav"}
	}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

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
