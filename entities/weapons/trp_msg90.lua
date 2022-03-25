AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "MSG90"

SWEP.Category 				= "TRP"
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_g3.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_g3.mdl")

SWEP.UseHands 				= true

SWEP.VMBodyGroups 			= {2}
SWEP.WMBodyGroups 			= {2}

SWEP.Tracer 				= "tracer"

SWEP.ClipSize 				= 10
SWEP.Damage 				= 150
SWEP.FireDelay 				= 0.24

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 1
end

SWEP.AimCone 				= 0.001
SWEP.HipCone 				= 0.01

SWEP.FireSound 				= soundscript.AddFire("WEAPON_BLATSMALL", "tekka/weapons/weapon_blatsmall.wav", 140)




SWEP.Animations = {
	reload = "reload1",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -4, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-5.699, -5, 0.9)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
