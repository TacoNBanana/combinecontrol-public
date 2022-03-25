AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Plasma Lance"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_75watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_75watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "lance"
--SWEP.LaserColor 			= COLOR_RED

SWEP.ClipSize 				= 200
SWEP.Damage 				= 110
SWEP.FireDelay 				= 0.06

SWEP.DoDissolve 			= true
SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5
SWEP.AimCone 				= 0.005
SWEP.HipCone 				= 0.04

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(0, 110, 0, 255)
	SWEP.AimpointSize 			= 10
end

SWEP.LoopSounds = {
    loop = "ambient/levels/citadel/zapper_loop2.wav",
    stop = "ambient/levels/citadel/zapper_warmup1.wav"
}

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
