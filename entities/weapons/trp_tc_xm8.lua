AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Jury-Rigged XM8"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_xm8.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_xm8.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.ClipSize 				= 100
SWEP.Damage 				= 60
SWEP.FireDelay 				= 0.09

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 6 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 5
	SWEP.RTScopeReticle 			= surface.GetTextureID("models/tnb/trpweapons/reticule_square")
end

SWEP.Recoil 				= 0.3

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TRP_PLASMA5", "tekka/weapons/plasma_single5.wav", 140)

SWEP.Animations = {
	reload = "base_reload_empty",
	fire = {"base_fire", "iron_fire"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -2, -0.5)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.769, -4, -0.4)
}

SWEP.LoweredOffset = {
	ang = Vector(-12, 0, 0),
	pos = Vector(0.5, 0, -1)
}
