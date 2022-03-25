AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "PPSH"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_ppsh.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_ppsh.mdl")

SWEP.UseHands 				= true


SWEP.ClipSize 				= 50
SWEP.FireDelay 				= 0.1

SWEP.AmmoCaliber 			= "7.62x25mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLSMALL", "tekka/weapons/weapon_pistolsmall.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_auto"},
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 1.2

SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.05

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -6, 1)
}

SWEP.AimOffset = {
	ang = Vector(0.401, 0, 0),
	pos = Vector(-6.36, -4, 4.301)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
