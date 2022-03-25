AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "M1911A1"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_1911.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_1911.mdl")

SWEP.UseHands 				= true

SWEP.ClipSize 				= 8
SWEP.FireDelay 				= 0.12

SWEP.AmmoCaliber 			= ".45"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_1911", "tekka/weapons/weapon_1911.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.06

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2", "shoot3"}
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 1.3, 0),
	pos = Vector(-6.199, -9, 2.701)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
