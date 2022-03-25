AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "AKM with 1p29 Optic"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= false
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/weapons/c_akm_classic.mdl")
SWEP.WorldModel 			= Model("models/tnb/weapons/w_akm_classic.mdl")

SWEP.UseHands 				= true
SWEP.MuzzleEffect 			= "CS_MuzzleFlash_X"
SWEP.Tracer 				= "tracer"

SWEP.VMBodyGroups 			= {2}
SWEP.WMBodyGroups 			= {2}

SWEP.ClipSize 				= 30
SWEP.Damage 				= 40
SWEP.FireDelay 				= 0.1

SWEP.AmmoItem 				= "ammo_rifle"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_SEMI, Vars = {}}
}

SWEP.Recoil 				= 1

SWEP.AimCone 				= 0.02
SWEP.HipCone 				= 0.06

SWEP.FireSound 				= soundscript.AddFire("WEAPON_AKS", "tekka/weapons/weapon_aks.wav", 140)

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 4
end


SWEP.Animations = {
	reload = "base_reload_empty",
	fire = {"base_fire", "iron_fire"}
}

SWEP.HoldType 			= "rpg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-0, 0, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2.829, -1, 0)
}

SWEP.LoweredOffset = {
	ang = Vector(-6, 0, 0),
	pos = Vector(0, 0, 0)
}

