AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "M98b Thermal"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_m98.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_m98.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 5
SWEP.Damage 				= 200
SWEP.FireDelay 				= 0.8

SWEP.AmmoItem 				= "ammo_sniper"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1.2



SWEP.AimCone 				= 0.0001
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("WEAPON_BLAT", "tekka/weapons/weapon_blat.wav", 140)

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 2
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -3, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.599, -9, 1)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
