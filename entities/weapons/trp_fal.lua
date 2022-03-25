AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "FN FAL"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_fal.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_fal.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.ClipSize 				= 20
SWEP.FireDelay 				= 0.14

SWEP.AmmoCaliber 			= "7.62x51mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_GUT", "tekka/weapons/weapon_gut.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 3

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.02

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -4, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.369, -6, 2.6)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
