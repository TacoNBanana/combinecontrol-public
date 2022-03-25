AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Tokarev TT"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_tokarev.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_tokarev.mdl")

SWEP.UseHands 				= true

SWEP.ClipSize 				= 8
SWEP.FireDelay 				= 0.12

SWEP.AmmoCaliber 			= "7.62x25mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLSMALL", "tekka/weapons/weapon_pistolsmall.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 1.2

SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.06

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"


SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -8, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.649, -7, 2.62)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
