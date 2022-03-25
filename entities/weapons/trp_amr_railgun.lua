AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "AMR99 Prototype Railgun"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_amr.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_amr.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "lance"

SWEP.ClipSize 				= 1
SWEP.Damage 				= 500
SWEP.FireDelay 				= -1

SWEP.AmmoItem 				= "ammo_plasma_heavy"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.VMBodyGroups 			= {2}
SWEP.WMBodyGroups 			= {2}

SWEP.Firemodes 				= {
	{Mode = FIREMODE_SEMI, Vars = {}}
}


SWEP.Recoil 				= 1

SWEP.AimCone 				= 0
SWEP.HipCone 				= 0.02

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 6 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 2
	SWEP.RTScopeReticle 			= surface.GetTextureID("models/tnb/weapons/elysium_lens")
end

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 255, 255, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "ar2"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}
SWEP.FireSound 				= soundscript.AddFire("WEAPON_PLASMAPISTOL", "tekka/weapons/plasma_pistol.wav", 140)

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-2, -11, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-3, -4, 1.351)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 10, 0),
	pos = Vector(-3, -11, -3)
}
