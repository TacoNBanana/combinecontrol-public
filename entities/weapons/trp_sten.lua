AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Sten Gun"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_sten.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_sten.mdl")

SWEP.UseHands 				= true


SWEP.ClipSize 				= 30
SWEP.FireDelay 				= 0.13

SWEP.AmmoCaliber 			= "9x19mm"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_PISTOLCRACK", "tekka/weapons/weapon_pistolcrack.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_auto"},
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 1.2

SWEP.AimCone 				= 0.02
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
	ang = Vector(0, 0, 0),
	pos = Vector(-6.429, -7, 4.27)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
