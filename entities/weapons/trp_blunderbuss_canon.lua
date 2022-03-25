AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Anti-Robot Pirate Blunderbuss Mk.73"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_blunderbuss.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_blunderbuss.mdl")

SWEP.UseHands 				= true

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.AllowThermals 			= true


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
