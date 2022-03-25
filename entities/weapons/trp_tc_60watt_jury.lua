AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Scav Jury Rigged PRAZMA KANON"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_scrap.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_scrap.mdl")

SWEP.UseHands 				= false

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.ClipSize 				= 400
SWEP.Damage 				= 30
SWEP.FireDelay 				= 0.05

SWEP.AmmoItem 				= "ammo_plasma_lmg"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_BURST3, Vars = {}}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.05
SWEP.HipCone 				= 0.1

SWEP.Animations = {
	reload = "reload",
	fire = {"fire1", "fire2"}
}

SWEP.LoopSounds = {
    loop = "tekka/weapons/plasma_longburst_loop.wav",
    stop = "tekka/weapons/plasma_heavy3.wav"
}

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 5
	SWEP.RTScopeReticle 			= true
end

SWEP.HoldType 			= "physgun"
SWEP.HoldTypeLowered 	= "physgun"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, 3, -2)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-7.599, -2, -2.65)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
