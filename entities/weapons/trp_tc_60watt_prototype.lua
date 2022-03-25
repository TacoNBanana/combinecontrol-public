AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom 60-Watt Prototype"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_xm.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_xm.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "HelicopterTracer"
SWEP.LaserColor 			= COLOR_BLUE

SWEP.ClipSize 				= 20
SWEP.Damage 				= 110
SWEP.FireDelay 				= 0.15

SWEP.AmmoItem 				= "ammo_plasma"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_M203, Vars = {}},	
	{Mode = FIREMODE_MASTERKEY, Vars = {}},
	{Mode = FIREMODE_MASTERKEY, Vars = {Name = "Underslung Slugs", Damage = 100, Count = 1, Spread = 0}}
}

SWEP.Recoil 				= 0.2

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.FireSound 				= soundscript.AddFire("WEAPON_LASER_SMG", "tekka/weapons/weapon_laser_smg.wav", 140)

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 6 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 0
	SWEP.RTScopeReticle 			= surface.GetTextureID("models/tnb/trpweapons/reticule_square")
end


SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}



SWEP.HoldType 			= "smg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -4, -1)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.849, -6, -0.2)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
