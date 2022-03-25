AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "Techcom Shoulder-Mounted Plasma Canon"

SWEP.Category 				= "TRP"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_tc_shouldercanon.mdl")
SWEP.WorldModel 			= Model("models/tnb/trpweapons/w_tc_shouldercanon.mdl")

SWEP.UseHands 				= true

SWEP.Tracer 				= "lance"

SWEP.ClipSize 				= 1
SWEP.Damage 				= 500
SWEP.FireDelay 				= -1
SWEP.DoDissolve 			= true
SWEP.AmmoItem 				= "ammo_plasma_heavy"

SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= true
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}},
	{Mode = FIREMODE_BURST3, Vars = {}}
}

SWEP.Recoil 				= 0.5


SWEP.AimCone 				= 0.005
SWEP.HipCone 				= 0.04

SWEP.FireSound 				= soundscript.AddFire("PLASMA_BOSS", "tekka/weapons/plasma_boss.wav", 140)

SWEP.AllowThermals 			= true

if CLIENT then
	SWEP.UseRTScope 				= true
	SWEP.RTScopeFOV 				= 5 -- 5 for ACOG, 3 for long range scopes
	SWEP.RTScopeMaterialIndex 		= 1
	SWEP.RTScopeReticle 			= true
end

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 14
end


SWEP.Animations = {
	reload = "reload",
	fire = "shoot1"
}


SWEP.HoldType 			= "rpg"
SWEP.HoldTypeLowered 	= "passive"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -5, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -7, 1)
}

SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}
