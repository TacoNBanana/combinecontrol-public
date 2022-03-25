AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom 80-Watt Plasma Rifle"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_80watt.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_80watt.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "lance"
SWEP.LaserColor 			= COLOR_PINK
SWEP.DoDissolve 			= true

SWEP.ClipSize 				= 5
SWEP.Damage 				= 300
SWEP.FireDelay 				= 1.1

SWEP.AmmoItem 				= "ammo_plasma_heavy"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0
SWEP.HipCone 				= 0.05

SWEP.FireSound 				= soundscript.AddFire("TRP_RIFLE4", "tekka/weapons/plasma_rifle4.wav", 140)

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 3
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -7, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.53, -12.639, 1.397)
}

SWEP.LoweredOffset = {
	ang = Vector(-14.764, 45, 0),
	pos = Vector(14.42, -3.013, -1.146)
}
