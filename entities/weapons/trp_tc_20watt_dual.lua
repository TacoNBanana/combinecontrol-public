AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom 20-Watt Dual" 

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_20watt_dual.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_20watt_dual.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser"
SWEP.LaserColor 			= COLOR_PINK

SWEP.ClipSize 				= 100
SWEP.Damage 				= 20
SWEP.FireDelay 				= 0.05

SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5


SWEP.AimCone 				= 0.04
SWEP.HipCone 				= 0.06

SWEP.LoopSounds = {
	loop = "tekka/weapons/plasma_longburst_loop.wav",
	stop = "tekka/weapons/plasma_single3.wav"
}

SWEP.AllowThermals 			= false

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 4 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 2
	SWEP.RTScopeReticle 			= surface.GetTextureID("models/tnb/trpweapons/aim_red_trans")
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot_left2", "shoot_right2"}
}

SWEP.HoldType 			= "duel"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -3, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.5, -15, 1)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
