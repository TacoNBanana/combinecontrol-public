AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Jury-Rigged M249"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_m249.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_m249.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "AirboatGunHeavyTracer"
SWEP.LaserColor 			= COLOR_GREEN

SWEP.ClipSize 				= 120
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.06

SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}



SWEP.Recoil 				= 0.3

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.LoopSounds = {
    loop = "tekka/weapons/plasma_longburst_loop2.wav",
    stop = "tekka/weapons/plasma_single11.wav"
}

SWEP.Animations = {
	reload = "reload",
	fire = {"fire01"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -6, -0.5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.199, -9, 0.051)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
