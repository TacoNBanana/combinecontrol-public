AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Browning M2 .50cal"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_m2.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m2.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 100
SWEP.Damage 				= 100
SWEP.FireDelay 				= 0.14

SWEP.AmmoItem 				= "ammo_lmg"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.8

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.03

SWEP.FireSound 				= soundscript.AddFire("WEAPON_GUT", "tekka/weapons/weapon_gut.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, -3),
	pos = Vector(-1, 0, -4)
}

SWEP.AimOffset = {
	ang = Vector(1.201, 0, -2),
	pos = Vector(-5.05, 3, -2)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
