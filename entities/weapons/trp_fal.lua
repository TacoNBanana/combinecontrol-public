AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "FN FAL"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_fal.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_fal.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 20
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.12

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1



SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("WEAPON_M14", "tekka/weapons/weapon_m14.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

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
