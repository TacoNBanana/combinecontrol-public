AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "HK417"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_hk416.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_hk416.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.ClipSize 				= 30
SWEP.FireDelay 				= 0.11

SWEP.AmmoCaliber 			= "7.62x51mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_HK416", "tekka/weapons/weapon_hk416.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"},
	{Mode = "firemode_auto"}
}

SWEP.Recoil 				= 1.5

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.04

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.51, -6, 1.15)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
