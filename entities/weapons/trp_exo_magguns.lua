AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Exoskeleton: Dual Mag Canons"

SWEP.Category 				= "TRP Exo Weapons"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_exo_dualmag.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_exo_dualmag.mdl")

SWEP.UseHands 				= true

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.ClipSize 				= 100
SWEP.AmmoItem 				= "ammo_shotgun"

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {
		Automatic = true,
		Name = "Autocannon",
		Delay = 0.19,
		Projectile = "cc_autocannon_mini",
		Sound = "tekka/weapons/weapon_gut.wav"
	}}
}

SWEP.Recoil 				= 0.5
SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 20

	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 7 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 6
	SWEP.RTScopeReticle 			= true
	SWEP.RTScopeReticle 			= surface.GetTextureID("models/tnb/trpweapons/reticule_square")	
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot_left1", "shoot_right1"}
}

SWEP.HoldType 			= "duel"
SWEP.HoldTypeLowered 	= "slam"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -9, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-3.2, -15, -3)
}

SWEP.LoweredOffset = {
	ang = Vector(-5, 0, 0),
	pos = Vector(0, -9, 0)
}

