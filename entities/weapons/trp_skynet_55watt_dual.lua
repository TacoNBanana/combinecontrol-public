AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SkyNet 55-Watt Dual" --needs material over the little panel for aim

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_55watt_dual.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_skynet_55watt_dual.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 80
SWEP.Damage 				= 50
SWEP.FireDelay 				= 0.07

SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {}}
}

SWEP.Recoil 				= 0.5


SWEP.AimCone 				= 0.03
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA7", "tekka/weapons/plasma_single7.wav", 140)



SWEP.Animations = {
	reload = "reload",
	fire = {"shoot_left2", "shoot_right2"}
}

SWEP.HoldType 			= "duel"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -5, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -15, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
