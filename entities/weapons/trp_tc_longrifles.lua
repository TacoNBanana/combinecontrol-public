AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Longrifles Hawkeye 50-Watt"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_longrifles.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_longrifles.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam"
SWEP.LaserColor 			= COLOR_PINK

SWEP.ClipSize 				= 30
SWEP.Damage 				= 60
SWEP.FireDelay 				= 0.15

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_BURST3, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 0.8

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 7 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 2
	SWEP.RTScopeReticle 			= surface.GetTextureID("models/tnb/trpweapons/reticule_square")	
end

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.FireSound 				= soundscript.AddFire("TRP_POW", "tekka/weapons/plasma_pow.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -10, 1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.3, -18, 2.181)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
