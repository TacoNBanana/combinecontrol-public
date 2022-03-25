AddCSLuaFile()

SWEP.Base					= "tekka_base"

SWEP.PrintName 				= "T-400 Plasma Cannon"

SWEP.Category 				= "TRP Skynet"
SWEP.Plasma 				= true
SWEP.DrawCrosshair 			= false
SWEP.AdminOnly 				= true
SWEP.Spawnable 				= true

SWEP.ViewModel 				= Model("models/tnb/trpweapons/c_skynet_70watt.mdl")
SWEP.WorldModel 			= ""

SWEP.UseHands 				= false
SWEP.DoDissolve 			= true
SWEP.Damage 				= 80
SWEP.FireDelay 				= 0.2

SWEP.Tracer 				= "trp_laser_beam_thicc"
SWEP.LaserColor 			= COLOR_PURPLE

SWEP.UseFireAnimationHip 	= false
SWEP.UseFireAnimationADS 	= false
SWEP.UseReloadAnimation 	= true

SWEP.Firemodes 				= {
	{Mode = FIREMODE_AUTO, Vars = {}}
}

SWEP.Recoil 				= 0.5

SWEP.AimCone 				= 0.005
SWEP.HipCone 				= 0.045

SWEP.FireSound 				= soundscript.AddFire("TEKKA_PLASMASINGLE8", "tekka/weapons/plasma_single8.wav", 140)

if CLIENT then
	SWEP.UseAimpoint 			= true
	SWEP.AimpointMaterial 		= Material("models/tnb/trpweapons/reticule_square")
	SWEP.AimpointColor 			= Color(255, 0, 0, 255)
	SWEP.AimpointSize 			= 12
end

SWEP.Animations = {
	reload = "reload",
	fire = {"shoot_right1", "shoot_left1"}
}

SWEP.HoldType 			= "fist"
SWEP.HoldTypeLowered 	= "normal"

SWEP.SoundScripts = {}

SWEP.DefaultOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -12, 0)
}

SWEP.AimOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(-1, -14, 1)
}

SWEP.LoweredOffset = {
	ang = Vector(-10, 0, 0),
	pos = Vector(0, 0, 0)
}

SWEP.CrouchOffset = {
	ang = Vector(0, 0, 0),
	pos = Vector(0, -2, 1)
}

SWEP.PlayerBodyGroups = {
	["models/tnb/skynet/t400.mdl"] = {0},
	["models/tnb/skynet/t400_repro.mdl"] = {0}
}