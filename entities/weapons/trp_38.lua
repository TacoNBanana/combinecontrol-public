AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= ".38 Snubnose"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_38.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_38.mdl")

SWEP.UseHands 				= true

SWEP.ClipSize 				= 5
SWEP.FireDelay 				= 0.4

SWEP.AmmoCaliber 			= ".38"

SWEP.FireSound 				= soundscript.AddFire("BULLET_38", "weapons/357/357_fire2.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.04
SWEP.HipCone 				= 0.07

SWEP.Animations = {
	reload = "reload",
	fire = "fire"
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-4.5, -6, 0.75)
}

SWEP.LoweredOffset = {
	ang = Vector(-25, 0, 0),
	pos = Vector(0, 0, 3)
}
