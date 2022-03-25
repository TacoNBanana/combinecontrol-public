AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Jury-Rigged SCAR"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.MuzzleEffect 			= "CS_MuzzleFlash_X"

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_scar.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_scar.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "HelicopterTracer"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.ClipSize 				= 60
SWEP.Damage 				= 60
SWEP.FireDelay 				= 0.09

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}


SWEP.Recoil 				= 0.3

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA7", "tekka/weapons/plasma_single7.wav", 140)


SWEP.Animations = {
	reload = "foregrip_reload_empty",
	fire = {"foregrip_iron_fire", "foregrip_iron_fire2"}
}

SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(1.9, 2, -3)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.849, -2, -2.4)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
