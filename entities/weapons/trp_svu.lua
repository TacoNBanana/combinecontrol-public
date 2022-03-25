AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "SVU"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_svu.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_svu.mdl")
SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}
SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 10
SWEP.Damage 				= 150
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_sniper"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1



SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SNAP", "tekka/weapons/weapon_silencedsnap.wav", 80)

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 2
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
	pos = Vector(-2, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-6.3, -3, 1.15)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
