AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Mac10"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_mac10.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_mac10.mdl")

SWEP.UseHands 				= true

SWEP.ClipSize 				= 30
SWEP.FireDelay 				= 0.07

SWEP.AmmoCaliber 			= ".45"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_1911", "tekka/weapons/weapon_1911.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_auto"}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.04
SWEP.HipCone 				= 0.07

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2", "fire3"}
}

SWEP.HoldType 			= "pistol"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 1, 0),
	pos = Vector(-5.3, -9, 1.5)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
