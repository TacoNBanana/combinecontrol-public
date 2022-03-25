AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-400 Heavy Plasma Cannon"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true

SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_100watt.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false
SWEP.DoDissolve 			= true
SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.AttachmentOverride 	= "muzzle_right"
SWEP.LaserColor 			= COLOR_RED

SWEP.Damage 				= 100
SWEP.FireDelay 				= 0.22


SWEP.UseFireAnimationHip 	= true
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 8
end

SWEP.AimCone 				= 0.01
SWEP.HipCone 				= 0.02

SWEP.FireSound 				= soundscript.AddFire("TRP_400_LONG", "tekka/weapons/weapon_laser_revolver.wav", 140)

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot1", "shoot2"}
}

SWEP.HoldType 			= "passive"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -14, -3)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -18, -6)
}


SWEP.LoweredOffset = {
	ang = Vector(-15, 5, 0),
	pos = Vector(0, 0, 0)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t400.mdl"] = {3},
	["models/tnb/skynet/t400_repro.mdl"] = {3}
}