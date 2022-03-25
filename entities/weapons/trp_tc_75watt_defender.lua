AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom 75-Watt Defender"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_75watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_75watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 100
SWEP.Damage 				= 90
SWEP.FireDelay 				= 0.13

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_BURST3, Vars = {}}
}

SWEP.Recoil 				= 0.5


SWEP.AimCone 				= 0.005
SWEP.HipCone 				= 0.04

SWEP.FireSound 				= soundscript.AddFire("PLASMSNIPER", "tekka/weapons/plasma_sniper.wav", 140)


SWEP.HoldType 			= "crossbow"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -9, 1.5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.829, -12, 1.201)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
