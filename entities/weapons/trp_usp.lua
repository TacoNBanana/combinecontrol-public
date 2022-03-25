AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "USP Compact"

SWEP.Category 				= "ZRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_usp.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_usp.mdl")

SWEP.UseHands 				= true

SWEP.ClipSize 				= 12
SWEP.FireDelay 				= 0.12

SWEP.AmmoCaliber 			= ".45"

SWEP.FireSound 				= soundscript.AddFire("WEAPON_1911", "tekka/weapons/weapon_1911.wav", 140)

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = "firemode_semi"}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.05

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2", "fire3"}
}

SWEP.HoldType 			= "revolver"
SWEP.HoldTypeLowered 	= "normal"

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -8, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.34, -8, 2.6)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
