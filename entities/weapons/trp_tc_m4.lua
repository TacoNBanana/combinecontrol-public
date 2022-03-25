AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Jury-Rigged M4"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_m4.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_m4.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "HelicopterTracer"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.ClipSize 				= 60
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.08

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}



SWEP.Recoil 				= 0.3

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA7", "tekka/weapons/plasma_single7.wav", 140)


SWEP.Animations = {
	reload = "reload",
	fire = {"fire01"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -9, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.159, -12, 1.01)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
