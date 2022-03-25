AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "KSVK"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_ksvk.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_ksvk.mdl")

SWEP.VMBodyGroups 			= {0}
SWEP.WMBodyGroups 			= {0}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 5
SWEP.Damage 				= 400
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_at"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 2

SWEP.AimCone 				= 0
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("WEAPON_SLUG", "tekka/weapons/weapon_slug.wav", 140)

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 1
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
	pos = Vector(-1, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.9, -4, 0.601)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
