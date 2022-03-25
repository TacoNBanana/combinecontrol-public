AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "AMR99 SD Thermal"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_amr.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_amr.mdl")

SWEP.VMBodyGroups 			= {1}
SWEP.WMBodyGroups 			= {1}

SWEP.UseHands 				= true

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 1
SWEP.Damage 				= 300
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

SWEP.FireSound 				= soundscript.AddFire("WEAPON_M9SD", "tekka/weapons/weapon_silencedm9.wav", 140)

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 6 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 2
	SWEP.RTScopeReticle 			= surface.GetTextureID("models/tnb/trpweapons/reticule_square")
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
	pos = Vector(-2, -8, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.869, -6, 1.351)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
