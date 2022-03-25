AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-450 Artillery"

SWEP.Category 				= "TRP Skynet"

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_rocketlauncher.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= false

SWEP.Firemodes 				= {
	{Mode = FIREMODE_CANNON, Vars = {}},
	{Mode = FIREMODE_CANNON, Vars = {
		High = 1
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

SWEP.HoldType 			= "normal"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(1, -12, -3)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(1, -12, 1)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(1, -12, -3)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t400.mdl"] = {2},
	["models/tnb/skynet/t400_repro.mdl"] = {2}
}