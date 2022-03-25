AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Baby Browning"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_browning.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_browning.mdl")

SWEP.UseHands 				= true

SWEP.ClipSize 				= 6
SWEP.FireDelay 				= 0.14

SWEP.AmmoCaliber 			= ".38"

SWEP.FireSound 				= soundscript.AddFire("357_FIRE2", "weapons/357/357_fire2.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.05
SWEP.HipCone 				= 0.08

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2", "fire3"}
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.73, -5, 3.3)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
