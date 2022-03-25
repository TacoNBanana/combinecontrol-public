AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Sten Gun"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_sten.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_sten.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 30
SWEP.Damage 				= 15
SWEP.FireDelay 				= 0.08

SWEP.AmmoItem 				= "ammo_pistol"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.2



SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.04

SWEP.FireSound 				= soundscript.AddFire("WEAPON_HOLLOW", "tekka/weapons/weapon_hollow.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}


SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -7, 2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.42, -7, 4.25)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
