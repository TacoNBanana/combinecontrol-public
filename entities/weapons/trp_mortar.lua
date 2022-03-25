AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Mortar with HE Rounds"

SWEP.Category 				= "TRP"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_mortar.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_mortar.mdl")

SWEP.UseHands 				= true

SWEP.AmmoItem 				= "weapon_grenade_mortar"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {
		High = 1,
		ClipSize = 1,
		Projectile = "cc_mortar",
		NoBlind = true
	}}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.03

SWEP.AllowThermals 			= false

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_mortar")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 5

	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 1
	SWEP.RTScopeReticle 			= true
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "knife"
SWEP.HoldTypeLowered 	= "slam"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(5, -5, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(4, -12, 4)
}

SWEP.LoweredOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(5, -5, 0)
}
